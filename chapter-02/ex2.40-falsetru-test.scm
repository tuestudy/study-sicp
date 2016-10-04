(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.40-falsetru.scm")

(define ex2.40-falsetru-tests
  (test-suite
   "Test for ex2.40-falsetru"

   (check-equal? (enumerate-interval 1 4)
                 '(1 2 3 4))
   (check-equal? (unique-pairs 4)
                 '((2 1) (3 1) (3 2) (4 1) (4 2) (4 3)))
   (check-equal? (prime-sum-pairs 6)
                 '((2 1 3) (3 2 5) (4 1 5) (4 3 7) (5 2 7) (6 1 7) (6 5 11)))
   ))

(exit
  (cond
    ((= (run-tests ex2.40-falsetru-tests) 0))
    (else 1)))
