(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term (next a) next b))))

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a) (* (term a) result))))
  (iter a 1))

;
; factorial
;
(define (inc a) (+ a 1))
(define (self a) a)

(define (fac n)
  (product self 1 inc n))

(define (fac-iter n)
  (product-iter self 1 inc n))


(= (fac 10) (fac-iter 10))


;
; pi
;
(define (pi) (wallis-pi 10000))

(define (wallis-pi n)
  (define (square x) (* x x))
  (define (even-term x) (square x))
  (define (odd-term x) (* (- x 1) (+ x 1)))
  (define (next x) (+ x 2))
  (* 2.0
     (/ (product-iter even-term 2 next n)
        (product-iter odd-term 2 next n))))