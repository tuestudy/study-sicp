(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.68-falsetru.scm")

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))
(define sample-text '(A D A B B C A))
(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree (make-leaf 'B 2)
                                  (make-code-tree (make-leaf 'D 1)
                                                  (make-leaf 'C 1)))))
(define ex2.68-falsetru-tests
  (test-suite
   "Test for ex2.68-falsetru"

   (check-equal? (encode-symbol 'A sample-tree) '(0))
   (check-equal? (encode-symbol 'B sample-tree) '(1 0))
   (check-equal? (encode-symbol 'C sample-tree) '(1 1 1))
   (check-equal? (encode-symbol 'D sample-tree) '(1 1 0))

   (check-equal? (encode sample-text sample-tree) '(0 1 1 0 0 1 0 1 0 1 1 1 0))

   (check-exn exn? (lambda() (encode '(X) sample-tree)))
   ))

(exit
  (cond
    ((= (run-tests ex2.68-falsetru-tests) 0))
    (else 1)))
