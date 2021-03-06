(load "../misc/scheme-test.scm")

;2.63 by gsong
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))
(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= x (entry set)) #t)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))
(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))
(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

(run (make-testcase
      '(assert-equal? (tree->list-1 '()) (tree->list-2 '()))
      '(assert-equal? (tree->list-1 '(5 (3 (2 (1 () ()) ()) ()) ())) (tree->list-2 '(5 (3 (2 (1 () ()) ()) ()) ())))
      '(assert-equal? (tree->list-1 '(5 (3 (1 () ()) (2 () ())) (7 (6 () ()) (8 () ())))) (tree->list-2 '(5 (3 (1 () ()) (2 () ())) (7 (6 () ()) (8 () ())))))
      '(assert-equal? (tree->list-1 '(7 (3 (1 () ()) (5 () ())) (9 () (11 () ())))) (tree->list-2 '(7 (3 (1 () ()) (5 () ())) (9 () (11 () ())))))
      '(assert-equal? (tree->list-1 '(3 (1 () ()) (7 (5 () ()) (9 () (11 () ()))))) (tree->list-2 '(3 (1 () ()) (7 (5 () ()) (9 () (11 () ()))))))
      '(assert-equal? (tree->list-1 '(5 (3 (1 () ()) ()) (9 (7 () ()) (11 () ())))) (tree->list-2 '(5 (3 (1 () ()) ()) (9 (7 () ()) (11 () ())))))
      ))