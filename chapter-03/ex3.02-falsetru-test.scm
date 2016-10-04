(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex3.02-falsetru.scm")

(define ex3.02-falsetru-tests
  (test-suite
   "Test for ex3.02-falsetru"

   (test-case
    "make-monitored"
    (define s (make-monitored sqrt))
    (check-equal? (s 100) 10)
    (check-equal? (s 'how-many-calls?) 1)
    (check-equal? (s 25) 5)
    (check-equal? (s 'how-many-calls?) 2)

    ; reset-count
    (s 'reset-count)
    (check-equal? (s 'how-many-calls?) 0)
    (check-equal? (s 100) 10)
    (check-equal? (s 'how-many-calls?) 1)
    )
   ))

(exit
  (cond
    ((= (run-tests ex3.02-falsetru-tests) 0))
    (else 1)))
