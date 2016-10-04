(require rackunit)
(require rackunit/text-ui)
(load "ex3.38a-falsetru.scm")

(define ex3.38a-falsetru-tests
  (test-suite
   "Test for ex3.38a-falsetru"

   (test-case
    "Peter-Paul-Mary permutations"
    (set! balance 100) (Peter) (Paul) (Mary) (check-equal? balance 45)
    (set! balance 100) (Peter) (Mary) (Paul) (check-equal? balance 35)
    (set! balance 100) (Paul) (Peter) (Mary) (check-equal? balance 45)
    (set! balance 100) (Paul) (Mary) (Peter) (check-equal? balance 50)
    (set! balance 100) (Mary) (Peter) (Paul) (check-equal? balance 40)
    (set! balance 100) (Mary) (Paul) (Peter) (check-equal? balance 40)
    )
   ))

(exit
  (cond
    ((= (run-tests ex3.38a-falsetru-tests) 0))
    (else 1)))
