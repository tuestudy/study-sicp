(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex3.08-falsetru.scm")

(define ex3.08-falsetru-tests
  (test-suite
    "Test for ex3.08-falsetru"

    (test-case
      "f(0), f(1)"
      (define f (make-f))
      (define A (f 0))
      (define B (f 1))
      (check-equal? (+ A B) 0)
      )
    (test-case
      "f(1), f(0)"
      (define f (make-f))
      (define B (f 1))
      (define A (f 0))
      (check-equal? (+ A B) 1)
      )
    ))

(exit
  (cond
    ((= (run-tests ex3.08-falsetru-tests) 0))
    (else 1)))
