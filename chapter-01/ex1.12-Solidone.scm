; define testing-code
(define (assert-equal? a b)
  (if (= a b)
      (display " <pass!> ")
      (display b)))

(define (assert-similar? a b c)
  (if (>= c (abs (- a b)))
      (display " <pass!> ")
      (display b)))

; define solve
(define (pascal-tri x y)
  (cond ((or (= y 1) (= x y))1)
        (else (+ (pascal-tri (- x 1) (- y 1))
                 (pascal-tri (- x 1) y)))))

; test-case
(assert-equal? 1 (pascal-tri 1 1))
(assert-equal? 1 (pascal-tri 2 1))
(assert-equal? 1 (pascal-tri 2 2))
(assert-equal? 1 (pascal-tri 3 1))
(assert-equal? 2 (pascal-tri 3 2))
(assert-equal? 1 (pascal-tri 3 3))
(assert-equal? 1 (pascal-tri 4 1))
(assert-equal? 3 (pascal-tri 4 2))
(assert-equal? 3 (pascal-tri 4 3))
(assert-equal? 1 (pascal-tri 4 4))






