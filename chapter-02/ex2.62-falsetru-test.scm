(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.62-falsetru.scm")

(define ex2.62-falsetru-tests
  (test-suite
    "Test for ex2.62-falsetru"

    (check-equal? (union-set '() '()) '())
    (check-equal? (union-set '() '(1)) '(1))
    (check-equal? (union-set '(1) '()) '(1))
    (check-equal? (union-set '(2) '(2)) '(2))
    (check-equal? (union-set '(1) '(2)) '(1 2))
    (check-equal? (union-set '(2) '(1)) '(1 2))
    (check-equal? (union-set '(1 2 3) '(1 3 4)) '(1 2 3 4))

    ))

(exit
  (cond
    ((= (run-tests ex2.62-falsetru-tests) 0))
    (else 1)))
