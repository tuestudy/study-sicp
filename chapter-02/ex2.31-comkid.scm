(load "../misc/scheme-test.scm")

(define (square x) (* x x))

(define (tree-map f tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (tree-map f sub-tree)
             (f sub-tree)))
       tree))

(define (square-tree tree)
  (tree-map square tree))

(run (make-testcase
      '(assert-equal? '(1 (4 (9 16) 25) (36 49)) (square-tree
                                                  (list 1
                                                        (list 2 (list 3 4) 5)
                                                        (list 6 7))))
      ))