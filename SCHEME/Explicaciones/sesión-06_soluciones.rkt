(require mzlib/compat racket/function)

; Para todas las funciones que se soliciten, y siempre que sea posible, deberá utilizarse
; la currificación

;-----------------------------------------------------------------------------------------
; EJERCICIO 1
; Definir, usando FOS, la función addLast(l, l1, l2, ...) que dada una lista l
; y una secuencia de listas l1, l2, ..., retorne la lista de listas (l1' l2' ...). Siendo 
; cada li' la concatenación de li con la lista l.
;-----------------------------------------------------------------------------------------

(define (addLast l . resto)
  (map (lambda(li) (append li l)) resto))

(display "Ejercicio 1) addLast: ")
(addLast '((a) b) () '(c) '(1 (2 3))) ;=> (((a) b) (c (a) b) (1 (2 3) (a) b))

;-----------------------------------------------------------------------------------------
; EJERCICIO 2
; Definir mediante FOS la función addLast+(ll, l1, l2, ...) que dada una lista de listas
; ll y una secuencia de listas l1, l2, ..., retorne la lista de listas (l1' l2' ...).
; Siendo cada li' la concatenación de li con cada una de las listas de ll en el mismo
; orden que aparecen en ésta
;-----------------------------------------------------------------------------------------

(define (addLast+ ll . resto)
  (apply addLast
         (cons (apply append ll) resto)))

(display "\nEjercicio 2) addLast+: ")
(addLast+ '((a) ((b) c)) () '(d) '(1 (2 3))) ;=> ((a (b) c) (d a (b) c) (1 (2 3) a (b) c))

;------------------------------------------------------------------------------------
; EJERCICIO 3
; Utilizar FOS para definir las funciones que se solicitan posteriormente, dada la
; definición del símbolo Manos que contienen la información de la situación de una
; partida del juego del UNO en un momento dado.
;
; Todas las cartas de la baraja del UNO tienen asociado un valor numérico entre 0 y 9
; o un valor simbólico correspondiente a distintas acciones: roba2, reversa, pierde-turno,
; comodin-color y comodin-roba4. Además, todas las cartas son de un color: azul, rojo,
; verde o amarillo, a excepción de los comodínes que se puedan utilizar con cualquier
; color. Por tanto, cada carta se representará por la lista de dos elementos (valor color),
; exceptuando los comodínes que se representarán mediante una lista de un elemento (su valor).

(define Manos
  '((ana    ((4 rojo) (9 rojo) (9 verde) (comodin-color) (9 verde) (8 verde) (3 azul)))
    (rosa   ((0 amarillo) (1 amarillo) (3 rojo) (8 azul) (4 verde) (3 rojo) (9 azul)))
    (luis   ((comodin-color) (8 amarillo) (5 rojo) (7 amarillo) (5 verde) (4 amarillo)))
    (pedro  ((7 amarillo) (1 rojo) (4 verde) (9 rojo) (7 rojo) (6 amarillo) (4 rojo)))
    (maria  ((7 verde) (8 amarillo) (0 rojo) (comodin-roba4) (3 verde) (8 verde) (3 azul)))
    (carmen ((8 azul) (5 verde) (5 amarillo) (6 amarillo) (3 amarillo) (6 azul) (pierde-turno azul)))
    (blanca ((3 amarillo) (1 rojo) (5 amarillo) (4 amarillo) (2 azul) (9 azul) (7 azul)))
    (quique ((9 amarillo) (reversa rojo) (2 rojo) (6 verde) (8 rojo) (1 azul) (1 verde)))))


;------------------------------------------------------------------------------------
; EJERCICIO 3a
; Definir la función cartas-mano(nombre, manos) que dado el nombre de un jugador de las
; las manos de una partida del UNO retorna las cartas de éste:
; la lista ((mano-del-jugador)).
;------------------------------------------------------------------------------------

(define (cartas-mano nombre manos)
  (cadar (filter (curry member nombre) manos)))

(displayln "\nEjercicio 3a) cartas-mano: ")
(cartas-mano 'maria Manos) ;=> ((7 verde) (8 amarillo) (0 rojo) (comodin-roba4)
                           ;    (3 verde) (8 verde) (3 azul))

;------------------------------------------------------------------------------------
; EJERCICIO 3b
; Definir la función comodin?(cartas-mano) que retorna cierto si las cartas de la mano
; de un jugador tiene un comodín y falso en caso contrario.
;
; Obsérvese que existen dos tipos de comodínes: comodin-color y comodin-roba4
;------------------------------------------------------------------------------------

(define (comodin? cartas-mano)
  (or (not (null? (filter (curry member 'comodin-color) cartas-mano)))
      (not (null? (filter (curry member 'comodin-roba4) cartas-mano)))))

(displayln "\nEjercicio 3b comodin? (Solución con filter)")
(comodin? (cartas-mano 'luis Manos)) ;=> #t
(comodin? (cartas-mano 'maria Manos)) ;=> #t
(comodin? (cartas-mano 'quique Manos)) ;=> #f

; Solución alternativa
(define (comodin? cartas-mano)
  (cond [(member 'comodin-color (apply append cartas-mano)) #t]
        [(member 'comodin-roba4 (apply append cartas-mano)) #t]
        [else #f]))

(displayln "\nEjercicio 3b comodin? (Solución con apply)")
(comodin? (cartas-mano 'luis Manos)) ;=> #t
(comodin? (cartas-mano 'maria Manos)) ;=> #t
(comodin? (cartas-mano 'quique Manos)) ;=> #f

;------------------------------------------------------------------------------------
; EJERCICIO 3c
; Definir la función valor-compatible(valor, cartas-mano) que retorna la lista
; de cartas de una mano cuyo valor (numérico o simbólico) es jugable para el valor
; dado.
;
; Se considerará que una carta será de valor compatible si tiene el mismo valor
; o bien si es un comodín.
;------------------------------------------------------------------------------------

(define (valor-compatible valor cartas-mano)
  (append [filter (curry member valor) cartas-mano]
          [filter (lambda(carta)
                    (cond [(eq? 'comodin-color (car carta))]
                          [(eq? 'comodin-roba4 (car carta))]
                          [else #f]))
                  cartas-mano]))

(displayln "\nEjercicio 3c)")
(valor-compatible 9 (cartas-mano 'ana Manos)) ;=> ((9 rojo) (9 verde) (9 verde) (comodin-color))
(valor-compatible 8 (cartas-mano 'maria Manos)) ;=> ((8 amarillo) (8 verde) (comodin-roba4))

;------------------------------------------------------------------------------------
; EJERCICIO 3d
; Definir la función color-compatible(color, cartas-mano) que retorna la lista de
; cartas de una mano que son jugables para el color dado.
;
; Se considerará que una carta será de color compatible si tiene el mismo color o bien
; si es un comodín.
;------------------------------------------------------------------------------------

(define (color-compatible color cartas-mano)
  (append [filter (curry member color) cartas-mano]
          [filter (lambda(carta)
                    (cond [(eq? 'comodin-color (car carta))]
                          [(eq? 'comodin-roba4 (car carta))]
                          [else #f]))
                  cartas-mano]))

(displayln "\nEjercicio 3d) color-compatible: ")
(color-compatible 'verde (cartas-mano 'maria Manos)) ;=> ((7 verde) (3 verde) (8 verde) (comodin-roba4))
(color-compatible 'rojo (cartas-mano 'pedro Manos)) ;=> ((1 rojo) (9 rojo) (7 rojo) (4 rojo))

;------------------------------------------------------------------------------------
; EJERCICIO 3e
; Definir la función compatibles(carta, cartas-mano) que retorna la lista de cartas
; de una mano que son compatibles para la carta dada (para su valor o color). El
; argumento carta siempre será una lista de dos elementos (valor color), incluso si la
; carta es un comodín porque será el color elegido para continuar el juego.
;
; Una carta de la mano será compatible con la carta dada si es de valor o color
; compatible con ésta.
;------------------------------------------------------------------------------------

(define (compatibles carta cartas-mano)
  (filter (lambda(c)
            (cond [(eq? 'comodin-color (car c))]  ; comodín
                  [(eq? 'comodin-roba4 (car c))]  ; comodín
                  [(eq? (cadr c) (cadr carta))]   ; tienen el mismo color
                  [(eq? (car c) (car carta))]     ; tienen el mismo valor
                  [else #f]))
          cartas-mano))

(displayln "\nEjercicio 3e) compatibles: ")
(compatibles '(9 rojo)
             (cartas-mano 'ana Manos)) ;=> ((4 rojo) (9 rojo) (9 verde) (comodin-color) (9 verde))
(compatibles '(comodin-color verde)
             (cartas-mano 'maria Manos)) ;=> ((7 verde) (comodin-roba4) (3 verde) (8 verde))

;------------------------------------------------------------------------------------
; EJERCICIO 3f
; Definir la función jugadores-con-comodin(manos) que retorna la lista de nombres de
; jugadores que tienen en su mano un comodín.
;------------------------------------------------------------------------------------

(define (jugadores-con-comodin manos)
  (map car
       [filter (compose (curry comodin?) cadr)
               manos]))

(display "\nEjercicio 3f) jugadores-con-comodin: ")
(jugadores-con-comodin Manos) ;=> (ana luis maria)

;------------------------------------------------------------------------------------
; EJERCICIO 3g
; Definir la función jugadores-cartas-compatibles(carta, manos) que retorna las cartas
; compatibles con la carta dada que cada jugador tiene en su mano.  El argumento
; carta siempre será una lista de dos elementos (valor color), incluso si la carta es
; un comodín porque será el color elegido para continuar el juego.
;------------------------------------------------------------------------------------

(define (jugadores-cartas-compatibles carta manos)
  (map [lambda(jugador)
         (cons (car jugador)
               (list (compatibles carta (cadr jugador))))]
       manos))

(displayln "\nEjercicio 3g) jugadores-cartas-compatibles:")
(jugadores-cartas-compatibles '(0 rojo) Manos)
;=> ((ana ((4 rojo) (9 rojo) (comodin-color)))
;    (rosa ((0 amarillo) (3 rojo) (3 rojo)))
;    (luis ((comodin-color) (5 rojo)))
;    (pedro ((1 rojo) (9 rojo) (7 rojo) (4 rojo)))
;    (maria ((0 rojo) (comodin-roba4)))
;    (carmen ())
;    (blanca ((1 rojo)))
;    (quique ((reversa rojo) (2 rojo) (8 rojo))))

(jugadores-cartas-compatibles '(comodin-color verde) Manos)
;=> ((ana ((9 verde) (comodin-color) (9 verde) (8 verde)))
;    (rosa ((4 verde)))
;    (luis ((comodin-color) (5 verde)))
;    (pedro ((4 verde)))
;    (maria ((7 verde) (comodin-roba4) (3 verde) (8 verde)))
;    (carmen ((5 verde)))
;    (blanca ())
;    (quique ((6 verde) (1 verde))))


;------------------------------------------------------------------------------------
; EJERCICIO 4
; Dada la definición del símbolo Vectores, que es una lista de vectores de dimensión
; variable donde cada vector tiene un nombre y a continuación sus coordenadas, obtener
; las funciones que se solicitan posteriormente.
;------------------------------------------------------------------------------------

(define Vectores
  '(v1 (12 2.5 -8 24 33)
    v2 (1 -2 3 0 7 -2.3 0 21)
    v3 (-12 2.8 3.5)
    v4 (-1 2 -2.3 5)
    v5 (-12.5 -3 8 5 24 0 -3 12)
    v6 (3 0 18 15 9 12.5)))

;------------------------------------------------------------------------------------
; EJERCICIO 4a
; Utilizar FOS para proporcionar una expresión que permita obtener la suma de todas
; las componentes de los vectores de Vectores
;------------------------------------------------------------------------------------

(display "\nEjercicio 4a) suma de todas las componentes: ") ;=> 177.2

(apply + (map (curry apply +) (filter list? Vectores)))

;------------------------------------------------------------------------------------
; EJERCICIO 4b
; Utilizar FOS para proporcionar una expresión que permita obtener una lista con el
; nombre de cada vector y a continuación, en lugar de sus componentes, el número de
; éstas.
;------------------------------------------------------------------------------------

(displayln "\nEjercicio 4b) número de componentes: ") ;=> (v1 5 v2 8 v3 3 v4 4 v5 8 v6 6)

(apply append
       (map list
            (filter symbol? Vectores)
            (map (curry length)
                 (filter list? Vectores))))

