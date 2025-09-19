1. NULL is a reference with no referent. It was introduced by Tony Hoare as a way to represent empty values, but it's led to runtime crashes and security vulnerabilities due to null pointer exceptions (billion dollar mistake).

2. Tony Hoare created the null reference for ALGOL W to handle optional or missing values. He intended for it to be a simple pointer indicating that an object wasn't pointing to anything. However, as Edsger Dijkstra noted, a null reference doesn't represent the absence of a connection. Instead, it creates a universal, false connection. Dijkstra's analogy, "If you have a null reference, then every bachelor who you represent in your object structure will seem to be married polyamorously to the same person Null," highlights this problem.

3. The correct value for 3**35 is 500,315,450,989,997,07. Python's result is correct because it uses arbitrary-precision integers, and JavaScript uses 64-bit floating-point number (IEEE 754), which has a limited number of bits for precision. The correct value, 500,315,450,989,997,07, exceeds JavaScript's precision limit, so it rounds the number to the nearest representable value resulting in an incorrect number.

4. {"x": 3, y: 5, "z": z}

5. In javascript, == is called loose equality and includes type-coercion which means it may automatically convert a value's data type in order to make a comparison. This can have unwanted results. For exanmple, javscript might convert the string "5" to an integer. Instead, most people recommend referring === as "equals" as this is strict equality, meaning it will compare both value and type with no coercion.

6.
function arithmeticsequence(start, delta)
    return coroutine.create(function()
        local value = start
        while true do
            coroutine.yield(value)
            value = value + delta
        end
    end)
end

7. a) Under static scoping, this script ends up being f() * h() - x = (1) * (1) - 1 = 0, as the variables resolve to x = 1, being the global default.
   b) Under dynamic scoping, the script is resolved based on their runtime execution. f() * h() - x = (1) * (3) - 1 =  2

8. Shallow binding doesn't make sense when combined with static scoping because shallow binding defines variables and functions within the context it was executed. However, with static scoping, the context for all code is fixed right at compile time. So combining shallow binding with static scoping does not matter, as the results will always be the same and determined at compile time.
