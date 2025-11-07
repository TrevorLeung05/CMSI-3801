1. a) abstract b) no keyword c) final d) no keyword

2. Structures are value types but calsses are reference types. Classes have more functionality than structures. Classes can have deinitalizers, they can inherit from superclasses, and they have run-time type cehcking and casting. 

3. No swift does nott have null references. Swift has a value called nil but it does not belong to type String, it belongs to type String? so if there is a chance you need nil, you must use a different type.

4. No, if the list is mutable. Doing so ould breark type safety because List<Animal> wouldallow inserting any kind of Animal even if they are not dogs. If the list is read only, then it would be safe.

5. Swift's Void type is weirdly named because Void is an alias for a unit type with exactly one value, (). Their excuse for using that term is just a stylistic way to show the absence of an actual return value.

6. A supplier is a function that takes no argument, but still returns a value. In swift, the type is () -> T

7. Yegor Bugayenko thought Alan Kay was wrong because Alan Kay regretted using the name "object", as that wording made people focus on objects just as data structures with methods. However, Yegor Bugayenko disagreed with Kay's regret, arguing that Kay's term of "object" was right, that the problem was the people forgot that an object should also act, not just hold.

8. In class-based OOP, objects are instantiated from a class, and inheritance occurs between classes. In prototype-based OOP, objects are created by cloning an existing object, and inheritance happens through delegation, where objects forward calls to their prototype.

9. A Java record automatically generates private final fields, a public "canonical" constructor, and accessor method for all its components. It also provides complete, value-based implementations of the equals(), hashCode(), and toString() methods.

10. Instead of Kotlin's companion object, Java programmers use static fields and static methods directly inside the class. This allows factory methods and constants to be called on the class itself, achieving the same functionality.
