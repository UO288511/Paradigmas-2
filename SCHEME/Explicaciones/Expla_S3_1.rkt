# Complementary Exercises (Optional)

The exercises below are complementary (voluntary) and some of them might have a higher degree of difficulty.

---

## Provided Function: `enteros(x, y)`

This function, given two integers `x` and `y`, returns the list of consecutive integers from `x` up to (but not including) `y`. In other words, it returns the integers in the range `[x, y)`. If `x >= y`, the list is empty.

```scheme
(define (enteros x y)
  (if (>= x y)
      ()
      (cons x (enteros (+ x 1) y))))

(displayln "\nFunción enteros: ")
(enteros -5 10) ;=> (-5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9)
(enteros 1 6)   ;=> (1 2 3 4 5)
```

---

## Exercise Comp-a: `sucAritm0(r, n)`

This function returns the list `(0 r 2*r ... (n-1)*r)`, that is, the first `n` terms of an arithmetic sequence whose first element is `0` and whose common difference is `r`.

```scheme
(define (sucAritm0 r n)
  (map (lambda (k) (* k r)) (enteros 0 n)))

(displayln "\nEjercicio Comp-a) sucAritm0: ")
(sucAritm0 3 5)  ;=> (0 3 6 9 12)
```

---

## Exercise Comp-b: `suc-aritmetica(a, r, n)`

This function returns the list `(a a+r a+2*r ... a+(n-1)*r)`, that is, the first `n` terms of an arithmetic sequence whose first element is `a` and whose common difference is `r`.

```scheme
(define (suc-aritmetica a r n)
  (map (lambda (t) (+ a t)) (sucAritm0 r n)))

(displayln "\nEjercicio Comp-b) suc-aritmetica: ")
(suc-aritmetica -7 3 5)   ;=> (-7 -4 -1 2 5)
```

---

## Exercise Comp-c: `suma-aritmetica(a, r, n)`

This function returns the sum of the first `n` terms of the arithmetic sequence whose first element is `a` and whose common difference is `r`.

```scheme
(define (suma-aritmetica a r n)
  (apply + (suc-aritmetica a r n)))

(displayln "\nEjercicio Comp-c) suma-aritmetica: ")
(suma-aritmetica -7 3 5)   ;=> -5
```

---

## Exercise Comp-d: `pares(a, b)`

This function returns the list of even numbers in the integer range `[a, b]`.

```scheme
(define (pares a b)
  (filter even? (enteros a (+ b 1))))

(displayln "\nEjercicio Comp-d) pares: ")
(pares -7 9)   ;=> (-6 -4 -2 0 2 4 6 8)
```

---

## Exercise Comp-e: `multiplos(a, b, n)`

This function returns the list of all multiples of the integer `n` that belong to the integer range `[a, b]`. If `n` is `0`, it returns the list of all integers in the given range.

```scheme
(define (multiplos a b n)
  (if (zero? n)
      (enteros a (+ b 1))
      (filter (lambda (k) (zero? (remainder k n)))
              (enteros a (+ b 1)))))

(displayln "\nEjercicio Comp-e) multiplos: ")
(multiplos -7 9 2)    ;=> (-6 -4 -2 0 2 4 6 8)
(multiplos -30 30 7)  ;=> (-28 -21 -14 -7 0 7 14 21 28)
(multiplos 1 10 0)    ;=> (1 2 3 4 5 6 7 8 9 10)
```

---

## Exercise Comp-f: `cambia-si(l1, l2, f-cond)`

This function changes the values of list `l1` by replacing an element with the corresponding element from list `l2` (at the same position), but only if the condition `f-cond` holds true for that value. It also validates its arguments.

```scheme
(define (cambia-si . args)
  (cond
    ([not (= (length args) 3)]
         (error "cambia-si(l1, l2, f-cond): requiere dos argumentos"))
    [(not (and (list? (car args)) (list? (cadr args))))
         (error "cambia-si(l1, l2, f-cond): l1 y l2 deben ser listas")]
    [(not (equal? (length (car args)) (length (cadr args))))
         (error "cambia-si(l1, l2, f-cond): Las dos listas deben tener el mismo tamaño")]
    [else
         (map (lambda (x y) (if ((caddr args) x y) y x)) (car args) (cadr args))]))

(displayln "\nEjercicio Comp-f) cambia-si: ")
(cambia-si '(1 2 4 8 16 32 64 128) '(2 3 4 5 6 7 8 9) <) ; => (2 3 4 8 16 32 64 128)
```

---

This concludes the complementary exercises.
