(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

;answer
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((element-of-set? (car set1) set2)
         (union-set (cdr set1) set2))
        (else
         (cons (car set1)  
               (union-set (cdr set1) set2)))))

;test-case
(define set1 '(1 2 3 4 5 6))
(define set2 '(2 4 6 8 10 12))
(define set3 '(2 4 6 7))

(union-set set1 set2)
(union-set set1 set3)