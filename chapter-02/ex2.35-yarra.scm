; 2.35

; accumulate 를 써서 2.2.2 절에 나온 count-leave 프로시저를 다시 정의해 보아라.

(load "../misc/accumulate.scm")
(load "../misc/scheme-test.scm")

(define (count-leaves t)
  (accumulate + 
              0 
              (map (lambda (x)
                     (if (pair? x)
                         (count-leaves x)
                         1))
                       t)))

(run
 (make-testcase
  '(assert-equal? 6 (count-leaves (list 1 2 3 4 5 6)))
  '(assert-equal? 10 (count-leaves (list 1 2 3 4 5 6 7 8 9 10)))))


