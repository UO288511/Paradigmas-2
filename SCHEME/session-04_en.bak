(require mzlib/compat racket/function)

; -------------------------------------------------------------------------------------
; REVIEW EXERCISES OBTAINED FROM PREVIOUS EXAMS
; -------------------------------------------------------------------------------------

; --- DEFINITIONS NECESSARY FOR THE EXERCISES ---
;
; Note: You can skip these definitions and start directly with exercise 1.
; If an exercise requires any of these definitions, return to this block.

; Database with the grades obtained by students in FIVE exams (grades out of 10)
; If the student did not attend an exam, that exam does not appear in the data.
(define AlmacenNotas '(
    ( (Menéndez Pérez, Luis) (EXAMEN1 3.3) (EXAMEN2 6.7)  (EXAMEN4 8.0) )
    ( (Idaho, Duncan) (EXAMEN1 5.1) (EXAMEN2 5.5) (EXAMEN3 6.5)  (EXAMEN4 10.0) )
    ( (Riestra García, Verónica) (EXAMEN1 3.5) (EXAMEN2 7.0) (EXAMEN3 4.5)  (EXAMEN4 10.0) (EXAMEN5 10.0) )
    ( (Atreides, Paul) (EXAMEN1 9.1) (EXAMEN2 10.0) (EXAMEN4 9.0) (EXAMEN5 9.0) )
    ( (Pika Pika, Pikachu) (EXAMEN2 6.35) (EXAMEN4 3.7) (EXAMEN5 4.5) )
    ( (Stark, Anthony Edward) (EXAMEN1 10.0) (EXAMEN2 10.0) (EXAMEN3 10.0)  (EXAMEN4 10.0) (EXAMEN5 10.0) )
    ( (Danvers, Carol) (EXAMEN1 9.1) (EXAMEN5 10.0) )
))

