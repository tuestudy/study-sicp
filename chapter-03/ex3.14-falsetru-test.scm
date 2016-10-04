(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex3.14-falsetru.scm")

(define ex3.14-falsetru-tests
  (test-suite
   "Test for ex3.14-falsetru"

   (test-case
    "mystery"
    (define v (list 'a 'b 'c 'd))
    (define w (mystery v))
    (check-equal? v '(a))
    (check-equal? w '(d c b a))
    )
   ))

(exit
  (cond
    ((= (run-tests ex3.14-falsetru-tests) 0))
    (else 1)))
