(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.32-falsetru.scm")

(define ex2.32-falsetru-tests
  (test-suite
   "Test for ex2.32-falsetru"

   (check-equal? (subsets '(1 2 3))
                 '(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3)))
   ))

(exit
  (cond
    ((= (run-tests ex2.32-falsetru-tests) 0))
    (else 1)))
