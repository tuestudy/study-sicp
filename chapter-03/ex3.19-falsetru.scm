(namespace-require 'r5rs)

(define (cycle? x)
  (define (cdr2 x)
    (if (null? x)
      null
      (cdr x)))
  (define (loop x1 x2)
    (cond ((null? x2) false)
          ((eq? x1 x2) true)
          (else (loop (cdr2 x1) (cdr2 (cdr2 x2))))))
  (loop (cdr2 x) (cdr2 (cdr2 x))))


(define (make-cycle x)
  (set-cdr! (my-last-pair x) x)
  x)

(define (my-last-pair x)
  (if (null? (cdr x))
    x
    (my-last-pair (cdr x))))

