1. a. double *a[n]; means a is an array of n pointers to double
b. double(*b)[n]; means b is a pointer to an array of n doubles
c. double (*c[n])(); means c is an array of n pointers to functions that returns double
d. double (*d())[n]; means d is a function returning a pointer to an array of n doubles

2. In C, arrays decay to pointers in any value context, whenever they're used in an expression, except when used with sizeof, unary &, or _Alignof,, or when initializing another array.

3.
a) Memory leak - allocated memory still referenced, but never freed
b) Dangling pointer - pointer referencing freed or invalid memory
c) Double free - freeing the same memory block twice
d) Buffer overflow - writing past allocated memory bounds
e) Stack overflow - stack memory exhausted by deep calls/allocations
f) Wild pointer - uninitialized or invalid pointer with unknown target

4. In C++, moving means stealing resources from an object and leaving it in a "valid but unspecified" state, often an empty state. This only makes sense on r-values and not l-values because r-values are objects we are about to throw away, while it won't make sense for named,, still in use objects like l-values