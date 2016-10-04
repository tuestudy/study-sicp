(require rackunit)
(require rackunit/text-ui)
(load "ex3.37-falsetru.scm")

(define ex3.37-falsetru-tests
  (test-suite
   "Test for ex3.37-falsetru"

   (test-case
    "c+"
    (define a (make-connector))
    (define b (make-connector))
    (define c (c+ a b))

    (set-value! a 1 'user)
    (set-value! b 2 'user)
    (check-equal? (get-value c) 3)
    )

   (test-case
    "c-"
    (define a (make-connector))
    (define b (make-connector))
    (define c (c- a b))

    (set-value! a 3 'user)
    (set-value! b 2 'user)
    (check-equal? (get-value c) 1)
    )

   (test-case
    "c*"
    (define a (make-connector))
    (define b (make-connector))
    (define c (c* a b))

    (set-value! a 3 'user)
    (set-value! b 4 'user)
    (check-equal? (get-value c) 12)
    )

   (test-case
    "c/"
    (define a (make-connector))
    (define b (make-connector))
    (define c (c/ a b))

    (set-value! a 12 'user)
    (set-value! b 4 'user)
    (check-equal? (get-value c) 3)
    )

   (test-case
    "cv"
    (define c (cv 9))
    (check-equal? (get-value c) 9)
    )

   (test-case
    "celsius-fahrenheit-converter"

    (define (celsius-fahrenheit-converter x)
      (c+ (c* (c/ (cv 9) (cv 5))
              x)
          (cv 32)))
    (define C (make-connector))
    (define F (celsius-fahrenheit-converter C))

    (set-value! C 25 'user)
    (check-equal? (get-value F) 77)
    (check-exn exn? (lambda () (set-value! F 212 'user)))
    (forget-value! C 'user)
    (set-value! F 212 'user)
    (check-equal? (get-value C) 100)
    )
   ))

(exit
  (cond
    ((= (run-tests ex3.37-falsetru-tests) 0))
    (else 1)))
