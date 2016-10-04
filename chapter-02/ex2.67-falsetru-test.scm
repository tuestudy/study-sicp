(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.67-falsetru.scm")

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))
(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree (make-leaf 'B 2)
                                  (make-code-tree (make-leaf 'D 1)
                                                  (make-leaf 'C 1)))))
(define ex2.67-falsetru-tests
  (test-suite
   "Test for ex2.67-falsetru"

   (check-equal? (decode sample-message sample-tree) '(A D A B B C A))
   ))

(exit
  (cond
    ((= (run-tests ex2.67-falsetru-tests) 0))
    (else 1)))
