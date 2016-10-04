(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.61-falsetru.scm")

(define ex2.61-falsetru-tests
  (test-suite
   "Test for ex2.61-falsetru"

   (check-true (element-of-set? 3 '(1 3 6 10)))
   (check-false (element-of-set? 4 '(1 3 6 10)))
   (test-case
    "intersection-set"
    (define a '(1 3 6 10))
    (define b '(2 4 6 8))
    (check-equal? (intersection-set a b) '(6)))
   (check-equal? (adjoin-set 1 '()) '(1))
   (check-equal? (adjoin-set 1 '(2)) '(1 2))
   (check-equal? (adjoin-set 2 '(1)) '(1 2))
   (check-equal? (adjoin-set 1 '(1 2)) '(1 2))
   (check-equal? (adjoin-set 2 '(1 2)) '(1 2))
   ))

(exit
  (cond
    ((= (run-tests ex2.61-falsetru-tests) 0))
    (else 1)))
