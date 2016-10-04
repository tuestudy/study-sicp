(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.13-falsetru.scm")

(define ex2.13-falsetru-tests
  (test-suite
   "Test for ex2.13-falsetru"

   (test-case
    "error-approx ~~ error-exact"
    (define r1 (make-center-percent 6.8 10))
    (define r2 (make-center-percent 4.7 5))
    (define r3 (mul-interval r1 r2))
    (define e-exact (percent r3))
    (define e-approx (error-approx r1 r2))
    (check-= e-exact e-approx 0.1)
    )
   ))

(exit
  (cond
    ((= (run-tests ex2.13-falsetru-tests) 0))
    (else 1)))
