(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

;answer
(define (adjoin-set x set)
  (cons x set))

(define (union-set set1 set2)
  (append set1 set2))

;test-case
(define set1 '(2 3 2 1 3 2 2))
(define set2 '(2 4 6 8 10 12))

(element-of-set? 2 set1)
(adjoin-set 2 set1)
(intersection-set set1 set2)
(union-set set1 set2)
