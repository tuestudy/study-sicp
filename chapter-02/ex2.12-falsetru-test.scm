(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.12-falsetru.scm")

(define ex2.12-falsetru-tests
  (test-suite
   "Test for ex2.12-falsetru"

   (test-case
    "make-center-percent"
    (define c 6.8)
    (define p 10.0)

    (define r (make-center-percent c p))

    (check-= (lower-bound r) 6.12 0.000001)
    (check-= (upper-bound r) 7.48 0.000001)
    (check-= (center r) c 0.000001)
    (check-= (percent r) p 0.000001)
    )
   ))

(exit
  (cond
    ((= (run-tests ex2.12-falsetru-tests) 0))
    (else 1)))
