(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.19-falsetru.scm")

(define ex2.19-falsetru-tests
  (test-suite
   "Test for ex2.19-falsetru"

   (check-equal? (cc 100 us-coins) 292)
   ))

(exit
  (cond
    ((= (run-tests ex2.19-falsetru-tests) 0))
    (else 1)))
