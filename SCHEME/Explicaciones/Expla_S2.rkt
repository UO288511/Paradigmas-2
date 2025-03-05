# Functional Programming: Higher-Order Functions, Lambda Expressions, and Filters

This session introduces key concepts of functional programming using a Scheme-like language. It demonstrates how to work with structured data (in this case, information about people), how to create accessor ("get") functions, how to use higher-order functions (functions that take other functions as arguments), and how to build and apply filters using lambda expressions.

---

## Data Description

The symbol `Datos` holds data about people in the following format:

```
((Name Surname1 Surname2 Age Gender (Studies) Works?) ...)
```

- **Gender:** `H` (hombre, male) or `M` (mujer, female)
- **Studies:** A list of higher education studies for the person
- **Works?:** `#t` (true) if the person works, `#f` (false) otherwise

For example:

```scheme
(define Datos '(
  (LUIS GARCIA PEREZ 26 H (MEDICINA INFORMATICA) #t)
  (MARIA LUZ DIVINA 23 M (INFORMATICA BIOLOGIA) #t)
  (ADOLFO MONTES PELADOS 24 H (INFORMATICA) #f)
  (ANA GARCIA GONZALEZ 18 M () #f)
  (JOSE PEREZ MONTES 36 H () #t)
  (JOSHUA IGLESIAS GARCIA 12 H () #f)
  (MARUJA FERNANDEZ GARCIA 9 M () #f)
  (ROSA LINDO SUAREZ 29 M (ECONOMIA MEDICINA) #t)
  (GUILLERMO PUERTAS VENTANAS 42 H (ECONOMIA) #f)
))
```

Each inner list represents a person. For instance, the entry  
`(MARIA LUZ DIVINA 23 M (INFORMATICA BIOLOGIA) #t)`  
represents a person named Maria Luz Divina, aged 23, female, with studies in INFORMATICA and BIOLOGIA, and who is working.

We also define a variable to extract one person’s data for testing:

```scheme
(define datos-persona (cadr Datos))
(displayln "Ejemplo de datos sobre una persona: ")
(writeln datos-persona)
```

---

## Exercise 1: Implementing Getter Functions

These functions extract specific pieces of information from a person's data list.

### 1a) `get-nombre(p)`

Returns the first element (the name) of the person's data.

```scheme
(define (get-nombre p)
  (car p))

; Test:
(displayln "\nEjercicio 1a) get-nombre: ")
(get-nombre datos-persona)  ;=> MARIA
```

### 1b) `get-apellidos(p)`

Returns a list with the two surnames (second and third elements) of a person.

```scheme
(define (get-apellidos p)
  (list (cadr p) (caddr p)))

; Test:
(displayln "\nEjercicio 1b) get-apellidos: ")
(get-apellidos datos-persona)  ;=> (LUZ DIVINA)
```

### 1c) `get-nombre-completo(p)`

Returns a list containing the full name (name followed by surnames) of a person.

```scheme
(define (get-nombre-completo p)
  (cons (get-nombre p) (get-apellidos p)))

; Test:
(displayln "\nEjercicio 1c) get-nombre-completo: ")
(get-nombre-completo datos-persona) ; => (MARIA LUZ DIVINA)
```

### 1d) `get-edad(p)`

Returns the age (fourth element) of a person.

```scheme
(define (get-edad p)
  (cadddr p))

; Test:
(displayln "\nEjercicio 1d) get-edad: ")
(get-edad datos-persona)  ;=> 23
```

### 1e) `get-sexo(p)`

Returns the biological gender of a person. Here, the gender is the first element after the age.

```scheme
(define (get-sexo p)
  (car (cddddr p)))

; Test:
(displayln "\nEjercicio 1e) get-sexo: ")
(get-sexo datos-persona) ; => M
```

### 1f) `get-estudios(p)`

Returns the list of higher education studies of a person.

```scheme
(define (get-estudios p)
  (cadr (cddddr p)))

; Test:
(displayln "\nEjercicio 1f) get-estudios: ")
(get-estudios datos-persona)  ;=> (INFORMATICA BIOLOGIA)
```

