(define (cons1 x y)
  (lambda (m) (m x y)))

(define (car1 z)
  (z (lambda (p q) p)))

(define (cdr1 z)
  (z (lambda (p q) q)))

;test-case
(= 100 (car1 (cons1 100 44)))
(= 44 (cdr1 (cons1 100 44)))