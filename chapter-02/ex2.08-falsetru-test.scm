(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.08-falsetru.scm")

(define ex2.08-falsetru-tests
  (test-suite
   "Test for ex2.08-falsetru"

   (test-case
    "sub-interval"
    ; Given
    (define x (make-interval 2.0 3.0))
    (define y (make-interval 0.5 1.0))
    ; When
    (define z (sub-interval x y))
    ; Then
    (check-equal? (lower-bound z) 1.0)
    (check-equal? (upper-bound z) 2.5)
    )
   ))

(exit
  (cond
    ((= (run-tests ex2.08-falsetru-tests) 0))
    (else 1)))
