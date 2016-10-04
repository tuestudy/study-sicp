(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.63-falsetru.scm")

(define t
  (make-tree 7
             (make-tree 3
                        (make-tree 1 null null)
                        (make-tree 5 null null))
             (make-tree 9
                        null
                        (make-tree 11 null null))))

(define ex2.63-falsetru-tests
  (test-suite
    "Test for ex2.63-falsetru"

    (check-equal? (tree->list-1 t) '(1 3 5 7 9 11))
    (check-equal? (tree->list-2 t) '(1 3 5 7 9 11))
    ))

(exit
  (cond
    ((= (run-tests ex2.63-falsetru-tests) 0))
    (else 1)))
