(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.57-falsetru.scm")

(define ex2.57-falsetru-tests
  (test-suite
   "Test for ex2.57-falsetru"

   ; XXX
   (check-equal? (deriv '(* x y (+ x 3)) 'x)
                 '(+ (* x y) (* y (+ x 3))))
   (check-equal? (deriv '(+ x x x x) 'x) 4)
   ))

(exit
  (cond
    ((= (run-tests ex2.57-falsetru-tests) 0))
    (else 1)))
