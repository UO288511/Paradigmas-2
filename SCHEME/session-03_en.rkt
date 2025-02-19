(require mzlib/compat)

; -----------------------------------------------------------------------
; REVIEW of the number of arguments in functions
; and their syntax
; -----------------------------------------------------------------------

; IMPORTANT: All the examples provided are lambda expressions,
;            but they can also be used in named functions (define)

; CASE 1: FUNCTIONS WITH A FIXED NUMBER OF ARGUMENTS
;
; For example, three fixed arguments
(displayln "Example of a function with a FIXED number of arguments (three in this case):")
(displayln "(lambda (x y z)")

; Note that this is merely an example of how to define a function with three arguments
; and it is not intended to solve any specific problem
((lambda (x y z)
   (display "First argument x: " )
   (displayln x)
   (display "Second argument y: ")
   (displayln y)
   (display "Third argument z: ")
   (displayln z)) 'a 'b '(c d))



; CASE 2: FUNCTIONS WHERE THE FIRST ARGUMENTS ARE FIXED (AND THUS REQUIRED) AND
; AFTER THESE, ANY NUMBER OF OPTIONAL ARGUMENTS IS ALLOWED.
; 
;
; Example of a function where the first two arguments are fixed (required)
; and then any number of optional arguments is allowed
;
; EACH INITIAL FIXED (REQUIRED) ARGUMENT HAS ITS OWN SYMBOL, AND THEN
; A SINGLE SYMBOL (WHICH WILL BE A LIST) IS USED TO STORE THE REMAINDER OF THE
; OPTIONAL ARGUMENTS. THIS LAST SYMBOL IS SEPARATED FROM THE PREVIOUS ONES USING DOT NOTATION
(displayln "\nExample of a function with two fixed arguments and the rest optional:")
(displayln "(lambda (x y . z)")

; x and y ARE THE FIRST REQUIRED ARGUMENTS. z WILL BE A LIST WITH THE REMAINDER OF
; THE OPTIONAL ARGUMENTS. z COULD BE THE EMPTY LIST --> NO OPTIONAL ARGUMENTS
((lambda (x y . z)
   (display "First argument x: " )
   (displayln x)
   (display "Second argument y: ")
   (displayln y)
   (display "List of optional arguments z: ")
   z) 'a 'b '(c d) '(e) 'f)



; CASE 3: FUNCTIONS THAT ALLOW AN INDETERMINATE NUMBER OF ARGUMENTS AND ALL ARE OPTIONAL.

;;; Function with optional arguments, where z is the list
;;; of arguments (note that the parameter syntax changes,
;;; instead of (. z) it is just z)
(displayln "\nExample of a function with an indeterminate number of arguments (all optional):")
(displayln "(lambda z")

((lambda z
   (display "List of optional arguments z: ")
   z) 'a 'b '(c d) '(e) 'f)



; ----------------------------------------------------------------------------------------------
; We are going to use CASE 3 TO VALIDATE THAT A FUNCTION HAS THE CORRECT NUMBER OF ARGUMENTS.
;
; We will validate more things, but this is THE MOST IMPORTANT,
; and it REQUIRES THAT THE FUNCTION'S NUMBER OF ARGUMENTS BE INDETERMINATE --> NEVER FORGET
; TO DO THIS VALIDATION WHEN ASKED TO VALIDATE A FUNCTION'S ARGUMENTS.
; -----------------------------------------------------------------------------------------------

; To validate the number of arguments of a function, we make the function accept only
; indeterminate parameters (CASE 3). By doing so, ALL the arguments passed when calling
; the function will be collected in A LIST (see CASE 3 above).
; Since they are all in a list, it is NOW POSSIBLE to validate that it has the correct number
; of arguments by comparing with the list’s length.

; Example: The function frecuency(x, l) that was requested in the complementary exercise
; Comp-d) of the previous session (Session-02)
;
; Define, using higher-order functions (FOS), the function frecuency(x, l) that returns
; the number of occurrences of x in the list l.
;
; If we did it normally (WITHOUT VALIDATING THE ARGUMENTS), the solution would be:
; NOTE: We have appended _SV to the function name so that it does not cause a double definition error later.
;
(define (frecuency_SV x l)
  (length (filter (lambda (y) (equal? x y)) l)))

; But by solving it this way, we have no way of verifying that, when called, exactly two arguments are passed.
; Therefore, we define another version (this time with the real function name) with indeterminate parameters
; and then check that the list of parameters has a length of 2.
(define (frecuency . args)
  ; We are going to perform several checks (using cond)
  (cond
    ; Check that there are exactly TWO arguments
    ; NEVER FORGET THIS CHECK, AS IT IS THE REASON WE
    ; WERE FORCED TO MAKE ALL THESE CHANGES
    ([not (= (length args) 2)]
         (error "frecuency(x, l): requires two arguments"))
    ; Check that the second argument is a list
    ([not (list? (cadr args))]
         (error "frecuency(x, l): the second argument must be a list"))
    ; If everything is correct, then proceed with the original function code
    [else
         ; Note that x is the car of args and l is the cadr of args
         (length (filter (lambda (y) (equal? (car args) y)) (cadr args)))]))


; Or, directly defining a lambda function (we call it frecuency2 so that it does not cause redefinition errors)
(define frecuency2
  (lambda args
    (cond
      ([not (= (length args) 2)]
           (error "frecuency2(x, l): requires two arguments"))
      ([not (list? (cadr args))]
           (error "frecuency2(x, l): the second argument must be a list"))
      [else
           (length (filter (lambda (y) (equal? (car args) y)) (cadr args)))])))


; NOTE: It is not necessary to validate the arguments of the functions you create from now on,
;       unless you are explicitly instructed to do so.


; --------------------------------------------------------------------------------------------------------------
; FROM THIS POINT ON, WE WILL FOCUS ON HIGHER-ORDER FUNCTIONS,
; INCLUDING PREDEFINED HIGHER-ORDER FUNCTIONS: filter, map, apply, etc.
;
; First, we are going to redefine the 'and' and 'or' operations of this language because we will need them
; to solve some exercises that follow.
;
; In this language, 'or' and 'and' ARE NOT FUNCTIONS, THEY ARE MACROS, and therefore cannot be used
; as parameters in higher-order functions. For this reason, we will define _or and _and which, being functions,
; can be used in higher-order functions.

;;; Definition of _and and _or functions for any number of arguments
;;; They can be used in higher-order functions and it is necessary
;;; to redefine them because in Scheme, 'and' and 'or' are macros rather than functions

(define _or
  (lambda x
    (letrec ([f (lambda (y)
                  (cond [(null? y) #f]
                        [(car y)]                 ; [(car y) #t] if only #t or #f is returned
                        [else (f (cdr y))]))])
      (f x))))

; Test of functionality
(displayln "\n_or: ")
(_or #f #f 'a)  ;=> a
(_or #f #f)     ;=> #f


(define _and
  (lambda x
    (letrec ([f (lambda (y)
                  (cond [(null? y) #t]
                        [(not (car y)) #f]
                        [(null? (cdr y))          ; this condition can be omitted if
                         (car y)]                 ; only #t or #f is returned
                        [else
                         (f (cdr y))]))])
      (f x))))

; Test of functionality
(displayln "\n_and: ")
(_and #t 'a 0 ())         ;=> ()
(_and #t 'a #f '(a b c))  ;=> #f



; -------------------------------------------------------------------------------
; NOW IT'S YOUR TURN
;
; In the previous session we implemented the recursive function Extrae;
; in this session, we want to implement it using higher-order functions (FOS).
;
; The function Extrae from the previous session:
;; Extrae(Data, Filter, Format) => (...)
;;
;; Higher-order function that receives:
;; data                      : the data to be examined
;; Filter(Person)  => #t/#f  : a filtering function applied to each person
;; Format(Person) => (...)   : a function that returns the relevant (or interesting) information from a person
;;
;;
;; The function Extrae returns the list of elements from data that satisfy Filter,
;; formatted via Format. In general, both the Filter function and the Format function
;; will be lambda expressions, but in cases where it is convenient, already defined accessor functions
;; can also be used.


; EXERCISE 1: Define the function Extrae using higher-order functions (FOS)
; HINT:
;    FIRST, filter the data
;    SECOND, format each of the filtered items
;
; WRITE THE DEFINITION HERE
(define (Extrae data filtro format)
  (map format (filter filtro data)))
; Observe the format of the following data
(define numeros
  '((n1 (3 7 3)) (n2 (3 4 9 0 1)) (n3 (3 0 3 4)) (n4 (7))))



; EXERCISE 2: Call the previously defined function Extrae to obtain the names
; of all numbers with more than 3 digits
(displayln "\nExercise 2) Names with more than 3 digits: ")
;
; WRITE THE CALL TO Extrae HERE
(define (more-than-3 num)
  (> (length (cadr num)) 3))


(Extrae numeros more-than-3 car)

(Extrae numeros (lambda (x) (> (length (cadr x)) 3)) car)


; IT SHOULD RETURN => (n2 n3)


; EXERCISE 3: Now, without using Extrae, but using filter, do the following:
; Obtain all numbers with more than 3 digits and display all their information.
(displayln "\nExercise 3) Numbers with more than 3 digits (all the information): ")
;
; WRITE THE CALL TO filter HERE
(filter (lambda (x) (> (length (cadr x)) 3)) numeros)
; IT SHOULD RETURN => ((n2 (3 4 9 0 1)) (n3 (3 0 3 4)))



; EXERCISE 4: Define the function union(A, B) using higher-order functions (FOS) and VALIDATE ITS ARGUMENTS
; -------------------------------------------------------------------------------
; union(A, B) = A U B 
; Returns the union of two sets
;
; WRITE THE DEFINITION HERE
(define (union a b)
  (append (filter(lambda (x)(not(member x b)))a)b))

(displayln "\nExercise 4) union: ")
; FUNCTIONALITY TESTS
;(union '(c a x) 3)       ;=> error
;(union '(c a x))         ;=> error
(union '(c a x) '(a (a))) ;=> (c x a (a))


; EXERCISE 5: Define the function subset?(A, B) using higher-order functions (FOS), specifically filter.
; REMEMBER THAT YOU SHOULD NOT VALIDATE ARGUMENTS UNLESS YOU ARE EXPLICITLY INSTRUCTED TO DO SO.
; --------------------------------------------------------------------------------
; subset?(A, B) = Is A contained in B?
; Returns true if set A is a subset of B
;
; WRITE THE DEFINITION HERE
(define (subset? A B)
  (null? (filter (lambda(x) (not (member x B))) A)))

(displayln "\nExercise 5) subset?:")
; FUNCTIONALITY TESTS
(subset? '(c b) '(a x b d c y))    ;=> #t
(subset? '(c b) '(a x b d (c) y))  ;=> #f


; EXERCISE 6: Redefine the previous function but by combining map and apply.
; Call the function subset2? so that it does not cause redefinition errors.
; -----------------------------------------------------------------------------------
; subset2?(A, B) = Is A contained in B?
; Returns true if set A is a subset of B
;
; WRITE THE DEFINITION HERE
(define (subset2? A B)
   (if (apply _and (map (lambda(x) (member x B)) A)) #t #f))


(displayln "\nExercise 6) subset2?:")
; FUNCTIONALITY TESTS
(subset2? '(c b) '(a x b d c y))    ;=> #t
(subset2? '(c b) '(a x b d (c) y))  ;=> #f


; -----------------------------------------------------------------------------------
; THE FOLLOWING EXERCISES ARE OPTIONAL (VOLUNTARY) AND
; SOME OF THEM MAY BE OF HIGH DIFFICULTY
;
; OPTIONAL EXERCISES
; -----------------------------------------------------------------------------------

; The function enteros(x, y) is provided, which, given two integers a and b,
; returns the list of consecutive integers (a, a+1, a+2, ... b-2, b-1); that is,
; the integers in the range [a, b). This list will be empty if a >= b.
(define (enteros x y)
  (if (>= x y)
      ()
      (cons x (enteros (+ x 1) y))))

(displayln "\nFunction enteros: ")
(enteros -5 10) ;=> (-5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9)
(enteros 1 6)   ;=> (1 2 3 4 5)

;
; Use higher-order functions (FOS) and, if necessary, the function enteros(x, y) to define
; the following functions:
;
; EXERCISE Comp-a: sucAritm0(r, n) that returns the list (0, r, 2*r, ... (n-1)*r); that is,
; the list of the first n terms of the arithmetic sequence whose first element is 0 and with common difference r.
;
; WRITE THE DEFINITION HERE
(define (sucAritm r n)
  (map (lambda (x) (* r x))(enteros 0 n)))

(displayln "\nExercise Comp-a) sucAritm0: ")
; FUNCTIONALITY TESTS
(sucAritm 3 5)  ;=> (0 3 6 9 12)


; EXERCISE Comp-b: suc-aritmetica(a, r, n) that returns the list (a, a+r, a+2*r, ... a+(n-1)*r);
; that is, the list of the first n terms of the arithmetic sequence whose first element is a and with common difference r.
;
; WRITE THE DEFINITION HERE
(define (suc-aritmetica a r n)
  (map (lambda (x) (+ a x))(sucAritm r n)))
(displayln "\nExercise Comp-b) suc-aritmetica: ")
; FUNCTIONALITY TESTS
(suc-aritmetica -7 3 5)   ;=> (-7 -4 -1 2 5)


; EXERCISE Comp-c) suma-aritmetica(a, r, n) that returns the sum of the first n terms
; of the arithmetic sequence whose first element is a and with common difference r.
;
; WRITE THE DEFINITION HERE
(define (suma-aritmetica a r n)
  (apply +(suc-aritmetica a r n)))

(displayln "\nExercise Comp-c) suma-aritmetica: ")
; FUNCTIONALITY TESTS
(suma-aritmetica -7 3 5)   ;=> -5


; EXERCISE Comp-d) pares(a, b) that returns the list of even numbers in the range [a, b] of integers
;
; WRITE THE DEFINITION HERE
(define (pares a b)
  (filter even? (enteros a (+ 1 b))))

  
(displayln "\nExercise Comp-d) pares: ")
; FUNCTIONALITY TESTS
(pares -7 9)   ;=> (-6 -4 -2 0 2 4 6 8)


; EXERCISE Comp-e) multiplos(a, b, n) that returns the list of all multiples of the integer n
; that belong to the range [a, b] of integers. If n = 0, return the list of
; integers in the given range.
;
; WRITE THE DEFINITION HERE



(displayln "\nExercise Comp-e) multiplos: ")
; FUNCTIONALITY TESTS
;(multiplos -7 9 2)    ;=> (-6 -4 -2 0 2 4 6 8)
;(multiplos -30 30 7)  ;=> (-28 -21 -14 -7 0 7 14 21 28)
;(multiplos 1 10 0)    ;=> (1 2 3 4 5 6 7 8 9 10)


; EXERCISE Comp-f) Define the function cambia-si(l1, l2, f-cond)
; which changes the values of the list l1 (given as the first parameter) to the element
; from the list given as the second parameter (l2) at the same position,
; but only if the condition f-cond holds true for those values.
;
; VALIDATE THE ARGUMENTS OF THIS FUNCTION
;
; WRITE THE DEFINITION HERE

(displayln "\nExercise Comp-f) cambia-si: ")
; FUNCTIONALITY TESTS
;(cambia-si '(1 2 4 8 16 32 64 128) '(2 3 4 5 6 7 8 9) <) ; => (2 3 4 8 16 32 64 128)

