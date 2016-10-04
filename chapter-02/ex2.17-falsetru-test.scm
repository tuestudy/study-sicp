(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.17-falsetru.scm")

(define ex2.17-falsetru-tests
  (test-suite
   "Test for ex2.17-falsetru"

   (check-equal? (last-pair2 (list 23 27 149 34)) (list 34))
   ))

(exit
  (cond
    ((= (run-tests ex2.17-falsetru-tests) 0))
    (else 1)))
