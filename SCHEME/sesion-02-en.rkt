; FUNCTIONAL PROGRAMMING
; HIGHER ORDER FUNCTIONS – lambda expressions, filters

; We are going to work with a database of people to perform
; practically all the exercises in this session. Read carefully
; its description and format.

; The symbol Datos provides people data in the format indicated:
;
;   (( Name Surname1 Surname2 Age Sex (Studies) Works? ) …)
;
; Sex: H (male) or M (female)
; Studies: list of higher education studies of that person
; Works?: #t or #f
;

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

; We are going to define the function datos-persona so that we can (and you can too)
; use it as an example person when checking the solutions to the exercises.
(define datos-persona (cadr Datos))
(displayln "Example of a person's data: ")
(writeln datos-persona)

; The first thing you are going to implement are observers (get functions) to access
; a field/attribute of a given person.
; To avoid prolonging the session too much, some of them we will provide already and others not.

; REMEMBER THAT IN THE PREVIOUS SESSION TUTORIAL WE SAW THAT THIS IS DONE
; BY APPROPRIATELY COMBINING CALLS TO THE car AND cdr FUNCTIONS.
; TRY TO USE THE ABBREVIATED VERSION cxxxxxxr

(displayln "\nEXERCISE 1: Implementation of get functions")

; EXERCISE 1a) Definition of get-nombre(p) -> returns the name of a person
; The first get is provided so you can focus on solving the rest.
(define (get-nombre p)
    (car p))


; VERY IMPORTANT, READ CAREFULLY: In all the exercises of every practice session
; we will leave a test prepared for you to check if you have correctly completed the exercise.
; WE LEAVE IT COMMENTED so that it does not produce errors when executed 
; (the test will give errors until the function is defined and correctly implemented).
;
; WHEN YOU WANT TO TEST YOUR EXERCISE, UNCOMMENT THE TEST.
; Then execute the file. Notice that in each test WE TELL YOU WHAT IT SHOULD RETURN
; using a comment and an arrow  ;=> MARIA

; As an example, we leave the test for the function get-nombre uncommented since we have already implemented it.
;
; TEST (using the example person the function datos-persona defined earlier)
(displayln "\nExercise 1a) get-nombre: ")
(get-nombre datos-persona)  ;=> MARIA


; NOW IT'S YOUR TURN TO WORK
; ============================

; EXERCISE 1b) Definition of get-apellidos(p) -> returns a list with the two surnames of a person
; IN THIS LANGUAGE, IN GENERAL, TO RETURN MORE THAN ONE VALUE WE ALWAYS USE A LIST

; PUT YOUR DEFINITION HERE
(define (get-apellidos p)
  (list (cadr p)(caddr p)))
; TEST – UNCOMMENT THE SECOND LINE BELOW WHEN YOU WANT TO TEST YOUR DEFINITION
(displayln "\nExercise 1b) get-apellidos: ")
(get-apellidos datos-persona)  ;=> (LUZ DIVINA)



; EXERCISE 1c) Definition of get-nombre-completo(p) -> returns a list with the name and surnames of a person
; PUT YOUR DEFINITION HERE
(define (get-nombre-completo p)
  (list (car p)(cadr p)(caddr p)))
; TEST
(displayln "\nExercise 1c) get-nombre-completo: ")
(get-nombre-completo datos-persona) ; => (MARIA LUZ DIVINA)



; EXERCISE 1d) Definition of get-edad(p) -> returns the age of a person
; PUT YOUR DEFINITION HERE
(define (get-edad p)
  (cadddr p))
; TEST
(displayln "\nExercise 1d) get-edad: ")
(get-edad datos-persona)  ;=> 23



; EXERCISE 1e) Definition of get-sexo(p) -> returns the biological sex of a person
; PUT YOUR DEFINITION HERE
(define (get-sexo p)
  (car (cddddr p)))
; TEST
(displayln "\nExercise 1e) get-sexo: ")
(get-sexo datos-persona) ; => M



; THE LAST TWO WE WILL DO FOR YOU SO THAT THE SESSION DOESN'T GET TOO LONG
; EXERCISE 1f) Definition of get-estudios(p) -> returns the list of higher education studies of a person
(define (get-estudios p)
  (cadr (cddddr p)))
; TEST
(displayln "\nExercise 1f) get-estudios: ")
(get-estudios datos-persona)  ;=> (INFORMATICA BIOLOGIA)



; EXERCISE 1g) Definition of trabaja?(p) -> returns true if the person works and false otherwise
(define (trabaja? p)
  (caddr (cddddr p)))
; TEST
(displayln "\nExercise 1g) trabaja? ")
(trabaja? datos-persona)  ;=> #t



