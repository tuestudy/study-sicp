(load "ex2.79-falsetru.scm")

(define EPS 1e-12)

(put '=zero? '(scheme-number) (lambda (x) (= x 0))) 
(put '=zero? '(rational) (lambda (x) (= (car x) 0))) ; XXX
(put '=zero? '(complex)
     (lambda (x)
       (or (and (= (real-part x) 0)
                (= (imag-part x) 0))
           (= (angle x) 0))))

(put 'equ? '(complex complex)
     (lambda (x y)
       (and (< (- (real-part x) (real-part y)) EPS)
            (< (- (imag-part x) (imag-part y)) EPS))))

(define (equ? x y) (apply-generic 'equ? x y))
(define (=zero? x) (apply-generic '=zero? x))
