(define set1 '(1 3 6 10))
(define set2 '(3 5 6 7 9 10))

(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((< (car set) x) (cons (car set) (adjoin-set x (cdr set))))
        ((= (car set) x) set)
        (else (cons x set))))

(adjoin-set 8 set2)
(adjoin-set 2 set2)
(adjoin-set 13 set2)
(adjoin-set 7 set2)