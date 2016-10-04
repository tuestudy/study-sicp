(load "ex2.33-falsetru.scm")
(define (enumerate-tree tree)
  (cond ((null? tree) null)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))
(define (count-leaves t)
  (accumulate (lambda (a b) (+ (length a) b))
              0
              (map enumerate-tree t)))

(define (count-leaves2 t)
  (accumulate +
              0
              (map (lambda (x)
                     (cond ((null? x) 0)
                           ((not (pair? x)) 1)
                           (else (count-leaves2 x))))
                   t)))
