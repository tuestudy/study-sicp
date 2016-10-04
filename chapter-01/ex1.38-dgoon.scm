(load "../misc/scheme-test.scm")
(load "../chapter-01/ex1.37-dgoon.scm")

(define e 2.718281828459045)

(define (e-d n)
    (if (= (remainder n 3) 2)
        (* 2 (floor (/ (+ n 1) 3)))
        1))

(define (e-n n) 1.0)

(run (make-testcase
    '(assert-equal? 1 (e-d 1))
    '(assert-equal? 2 (e-d 2))
    '(assert-equal? 1 (e-d 3))
    '(assert-equal? 1 (e-d 4))
    '(assert-equal? 4 (e-d 5))
    '(assert-near? (- e 2) (cont-frac e-n e-d 10) 0.001)))
