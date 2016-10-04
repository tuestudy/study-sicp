(load "ex2.77-falsetru.scm")

(define (attach-tag tag x) (if (number? x) x (cons tag x)))
(define (type-tag x) (if (number? x) 'scheme-number (car x)))
(define (contents x) (if (number? x) x (cdr x)))
