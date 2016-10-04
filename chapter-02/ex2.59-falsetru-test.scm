(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.59-falsetru.scm")

(define a '(1 2 3))
(define b '(1 3 4))
(define u (union-set a b))

(define ex2.59-falsetru-tests
  (test-suite
   "Test for ex2.59-falsetru"

   (check-equal? (length u) 4)
   (check-true (element-of-set? 1 u))
   (check-true (element-of-set? 2 u))
   (check-true (element-of-set? 3 u))
   (check-true (element-of-set? 4 u))
   (check-false (element-of-set? 5 u))
   ))

(exit
  (cond
    ((= (run-tests ex2.59-falsetru-tests) 0))
    (else 1)))
