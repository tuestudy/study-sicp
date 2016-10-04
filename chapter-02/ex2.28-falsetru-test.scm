(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.28-falsetru.scm")

(define x (list (list 1 2) (list 3 4)))

(define ex2.28-falsetru-tests
  (test-suite
   "Test for ex2.28-falsetru"

   (check-equal? (fringe x) '(1 2 3 4))
   (check-equal? (fringe (list x x)) '(1 2 3 4 1 2 3 4))
   ))

(exit
  (cond
    ((= (run-tests ex2.28-falsetru-tests) 0))
    (else 1)))
