(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.41-falsetru.scm")

(define ex2.41-falsetru-tests
  (test-suite
   "Test for ex2.41-falsetru"

   (check-equal? (unique-triples 4) '((1 2 3) (1 2 4) (1 3 4) (2 3 4)))

   (check-equal? (sum-triples 4 9) '((2 3 4)))
   ))

(exit
  (cond
    ((= (run-tests ex2.41-falsetru-tests) 0))
    (else 1)))
