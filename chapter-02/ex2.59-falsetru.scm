(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set)
  (if (element-of-set? x set)
    set
    (cons x set)))

(define (intersectin-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2)
         (cons (car set1)
               (intersectin-set (cdr set1) set2)))
        (else (intersectin-set (cdr set1) set2))))

(define (union-set set1 set2)
  (if (null? set1)
    set2
    (union-set (cdr set1) (adjoin-set (car set1) set2))))
