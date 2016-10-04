(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.35-falsetru.scm")

(define ex2.35-falsetru-tests
  (test-suite
   "Test for ex2.35-falsetru"

   (check-equal? (count-leaves (list 1 (list 2 (list 3 4)))) 4)
   (check-equal? (count-leaves2 (list 1 (list 2 (list 3 4)))) 4)
   ))

(exit
  (cond
    ((= (run-tests ex2.35-falsetru-tests) 0))
    (else 1)))
