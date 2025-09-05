1. Filtering a list means to create a new list using elements from an original list which meet a certain set of requirements that values in the original list might not meet.
nums = [0, 1, 2, 3, 4, 5]

def even(i):
    return i % 2 == 0

evenNums = list(filter(even, nums))
print(evenNums)

2. numbers .^ 3

3. pragmatics of programming languages refers to the usability and effectiveness in practice, or how programming languages is used in the real world. An example of this would be how efficient programming langauges are in supporting developers in solving problems.

4.
   - this entire expression is a monadic fucntion which takes "x". A mondaic function is a function that takes onlyone argument, in this case "x".
   - "x!2" will calculate the remainder of mod 2.
   - "& x!2" makes it so that it returns all indicies where the remainder is 1, separating the odds from the evens.
   - x[&x!2] indexes "x" at those positions, effectively making a sublist of the odd elements
   - ^2 squares each element
   - +/ adds all of the values
   - This function returnes the sum of the squared odd elements of x.

5. Today, object orientation is referred to as something that is designed for objects to work together cooperatively. Originally object orientation was the idea that everything is an object, and every object has their own memory while being an instance of a class, where the class holds any shared behavior for its instances.

6. ᐊ - Canadian Syllabics A (U+140A)
   ᐃ - Canadian Syllabics I (U+1403)
   ᓐ - Canadian Syllabics N (U+14D0)
   ᖓ - Canadian Syllabics Nga (U+1593)
   ᐃ - Canadian Syllabics I (U+1403)
   The string roughly means "hello" in Inuktitut

7. Control Flow is the order in which computation proceeds within each line of execution. On the other hand, Concurrency is the coordination between lines of execution, or multiple executed tasks happening at the same time.

8. Machine language is the lowest-level language, consisting of binary code (0s and 1s). Assembly language, uses human-readable mnemonics and symbols (like ADD and MOV) to represent machine code instructions They differ in their readability and how they are processed by a computer.

	Function to Add Two Numbers\
	Machine Language\
 	A1 XX XX XX XX     ; mov eax, [num1] - placeholder\
 	03 05 YY YY YY YY  ; add eax, [num2] - placeholder\

   Assembly Language\
   	mov eax, [num1]     ; Load value from memory location 'num1' into EAX\
   	add eax, [num2]     ; Add value from memory location 'num2' to EAX\
   	; Result is now in EAX\

9. Lua
```
function conditional_calculation(n)
    if (n % 2 == 0) then
        return 3 * n + 1
    else
        return 4 * n - 3
    end
end
```

10. Verse is a modern programming language developed by Epic Games and released in 2023, written by a team of programmers led by Simon Peyton Jones and Epic Games CEO Tim Sweeney. It was designed as the foundational language for building in the metaverse, with Fortnite Creative and Unreal Engine environments in mind. Verse combines elements of functional programming, which emphasizes clean and reusable code, with logic programming, which allows for flexible problem-solving through pattern matching and inference. 
