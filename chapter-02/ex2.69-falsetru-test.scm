(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.69-falsetru.scm")

(define sample-pairs '((A 4) (B 2) (C 1) (D 1)))
(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree (make-leaf 'B 2)
                                  (make-code-tree (make-leaf 'D 1)
                                                  (make-leaf 'C 1)))))
(define ex2.69-falsetru-tests
  (test-suite
   "Test for ex2.69-falsetru"

   (check-equal? (make-leaf-set sample-pairs)
                 '((leaf D 1) (leaf C 1) (leaf B 2) (leaf A 4)))
   (check-equal? (generate-huffman-tree sample-pairs)
                 sample-tree)
   ))

(exit
  (cond
    ((= (run-tests ex2.69-falsetru-tests) 0))
    (else 1)))
