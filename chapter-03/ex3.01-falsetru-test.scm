(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex3.01-falsetru.scm")

(define ex3.01-falsetru-tests
  (test-suite
   "Test for ex3.01-falsetru"

   (test-case
    "accumulator"
    (define A (make-accumulator 5))
    (define B (make-accumulator 10))
    (check-equal? (A 10) 15)
    (check-equal? (A 10) 25)

    (check-equal? (B 10) 20)
    )
   ))

(exit
  (cond
    ((= (run-tests ex3.01-falsetru-tests) 0))
    (else 1)))
