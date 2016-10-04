(load "ex2.56-falsetru.scm")

(define (rest exp)
  (if (= (length exp) 3)
    (caddr exp)
    (cons (car exp) (cddr exp))))
(define addend rest)
(define multiplier rest)
(define exponent rest) ; ?
