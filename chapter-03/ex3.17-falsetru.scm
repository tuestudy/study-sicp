(namespace-require 'r5rs)

(define (count-pairs x)
  (define visited '())
  (define (loop x)
    (cond ((not (pair? x)) 0)
          ((memq x visited) 0)
          (else
            (set! visited (cons x visited))
                (+ (loop (car x))
                   (loop (cdr x))
                   1))))
  (loop x))
