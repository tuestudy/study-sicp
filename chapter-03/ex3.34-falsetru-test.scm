(require rackunit)
(require rackunit/text-ui)
(load "ex3.34-falsetru.scm")

(define ex3.34-falsetru-tests
  (test-suite
   "Test for ex3.34-falsetru"
   (test-case
    "a * a = ?"
    (define a (make-connector))
    (define b (make-connector))
    (squarer a b)

    (set-value! a 5 'user)

    (check-equal? (get-value b) 25)
    )

   (test-case
    "? * ? = b -> not work."
    (define a (make-connector))
    (define b (make-connector))
    (squarer a b)

    (set-value! b 25 'user)

    ;(check-equal? (get-value a) 5)
    (check-equal? (get-value a) false)
    )
   ))

(exit
  (cond
    ((= (run-tests ex3.34-falsetru-tests) 0))
    (else 1)))
