(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(namespace-require 'r5rs)

(load "ex3.16-falsetru.scm")

(define ex3.16-falsetru-tests
  (test-suite
   "Test for ex3.16-falsetru"

   (test-case
    "correct"
    (check-equal? (count-pairs '((a) b)) 3)
    (check-equal? (count-pairs '((a) b c)) 4)
    (check-equal? (count-pairs '((a) b c d e f)) 7))

   (test-case
    "incorrect (share)"
    (define a '(a))
    (check-equal? (count-pairs (list a a)) 4)) ; 3 boxes

   (test-case
    "loop"
    (define a '(a))
    (set-cdr! a a)
    ; (count-pairs a) ; This cause infinite loop
    )

   ))

(exit
  (cond
    ((= (run-tests ex3.16-falsetru-tests) 0))
    (else 1)))
