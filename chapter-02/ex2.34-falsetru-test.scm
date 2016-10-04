(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.34-falsetru.scm")

(define ex2.34-falsetru-tests
  (test-suite
   "Test for ex2.34-falsetru"

   (check-equal? (horner-eval 2 (list 1 3 0 5 0 1)) 79)
   ))

(exit
  (cond
    ((= (run-tests ex2.34-falsetru-tests) 0))
    (else 1)))
