(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.78-falsetru.scm")

(install-scheme-number-package)
(define ex2.78-falsetru-tests
  (test-suite
   "Test for ex2.78-falsetru"

   (check-equal? (add (make-scheme-number 1) (make-scheme-number 2))
                 (make-scheme-number 3))
   ))

(exit
  (cond
    ((= (run-tests ex2.78-falsetru-tests) 0))
    (else 1)))
