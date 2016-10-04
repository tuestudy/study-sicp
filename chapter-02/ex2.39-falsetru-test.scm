(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.39-falsetru.scm")

(define ex2.39-falsetru-tests
  (test-suite
   "Test for ex2.39-falsetru"

   (check-equal? (reverse1 (list 1 2 3 4)) (list 4 3 2 1))
   (check-equal? (reverse2 (list 1 2 3 4)) (list 4 3 2 1))
   ))

(exit
  (cond
    ((= (run-tests ex2.39-falsetru-tests) 0))
    (else 1)))
