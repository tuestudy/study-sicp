(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex3.17-falsetru.scm")

(define ex3.17-falsetru-tests
  (test-suite
   "Test for ex3.17-falsetru"

   (test-case
    "correct"
    (check-equal? (count-pairs '((a) b)) 3)
    (check-equal? (count-pairs '((a) b c)) 4)
    (check-equal? (count-pairs '((a) b c d e f)) 7))

   (test-case
    "incorrect (share)"
    (define a '(a))
    (check-equal? (count-pairs (list a a)) 3))

   (test-case
    "loop"
    (define a '(a))
    (set-cdr! a a)
    (check-equal? (count-pairs a) 1))
   ))

(exit
  (cond
    ((= (run-tests ex3.17-falsetru-tests) 0))
    (else 1)))
