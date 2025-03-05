# Preliminary Examples Recap

Before the exercises, the code shows how to work with lists, higher‐order functions, currying, and composition. Notice how:

- **Filtering evens**: Uses both an explicit lambda with `filter` and a curried version `((curry filter even?))`.
- **Currying examples**: Functions like `div-5/x` and `div-x/5` demonstrate how you can “preload” one argument.
- **compose usage**: Combining functions (e.g., applying `apply` after extracting a sublist with `cadr`) shows the power of composition.

These examples set the stage for the exercises.

## Exercise 1: binary-and

**Task**: Define a function that takes two lists (each representing a binary number with 0’s and 1’s) and returns their bitwise AND.

**Clue & Explanation**:
- In Scheme, multiplying two numbers that are either 0 or 1 gives you the AND result (since 1×1 = 1 and any multiplication with 0 gives 0).
- Use the `map` function to apply multiplication element-wise over the two lists.

**Hint**:
```scheme
(define (binary-and n1 n2)
    (map * n1 n2))
```

## Exercise 2: maxLength

**Task**: Define a function that returns the maximum length among several provided lists.

**Clue & Explanation**:
- Since the function takes a variable number of list arguments, define it as a variadic function.
- Use the `map` function to transform each list into its length.
- Finally, use `apply` with the `max` function to get the greatest length.

**Hint**:
```scheme
(define (maxLength . lists)
    (apply max (map length lists)))
```

## Exercise 3: filtrar-for

**Task**: Create a function that applies a given predicate to each list provided (again, as variadic arguments) and returns the filtered lists.

**Clue & Explanation**:
- The first argument is the predicate (a function).
- The rest of the arguments are the lists to be processed.
- Use a `map` that, for each list, applies the predicate with `filter`.

**Hint**:
```scheme
(define (filtrar-for pred . lists)
    (map (lambda (lst) (filter pred lst)) lists))
```

## Exercise 4: info

**Task**: Define a function that, given a key and a “person” (a list of key-value pairs), returns the value associated with that key.

**Clue & Explanation**:
- Think of each person as an association list.
- The built-in function `assoc` can help find the pair with the key.
- Since `assoc` returns a two-element list (key and value), extract the second element.

**Hint**:
```scheme
(define (info key person)
    (cadr (assoc key person)))
```

## Exercise 5: buscar

**Task**: Extract a specific field (by key) for every person in a data collection.

**Clue & Explanation**:
- Use the `info` function on every element of the `datos` list.
- Apply `map` over the data to collect each person’s value for that key.

**Hint**:
```scheme
(define (buscar key datos)
    (map (lambda (person) (info key person)) datos))
```

## Exercise 6: buscar+

**Task**: Return, for each person, a list containing the values corresponding to several keys.

**Clue & Explanation**:
- Define a helper function that, for a single person, extracts the values for all keys in a provided list.
- Then, map this helper over all persons in the data.

**Hint**:
```scheme
(define (buscar-person keys person)
    (map (lambda (k) (info k person)) keys))

(define (buscar+ keys datos)
    (map (lambda (person) (buscar-person keys person)) datos))
```

## Exercise 7: presentar

**Task**: Display each person’s data with fields shown in a specified order.

**Clue & Explanation**:
- The second argument is a list of keys specifying the desired order.
- First, sort the keys using the provided `sort` function (assuming it sorts based on the order provided).
- For each person, use the sorted keys to extract the corresponding information.

**Hint**:
```scheme
(define (presentar datos orden-claves)
    (let ((sorted-keys (sort orden-claves <)))  ; here, '<' is a placeholder for the appropriate order function
        (map (lambda (person)
                     (map (lambda (k) (info k person)) sorted-keys))
                 datos)))
```
*Note: Adjust the sort predicate as needed based on how the order is defined.*

## Exercise 8: change-all

**Task**: Return a new list where every occurrence of an element `u` is replaced with `v`.

**Clue & Explanation**:
- Use `map` to traverse the list.
- For each element, check if it equals `u` (using `equal?`).
- If so, return `v`; otherwise, keep the element as is.

**Hint**:
```scheme
(define (change-all lst u v)
    (map (lambda (x) (if (equal? x u) v x)) lst))
```
*Note: The example shows that only top-level elements are compared (sublist `(a 3)` remains unchanged because it isn’t exactly equal to `(a)`).*

## Exercise 9: Currified Version using choose

**Task**: First, define `choose(u, v, z)` that returns `v` if `z` equals `u`, and `z` otherwise. Then use it to “currify” the `change-all` functionality.

**Clue & Explanation**:
- Write a simple function `choose` that performs the comparison.
- Then, redefine `change-all` (or provide a version of it) using `map` and `choose` instead of an inline `if`.

**Hint**:
```scheme
(define (choose u v z)
    (if (equal? z u) v z))

(define (change-all lst u v)
    (map (lambda (x) (choose u v x)) lst))
```
For currying, you might write a function that returns a new function for a given `u` and `v`:
```scheme
(define (change-all-c u v)
    (lambda (lst) (map (lambda (x) (choose u v x)) lst)))
```

## Exercise 10: fill

**Task**: Insert an element `x` into every possible position within a list `l`, returning a list of all these new lists.

**Clue & Explanation**:
- If the list is empty, the only possibility is the list containing just `x`.
- For a non-empty list, think of “splitting” the list into a prefix and a suffix.
- For each position (from beginning to end), build a new list by appending `x` between the prefix and suffix.

**Hint**:
One common strategy is to use a helper that carries the “prefix” so far:
```scheme
(define (fill x lst)
    (define (insert-helper prefix suffix)
        (if (null? suffix)
                (list (append prefix (list x)))
                (cons (append prefix (list x) suffix)
                            (insert-helper (append prefix (list (car suffix))) (cdr suffix)))))
    (insert-helper '() lst))
```

## Exercise 11: Currified Version of fill

**Task**: Provide a currified version of the `fill` function so that it can be partially applied.

**Clue & Explanation**:
- Currying means that you can supply the element `x` first and get back a function waiting for the list `l`.

**Hint**:
```scheme
(define (fill-c x)
    (lambda (lst) (fill x lst)))
```
Now, calling `((fill-c 'x) '(a (b c) d))` will yield the same result as `(fill 'x '(a (b c) d))`.

## Exercise 12: my-curry

**Task**: Define a lambda function `my-curry` (or helper functions) that transforms a two-argument function into its curried form.

**Clue & Explanation**:
- The idea of currying is to take a function `f(x, y)` and return a function that takes `x` and returns another function that takes `y` and finally applies `f` to both.
- This is a classic exercise in higher-order functions.

**Hint**:
```scheme
(define my-curry
    (lambda (f)
        (lambda (x)
            (lambda (y)
                (f x y)))))
```
Alternatively, if you want to split it into two functions:
```scheme
(define (g f)
    (lambda (x)
        (lambda (y)
            (f x y))))

(define (h f x)
    (lambda (y)
        (f x y)))
```
