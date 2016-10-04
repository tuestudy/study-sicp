(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.73c-falsetru.scm")

(define ex2.73c-falsetru-tests
  (test-suite
   "Test for ex2.73c-falsetru"

   (check-equal? (deriv '(** x 3) 'x) '(* 3 (** x 2)))
   ))

(exit
  (cond
    ((= (run-tests ex2.73c-falsetru-tests) 0))
    (else 1)))
