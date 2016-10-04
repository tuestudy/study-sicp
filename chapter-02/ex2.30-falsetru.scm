(define (square-tree1 tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (* tree tree))
        (else (cons (square-tree1 (car tree))
                    (square-tree1 (cdr tree))))))

(define (square-tree2 tree)
  (map (lambda (t)
         (if (pair? t)
           (square-tree2 t)
           (* t t)))
       tree))