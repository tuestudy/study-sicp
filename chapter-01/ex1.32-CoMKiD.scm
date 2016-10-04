(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner null-value term (next a) next b))))

(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (combiner (term a) result))))
  (iter a null-value))

;
; sum
;
(define (sum-iter term a next b)
  (accumulate-iter + 0 term a next b))

; test
(define (cube x) (* x x x))
(define (inc x) (+ x 1))
(sum-iter cube 1 inc 100)

;
; product
;
(define (product-iter term a next b)
  (accumulate-iter * 1 term a next b))

; test
(define (inc a) (+ a 1))
(define (self a) a)
(product-iter self 1 inc 10) ; factorial