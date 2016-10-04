(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.86-falsetru.scm")

(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)

(define ex2.86-falsetru-tests
  (test-suite
   "Test for ex2.86-falsetru"

   (check-equal? (add (make-complex-from-real-imag 
                        (make-rational 1 2) (make-rational 3 2))
                      (make-complex-from-real-imag
                        (make-rational 3 2) (make-rational 3 2)))
                 (make-complex-from-real-imag
                   (make-rational 2 1)
                   (make-rational 3 1)))
   (check-equal? (sub (make-complex-from-real-imag 
                        (make-rational 2 2) (make-rational 3 2))
                      (make-complex-from-real-imag
                        (make-rational 1 2) (make-rational 3 2)))
                 (make-complex-from-real-imag
                   (make-rational 1 2)
                   (make-rational 0 1)))
   ))

(exit
  (cond
    ((= (run-tests ex2.86-falsetru-tests) 0))
    (else 1)))
