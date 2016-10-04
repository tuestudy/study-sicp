(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.73b-falsetru.scm")

(define ex2.73b-falsetru-tests
  (test-suite
   "Test for ex2.73b-falsetru"

   (check-equal? (deriv '(+ x 3) 'x) '1)
   (check-equal? (deriv '(* x y) 'x) 'y)
   ))

(exit
  (cond
    ((= (run-tests ex2.73b-falsetru-tests) 0))
    (else 1)))
