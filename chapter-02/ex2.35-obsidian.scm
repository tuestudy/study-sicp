(load "../misc/scheme-test.scm")

(define (count-leaves t)
  (foldr (λ(x y) (+ x y)) 
         0 
         (map (λ(p)(if (pair? p)
                       (count-leaves p)
                       1))
              t)))


(run (make-testcase
      '(assert-equal? (+ 1 1) 2)
      '(assert-equal? (count-leaves '(1 2 3 4 5)) 5)
      '(assert-equal? (count-leaves '(1 2 (1 1 (1 1 (1) 1) 1) 3 4 5)) 12)
      ))
