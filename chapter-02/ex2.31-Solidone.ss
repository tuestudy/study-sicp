(define (square x) (* x x))

(define (square-tree tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (* tree tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))

(define (square-tree2 items)
  (map (lambda (sub-tree)
         (if (pair? sub-tree)
             (square-tree sub-tree)
             (square sub-tree)))
         items))
;test-case
(define a (list 1
        (list 2 (list 3 4) 5)
        (list 6 7)))
(define b (list 1 (list 4 (list 9 16) 25) (list 36 49)))

(equal? b (square-tree a))
(equal? b (square-tree2 a))
 