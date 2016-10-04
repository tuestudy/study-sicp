(define (my-equal? a b)
  (or (eq? a b)
      (and (and (pair? a) (pair? b))
           (my-equal? (car a) (car b))
           (my-equal? (cdr a) (cdr b)))))