; Let's complicate things a little (one more level of difficulty)
; We provide you with an implemented recursive higher order function Extrae that will
; allow us to extract ANY information from the people database.
;
; READ CAREFULLY THE PARAMETERS IT EXPECTS, WHAT IT DOES, AND WHAT IT RETURNS.
; NOTE THAT THIS IS A HIGHER ORDER FUNCTION.
;
;----------------------------------------------------------------------
; 2 – Applying the function Extrae
;----------------------------------------------------------------------
; Extrae(Datos, Filtro, Formato) => (…)
;
; Higher order function that receives:
; Datos                     : the data to examine
; Filtro(Persona)  => #t/#f : a filtering function applied to each person
; Formato(Persona) => (…): a function that returns the relevant,
;                             or interesting, information of a person
;
; The function Extrae returns the list of elements in Datos that satisfy Filtro
; and are formatted via Formato.
; Filtro will be a function (or lambda expression) that filters the people database
; to KEEP ONLY THOSE THAT MEET A CONDITION.
; Formato will be a function (or lambda expression) that extracts the information
; we want from the previously filtered persons (for example, we only want their surnames).

; Recursive definition of Extrae
;  1. Base       : Extrae((), Filtro, Formato) = ()
;  2. Recurrence: If Datos is not empty (i.e., Datos = cons(car(Datos), cdr(Datos)))
;       Hypothesis: assume Extrae(cdr(Datos), Filtro, Formato) = H
;       Thesis    : Extrae(Datos, Filtro, Formato) =
;                                  if Filtro(car(Datos))
;                                  then cons(Formato(car(Datos)), H)
;                                  else H

(define (Extrae Datos Filtro Formato)
  (cond
    ([null? Datos] Datos)
    ([Filtro (car Datos)] (cons (Formato (car Datos))
                                (Extrae (cdr Datos) Filtro Formato)))
    (else (Extrae (cdr Datos) Filtro Formato))))



; We are going to ask you to make various calls to the function Extrae above
; to extract specific information from the people database.
;
; IMPORTANT: WHEN CALLING Extrae YOU MAY ONLY USE AS Filter OR AS
;             Format either the previously defined get FUNCTIONS or
;             lambda expressions; UNDER NO CIRCUMSTANCES SHOULD YOU MAKE NEW DEFINITIONS

(displayln "\nEXERCISE 2: Extrae(Datos, Filtro, Formato)")

; THE FIRST EXERCISE WE SOLVE FOR YOU AS AN EXAMPLE

; EXERCISE 2a) List of names of adult persons
(displayln "\nExercise 2a) List of names of adult persons:")

; UNCOMMENT THE SOLUTION (THE NEXT LINE). IT WILL FAIL IF YOU HAVEN'T IMPLEMENTED get-edad
(Extrae Datos (lambda (p) (>= (get-edad p) 18)) get-nombre)
; Note that as filter we are using a lambda expression and as format the predefined
; function get-nombre.
; It should return: (LUIS MARIA ADOLFO ANA JOSE ROSA GUILLERMO)


; NOW IT'S YOUR TURN TO WORK
; ============================

