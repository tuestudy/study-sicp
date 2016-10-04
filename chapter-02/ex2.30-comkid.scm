(load "../misc/scheme-test.scm")

(define (square-tree tree)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree sub-tree)
             (* sub-tree sub-tree)))
       tree))

(run (make-testcase
      '(assert-equal? '(1 (4 (9 16) 25) (36 49)) (square-tree
                                                  (list 1
                                                        (list 2 (list 3 4) 5)
                                                        (list 6 7))))
      ))