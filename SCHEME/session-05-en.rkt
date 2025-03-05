; Scheme no tiene currificación de forma nativa
; Función curry del módulo "racket/function"

(require mzlib/compat racket/function)

;; -----------------------------------------------------------
;; Preliminary examples (not labeled as exercises)
;; -----------------------------------------------------------
(define ll-numeros '((1 3 -10) (5 -8 0 17 21) (8 3)))

; Given the list ll-numeros, where elements are sublists of integers,
; obtain a new list of lists containing only the even values from the original sublists.
(display "Filtered evens: ")
(map (lambda (l)
       (filter even? l)) ll-numeros)

; Using currying to filter the values
(display "Filtered evens (curry): ")
(map (curry filter even?) ll-numeros)

; Examples of currying and lambda functions:
(define div-5/x (curry / 5))
(display "div-5/x(3): ")
(div-5/x 3)
(display "div-5/x(2.0): ")
(div-5/x 2.0)

(define div-x/5 (curryr / 5))
(display "div-x/5(3): ")
(div-x/5 3)
(display "div-x/5(2.0): ")
(div-x/5 2.0)

; In Racket, an equivalent definition of 5/x:
(define 5/x
  (lambda(x)
    (/ 5 x)))
(display "5/x(3): ")
(5/x 3)
(display "5/x(2.0): ")
(5/x 2.0)

; Making 5/x accept a variable number of arguments:
(define 5/x
  (lambda x
    (/ 5 (apply * x))))
(display "div-5/x(2, -1, 3.0): ")
(div-5/x 2 -1 3.0)
(display "5/x(2, -1, 3.0): ")
(5/x 2 -1 3.0)

; Using compose and currying with datos:
(define datos '((a (16 -3 4 0)) (b (5 8 0 11 2)) (c (8 19 9 -15))))
(display "Sums: ")
(map (lambda(x)
       (apply + (cadr x))) datos)
(display "Sums (compose): ")
(map (compose (curry apply +) cadr) datos)
(display "Numbers of n2: ")
(cadar (filter (compose (curry eq? 'a) car) datos))
(display "Numbers of n2: ")
(cadar (filter (curry member 'a) datos))


;; ============================================================
;; Exercise 1:
;; Define the function binary-and(n1, n2)
;; which returns the AND of two binary numbers represented by lists
;; of zeros and ones.
;; Example:
;; (binary-and '(1 1 0 0 1 0 1 0) '(0 1 0 1 1 0 1 1))
;;  => (0 1 0 0 1 0 1 0)
;; ============================================================
(define (binary-and n1 n2)
  (map * n1 n2))


(define mybin(curry binary-and))



(display "binary-and: ")

(binary-and '(1 1 0 0 1 0 1 0) '(0 1 0 1 1 0 1 1))
(display "Curry binary-and: ")
(displayln ((mybin '(1 1 0 0 1 0 1 0))'(0 1 0 1 1 0 1 1)))


;; ============================================================
;; Exercise 2:
;; Define the function maxLength which returns the greatest length
;; among the lists provided as arguments.
;;
;; Example:
;; (maxLength '(a (b c)) '(1 2 3 4) '((a b) (c d) e (f) g)) ;=> 5
;;
;; Tips:
;; - Use 'length' to calculate the length of each list.
;; - Use 'map' to apply 'length' to each list in the list of arguments.
;; - Use 'apply' along with 'max' to get the maximum value of the lengths.
;; ============================================================
(define (maxLength . lists)
    (apply max (map length lists)))

(define curried-maxLength(curry maxLength))

(display "maxLength: ")
(maxLength '(a (b c)) '(1 2 3 4) '((a b) (c d) e (f) g)) ;=> 5
(display "curry maxLength: ")
(displayln ((curried-maxLength '(a (b c)))'(1 2 3 4) '((a b) (c d) e (f) g)))

;; ============================================================
;; Exercise 3:
;; Define the function filter-for that takes a predicate 'f' and
;; a series of lists (l1, l2, ...) and returns a list formed
;; by the results of applying (filter f) to each of them.
;;
;; Examples:
;; (filter-for atom? '(1 (2) 3) '(9 (2 3)) '(0 1 6))      ; => ((1 3) (9) (0 1 6))
;; (filter-for number? '(a (b) 3) '(d (2 e)) '(a 1 (b)))  ; => ((3) () (1))
;;
;; Tips:
;; - Use the 'filter' function to extract from each list the elements
;;   that satisfy the predicate 'f'.
;; - Use 'curry' to create a partial function that applies 'filter'
;;   with the predicate 'f' to each list.
;; - Use 'map' to apply this function to each of the received lists.
;; - The notation '. rest' in the definition allows the function to accept
;;   a variable number of lists as arguments.
;; ============================================================

(define (filter-for cond . lists)
  (map (lambda (c) (filter cond c)) lists))


(define (curried-filter-for cond)
  (lambda args(apply filter-for cond args)))


(displayln "filter:")
(displayln (filter-for atom? '(1 (2) 3) '(9 (2 3)) '(0 1 6)))
(displayln (filter-for number? '(a (b) 3) '(d (2 e)) '(a 1 (b))))

(displayln "Curry filter for:")
(displayln ((curried-filter-for atom?) '(1 (2) 3) '(9 (2 3)) '(0 1 6)))
(displayln ((curried-filter-for number?) '(a (b) 3) '(d (2 e)) '(a 1 (b))))

;; ============================================================
;; Data Definition:
;; Define the symbol Datos which holds information organized by key fields
;; (such as name, studies, etc.) for several people.
;; ============================================================
(define
 Datos
 '(((nombre LUIS) (sexo V) (apellidos GARCIA PEREZ) (estudios (INFORMATICA MEDICINA)) (edad 26) (en_activo #t))
  ((en_activo #t) (sexo M) (nombre MARIA) (apellidos LUZ DIVINA) (edad 23) (estudios (INFORMATICA)))
  ((nombre ADOLFO) (sexo V) (estudios (INFORMATICA)) (apellidos MONTES PELADOS) (edad 24) (en_activo #f))
  ((nombre ANA) (apellidos GARCIA GONZALEZ) (edad 22) (sexo M) (estudios ()) (en_activo #t))
  ((sexo V) (estudios ()) (nombre JOSE) (en_activo #f) (apellidos PEREZ MONTES) (edad 36))
  ((edad 12) (nombre JOSHUA) (apellidos IGLESIAS GARCIA) (sexo V) (estudios ()) (en_activo #t))
  ((nombre MARUJA) (edad 9) (sexo M) (estudios ()) (apellidos FERNANDEZ GARCIA) (en_activo #f))
  ((apellidos PUERTAS VENTANAS) (nombre GUILLERMO) (en_activo #f) (edad 2) (sexo V) (estudios (ECONOMIA)))))


;; ============================================================
;; Exercise 4:
;; Define the function info(key, p)
;; which returns a list with the value associated with the key for a given person p.
;; Example:
;; (info 'apellidos (cadr Datos))  ; => (LUZ DIVINA)
;;
;; Tips:
;; - Use the 'filter' function to find the pair in the list 'p' where the car is equal to 'key'.
;; - Use 'lambda' to create an anonymous function that checks if the car of a pair is equal to 'key'.
;; - Use 'cdar' to extract the value associated with the key from the filtered result.
;; - Alternatively, you can use 'compose' and 'curry' to achieve the same result in a more functional style.
;; ============================================================

(define (info key p)
(cdar (filter (lambda (x) (eq? (car x) key)) p)))

;(define (info key person)
;   (cdr(assoc key person)))

(define curried-info (curry info))

(display "info: ")
(info 'apellidos (car Datos))  ; => (LUZ DIVINA)

(display "Curried info: ")
(display ((curried-info 'apellidos)(car Datos)))


;; ============================================================
;; Exercise 5:
;; Define the function buscar(key, datos)
;; which returns the list with the given key information for all people in datos.
;; Example:
;; (buscar 'nombre Datos)
;; ;=> ((LUIS) (MARIA) (ADOLFO) (ANA) (JOSE LUIS) (JOSHUA) (MARUJA) (GUILLERMO))
;;
;; Tips:
;; - Use the 'map' function to apply a function to each element in the list 'datos'.
;; - Define a helper function 'info' that retrieves the value associated with the key for a given person.
;; - Use 'curry' to partially apply the 'info' function with the given key.
;; ============================================================

(define (buscar key datos)
  (map (curry info key)datos))

(display "search: ")
(buscar 'nombre Datos)  


;; ============================================================
;; Exercise 6:
;; Define the function buscar+(l-keys, datos)
;; which returns the list with the corresponding information for the given keys
;; in l-keys for all people in datos.
;; Suggestion: Define a helper function for a single person then map it over Datos.
;;
;; Examples:
;; (buscar+ '(nombre apellidos) Datos)
;; ;=> ((LUIS GARCIA PEREZ) (MARIA LUZ DIVINA) (ADOLFO MONTES PELADOS) ...)
;; (buscar+ '(nombre sexo edad) Datos)
;; ;=> ((LUIS V 26) (MARIA M 23) (ADOLFO V 24) (ANA M 22) (JOSE V 36) ...)
;;
;; Tips:
;; - `map`: Applies a function to each element of a list, returning a list of results.
;; - `lambda`: Creates an anonymous function.
;; - `apply`: Applies a function to a list of arguments.
;; - `append`: Concatenates lists.
;; - `curry`: Partially applies a function, fixing some arguments and returning a new function.
;; ============================================================
(define (buscar+ keys Datos)
  (map (curryr buscar Datos)keys))


(displayln "buscar+:")
(buscar+ '(nombre apellidos) Datos)
(buscar+ '(nombre sexo edad) Datos)


;; ============================================================
;;  Additional exercises
;; ============================================================

;; ============================================================
;; Exercise 7:
;; Define the function presentar(datos, orden_claves)
;; which, when evaluated, receives the Datos information as the first argument and
;; a second argument containing the keys specifying the order in which the fields should be displayed.
;; Use the predefined sort(l, f) function to sort the keys.
;;
;; Example:
;; (presentar Datos '(apellidos nombre edad sexo estudios en_activo))
;; ============================================================
;(displayln "presentar:")
;(presentar Datos '(apellidos nombre edad sexo estudios en_activo))


;; ============================================================
;; Exercise 8:
;; Define the function change-all(l, u, v)
;; which returns the resulting list of changing each occurrence of u in l to v.
;;
;; Example:
;; (change-all '((a) b 2 (a 3) (a) a) '(a) 0)  ; => (0 b 2 (a 3) 0 a)
;; ============================================================
;(display "change-all: ")
;(change-all '((a) b 2 (a 3) (a) a) '(a) 0)


;; ============================================================
;; Exercise 9:
;; Currified version:
;; Define the function choose(u, v, z)
;; which returns v if u is equal to z and z otherwise.
;; Use this function to provide a currified version of change-all.
;; ============================================================


;; ============================================================
;; Exercise 10:
;; Define the recursive function fill(x, l).
;; Given a list l, returns a list of all possible sublists obtained by inserting x
;; at each distinct position in l.
;;
;; Examples:
;; (fill x ()) => ((x))
;; (fill x (a b)) => ((x a b) (a x b) (a b x))
;; ============================================================
;(display "fill: ")
;(fill 'x '(a (b c) d)) ; => ((x a (b c) d) (a x (b c) d) (a (b c) x d) (a (b c) d x))


;; ============================================================
;; Exercise 11:
;; Provide a currified version of the fill function.
;; ============================================================
;(display "fill (curry): ")
;(fill 'x '(a (b c) d)) ; => ((x a (b c) d) (a x (b c) d) (a (b c) x d) (a (b c) d x))


;; ============================================================
;; Exercise 12:
;; Define the symbol my-curry as a lambda function to behave
;; the same way as currying a function f(x, y) with two arguments.
;; If the previous definition is too complex, you may define two functions,
;; g(f) and h(f, x), that return equivalent lambda functions for curry(f) and curry(f, x) respectively.
;; ============================================================
