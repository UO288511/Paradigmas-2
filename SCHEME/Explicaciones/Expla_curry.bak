# Currying in Functional Programming

Currying is a functional programming technique where a function that takes multiple arguments is decomposed into a series of functions that take a single argument.

In other words, a function f(a, b) is transformed into a series of functions f(a)(b), where the first value a is passed in an initial call, and the second value b is passed in a subsequent call.

Basically, it involves making a function return another function.

## Example in Python

Instead of defining a function that takes two arguments:

```python
def normal_sum(a, b):
    return a + b
```

We can define a function that returns another function:

```python
def curried_sum(a):
    def inner(b):
        return a + b
    return inner
```

### Using the functions

#### With the normal function

```python
normal_sum(3, 2)  # Returns 5
```

#### With the curried function

First, we get the inner function with the first argument:

```python
inner = curried_sum(3)  # `inner` is the function inside curried_sum, which has `a` fixed at 3
```

Then, we call the inner function with the second argument:

```python
inner(2)  # Returns 5
```

We can also call the curried function all at once:

```python
curried_sum(3)(2)  # Returns 5
```

## Example in Scheme

In Scheme, `curry` and `curryr` are functions that are commonly used in functional programming to transform a multi-argument function into a series of functions, each accepting one argument at a time. This concept is a core part of currying, a technique in which a function that takes multiple arguments is transformed into a sequence of functions, each taking a single argument.

- `curry`: Converts a function that takes multiple arguments into a series of unary (single-argument) functions.
- `curryr`: Similar to `curry`, but it reverses the order of arguments.

Let's go through their syntax and examples.

### 1. curry

The `curry` function transforms a function that takes multiple arguments into a function that takes its arguments one by one.

**Syntax:**

```scheme
(curry f)
```

Where `f` is a function that takes multiple arguments.

**Example:** Suppose you have a function that takes two arguments and adds them:

```scheme
(define (add a b)
    (+ a b))
```

You can curry this function like this:

```scheme
(define curried-add (curry add))
```

Now `curried-add` is a function that takes one argument and returns a function that takes the second argument:

```scheme
(define add5 (curried-add 5))  ; `add5` is now a function that takes one argument and adds 5 to it
(add5 3)  ; => 8
```

Here’s what happens in the curried version:

- `(curry add)` produces a function that, when given a number (like 5), returns another function that expects the second argument (b).
- `add5` is now a function that takes the second argument (3 in this case) and applies it to `add5` to produce the sum.

### 2. curryr

The `curryr` function works similarly to `curry`, but it reverses the order of arguments. Essentially, the first argument you provide is the last argument of the original function.

**Syntax:**

```scheme
(curryr f)
```

Where `f` is a function that takes multiple arguments.

**Example:** Using the same `add` function:

```scheme
(define (add a b)
    (+ a b))
```

Now apply `curryr` to the function:

```scheme
(define curried-add-right (curryr add))
```

Now `curried-add-right` expects the second argument first and the first argument second:

```scheme
(define add5right (curried-add-right 5))  ; `add5right` expects the second argument first
(add5right 3)  ; => 8
```

Here’s what happens in the `curryr` version:

- `(curryr add)` produces a function where the first argument (5) is applied last to the original function.
- `add5right` is now a function that takes the second argument (3 in this case), and applies it to `add5right` with 5 as the first argument.

### Summary

- `curry` transforms a multi-argument function into a series of functions that accept one argument at a time (starting from the first argument).
- `curryr` does the same but reverses the order of arguments.

**Example of both in use:**

```scheme
(define (multiply a b)
    (* a b))

(define curried-multiply (curry multiply))  ; Currying the multiply function
(define curried-multiply-reversed (curryr multiply))  ; Currying and reversing the arguments

(define multiply-by-3 (curried-multiply 3))  ; First argument is fixed
(multiply-by-3 4)  ; => 12

(define multiply-by-4-reversed (curried-multiply-reversed 4))  ; Second argument is fixed
(multiply-by-4-reversed 3)  ; => 12
```

In this example:

- `curried-multiply` gives us a function where the first argument is provided first.
- `curried-multiply-reversed` gives us a function where the second argument is provided first, reversing the order.




