(load "ex2.77-falsetru.scm")

(define EPS 1e-12)

(put 'equ? '(scheme-number scheme-number) eq?)
(put 'equ? '(rational rational)
     (lambda (x y)
       (<
         (- (* (numer x) (denom y))
            (* (numer y) (denom x)))
         EPS)))
(put 'equ? '(complex complex)
     (lambda (x y)
       (and (< (- (real-part x) (real-part y)) EPS)
            (< (- (imag-part x) (imag-part y)) EPS))))

(define (equ? x y) (apply-generic 'equ? x y))
