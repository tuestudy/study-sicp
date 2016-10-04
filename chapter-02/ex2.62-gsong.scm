(load "ex2.62-test.scm")

;Solution 2.62
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else
         (let ((x1 (car set1)) (x2 (car set2)))
           (cond
             ((= x1 x2) (cons x1 (union-set (cdr set1) (cdr set2))))
             ((< x1 x2) (cons x1 (union-set (cdr set1) set2)))
             ((> x1 x2) (cons x2 (union-set set1 (cdr set2)))))))))

(run test)

