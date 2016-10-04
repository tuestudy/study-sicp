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
(define (func x)
  (cond ((= x 0) 0)
        ((= x 1) 1)
        ((= x 2) 2)
        ((>= x 3) (+ (func (- x 1))
                     (* 2 (func (- x 2)))
                     (* 3 (func (- x 3)))))))

(define (dec x) (- x 1))
(define (func2 x)
  (func-iter 2 1 0 x))

(define (func-iter a b c count)
  (if (= count 0)
      c
      (func-iter (+ a (* 2 b) (* 3 c)) a b (dec count)))) 


; test-case
(assert-equal? 0 (func 0))
(assert-equal? 1 (func 1))
(assert-equal? 2 (func 2))
(assert-equal? (+ 2 (* 2 1) 0) (func 3))
(assert-equal? (+ 4 (* 2 2) 3) (func 4))

(assert-equal? 0 (func2 0))
(assert-equal? 1 (func2 1))
(assert-equal? 2 (func2 2))
(assert-equal? (+ 2 (* 2 1) 0) (func2 3))
(assert-equal? (+ 4 (* 2 2) 3) (func2 4))

(assert-equal? (func 20) (func2 20))
