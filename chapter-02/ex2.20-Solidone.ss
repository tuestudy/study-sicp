; solving part
(define (same-parity a . b)
  (cons a (filter-parity (check-parity a) b)))

(define (filter-parity parity b)
  (cond ((null? b) '())
        ((= parity (check-parity (car b))) (cons (car b) (filter-parity parity (cdr b))))
        (else (filter-parity parity (cdr b)))))

(define (check-parity x)
  (remainder x 2))


; test-case
(equal? (list 1 3 5 7) (same-parity 1 2 3 4 5 6 7))
(equal? (list 2 4 6) (same-parity 2 3 4 5 6 7))
(= (check-parity 3)
   (check-parity 1))
