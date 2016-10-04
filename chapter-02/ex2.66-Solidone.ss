; answer
(define (lookup-tree given-key tree)
  (if (null? tree)
      false
      (let ((entry (car tree))
            (left-tree (cadr tree))
            (right-tree (caddr tree)))
        (cond ((equal? given-key entry) (car tree))
              ((< given-key entry) (lookup-tree given-key left-tree))
              (else (lookup-tree given-key right-tree))))))

; test-case
(define b-tree
  '(6 (2 (1 () ()) (4 () (5 () ()))) (12 (8 () (10 () ())) (13 () (14 () ())))))

(= 8 (lookup-tree 8 b-tree))
(equal? #f (lookup-tree 7 b-tree))
(= 2 (lookup-tree 2 b-tree))