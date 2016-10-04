(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.42-falsetru.scm")

(define ex2.42-falsetru-tests
  (test-suite
   "Test for ex2.42-falsetru"

   (check-false (safe? '(1 2 3 4)))
   (check-false (safe? '(1 1 3 4)))
   (check-false (safe? '(2 1 3 4)))
   (check-true (safe? '(3 1 4 2)))
   ))

(exit
  (cond
    ((= (run-tests ex2.42-falsetru-tests) 0))
    (else 1)))
