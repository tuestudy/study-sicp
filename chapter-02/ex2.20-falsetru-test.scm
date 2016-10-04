(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.20-falsetru.scm")

(define ex2.20-falsetru-tests
  (test-suite
   "Test for ex2.20-falsetru"

   (check-equal? (same-parity 1 2 3 4 5 6 7) (list 1 3 5 7))
   ;(check-equal? (same-parity 2 3 4 5 6 7) (list 2 4 6))
   ))

(exit
  (cond
    ((= (run-tests ex2.20-falsetru-tests) 0))
    (else 1)))
