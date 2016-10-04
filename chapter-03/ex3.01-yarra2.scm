(define (accumulator n)
  ((lambda (n)
     (lambda (m)
             (begin (set! n (+ n m)) n)))
   n))

(define A (accumulator 10))
(A 10)
(A 20)