; 3.16

(load "../misc/scheme-test.scm")

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))


; solution
(define ab (cons 'a 'b))
(define cd (cons 'c 'd))
(define three (cons ab cd))
(define four (cons (cons ab ab) '()))
(define double_ab (cons ab ab))
(define seven (cons double_ab double_ab))


; test
(run
 (make-testcase
  '(assert-equal? 3 (count-pairs three))
  '(assert-equal? 4 (count-pairs four))
  '(assert-equal? 7 (count-pairs seven))))