### 1g) `trabaja?(p)`

Returns `#t` if the person works, or `#f` otherwise.

```scheme
(define (trabaja? p)
  (caddr (cddddr p)))

; Test:
(displayln "\nEjercicio 1g) trabaja? ")
(trabaja? datos-persona)  ;=> #t
```

---

## Exercise 2: Applying the `Extrae` Function

The function `Extrae` is a higher-order function that processes the list of people (`Datos`). It takes three parameters:
- **Datos:** The complete data list.
- **Filtro:** A function that, given a person, returns `#t` (true) or `#f` (false) based on a condition.
- **Formato:** A function that extracts or formats the desired information from a person.

`Extrae` returns a list of formatted elements for those persons who pass the filter.

### Recursive Definition of `Extrae`

1. **Base Case:**  
   If `Datos` is empty, then return an empty list.

2. **Recursive Case:**  
   If `Datos` is not empty, then:
   - Check the first element (using `car Datos`).
   - If it satisfies the filter, apply the formatting function and add it to the result.
   - Otherwise, skip it and continue with the rest of the list.

### Implementation of `Extrae`

```scheme
(define (Extrae Datos Filtro Formato)
  (cond
    ([null? Datos] Datos)
    ([Filtro (car Datos)] (cons (Formato (car Datos))
                                (Extrae (cdr Datos) Filtro Formato)))
    (else (Extrae (cdr Datos) Filtro Formato))))
```

### Using `Extrae` to Extract Information

#### 2a) List of Names of Adult Persons

Filter those whose age is 18 or more and extract their names.

```scheme
(displayln "\nEjercicio 2a): Lista de nombres de las personas adultas:")
(Extrae Datos (lambda (p) (>= (get-edad p) 18)) get-nombre)
; Expected output: (LUIS MARIA ADOLFO ANA JOSE)
```

#### 2b) List of Full Names of All Persons

No filter is needed (always true), so extract the full names of every person.

```scheme
(displayln "\nEjercicio 2b) Lista de nombres completos de todas las personas:")
(Extrae Datos (lambda (p) #t) get-nombre-completo)
; Expected output:
; ((LUIS GARCIA PEREZ)
;  (MARIA LUZ DIVINA)
;  (ADOLFO MONTES PELADOS)
;  (ANA GARCIA GONZALEZ)
;  (JOSE PEREZ MONTES)
;  (JOSHUA IGLESIAS GARCIA)
;  (MARUJA FERNANDEZ GARCIA)
;  (ROSA LINDO SUAREZ)
;  (GUILLERMO PUERTAS VENTANAS))
```

#### 2c) List of Names of All Women Who Work

Filter for persons whose gender is `M` and who are working, then extract their names.

```scheme
(displayln "\nEjercicio 2c) Lista de nombres de mujeres que trabajan:")
(Extrae Datos (lambda (p) (and (eq? (get-sexo p) 'M)
                               (trabaja? p))) get-nombre)
; Expected output: (MARIA ROSA)
```

#### 2d) List of Full Names of Persons with Studies in INFORMATICA

Filter persons whose list of studies includes `INFORMATICA` and extract their full names.

```scheme
(displayln "\nEjercicio 2d) Lista de nombres completos de todas las personas con estudios de INFORMATICA")
(Extrae Datos (lambda (p) (member 'INFORMATICA (get-estudios p))) get-nombre-completo)
; Expected output:
; ((LUIS GARCIA PEREZ) (MARIA LUZ DIVINA) (ADOLFO MONTES PELADOS))
```

#### 2e) List of (Gender, Age) Pairs for Persons Without Studies

Filter for persons with an empty studies list and format the output as a pair `(sexo edad)`.

```scheme
(displayln "\nEjercicio 2e) Lista de pares (sexo edad) de las personas sin estudios superiores")
(Extrae Datos
        (lambda (p) (null? (get-estudios p)))
        (lambda (p) (list (get-sexo p) (get-edad p))))
; Expected output: ((M 18) (H 36) (H 12) (M 9))
```

