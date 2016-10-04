(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.09-falsetru.scm")

(define ex2.09-falsetru-tests
  (test-suite
   "Test for ex2.09-falsetru"

   (check-equal? (width (make-interval 1.0 2.0)) 0.5)

   (test-case
    "counterexample; (width r1) = (width r2), but (width r1*r3) != (width r2*r3)"
    ; Given
    (define r1 (make-interval 0 10))
    (define r2 (make-interval 10 20))
    (define r3 (make-interval 0 2))
    ; When
    (define r4 (mul-interval r1 r3))
    (define r5 (mul-interval r2 r3))
    ; Then
    (check-not-equal? (width r4)
                      (width r5))
    )
   ))

(exit
  (cond
    ((= (run-tests ex2.09-falsetru-tests) 0))
    (else 1)))
