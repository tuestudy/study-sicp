(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex3.04-falsetru.scm")

(define ex3.04-falsetru-tests
  (test-suite
   "Test for ex3.04-falsetru"

   (test-case
    "make-acount password-protected"
    (define acc (make-acount 100 'secret-password))
    (check-equal? ((acc 'secret-password 'withdraw) 40) 60)
    (check-equal? ((acc 'some-other-password 'withdraw) 50) "Incorrect password")
    (check-equal? ((acc 'secret-password 'withdraw) 50) 10)
    (check-equal? ((acc 'some-other-password 'withdraw) 50) "Incorrect password")
    (check-equal? ((acc 'some-other-password 'withdraw) 50) "Incorrect password")
    (check-equal? ((acc 'some-other-password 'withdraw) 50) "Incorrect password")
    (check-equal? ((acc 'some-other-password 'withdraw) 50) "Incorrect password")
    (check-equal? ((acc 'some-other-password 'withdraw) 50) "Incorrect password")
    (check-equal? ((acc 'some-other-password 'withdraw) 50) "Call the cops")
    (check-equal? ((acc 'some-other-password 'withdraw) 50) "Call the cops")
    )

   ))

(exit
  (cond
    ((= (run-tests ex3.04-falsetru-tests) 0))
    (else 1)))
