; define testing-code
(define (assert-equal? a b)
  (if (= a b)
      (display "pass! ")
      (display "fail! ")))

(define (assert-similar? a b c)
  (if (>= c (abs (- a b)))
      (display "pass! ")
      (display "fail! ")))

; define section
(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (cube x) (* x x x))
(define (inc x) (+ x 1))  

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

; test-case
(assert-equal? 1 1)
(assert-equal? 1 (coeff 0))
(assert-equal? 4 (coeff 1))
(assert-equal? 2 (coeff 2))
(assert-equal? 4 (coeff 3))
(assert-equal? 1 (coeff n))

(assert-similar? 1 1.00001 0.001)
(assert-similar? 0.25 (simpson cube 0 1) 0.0001)