; EXERCISE 2b) The list of complete names of all persons
(displayln "\nExercise 2b) List of complete names of all persons:")
; PUT YOUR CALL TO Extrae HERE
(Extrae Datos (lambda (p) #t) get-nombre-completo)
; It should return: (DO NOT UNCOMMENT THIS, IT WOULD GIVE AN ERROR – WE PROVIDE IT SO YOU CAN VALIDATE THE EXERCISE
; ((LUIS GARCIA PEREZ)
;  (MARIA LUZ DIVINA)
;  (ADOLFO MONTES PELADOS)
;  (ANA GARCIA GONZALEZ)
;  (JOSE PEREZ MONTES)
;  (JOSHUA IGLESIAS GARCIA)
;  (MARUJA FERNANDEZ GARCIA)
; (ROSA LINDO SUAREZ)
; (GUILLERMO PUERTAS VENTANAS))



; EXERCISE 2c) The list of names of all women who work
(displayln "\nExercise 2c) List of names of women who work:")
; PUT YOUR CALL TO Extrae HERE
(Extrae Datos(lambda (p)
               (and (eq?'M (get-sexo p))(eq? #t (trabaja? p))))
        get-nombre)
; It should return: (MARIA ROSA)



; EXERCISE 2d) The list of complete names of all persons who have studies in INFORMATICA
(displayln "\nExercise 2d) List of complete names of all persons with studies in INFORMATICA")
; PUT YOUR CALL TO Extrae HERE
(Extrae Datos(lambda (p)
                (member 'INFORMATICA (get-estudios p)))
        get-nombre-completo)
; It should return: ((LUIS GARCIA PEREZ) (MARIA LUZ DIVINA) (ADOLFO MONTES PELADOS))



; EXERCISE 2e) List of pairs (sex age), where each pair is a list of two elements, of all persons without
;               higher education studies
(displayln "\nExercise 2e) List of pairs (sex age) of persons without higher education")
; PUT YOUR CALL TO Extrae HERE
(Extrae Datos
        (lambda (p) (null? (get-estudios p)))
        (lambda (p) (cons (get-sexo p) (get-edad p))))
; It should return: ((M 18) (H 36) (H 12) (M 9))



; EXERCISE 2f) List of ages of all women who have studied INFORMATICA
(displayln "\nExercise 2f) List of ages of all women with studies in INFORMATICA")
; PUT YOUR CALL TO Extrae HERE
(Extrae Datos (lambda (p)
                (and (member 'INFORMATICA (get-estudios p))(eq? 'M (get-sexo p))))
                get-edad)
; It should return: (23)



; EXERCISE 2g) The list of complete names of all persons who do not work
(displayln "\nExercise 2g) List of complete names of persons who do not work")
; PUT YOUR CALL TO Extrae HERE
(Extrae Datos (lambda (p)
                (eq? #f (trabaja? p)))
        get-nombre-completo)
; It should return: 
; ((ADOLFO MONTES PELADOS) (ANA GARCIA GONZALEZ) (JOSHUA IGLESIAS GARCIA) (MARUJA FERNANDEZ GARCIA) (GUILLERMO PUERTAS VENTANAS))



; EXERCISE 2h) The list of names of all persons with more than one higher education study
(displayln "\nExercise 2h) List of names of persons with more than one higher education study")
; PUT YOUR CALL TO Extrae HERE
(Extrae Datos (lambda (p)
                (> (length(get-estudios p))1))
        get-nombre)
; It should return: (LUIS MARIA ROSA)
; 


; Now we are going to redo the previous exercises (2x) in a more abstract way.
; For this we will use the higher order function gen-filtro which we have already implemented below.

; ----------------------------------------------------------
; 3 – FUNCTION gen-filtro
; ----------------------------------------------------------
; gen-filtro :: (A -> B) x (C x B -> BOOL) x C -> (A -> BOOL)
; gen-filtro(Extractor, Operador, Valor) => lambda(Persona)
;
; This higher order function returns a lambda function (p) to be applied 
; as a filter in Extrae. It is parameterized with:
;
; Extractor: function that extracts the data to be checked from the person
; Operador : function that compares the Valor with the output of Extractor (returns a boolean)
; Valor    : value with which the person's data is compared

(define (gen-filtro Extractor Operador Valor)
  (lambda(p) (Operador Valor (Extractor p)))) ; The novelty is that the function returns another function


; Now we are going to repeat the previous exercises (2x) but as filter WE WILL MANDATORILY USE
; THE FUNCTION gen-filtro
(displayln "\nEXERCISE 3: gen-filtro(Extractor Operador Valor)")

; JUST LIKE BEFORE, THE FIRST ONE WE DO AS AN EXAMPLE

; EXERCISE 3a) List of names of adult persons
(displayln "\nExercise 3a) List of names of adult persons:")
; UNCOMMENT THE SOLUTION (THE NEXT THREE LINES). IT WILL FAIL IF YOU HAVEN'T IMPLEMENTED get-edad
(Extrae Datos                         ; people's data
        (gen-filtro get-edad <= 18)   ; Filter: filter generated USING gen-filtro
        get-nombre)                   ; Format
; It should return the same as exercise 2a)


; NOW IT'S YOUR TURN TO WORK
; ============================

; EXERCISE 3b) The list of complete names of all persons
(displayln "\nExercise 3b) List of complete names of all persons:")
; PUT YOUR CALL TO Extrae HERE, but using as filter a call to gen-filtro
(define lista-todos
  (gen-filtro (lambda (p) #t) eq? #t))
(Extrae Datos lista-todos get-nombre-completo)
; It should return the same as exercise 2b)



; EXERCISE 3c) The list of names of all women who work
(displayln "\nExercise 3c) List of names of women who work:")
; PUT YOUR CALL TO Extrae HERE, but using as filter a call to gen-filtro
(define mujeres-trabajan
  (gen-filtro (lambda (p)
                (and  (trabaja? p) (get-sexo p))) eq? 'M))
(Extrae Datos mujeres-trabajan get-nombre)
; It should return the same as exercise 2c)



; EXERCISE 3d) The list of complete names of all persons who have studies in INFORMATICA
(displayln "\nExercise 3d) List of complete names of all persons with studies in INFORMATICA")
; PUT YOUR CALL TO Extrae HERE, but using as filter a call to gen-filtro
(define todos-informaticos
  (gen-filtro get-estudios member 'INFORMATICA ))
(Extrae Datos todos-informaticos get-nombre-completo)
; It should return the same as exercise 2d)



; EXERCISE 3e) List of pairs (sex age), where each pair is a list of two elements, of all persons without
;               higher education studies
(displayln "\nExercise 3e) List of pairs (sex age) of persons without higher education")                          
; PUT YOUR CALL TO Extrae HERE, but using as filter a call to gen-filtro
(define sin-estudios
  (gen-filtro (lambda (p) (get-estudios p)) eq? ()))
(Extrae Datos sin-estudios (lambda (p) (cons (get-sexo p)(get-edad p))))
; It should return the same as exercise 2e)



; EXERCISE 3f) List of ages of all women who have studied INFORMATICA
(displayln "\nExercise 3f) List of ages of all women with studies in INFORMATICA")
; PUT YOUR CALL TO Extrae HERE, but using as filter a call to gen-filtro
(define mujeres-informatica
  (gen-filtro (lambda(p)
                      (and (member 'INFORMATICA (get-estudios p))
                           (get-sexo p))) eq? 'M))
(Extrae Datos mujeres-informatica get-edad)
; It should return the same as exercise 2f)



; EXERCISE 3g) The list of complete names of all persons who do not work
(displayln "\nExercise 3g) List of complete names of persons who do not work")
; PUT YOUR CALL TO Extrae HERE, but using as filter a call to gen-filtro
(define people-nowork
  (gen-filtro (lambda (p)
                (trabaja? p))
              eq? #f))
(Extrae Datos people-nowork get-nombre-completo)
; It should return the same as exercise 2g)


; EXERCISE 3h) The list of names of all persons with more than one higher education study
(displayln "\nExercise 3h) List of names of persons with more than one higher education study")
; PUT YOUR CALL TO Extrae HERE, but using as filter a call to gen-filtro
(define more-studies
  (gen-filtro (lambda (p)
                (length(get-estudios p)))
              < 1) )
(Extrae Datos more-studies get-nombre)
; It should return the same as exercise 2h)



