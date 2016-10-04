; filtered-accumulate
;
(define (filtered-accumulate-iter pred combiner null-value term a next b)
  (define (iter a result)
    (cond ((> a b) result)
          ((pred a) (iter (next a) (combiner (term a) result)))
          (else (iter (next a) result))))
  (iter a null-value))

; prime number
;
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (define (square x) (* x x))
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

; prime-square-sum
;
(define (prime-square-sum a b)
  (define (square x) (* x x))
  (define (inc x) (+ x 1))
  (filtered-accumulate-iter prime? + 0 square a inc b))

(= 87 (prime-square-sum 2 10))
(= 208 (prime-square-sum 2 12))
(= 377 (prime-square-sum 2 13))
(= 0 (prime-square-sum 20 22))

; GCD (Great Common Divisor)
;
(define (gcd-product n)
  (define (self a) a)
  (define (inc x) (+ x 1))
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))
  (define (gcd? a) (= 1 (gcd a n)))
  (filtered-accumulate-iter gcd? * 1 self 1 inc n))

(= 189 (gcd-product 10)) ; 1 * 3 * 7 * 9
