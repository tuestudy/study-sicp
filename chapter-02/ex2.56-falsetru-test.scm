(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.56-falsetru.scm")

(define ex2.56-falsetru-tests
  (test-suite
   "Test for ex2.56-falsetru"

   (check-equal? (deriv '(+ x 3) 'x) '1)
   (check-equal? (deriv '(* x y) 'x) 'y)
   (check-equal? (deriv '(* (* x y) (+ x 3)) 'x) '(+ (* x y) (* (+ x 3) y)))
   (check-equal? (** 2 0) 1)
   (check-equal? (** 3 1) 3)
   (check-equal? (** 2 10) 1024)
   (check-equal? (** 'x 3) '(** x 3))

   (check-equal? (deriv (** 'x 3) 'x) '(* 3 (** x 2)))
   ))

(exit
  (cond
    ((= (run-tests ex2.56-falsetru-tests) 0))
    (else 1)))
