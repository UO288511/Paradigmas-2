# Explanation of the Scheme Code

Below is a breakdown of the given code and how it works.

## Function Definition: `Extrae`

```scheme
(define (Extrae datos Filtro Formato)
  (map Formato (filter Filtro datos)))
```

- **`Extrae`** is a function that takes three arguments:
  1. **`datos`**: A list of data elements.
  2. **`Filtro`**: A predicate function used to filter elements in `datos`.
  3. **`Formato`**: A function that formats or extracts a part of each element.
  
- **Filtering Step:**
  - The expression `(filter Filtro datos)` applies the `Filtro` function to each element in `datos` and **keeps only** those elements for which `Filtro` returns `true`.

- **Mapping Step:**
  - The expression `(map Formato ...)` then applies the `Formato` function to each of the filtered elements, transforming them as specified.

**Summary:**  
The `Extrae` function first **filters** the data using the predicate `Filtro` and then **maps** the formatting function `Formato` over the filtered list.

---

## Data Example: `numeros`

```scheme
(define numeros
  '((n1 (3 7 3)) (n2 (3 4 9 0 1)) (n3 (3 0 3 4)) (n4 (7))))
```

- **`numeros`** is a list of pairs.
  - Each pair consists of a **name** (e.g., `n1`, `n2`, etc.) and a **list of digits**.
  
For example:
- `(n2 (3 4 9 0 1))` represents the number named `n2` with the digits `3 4 9 0 1`.

---

## Exercise 2: Extracting Names with More Than 3 Digits

```scheme
(displayln "\nExercise 2) Names with more than 3 digits: ")
(Extrae numeros (lambda (x) (> (length (cadr x)) 3)) car)
```

- **Filtering Condition:**
  ```scheme
  (lambda (x) (> (length (cadr x)) 3))
  ```
  - For each element `x` in `numeros`, `(cadr x)` retrieves the second element (the list of digits).
  - `(length (cadr x))` computes the number of digits.
  - The lambda function returns `true` if the number of digits is greater than 3.

- **Formatting Function:**
  - The function `car` is used to extract the first element (the name) of each pair.

**Process:**
1. **Filter**: Only pairs where the digit list has **more than 3 elements** are retained.
2. **Map**: The `car` function extracts the **name** from each filtered pair.

---

## Exercise 3: Displaying Full Information for Numbers with More Than 3 Digits

```scheme
(displayln "\nEjercicio 3) Números con más de 3 dígitos (toda la información): ")
(filter (lambda(x) (> (length (cadr x)) 3)) numeros)
```

- **Objective:**
  - Retrieve and display all the information for numbers that have **more than 3 digits**, without using the `Extrae` function.

- **Filtering Condition:**
  ```scheme
  (lambda(x) (> (length (cadr x)) 3))
  ```
  - For each element `x` in `numeros`, `(cadr x)` retrieves the list of digits.
  - `(length (cadr x))` calculates the number of digits.
  - The lambda returns `true` if the number has more than 3 digits.

- **Using `filter`:**
  - The `filter` function applies the lambda to each element in `numeros`.
  - Only the elements (which include both the name and the list of digits) that satisfy the condition are kept.
  
**Outcome:**  
The `filter` function returns a list of all numbers from `numeros` that have more than 3 digits, including their complete information.

---

## Final Summary

- **`Extrae` Function:**  
  A higher-order function that:
  - **Filters** the input data (`datos`) using the predicate (`Filtro`).
  - **Transforms** the filtered data using a formatting function (`Formato`).

- **Usage in Exercise 2:**  
  Extracts the **names** of numbers from `numeros` where the list of digits contains **more than 3 elements**.

- **Usage in Exercise 3:**  
  Directly applies `filter` to retrieve the **entire information** (name and digits) for numbers in `numeros` that have **more than 3 digits**.

This modular approach allows you to easily adjust the filtering condition and formatting function for various tasks, making your code more reusable and flexible.



# Exercises 4, 5, and 6: Set Operations

This document includes the definitions and tests for the following functions:
- **Exercise 4**: `union(A, B)` using FOS with argument validation.
- **Exercise 5**: `subset?(A, B)` using FOS and specifically `filter`.
- **Exercise 6**: `subset2?(A, B)` combining `map` and `apply`.

