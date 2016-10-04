(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.85-falsetru.scm")

(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)

(define ex2.85-falsetru-tests
  (test-suite
   "Test for ex2.85-falsetru"

   (check-equal? (project (make-complex-from-real-imag 1 1))
                 (make-rational 1 1))

   (check-true (equ? (project (make-complex-from-mag-ang 1 (/ pi 2)))
                     (make-rational 0 1)))

   (check-equal? (project (add (make-rational 2 3) (make-rational 4 3)))
                 (make-scheme-number 2))

   (check-equal? (project (make-scheme-number 3))
                 (make-scheme-number 3))

   (check-equal? (drob (make-rational 2 1))
                 (make-scheme-number 2))
   (check-equal? (drob (make-complex-from-mag-ang 2 0))
                 (make-scheme-number 2))

   (check-equal? (add (make-complex-from-mag-ang 2 0)
                      (make-complex-from-mag-ang 1 0))
                 (make-scheme-number 3))

   ))

(exit
  (cond
    ((= (run-tests ex2.85-falsetru-tests) 0))
    (else 1)))
