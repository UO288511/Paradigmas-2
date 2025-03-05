
## Glossary

### define
Defines variables or functions.
```scheme
(define x 10) ; creates a variable x with the value 10
(define (f x) (* x 2)) ; defines a function
```

### displayln
Prints a value to the output followed by a newline.
```scheme
(displayln "Hello, world!") ; prints the string and moves to the next line
```

### map
Applies a function to each element of a list, returning a new list with the results.
```scheme
(map (lambda (n) (* n 2)) '(1 2 3)) ; produces (2 4 6)
```

### lambda
Creates an anonymous (unnamed) function.
```scheme
(lambda (x) (* x 2)) ; defines a function that doubles its input
```

### let
Introduces local bindings (variables) within an expression.
```scheme
(let ([a 3] [b 4]) (+ a b)) ; evaluates to 7
```

### filter
Returns a new list containing only the elements of the input list that satisfy a given predicate (a function returning true or false).
```scheme
(filter even? '(1 2 3 4)) ; produces (2 4)
```

### eq?
Tests whether its two arguments are the same object (often used for comparing symbols).
```scheme
(eq? 'a 'a) ; is true, but caution is needed when comparing complex data
```

### string->symbol
Converts a string into a symbol.
```scheme
(string->symbol "hello") ; produces the symbol 'hello
```

### string-append
Concatenates (joins) two or more strings into one string.
```scheme
(string-append "Hello, " "world!") ; produces "Hello, world!"
```

### number->string
Converts a number into its string representation.
```scheme
(number->string 123) ; yields "123"
```

### car
Returns the first element of a list.
```scheme
(car '(a b c)) ; gives a
```

### cdr
Returns the remainder of the list after removing the first element.
```scheme
(cdr '(a b c)) ; gives (b c)
```

### cadr
A shorthand for (car (cdr ...)), it returns the second element of a list.
```scheme
(cadr '(a b c)) ; gives b
```

### caddr
A shorthand for (car (cdr (cdr ...))), it returns the third element of a list.
```scheme
(caddr '(a b c d)) ; gives c
```

### cadddr
A shorthand for (car (cdr (cdr (cdr ...)))), it returns the fourth element of a list.
```scheme
(cadddr '(a b c d e)) ; gives d
```

### length
Returns the number of elements in a list.
```scheme
(length '(1 2 3)) ; produces 3
```

### null?
Checks whether a list is empty (i.e., it is exactly '()).
```scheme
(null? '()) ; is true
(null? '(a)) ; is false
```

### equal?
Tests for structural (deep) equality between two values (such as lists with the same content).
```scheme
(equal? '(1 2) '(1 2)) ; returns true
```

### apply
Applies a function to a list of arguments. This is useful when the number of arguments is not known in advance.
```scheme
(apply + '(1 2 3 4)) ; computes the sum 10
```

### append
Concatenates multiple lists into one list.
```scheme
(append '(1 2) '(3 4)) ; produces (1 2 3 4)
```



### curry
Transforms a function that takes multiple arguments into a chain of functions each accepting one argument. This enables partial application of the function.
```scheme
(define (curry f)
    (lambda (x)
        (lambda (y)
            (f x y))))
```
Example usage:
```scheme
(define add (curry +))
((add 2) 3) ; produces 5
```

### curryr
Similar to curry, but reverses the order of the arguments when applying the original function. This is useful when you want the partially applied argument to be the second parameter instead of the first.
```scheme
(define (curryr f)
    (lambda (x)
        (lambda (y)
            (f y x))))
```
Example usage:
```scheme
(define subtract (curryr -))
((subtract 2) 10) ; equivalent to (- 10 2) and produces 8
```
