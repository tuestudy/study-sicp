(load "../misc/scheme-test.scm")
(load "ex2.30-yarra.scm")

(define (tree-map proc tree)
  (cond ((null? tree) '())
        ((pair? tree) (cons (tree-map proc (car tree))
                            (tree-map proc (cdr tree))))
        (else (proc tree))))

(define (square-tree2 tree)
  (tree-map square tree))

(define test-list '(1 (2 3 (4 5) 6)))

(run (make-testcase
      '(assert-equal? (square-tree test-list)
                      (square-tree2 test-list))))
