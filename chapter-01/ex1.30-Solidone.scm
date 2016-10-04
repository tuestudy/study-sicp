; define testing-code
(define (assert-equal? a b)
  (if (= a b)
      (display " <pass!> ")
      (display b)))

(define (assert-similar? a b c)
  (if (>= c (abs (- a b)))
      (display " <pass!> ")
      (display b)))

; define section
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (sum-iter term a next b)
  (define (iter x result)
    (if (> x b)
        result
        (iter (next x) (+ (term x) result))))
  (iter a 0))

(define (cube x) (* x x x))
(define (inc x) (+ x 1))

; example
(define (sum-cube a b)
  (sum cube a inc b))

(assert-equal? 3025 (sum-cube 1 10))

(define (sum-cube2 a b)
  (sum-iter cube a inc b))

(assert-equal? 3025 (sum-cube2 1 10))


(define (identity x) x)

(define (sum-integers a b)
  (sum identity a inc b))

(assert-equal? 55 (sum-integers 1 10))

(define (sum-integers2 a b)
  (sum-iter identity a inc b))
  
(assert-equal? 55 (sum-integers2 1 10))


(define (pi-sum a b)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum pi-term a pi-next b))

(assert-similar? 3.14 (* 8 (pi-sum 1 1000)) 0.001)


; define solve
(define n 100); If you want more precise answer, change from 100 to a more big number.

(define (coeff x)
  (cond ((= x 0) 1)
        ((= x n) 1)
        ((even? x) 2)
        (else 4)))
  
(define (simpson f a b)
  (define h (/ (- b a) n))
  (define (fk k) (* (coeff k) (f (+ a (* k h)))))
  (* (/ h 3.0) (sum fk a inc n)))

(define (simpson-iter f a b)
  (define h (/ (- b a) n))
  (define (fk k) (* (coeff k) (f (+ a (* k h)))))
  (* (/ h 3.0) (sum-iter fk a inc n)))

; test-case
(assert-similar? 1 1.00001 0.001)
(assert-similar? 0.25 (simpson cube 0 1) 0.0001)
(assert-similar? 0.25 (simpson-iter cube 0 1) 0.0001)