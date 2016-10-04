(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.10-falsetru.scm")

(define ex2.10-falsetru-tests
  (test-suite
   "Test for ex2.10-falsetru"

   (test-case
    "divisor span 0"
    (define r1 (make-interval 1 2))
    (define r2 (make-interval -1 1))
    (check-exn exn? (lambda () (div-interval r1 r2)))
    (check-not-exn (lambda () (div-interval r1 r1)))
    )))

(exit
  (cond
    ((= (run-tests ex2.10-falsetru-tests) 0))
    (else 1)))
