(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex3.06-falsetru.scm")

(define ex3.06-falsetru-tests
  (test-suite
   "Test for ex3.06-falsetru"

   (test-case
    "generate/reset random value"
    (define dummy1 ((rand 'reset) 1))
    (define r1 (list (rand 'generate) (rand 'generate) (rand 'generate)))
    (define dummy2 ((rand 'reset) 2))
    (define r2 (list (rand 'generate) (rand 'generate) (rand 'generate)))
    (define dummy3 ((rand 'reset) 1))
    (define r3 (list (rand 'generate) (rand 'generate) (rand 'generate)))

    (check-not-equal? r1 r2)
    (check-equal? r1 r3)
    )))

(exit
  (cond
    ((= (run-tests ex3.06-falsetru-tests) 0))
    (else 1)))
