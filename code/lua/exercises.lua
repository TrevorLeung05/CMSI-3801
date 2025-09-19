 -- exercises.lua
-- Implements required functions and a Quaternion datatype for the tests.

----------------------------------------------------------------------
-- first_then_apply(a, p, f)
-- Returns f(x) for the first x in a where p(x) is true; otherwise nil.
function first_then_apply(a, p, f)
  for i = 1, #a do
    local x = a[i]
    if p(x) then return f(x) end
  end
  return nil
end

----------------------------------------------------------------------
-- powers_generator(b, limit)
-- Returns a coroutine that yields b^0, b^1, ... up to <= limit, then yields nil.
function powers_generator(b, limit)
  assert(type(b) == "number" and type(limit) == "number", "numbers required")
  return coroutine.create(function()
    local v = 1
    while v <= limit do
      coroutine.yield(v)
      v = v * b
    end
    coroutine.yield(nil)
  end)
end

----------------------------------------------------------------------
-- say: chainable collector; ≤1 string per call; final empty call returns result
-- Examples:
--   say()                          --> ""
--   say("hello")("world")()        --> "hello world"
function say(first)
  local words = {}
  local function step(arg)
    if arg == nil then
      return table.concat(words, " ")
    else
      table.insert(words, tostring(arg))
      return step
    end
  end
  if first ~= nil then table.insert(words, tostring(first)) end
  return step
end

----------------------------------------------------------------------
-- meaningful_line_count(filename)
-- Count lines that are NOT:
--   (1) empty, (2) whitespace-only, or (3) whose first nonspace is '#'.
function meaningful_line_count(filename)
  assert(type(filename) == "string", "filename must be a string")
  local f, err = io.open(filename, "r")
  if not f then error(err, 2) end
  local n = 0
  for line in f:lines() do
    local start_nonspace = line:match("^%s*()")
    local first_char = line:sub(start_nonspace, start_nonspace)
    local whitespace_only = line:match("^%s*$") ~= nil
    if not whitespace_only and first_char ~= "#" and line ~= "" then
      n = n + 1
    end
  end
  f:close()
  return n
end

----------------------------------------------------------------------
-- Quaternion datatype
local Q = {}
Q.__index = Q

-- Constructor uses fields a,b,c,d as in the tests.
function Q.new(a, b, c, d)
  assert(type(a)=="number" and type(b)=="number" and type(c)=="number" and type(d)=="number",
         "numbers required")
  local self = setmetatable({ a = a, b = b, c = c, d = d }, Q)
  -- Freeze instances (disallow later writes)
  return setmetatable(self, {
    __index = Q,
    __newindex = function() error("Quaternion instances are immutable", 2) end,
    __add = Q.__add,
    __mul = Q.__mul,
    __eq  = Q.__eq,
    __tostring = Q.__tostring
  })
end

-- List of coefficients in (a,b,c,d) order
function Q:coefficients()
  return { self.a, self.b, self.c, self.d }
end

-- Conjugate: (a, -b, -c, -d)
function Q:conjugate()
  return Q.new(self.a, -self.b, -self.c, -self.d)
end

-- Value equality
function Q.__eq(q1, q2)
  return q1.a == q2.a and q1.b == q2.b and q1.c == q2.c and q1.d == q2.d
end

-- Component-wise addition
function Q.__add(q1, q2)
  return Q.new(q1.a + q2.a, q1.b + q2.b, q1.c + q2.c, q1.d + q2.d)
end

-- Hamilton product
function Q.__mul(q1, q2)
  local a1, b1, c1, d1 = q1.a, q1.b, q1.c, q1.d
  local a2, b2, c2, d2 = q2.a, q2.b, q2.c, q2.d
  local a = a1*a2 - b1*b2 - c1*c2 - d1*d2
  local b = a1*b2 + b1*a2 + c1*d2 - d1*c2
  local c = a1*c2 - b1*d2 + c1*a2 + d1*b2
  local d = a1*d2 + b1*c2 - c1*b2 + d1*a2
  return Q.new(a, b, c, d)
end

-- Helper for coefficient pretty-print
local function coeff_str(n, unit, is_first_term)
  if n == 0 then return nil end
  local sign = n < 0 and "-" or (is_first_term and "" or "+")
  local absn = math.abs(n)
  if unit == nil then
    -- scalar part: always show the number (Lua tostring keeps .0 when present)
    return sign .. tostring(absn)
  else
    if absn == 1 then
      return sign .. unit
    else
      return sign .. tostring(absn) .. unit
    end
  end
end

-- String representation like: "0", "j", "-k", "1.0-2.0j+5.0k", etc.
function Q.__tostring(q)
  local parts = {}
  local s = coeff_str(q.a, nil, true)
  if s then table.insert(parts, s) end
  local i = coeff_str(q.b, "i", #parts == 0)
  if i then table.insert(parts, i) end
  local j = coeff_str(q.c, "j", #parts == 0)
  if j then table.insert(parts, j) end
  local k = coeff_str(q.d, "k", #parts == 0)
  if k then table.insert(parts, k) end
  if #parts == 0 then return "0" end
  return table.concat(parts, "")
end

-- Expose as global 'Quaternion' to match the tests.
Quaternion = Q
