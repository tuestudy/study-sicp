(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.21-falsetru.scm")

(define ex2.21-falsetru-tests
  (test-suite
   "Test for ex2.21-falsetru"

   (check-equal? (square-list1 (list 1 2 3 4)) (list 1 4 9 16))
   (check-equal? (square-list2 (list 1 2 3 4)) (list 1 4 9 16))
   ))

(exit
  (cond
    ((= (run-tests ex2.21-falsetru-tests) 0))
    (else 1)))
