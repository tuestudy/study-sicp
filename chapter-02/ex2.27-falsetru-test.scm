(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.27-falsetru.scm")

(define ex2.27-falsetru-tests
  (test-suite
   "Test for ex2.27-falsetru"

   (test-case
    "deep-reverse"
    (define x (list (list 1 2) (list 3 4)))
    (define x2 '(((1 2) (3 4)) ((5 6) (7 8)) 9))
    (check-equal? (deep-reverse x) '((4 3) (2 1)))
    (check-equal? (deep-reverse x2) '(9 ((8 7) (6 5)) ((4 3) (2 1))))
    )))

(exit
  (cond
    ((= (run-tests ex2.27-falsetru-tests) 0))
    (else 1)))
