1. data Tree t = Node t [Tree t]

2. m^n = [1, if n = 0
         [m x m^(n-1) if n > 0

3.
    a) tag1 True, tag1 False, and tag2()
    b) (True, *), (False, *)

4. 
    a) (True, *), (False, *)
    b) λb. ⋆

5. This article argues the ambiguity in what a "character" is, encoding problems that fixes some problems but creates new problems, as shown with the cat and noël example, as well as weird case points where a fully upercase function producing a string that is converted to uppercase, while still having lowercase characters in it.

6. No you cannot, because the subterm xx forces a type equation that in a simply typed system without recursive types, the equation has no solution.

7. not(A(x))

8. A pure function is a function that always produces the same output for the same input, as well has having no side effects. A pure function works like a mathematical function f(x) = y. We care about pure functions because they keep things safe and predictable.

9. Haskell isolates pure and impure code by putting effects in the type and only lets them run at the edge. If a function's type is pure, the compiler will guarantee that function has no side effects, but if effects are present, then they're visible in the type.

10. In typescript, & (intersection) is closer to subclassing or inheritance from Python, as & (intersection) combines all members of multiple types into one, while | (union) means a value can be one of several types. 

type A = {
    greet: () => void
}
type B = {
    A & {
        bye: () => void
    }
}
const b: B = {
    greet: () => console.log("Hello from A")
    bye : () console.log("Bye from B")
}