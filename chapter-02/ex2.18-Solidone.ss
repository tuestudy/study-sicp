(define squares (list 1 4 9 16 25))
(define odds (list 1 3 5 7))

(define (reverse2 items)
  (define (iter item result)
    (if (null? item)
        result
        (iter (cdr item) (cons (car item) result))))
  (iter items null))

(and
 (equal? (list 25 16 9 4 1) (reverse2 squares))
 (equal? (list 7 5 3 1) (reverse2 odds))
 )