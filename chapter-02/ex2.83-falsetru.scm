(load "ex2.77-falsetru.scm")

(define (raise x) (apply-generic 'raise x))
(put 'raise '(scheme-number) (lambda (n) (make-rational n 1)))
(put 'raise '(rational)
     (lambda (r) (make-complex-from-real-imag (/ (numer r) (denom r)) 0)))