; If you have extra time, we propose some complementary exercises. If not, DO THEM ON YOUR OWN TO PREPARE FOR THE EXAM

; ----------------------------------------------------------------------------------------
; COMPLEMENTARY EXERCISES
; ----------------------------------------------------------------------------------------
;

; Defined the symbol numeros as indicated below:
; A list of numbers given by the list of their digits and
; that have an associated name.
(define numeros
  '((n1 (3 7 3))(n2 (3 4 9 0 1))(n3 (3 0 3 4)) (n4 (7))))

; USE THE filter FUNCTION TO OBTAIN THE REQUESTED NUMBERS.

; EXERCISE Comp-a) Obtain all numbers with more than 3 digits
(displayln "\nExercise Comp-a) Obtain all numbers with more than 3 digits")
; PUT YOUR CALL TO filter HERE
(filter (lambda (p)
          (> (length(cadr p)) 3))
        numeros)
; It should return:  ((n2 (3 4 9 0 1)) (n3 (3 0 3 4)))



; EXERCISE Comp-b) Obtain all numbers that contain a seven
(displayln "\nExercise Comp-b) Obtain all numbers that contain a seven")
; PUT YOUR CALL TO filter HERE
(filter (lambda (p)
          (member 7 (cadr p)))
        numeros)
; It should return:  ((n1 (3 7 3)) (n4 (7)))


; EXERCISE Comp-c) Obtain all numbers that have 3 as the first digit
(displayln "\nExercise Comp-c) Obtain all numbers that have 3 as the first digit")
; PUT YOUR CALL TO filter HERE
(filter (lambda (p)
          (eq? (caadr p) 3))
        numeros)
; It should return:  ((n1 (3 7 3)) (n2 (3 4 9 0 1)) (n3 (3 0 3 4)))


; EXERCISE Comp-d)
;------------------------------------------------------
; Define using higher order functions the function frecuency(x, l) that
; returns the number of occurrences of x in the list l
;------------------------------------------------------
;
; PUT YOUR DEFINITION HERE

; UNCOMMENT THE SECOND LINE TO TEST THE frecuency FUNCTION
(displayln "\nExercise Comp-d) frecuency:")
(define (frecuency1 x l)
  (length (filter (lambda(y) (equal? x y)) l)))

(frecuency1 '(a) '(a b (a) a d (a))) ; => 2
