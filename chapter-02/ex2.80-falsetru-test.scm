(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.80-falsetru.scm")

(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)

(define ex2.80-falsetru-tests
  (test-suite
   "Test for ex2.80-falsetru"

   ; scheme number
   (check-true (=zero? (make-scheme-number 0)))
   (check-false (=zero? (make-scheme-number 1)))

   ; rational
   (check-true (=zero? (make-rational 0 4)))
   (check-false (=zero? (make-rational 2 4)))

   ; complex
   (check-true (=zero? (make-complex-from-real-imag 0 0)))
   (check-true (=zero? (make-complex-from-mag-ang 0 pi)))
   (check-false (=zero? (make-complex-from-real-imag 1 1)))
   (check-false (=zero? (make-complex-from-mag-ang 1 1)))
   ))

(exit
  (cond
    ((= (run-tests ex2.80-falsetru-tests) 0))
    (else 1)))
