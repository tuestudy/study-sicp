(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex3.24-falsetru.scm")

(define ex3.24-falsetru-tests
  (test-suite
   "Test for ex3.24-falsetru"

   (test-case
    "table equal?"
    (define t (make-table equal?))
    (define get (t 'lookup-proc))
    (define put (t 'insert-proc!))
    (put 'a 'b 3)
    (check-equal? (get 'a 'b) 3)
    (check-equal? (get 'a 'c) false)
    )
   (test-case
    "talbe <custom-equal>"
    (define t (make-table (lambda (a b) (< (abs (- a b)) 0.0001))))
    (define get (t 'lookup-proc))
    (define put (t 'insert-proc!))
    (put 1 1 3)
    (check-equal? (get 1 1) 3)
    (check-equal? (get 1 1.0000001) 3)
    (check-equal? (get 1 2) false)
    )
   ))

(exit
  (cond
    ((= (run-tests ex3.24-falsetru-tests) 0))
    (else 1)))