; Definition of the weights of each exam (in fractions)
(define Ponderaciones '(0.3 0.15 0.2 0.15 0.2))

; Choose a person to test the exercises
(define unaPersona (cadddr AlmacenNotas))
(displayln "unaPersona es")
(displayln unaPersona)

; Choose another person to test the exercises
(define otraPersona (caddr AlmacenNotas))
(displayln "otraPersona es")
(displayln otraPersona)

; Function that, given a student, returns the list of their grades, adding 0.0 for exams not attended.
; For example, for the student Luis, it returns: (3.3 6.7 0.0 8.0 0.0)
; (It is not necessary to understand the code of this function for the following exercises.)
(define (notasCompletas est)
    (map (lambda (nexam)
                 (let ([par (filter (lambda (elem)
                                                            (eq? (car elem)
                                                                     (string->symbol (string-append "EXAMEN" (number->string nexam)))))
                                                        est)])
                     (if (null? par)
                             0
                             (cadar par))))
             '(1 2 3 4 5)))

; -------------------------------------------------------------------------------------
; NOW IT'S YOUR TURN TO WORK
; -------------------------------------------------------------------------------------

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EXERCISE 1:
;; ============
;;
;; Define, USING HOF, a function contarAprobados(vNotas, umbral) that given a
;; vector (list) of real grades (0 to 10) and a threshold value returns an integer indicating
;; the number of grades in the vector that are greater than or equal to the threshold.
;;
;; Clues:
;; - Use 'filter' to select only the grades that meet (>= threshold).
;; - Use 'lambda' to define the condition.
;; - Use 'length' to count the number of filtered elements.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define (contarAprobados vNotas umbral)
    ;; IMPLEMENT HERE
    )

(displayln "\nExercise 1): ")
;; FUNCTIONALITY TESTS
;; (contarAprobados '(2.3 5 2.7 7 3.14) 5.0)  ; => 2
;; (contarAprobados '(9.7 6.3 4.5 7.8 10.0) 4.0)  ; => 5

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EXERCISE 2:
;; ============
;;
;; From the grades database (AlmacenNotas), define the following functions
;; USING HOF. (The solutions should work for any number of exams.)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; --- EXERCISE 2a: notasEstudiante ---
;;
;; Given the information of a student (a row from AlmacenNotas), return the list of exams
;; attended along with the grade obtained.
;;
;; Clue:
;; - Use 'cdr' to omit the name and get the rest of the list.
(define (notasEstudiante est)
    ;; IMPLEMENT HERE
    )

(displayln "\nExercise 2a): ")
;; FUNCTIONALITY TESTS
;; (notasEstudiante unaPersona)  ; => ((EXAMEN1 9.1) (EXAMEN2 10.0) (EXAMEN4 9.0) (EXAMEN5 9.0))
;; (notasEstudiante otraPersona)  ; => ((EXAMEN1 3.5) (EXAMEN2 7.0) (EXAMEN3 4.5) (EXAMEN4 10.0) (EXAMEN5 10.0))


;; --- EXERCISE 2b: examenesEstudiante ---
;;
;; Returns the same information as in 2a, but only with the names of the exams.
;;
;; Clue:
;; - Use 'map' along with 'car' to extract only the name of each exam.
(define (examenesEstudiante est)
    ;; IMPLEMENT HERE
    )

(displayln "\nExercise 2b): ")
;; FUNCTIONALITY TESTS
;; (examenesEstudiante unaPersona)  ; => (EXAMEN1 EXAMEN2 EXAMEN4 EXAMEN5)
;; (examenesEstudiante otraPersona)  ; => (EXAMEN1 EXAMEN2 EXAMEN3 EXAMEN4 EXAMEN5)


;; --- EXERCISE 2c: examenesAprobadosEstudiante ---
;;
;; Given the information of a student and a passing threshold, return the list of exams
;; attended in which the grade is greater than or equal to the threshold.
;;
;; Clues:
;; - First, use 'filter' with a lambda that compares the grade (extracted with 'cadr') with the threshold.
;; - Then, use 'map' to extract the names of the exams (using 'car').
(define (examenesAprobadosEstudiante est umbral)
    ;; IMPLEMENT HERE
    )

(displayln "\nExercise 2c): ")
;; FUNCTIONALITY TESTS
;; (examenesAprobadosEstudiante unaPersona 10.0)  ; => (EXAMEN2)
;; (examenesAprobadosEstudiante otraPersona 4.5)  ; => (EXAMEN2 EXAMEN3 EXAMEN4 EXAMEN5)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EXERCISE 3:
;; ============
;;
;; We continue working with the grades database (AlmacenNotas). Use the 'filter' function
;; in each solution.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; --- EXERCISE 3a: notasNombreEstudiante ---
;;
;; Given a grades database and the full name of a student (in the form of a list), return the
;; complete row (record) of the student.
;;
;; Clues:
;; - Use 'filter' with a lambda that compares the first element of the record (name) with the given name.
;; - Use 'equal?' to compare lists/structures.
;; - Extract the first match with 'car'.
(define (notasNombreEstudiante almacen nombre)
    ;; IMPLEMENT HERE
    )

(displayln "\nExercise 3a): ")
;; FUNCTIONALITY TESTS
;; (notasNombreEstudiante AlmacenNotas '(Menéndez Pérez, Luis))  
;;   => ((Menéndez Pérez, Luis) (EXAMEN1 3.3) (EXAMEN2 6.7) (EXAMEN4 8.0))
;; (notasNombreEstudiante AlmacenNotas '(Stark, Anthony Edward))  
;;   => ((Stark, Anthony Edward) (EXAMEN1 10.0) (EXAMEN2 10.0) (EXAMEN3 10.0) (EXAMEN4 10.0) (EXAMEN5 10.0))


;; --- EXERCISE 3b: todoAprobado? ---
;;
;; Given a student (complete record) and a threshold, return #t if the student obtained a grade
;; greater than or equal to the threshold in ALL exams.
;;
;; Clues:
;; - Use the function 'notasCompletas' to get all the grades.
;; - Use 'filter' with a lambda that selects the grades below the threshold.
;; - If the resulting list is empty (use 'null?'), then the student passed all the exams.
(define (todoAprobado? est umbral)
    ;; IMPLEMENT HERE
    )

(displayln "\nExercise 3b): ")
;; FUNCTIONALITY TESTS
;; (todoAprobado? unaPersona 3.0)  ; => #f
;; (todoAprobado? otraPersona 3.0)  ; => #t


;; --- EXERCISE 3c: listaTodoAprobado ---
;;
;; Given a grades database and a threshold, return a list with the full names of all the
;; students who have passed all the exams.
;;
;; Clues:
;; - Use 'filter' to select the students who meet the condition (use your function from 3b).
;; - Use 'map' to extract the name (first element) of each record.
(define (listaTodoAprobado almacen umbral)
    ;; IMPLEMENT HERE
    )

(displayln "\nExercise 3c): ")
;; FUNCTIONALITY TESTS
;; (listaTodoAprobado AlmacenNotas 3.5)  
;;   => ((Riestra García, Verónica) (Stark, Anthony Edward))

; ---------------------------------------------------------------------------------------------------
; CHANGING THE TOPIC
; ---------------------------------------------------------------------------------------------------

; --- DEFINITIONS NECESSARY FOR THE FOLLOWING EXERCISES ---
;
; Database describing the domino pieces of each player.
; Each piece is represented as a pair of numbers. The piece is ordered so that the smaller number
; appears first. The "blanks" are represented with the number zero.
(define fichasJugadores '(
    ( (Miller, Joel) () )
    ( (Williams, Ellie) ((4 4) (3 6) (1 4) (2 5)) )
    ( (Stark, Anthony Edward) ((2 4) (3 3) (1 3) (6 6) (4 5) (0 1)) )
    ( (Danvers, Carol) ((0 4) (5 6) (2 6)) )
))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EXERCISE 4:
;; ============
;;
;; Define the function fichasJugador(BD, nombre) that, using HOF, returns the list of domino pieces
;; of a player. The function has two parameters: the players' database and the full name
;; of a player (in the form of a list).
;;
;; Clues:
;; - Use 'filter' with a lambda to find the record whose name (first element) matches.
;; - Extract the list of pieces from that record.
(define (fichasJugador BD nombre)
    ;; IMPLEMENT HERE
    )

(displayln "\nExercise 4): ")
;; FUNCTIONALITY TESTS
;; (fichasJugador fichasJugadores '(Williams, Ellie))  ; => ((4 4) (3 6) (1 4) (2 5))
;; (fichasJugador fichasJugadores '(Danvers, Carol))     ; => ((0 4) (5 6) (2 6))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EXERCISE 5:
;; ============
;;
;; Define, using HOF, the function fichasDobles(lFichas) that, given a list of domino pieces,
;; returns a list with the double pieces (those in which both numbers are equal).
;;
;; Clues:
;; - Use 'filter' with a lambda that checks if (car piece) is equal to (cadr piece).
(define (fichasDobles lFichas)
    ;; IMPLEMENT HERE
    )

(displayln "\nExercise 5): ")
;; FUNCTIONALITY TESTS
;; (fichasDobles '((2 4) (3 3) (1 3) (6 6) (0 1)))   ; => ((3 3) (6 6))
;; (fichasDobles '((2 4) (0 3) (1 3) (3 6) (0 1)))       ; => ()


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EXERCISE 6:
;; ============
;;
;; Define, using HOF, the function puntosTotales(lFichas) that, given a list of domino pieces,
;; returns the total sum of points of all the pieces.
;;
;; Clues:
;; - You will need to "flatten" the list of pieces to have all the numbers in a single list.
;;   You can use 'append' or a similar technique.
;; - Use 'apply' with '+' to sum all the numbers.
(define (puntosTotales lFichas)
    ;; IMPLEMENT HERE
    )

(displayln "\nExercise 6): ")
;; FUNCTIONALITY TESTS
;; (puntosTotales '((2 4) (3 3) (1 3) (6 6) (0 1))) ; => 29
;; (puntosTotales '((2 4) (0 3) (1 3) (3 6) (0 1))) ; => 23
;; (puntosTotales '(()))                               ; => 0

