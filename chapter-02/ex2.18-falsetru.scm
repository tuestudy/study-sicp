(load "ex2.17-falsetru.scm")

(define (reverse2 items)
  (if (null? items)
    items
    (append (reverse2 (cdr items))
            (list (car items)))))
