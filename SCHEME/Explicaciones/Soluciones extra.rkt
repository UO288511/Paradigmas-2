¡Claro! Vamos a resolver el examen completo nuevamente, utilizando la función `curry` para simplificar las versiones curried.

;;; Exercise: Higher–Order Functions & Currying Challenge

;;;; (1 point) Implement a Function Using HOF

**Task:**
Escribe una función llamada `filter-map` que acepte tres argumentos:
- Una función predicado `pred`
- Una función de mapeo `f`
- Una lista `lst`

La función debe primero filtrar la lista usando `pred` (es decir, mantener solo los elementos para los cuales `pred` devuelve verdadero) y luego aplicar la función de mapeo `f` a cada uno de los elementos filtrados. Usa las funciones de orden superior incorporadas de Racket como `filter` y `map` en tu solución.

**Solución:**
```racket
(define (filter-map pred f lst)
  (map f (filter pred lst)))

; Ejemplo:
(filter-map even? (lambda (x) (* x x)) '(1 2 3 4 5 6))
; debería devolver '(4 16 36)
```

;;;; (0.5 points) Currify the Function

**Task:**
Crea una versión curried de la función `filter-map` llamada `filter-map-curried` para que puedas aplicar parcialmente sus argumentos.

**Solución:**
```racket
(define filter-map-curried (curry filter-map))

; Ejemplo:
((filter-map-curried even?) (lambda (x) (* x x)) '(1 2 3 4 5 6))
; debería devolver '(4 16 36)
```

;;;; (1 point) Use the Curried Function for a More Complex Task

**Task:**
Usando `filter-map-curried`, define una nueva función llamada `even-squares` que acepte una lista de números y devuelva una lista que contenga los cuadrados de los números pares.

**Solución:**
```racket
(define even-squares
  ((filter-map-curried even?) (lambda (x) (* x x))))

; Ejemplo:
(even-squares '(10 15 20 25 30))
; debería devolver '(100 400 900)
```

;;; Exercise: Filtering Employee Data with HOF and Currying

;;;; Part 1 (1 point): Implement a Function Using Higher–Order Functions

**Task:**
Implementa una función llamada `filter-names` que tome dos argumentos:
- Una función predicado `pred` que recibe un registro de empleado (una lista) y devuelve un booleano.
- Una lista de registros de empleados.

La función debe primero filtrar los empleados basándose en `pred` y luego devolver una lista de nombres (el primer elemento de cada registro) para los empleados que satisfacen el predicado. Usa las funciones incorporadas `filter` y `map` de Racket.

**Solución:**
```racket
(define (filter-names pred employees)
  (map car (filter pred employees)))

; Ejemplo:
(define employees '((Alice 30 4000) (Bob 40 5000) (Charlie 35 4500) (Diana 28 4800) (Eve 50 4700)))
(filter-names (lambda (emp) (>= (caddr emp) 4500)) employees)
; debería devolver '(Bob Charlie Diana Eve)
```

;;;; Part 2 (0.5 points): Currify the Function

**Task:**
Crea una versión curried de la función `filter-names` llamada `filter-names-curried` para que el predicado pueda ser proporcionado primero. En la versión curried, la función devuelve otra función que toma la lista de empleados.

**Solución:**
```racket
(define filter-names-curried (curry filter-names))

; Ejemplo:
(((filter-names-curried (lambda (emp) (>= (caddr emp) 4500))) employees))
; debería devolver '(Bob Charlie Diana Eve)
```

;;;; Part 3 (1 point): Use the Curried Function for a More Complex Task

**Task:**
Usando `filter-names-curried`, define una nueva función llamada `high-earners` que tome una lista de empleados y devuelva los nombres de aquellos cuyo salario sea al menos 4500. Luego, aplica `high-earners` a los datos de empleados simulados.

**Solución:**
```racket
(define high-earners
  ((filter-names-curried (lambda (emp) (>= (caddr emp) 4500)))))

; Ejemplo:
(high-earners employees)
; debería devolver '(Bob Charlie Diana Eve)
```

¡Espero que esto te ayude! ¿Hay algo más en lo que pueda asistirte?