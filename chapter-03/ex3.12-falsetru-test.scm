(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex3.12-falsetru.scm")

(define ex3.12-falsetru-tests
  (test-suite
   "Test for ex3.12-falsetru"

   (test-case "append"
    (define x (list 'a 'b))
    (define y (list 'c 'd))
    (define z (append x y))
    (check-equal? (cdr x) (list 'b)))
   (test-case
    "append!"
    (define x (list 'a 'b))
    (define y (list 'c 'd))
    (define w (append! x y))
    (check-equal? w (list 'a 'b 'c 'd))
    (check-equal? (cdr x) (list 'b 'c 'd))
    (check-equal? w x)
    )
   ))

(exit
  (cond
    ((= (run-tests ex3.12-falsetru-tests) 0))
    (else 1)))