---

## Exercise 4: `union(A, B)`

**Objective:**  
Define the function `union(A, B)` which returns the union of two sets, validating its arguments.

```scheme
(displayln "\nEjercicio 4) union: ")
; PRUEBAS DE FUNCIONAMIENTO
;(union '(c a x) 3)       ;=> error
;(union '(c a x))         ;=> error
(union '(c a x) '(a (a))) ;=> (c x a (a))
```

**Explanation:**  
- The function `union` is intended to compute the union of two sets `A` and `B`.
- It should validate that both arguments are proper sets (i.e., lists). If an argument is not a list (or is missing), the function should signal an error.
- In the test examples:
  - `(union '(c a x) 3)` and `(union '(c a x))` should produce an error due to invalid arguments.
  - `(union '(c a x) '(a (a)))` returns the union of the two sets, here shown as `(c x a (a))`.  
- **Note:** The actual implementation of `union` is not shown here, but it must include both the logic for set union and argument validation using FOS (Funciones de Orden Superior).

Result: 
```scheme
(displayln "\nEjercicio 4) union: ")

;; Función auxiliar: diferencia de conjuntos
(define (set-difference A B)
  (filter (lambda (elem) (not (member elem B))) A))

;; Función union: A U B = (A - B) ∪ B
(define (union A B)
  ;; Validación de argumentos: ambos deben ser listas (conjuntos)
  (if (and (list? A) (list? B))
      (append (set-difference A B) B)
      (error "Error: Ambos argumentos deben ser conjuntos (listas).")))

;; PRUEBAS DE FUNCIONAMIENTO:
;; (union '(c a x) 3)       ;=> error
;; (union '(c a x))         ;=> error
(displayln (union '(c a x) '(a (a)))) ;=> (c x a (a))

```

---

## Exercise 5: `subset?(A, B)`

**Objective:**  
Define the function `subset?(A, B)` using FOS (specifically `filter`), which checks if set `A` is a subset of set `B`.

```scheme
(define (subset? A B)
  (null? (filter (lambda(x) (not (member x B))) A)))

(displayln "\nEjercicio 5) subset:")
(subset? '(c b) '(a x b d c y))    ;=> #t
(subset? '(c b) '(a x b d (c) y))  ;=> #f
```

**Explanation:**  
- The function verifies whether every element in set `A` is present in set `B`.
- The lambda function `(lambda(x) (not (member x B)))` returns true for any element in `A` that is **not** found in `B`.
- `filter` gathers all such elements. If the resulting list is empty (i.e., `(null? ...)` returns `#t`), then every element of `A` is in `B` and `A` is a subset of `B`.
- The tests show that `'(c b)` is a subset of `'(a x b d c y)` (resulting in `#t`), but not a subset of `'(a x b d (c) y)` (resulting in `#f`).

---

## Exercise 6: `subset2?(A, B)`

**Objective:**  
Redefine the subset check by combining `map` and `apply`. The function `subset2?` returns `#t` if set `A` is a subset of set `B`, and `#f` otherwise.

```scheme
(define (subset2? A B)
   (if (apply _and (map (lambda(x) (member x B)) A)) #t #f))

(displayln "\nEjercicio 6) subset2?:")
(subset2? '(c b) '(a x b d c y))    ;=> #t
(subset2? '(c b) '(a x b d (c) y))  ;=> #f
```

**Explanation:**  
- This function uses `map` to check for each element in `A` whether it is a member of `B` by applying `(member x B)`.
- The results of these checks (which are truthy or false values) are then combined using `apply` with the helper function `_and`. This function `_and` should logically 'AND' all the values together.
- If every element in `A` is found in `B`, the combined result will be truthy (thus `#t`); otherwise, it will be false (thus `#f`).
- The tests verify that `'(c b)` is a subset of `'(a x b d c y)` (resulting in `#t`), but not a subset of `'(a x b d (c) y)` (resulting in `#f`).

> **Note:**  
> The helper `_and` function must be defined in your environment for this approach to work. If `_and` is not available, you may need to implement it or use an alternative logical method to combine the results.

---

This document summarizes the code and explanations for Exercises 4, 5, and 6.