#### 2f) List of Ages of All Women Who Have Studied INFORMATICA

Filter for women whose studies include `INFORMATICA` and extract their ages.

```scheme
(displayln "\nEjercicio 2f) Lista de edades de todas las mujeres con estudios de INFORMATICA")
(Extrae Datos (lambda (p) (and (eq? (get-sexo p) 'M)
                               (member 'INFORMATICA (get-estudios p)))) get-edad)
; Expected output: (23)
```

#### 2g) List of Full Names of All Persons Who Do Not Work

Filter persons who do not work and extract their full names.

```scheme
(displayln "\nEjercicio 2g) Lista de nombres completos de las personas que no trabajan")
(Extrae Datos (lambda(p) (not (trabaja? p))) get-nombre-completo)
; Expected output:
; ((ADOLFO MONTES PELADOS) (ANA GARCIA GONZALEZ)
;  (JOSHUA IGLESIAS GARCIA) (MARUJA FERNANDEZ GARCIA)
;  (GUILLERMO PUERTAS VENTANAS))
```

#### 2h) List of Names of All Persons with More Than One Higher Education Study

Filter for persons with more than one study (i.e., the length of their studies list is greater than 1) and extract their names.

```scheme
(displayln "\nEjercicio 2h) Lista de nombres de las personas con más de un estudio superior")
(Extrae Datos (lambda(p) (> (length (get-estudios p)) 1)) get-nombre)
; Expected output: (LUIS MARIA ROSA)
```

---

## Exercise 3: Function `gen-filtro`

The `gen-filtro` function is a higher-order function that creates a filter function for use with `Extrae`. It is parameterized by:

- **Extractor:** A function that extracts a specific piece of data from a person.
- **Operador:** A comparison function that takes a value and the extracted data, returning a boolean.
- **Valor:** The value to compare against.

### Definition of `gen-filtro`

```scheme
(define (gen-filtro Extractor Operador Valor)
  (lambda(p) (Operador Valor (Extractor p))))
```

This function returns a new lambda function that, when given a person `p`, compares `(Extractor p)` with `Valor` using `Operador`.

### Using `gen-filtro` with `Extrae`

#### 3a) List of Names of Adult Persons

Generate a filter for adults using `get-edad` and the comparison operator `<=` (since `(<= 18 (get-edad p))` is equivalent to checking that the age is at least 18).

```scheme
(displayln "\nEjercicio 3a): Lista de nombres de las personas adultas:")
(Extrae Datos                         ; data of persons
        (gen-filtro get-edad <= 18)   ; generated filter: 18 <= age
        get-nombre)                   ; extract name
```

#### 3b) List of Full Names of All Persons

A trivial filter that always returns true by checking if the person is a list (which is always the case).

```scheme
(displayln "\nEjercicio 3b) Lista de nombres completos de todas las personas:")
(Extrae Datos
        (gen-filtro (lambda(p) (list? p)) eq? #t)
        get-nombre-completo)
```

#### 3c) List of Names of All Women Who Work

Generate a filter that checks if a person works and has gender `M`.

```scheme
(displayln "\nEjercicio 3c) Lista de nombres de mujeres que trabajan:")
(Extrae Datos
        (gen-filtro (lambda(p)
                      (and (trabaja? p)
                           (get-sexo p))) eq? 'M)
        get-nombre)
```

#### 3d) List of Full Names of Persons with Studies in INFORMATICA

Generate a filter for persons whose studies include `INFORMATICA`.

```scheme
(displayln "\nEjercicio 3d) Lista de nombres completos de todas las personas con estudios de INFORMATICA")
(Extrae Datos
        (gen-filtro get-estudios member 'INFORMATICA)
        get-nombre-completo)
```

#### 3e) List of (Gender, Age) Pairs for Persons Without Studies

Generate a filter for persons with an empty studies list and format the output as `(sexo, edad)`.

