(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))
(load "ex2.31-falsetru.scm")

(define tree  (list 1
                    (list 2 (list 3 4) 5)
                    (list 6 7)))

(define (square x) (* x x))
(define (square-tree1 tree) (tree-map square tree))
(define (square-tree2 tree) (tree-map2 square tree))

(define ex2.31-falsetru-tests
  (test-suite
   "Test for ex2.31-falsetru"
   (check-equal? (square-tree1 tree) '(1 (4 (9 16) 25) (36 49)))
   (check-equal? (square-tree2 tree) '(1 (4 (9 16) 25) (36 49)))
   ))

(exit
  (cond
    ((= (run-tests ex2.31-falsetru-tests) 0))
    (else 1)))

