(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex3.07-falsetru.scm")

(define ex3.07-falsetru-tests
  (test-suite
   "Test for ex3.07-falsetru"

   (test-case
    "make-acount password-protected"
    (define peter-acc (make-acount 100 'secret-password))
    (define paul-acc
      (make-joint peter-acc 'secret-password 'rosebud))
    (check-equal? ((peter-acc 'secret-password 'withdraw) 40) 60)
    (check-equal? ((peter-acc 'rosebud 'withdraw) 10) "Incorrect password")
    (check-equal? ((peter-acc 'some-other-password 'withdraw) 50) "Incorrect password")
    (check-equal? ((paul-acc  'rosebud 'withdraw) 10) 50)
    (check-equal? ((paul-acc  'secret-password 'withdraw) 10) 40)
    (check-equal? ((paul-acc  'some-other-password 'withdraw) 10) "Incorrect password")
    (check-equal? ((peter-acc 'secret-password 'withdraw) 10) 30)
    )
   ))

(exit
  (cond
    ((= (run-tests ex3.07-falsetru-tests) 0))
    (else 1)))