```scheme
(displayln "\nEjercicio 3e) Lista de pares (sexo edad) de las personas sin estudios superiores")
(Extrae Datos
        (gen-filtro get-estudios eq? ())
        (lambda (p) (list (get-sexo p) (get-edad p))))
```

#### 3f) List of Ages of All Women Who Have Studied INFORMATICA

Generate a filter for women with `INFORMATICA` in their studies and extract their age.

```scheme
(displayln "\nEjercicio 3f) Lista de edades de todas las mujeres con estudios de INFORMATICA")
(Extrae Datos
        (gen-filtro (lambda(p)
                      (and (member 'INFORMATICA (get-estudios p))
                           (get-sexo p))) eq? 'M)
        get-edad)
```

#### 3g) List of Full Names of All Persons Who Do Not Work

Generate a filter for persons who do not work.

```scheme
(displayln "\nEjercicio 3g) Lista de nombres completos de las personas que no trabajan")
(Extrae Datos
        (gen-filtro trabaja? eq? #f)
        get-nombre-completo)
```

#### 3h) List of Names of All Persons with More Than One Higher Education Study

Generate a filter for persons with more than one study. Here, using `<` in the generated filter:  
`(gen-filtro (lambda(p) (length (get-estudios p))) < 1)`  
is equivalent to checking that `1 < (length (get-estudios p))`.

```scheme
(displayln "\nEjercicio 3h) Lista de nombres de las personas con más de un estudio superior")
(Extrae Datos
        (gen-filtro (lambda(p) (length (get-estudios p))) < 1)
        get-nombre)
```

---

## Complementary Exercises

The following exercises work with a list of numbers, where each number is given by a list of its digits along with an associated name.

### Definition of `numeros`

```scheme
(define numeros
  '((n1 (3 7 3))
    (n2 (3 4 9 0 1))
    (n3 (3 0 3 4))
    (n4 (7))))
```

We will use the `filter` function to extract numbers based on various conditions.

#### Comp-a) Obtain All Numbers with More Than 3 Digits

Filter the list `numeros` to keep those numbers whose digits list has a length greater than 3.

```scheme
(displayln "\nEjercicio Comp-a) Obtener todos los números con más de 3 dígitos")
(filter (lambda(x) (> (length (cadr x)) 3)) numeros)
; Expected output:
; ((n2 (3 4 9 0 1)) (n3 (3 0 3 4)))
```

#### Comp-b) Obtain All Numbers That Contain the Digit 7

Filter `numeros` to get those numbers that include the digit `7` in their digits list.

```scheme
(displayln "\nEjercicio Comp-b) Obtener todos los números que tengan un siete")
(filter (lambda(x) (member 7 (cadr x))) numeros)
; Expected output:
; ((n1 (3 7 3)) (n4 (7)))
```

#### Comp-c) Obtain All Numbers with 3 as the First Digit

Filter `numeros` to select those numbers where the first digit is `3`. Here, `(caadr x)` retrieves the first element of the digits list.

```scheme
(displayln "\nEjercicio Comp-c) Obtener todos los números que tengan como primer dígito un 3")
(filter (lambda(x) (= (caadr x) 3)) numeros)
; Expected output:
; ((n1 (3 7 3)) (n2 (3 4 9 0 1)) (n3 (3 0 3 4)))
```

#### Comp-d) Define the Function `frecuency(x, l)`

Define the function `frecuency1` using higher-order functions. It returns the number of times `x` appears in the list `l`.

```scheme
(define (frecuency1 x l)
  (length (filter (lambda(y) (equal? x y)) l)))

(displayln "\nEjercicio Comp-d) frecuency:")
(frecuency1 '(a) '(a b (a) a d (a))) ; Expected output: 2
```

The `frecuency1` function works by filtering the list `l` for elements equal to `x` and then counting the number of elements in the resulting list.

---

This concludes the session. Each section demonstrates important functional programming techniques such as creating accessor functions, using lambda expressions, building higher-order functions, applying filters, and constructing recursive functions in Scheme.
