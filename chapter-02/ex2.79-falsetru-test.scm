(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.79-falsetru.scm")

(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)

(define ex2.79-falsetru-tests
  (test-suite
   "Test for ex2.79-falsetru"

   ; scheme number
   (check-true (equ? (make-scheme-number 1) (make-scheme-number 1)))
   (check-false (equ? (make-scheme-number 1) (make-scheme-number 2)))

   ; rational
   (check-true (equ? (make-rational 2 4) (make-rational 1 2)))
   (check-true (equ? (make-rational 5 6)
                     (mul (make-rational 5 2) (make-rational 1 3))))
   (check-false (equ? (make-rational 1 2) (make-rational 1 3)))

   ; complex
   (check-true (equ? (make-complex-from-real-imag 1 0)
                     (make-complex-from-mag-ang 1 0)))
   (check-false (equ? (make-complex-from-real-imag 2 0)
                      (make-complex-from-mag-ang 1 0)))
   (check-true (equ? (make-complex-from-real-imag -1 0)
                     (make-complex-from-mag-ang 1 pi)))
   ))

(exit
  (cond
    ((= (run-tests ex2.79-falsetru-tests) 0))
    (else 1)))
