(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.54-falsetru.scm")

(define ex2.54-falsetru-tests
  (test-suite
   "Test for ex2.54-falsetru"

   (check-true (my-equal? '(this is a list) '(this is a list)))
   (check-false (my-equal? '(this is a list) '(this (is a) list)))
   ))

(exit
  (cond
    ((= (run-tests ex2.54-falsetru-tests) 0))
    (else 1)))
