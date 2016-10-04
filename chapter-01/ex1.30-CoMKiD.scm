(define (sum-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (+ (term a) result))))
  (iter a 0))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))


(define (cube x) (* x x x))
(define (inc x) (+ x 1))

(define (double x) (* 2 x))
(define (milli-inc x) (+ x 0.001))

;
; Test
;
(sum-iter cube 1 inc 100)
(sum cube 1 inc 100)

(sum-iter double 1 milli-inc 1000)
;(sum double 1 milli-inc 1000) ; segment fault