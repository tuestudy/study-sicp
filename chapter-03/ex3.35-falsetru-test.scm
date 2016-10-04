(require rackunit)
(require rackunit/text-ui)
(load "ex3.35-falsetru.scm")

(define ex3.35-falsetru-tests
  (test-suite
   "Test for ex3.35-falsetru"

   (test-case
    "a * a = ?"
    (define a (make-connector))
    (define b (make-connector))
    (squarer a b)

    (set-value! a 5 'user)

    (check-equal? (get-value b) 25)

    (forget-value! a 'user)
    (set-value! a -1 'user)
    (check-equal? (get-value b) 1)
    )

   (test-case
    "? * ? = b"
    (define a (make-connector))
    (define b (make-connector))
    (squarer a b)

    (set-value! b 25 'user)

    (check-equal? (get-value a) 5)
    )

   (test-case
    "? * ? = b (b < 0) => ERROR"
    (define a (make-connector))
    (define b (make-connector))
    (squarer a b)

    (check-exn exn? (lambda () (set-value! b -1 'user)))
    )
   ))

(exit
  (cond
    ((= (run-tests ex3.35-falsetru-tests) 0))
    (else 1)))
