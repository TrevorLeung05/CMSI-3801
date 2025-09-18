1.

2.

3.

4.

5.

6.

7. a) Under static scoping, this script ends up being f() * h() - x = (1) * (1) - 1 = 0, as the variables resolve to x = 1, being the global default.
   b) Under dynamic scoping, the script is resolved based on their runtime execution. f() * h() - x = (1) * (3) - 1 =  2

8. Shallow binding doesn't make sense when combined with static scoping because shallow binding defines variables and functions within the context it was executed. However, with static scoping, the context for all code is fixed right at compile time. So combining shallow binding with static scoping does not matter, as the results will always be the same and determined at compile time.