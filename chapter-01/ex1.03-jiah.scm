(load "../misc/scheme-test.scm")

(define (square x) (* x x))
(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (ex1_03 x y z)
  (cond ((and (<= x y) (<= x z)) (sum-of-squares y z))
        ((and (<= y x) (<= y z)) (sum-of-squares x z))
        ((and (<= z x) (<= z y)) (sum-of-squares x y))))

(define ex1_03-test
  (make-testcase
    '(assert-true? (= 441 (square 21)))
    '(assert-true? (= 49 (square (+ 2 5))))
    '(assert-true? (= 81 (square (square 3))))
    '(assert-true? (= 25 (sum-of-squares 3 4)))
    '(assert-true? (= 25 (ex1_03 2 3 4)))
    '(assert-true? (= 25 (ex1_03 3 2 4)))
    '(assert-true? (= 25 (ex1_03 3 4 2)))
    '(assert-true? (= 20 (ex1_03 4 2 2)))
    ))

(run ex1_03-test)
