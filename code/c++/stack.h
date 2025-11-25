#ifndef STACK_H
#define STACK_H

#include <cstddef>
#include <stdexcept>

// Maximum number of elements any Stack can hold
constexpr std::size_t MAX_CAPACITY = 1024;

template <typename T>
class Stack {
public:
    Stack();
    ~Stack();

    // Disable copying and moving
    Stack(const Stack&) = delete;
    Stack& operator=(const Stack&) = delete;
    Stack(Stack&&) = delete;
    Stack& operator=(Stack&&) = delete;

    // Core stack operations
    void push(const T& value);
    T pop();

    // Observers
    bool is_empty() const;
    bool is_full() const;
    std::size_t size() const;

private:
    // Intentionally private so accessing these is a compile error
    std::size_t top;       // index of next free slot (also size)
    std::size_t capacity;  // current allocated capacity (<= MAX_CAPACITY)
    T* elements;           // dynamically allocated array

    // Internal helper, should not be callable from outside
    void reallocate(std::size_t new_capacity);
};

// -----------------------------------------------------------------------------
// Implementation
// -----------------------------------------------------------------------------

template <typename T>
Stack<T>::Stack()
    : top(0), capacity(4), elements(nullptr)
{
    if (capacity > MAX_CAPACITY) {
        capacity = MAX_CAPACITY;
    }
    elements = new T[capacity];
}

template <typename T>
Stack<T>::~Stack() {
    delete[] elements;
}

template <typename T>
bool Stack<T>::is_empty() const {
    return top == 0;
}

template <typename T>
bool Stack<T>::is_full() const {
    return top == MAX_CAPACITY;
}

template <typename T>
std::size_t Stack<T>::size() const {
    return top;
}

template <typename T>
void Stack<T>::push(const T& value) {
    // If we've already hit the hard max, throw
    if (is_full()) {
        throw std::overflow_error("Stack has reached maximum capacity");
    }

    // Grow internal array if needed (but never beyond MAX_CAPACITY)
    if (top == capacity) {
        std::size_t new_capacity = capacity * 2;
        if (new_capacity > MAX_CAPACITY) {
            new_capacity = MAX_CAPACITY;
        }
        reallocate(new_capacity);
    }

    elements[top++] = value;  // copy into storage
}

template <typename T>
T Stack<T>::pop() {
    if (is_empty()) {
        throw std::underflow_error("cannot pop from empty stack");
    }
    // Decrement top and return the last element
    return elements[--top];
}

template <typename T>
void Stack<T>::reallocate(std::size_t new_capacity) {
    if (new_capacity <= capacity) {
        return;
    }
    if (new_capacity > MAX_CAPACITY) {
        new_capacity = MAX_CAPACITY;
    }

    T* new_elements = new T[new_capacity];
    for (std::size_t i = 0; i < top; ++i) {
        new_elements[i] = elements[i];
    }
    delete[] elements;
    elements = new_elements;
    capacity = new_capacity;
}

#endif // STACK_H
