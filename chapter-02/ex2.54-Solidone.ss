(define (new-equal? a b)
  (cond ((and (null? a) (null? b)) true)
        ((eq? (car a) (car b)) (new-equal? (cdr a) (cdr b)))
        (else #f)))

(new-equal? '(this is a list) '(this is a list))

(new-equal? '(this is a list) '(this (is a) list))



