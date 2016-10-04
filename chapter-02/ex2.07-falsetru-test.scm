(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.07-falsetru.scm")

(define interval-tests
  (test-suite
   "interval test"
   (check-equal? (lower-bound (make-interval 1 2)) 1)
   (check-equal? (upper-bound (make-interval 1 2)) 2)

   (test-case
    "Test for interval operations"
    
    ; Given
    (define one (make-interval 1.0 1.0))
    (define R1 (make-interval 6.12 7.48))
    (define R2 (make-interval 4.465 4.935))
    ; When
    (define Rp (div-interval one
                             (add-interval (div-interval one R1)
                                           (div-interval one R2))))
    ; Then
    (check-= (lower-bound Rp) 2.58 0.01)
    (check-= (upper-bound Rp) 2.97 0.01)
    )))

(run-tests interval-tests)
