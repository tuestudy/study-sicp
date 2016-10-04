(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.33-falsetru.scm")

(define a (list 1 2 3 4 5))
(define b (list 6 7 8 9))
(define (square x) (* x x))

(define ex2.33-falsetru-tests
  (test-suite
   "Test for ex2.33-falsetru"

   (check-equal? (map2 square a) (list 1 4 9 16 25))
   (check-equal? (append2 a b) (list 1 2 3 4 5 6 7 8 9))
   (check-equal? (length2 a) 5)
   ))

(exit
  (cond
    ((= (run-tests ex2.33-falsetru-tests) 0))
    (else 1)))
