(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.66-falsetru.scm")

(define t
  (make-tree 7
             (make-tree 3
                        (make-tree 1 null null)
                        (make-tree 5 null null))
             (make-tree 9
                        null
                        (make-tree 11 null null))))

(define ex2.66-falsetru-tests
  (test-suite
    "Test for ex2.66-falsetru"

    (check-equal? (lookup 111 t) false)
    (check-equal? (lookup 7 t) 7)
    (check-equal? (lookup 11 t) 11)
    ))

(exit
  (cond
    ((= (run-tests ex2.66-falsetru-tests) 0))
    (else 1)))
