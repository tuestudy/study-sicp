(namespace-require 'r5rs)

(define (cycle? x)
  (define (loop x visited)
    (cond ((null? x) false)
          ((memq x visited) true)
          (else (loop (cdr x) (cons x visited)))))
  (loop x null))

(define (make-cycle x)
  (set-cdr! (my-last-pair x) x)
  x)

(define (my-last-pair x)
  (if (null? (cdr x))
    x
    (my-last-pair (cdr x))))
