(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.18-falsetru.scm")

(define ex2.18-falsetru-tests
  (test-suite
   "Test for ex2.18-falsetru"

   (check-equal? (reverse2 (list 1 4 9 16 25)) (list 25 16 9 4 1))
   ))

(exit
  (cond
    ((= (run-tests ex2.18-falsetru-tests) 0))
    (else 1)))
