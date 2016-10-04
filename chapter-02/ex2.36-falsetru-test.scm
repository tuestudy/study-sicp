(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.36-falsetru.scm")

(define s (list (list 1 2 3) (list 4 5 6) (list 7 8 9) (list 10 11 12)))
(define ex2.36-falsetru-tests
  (test-suite
   "Test for ex2.36-falsetru"

   (check-equal? (accumulate-n + 0 s) (list 22 26 30))
   ))

(exit
  (cond
    ((= (run-tests ex2.36-falsetru-tests) 0))
    (else 1)))
