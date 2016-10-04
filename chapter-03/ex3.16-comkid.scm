(load "../misc/scheme-test-r5rs.scm")

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

(define a (cons 1 2))
(define b (cons 3 4))
(define c (cons a a))

(define x1 (cons 1 (cons 2 a)))
(define x2 (cons b a))
(define y1 (cons 1 (cons a a)))
(define y2 (cons a (cons 1 a)))
(define z3 (cons c c))

(run (make-testcase  
      '(assert-equal? 3 (count-pairs x1))
      '(assert-equal? 3 (count-pairs x2))      
      '(assert-equal? 4 (count-pairs y1))      
      '(assert-equal? 4 (count-pairs y2)) 
      '(assert-equal? 7 (count-pairs z3)) 
      ))

(define a1 (cons 1 2))
(define b1 (cons 1 a1))
(set-cdr! a1 b1)
(define c1 (cons 1 b1))