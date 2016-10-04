(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex3.19-falsetru.scm")

(define ex3.19-falsetru-tests
  (test-suite
   "Test for ex3.19-falsetru"

   (test-case
    "simple list"
    (check-false (cycle? '(1)))
    (check-false (cycle? '(1 2 3))))

   (test-case
    "complex list, but not cycle"
    (define a '(a b c))
    (define b (list a a))
    (check-false (cycle? b))
    )

   (test-case
    "non-cycle"
    (define a 'x)
    (check-false (cycle? '(a a a)))
    (check-false (cycle? (list a a a)))
    )

   (test-case
    "cycle from ex 3.13"
    ; a b c
    ; ^---+
    (define z (make-cycle (list 'a 'b 'c)))

    ; x a b c
    ;   ^---+
    (define z2 (cons 'x z))

    (check-true (cycle? z))
    (check-true (cycle? z2))
    )
   ))

(exit
  (cond
    ((= (run-tests ex3.19-falsetru-tests) 0))
    (else 1)))
