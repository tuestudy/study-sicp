(namespace-require 'r5rs)

(define (append! x y)
  (set-cdr! (my-last-pair x) y)
  x)

(define (my-last-pair x)
  (if (null? (cdr x))
    x
    (my-last-pair (cdr x))))
