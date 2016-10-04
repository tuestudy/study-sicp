(load "../misc/scheme-test.scm")

;Solution 2.61
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (element-of-set? x (cdr set)))))

(define (intersection-set set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1
                     (intersection-set (cdr set1)
                                       (cdr set2))))
              ((< x1 x2)
               (intersection-set (cdr set1) set2))
              ((< x2 x1)
               (intersection-set set1 (cdr set2)))))))
(define (adjoin-set x set)
  (cond ((null? set) (list x))
        ((> (car set) x) (cons x set))
        (else (cons (car set) (adjoin-set x (cdr set))))))
      
  

(run
   (make-testcase
   '(assert-equal? (adjoin-set 3 '(1 2 4 5)) '(1 2 3 4 5) )
   '(assert-equal? (adjoin-set 0 '(1 2 4 5)) '(0 1 2 4 5) )
   '(assert-equal? (adjoin-set 6 '(1 2 4 5)) '(1 2 4 5 6) )
   ))
