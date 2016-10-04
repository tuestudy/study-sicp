(load "../chapter-02/ex2.78-dgoon.scm")

(define (equ? x y) (apply-generic 'equ? x y))

(define (install-generic-equ?)
  (define (scheme-number-equ? x y)
    (= (contents x) (contents y)))
  (define (rational-number-equ? x y)
    (and (= (car x) (car y)) ; i wanna use numer !!!
	 (= (cdr x) (cdr y)))) ; i wanna use denom !!!
  (define (complex-number-equ? x y)
    (and (> 0.00001 (- (real-part x) (real-part y)))
	 (> 0.00001 (- (imag-part x) (imag-part y)))))
  (put 'equ? '(scheme-number scheme-number) scheme-number-equ?)
  (put 'equ? '(rational rational) rational-number-equ?)
  (put 'equ? '(complex complex) complex-number-equ?))

;; install-rational-package 를 고쳐야합니다. T_T
;; 귀찮으므로 패스 ;;

(install-generic-equ?)

(define PI 3.1415927)

(run (make-testcase
      '(assert-true? (equ? (make-scheme-number 3.0) (make-scheme-number 3.0)))
      '(assert-true? (equ? 3.0 3.0))
      '(assert-true? (equ? (make-rational 1 3) (make-rational 1 3)))
      '(assert-true? (equ? (make-complex-from-real-imag 1 3)
			   (make-complex-from-real-imag 1 3)))
      '(assert-true? (equ? (make-complex-from-real-imag 3.0 0.0)
			   (make-complex-from-mag-ang 3.0 0)))
      '(assert-true? (equ? (make-complex-from-real-imag 1 1)
			   (make-complex-from-mag-ang (sqrt 2) (/ PI 4))))
      '(assert-false? (equ? 3.0 3.1))))