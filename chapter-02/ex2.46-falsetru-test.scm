(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.46-falsetru.scm")

(define v1 (make-vector1 1 2))
(define v2 (make-vector1 2 3))

(define ex2.46-falsetru-tests
  (test-suite
   "Test for ex2.46-falsetru"

   (check-equal? (xcor-vect v1) 1)
   (check-equal? (ycor-vect v1) 2)
   (check-equal? (add-vect v1 v2) (make-vector1 3 5))
   (check-equal? (sub-vect v2 v1) (make-vector1 1 1))
   (check-equal? (scale-vect 2 v1) (make-vector1 2 4))
   ))

(exit
  (cond
    ((= (run-tests ex2.46-falsetru-tests) 0))
    (else 1)))
