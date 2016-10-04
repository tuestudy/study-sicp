;
; Miller-Rabin Test
;
; If n is a prime number and a is any positive integer less than n,
; then a raised to the (n-1)st power is congruent to 1 modulo n.
;  
(define (miller-rabin-test? n a)
  (= (expmod a (- n 1) n) 1))

;
; remainder-nsr-1-mod-n 
;
;   check whether x is "nontrivial square root of 1 modulo n".
;
;   If it is true 
;                then this procedure returns 0.
;   If it is false 
;                then this procedure returns 
;                square of x modulo n.
;
; A "nontrivial square root of 1 modulo n",
;       that is, a number not equal to 1 or n - 1 
;       whose square is equal to 1 modulo n
;
(define (remainder-nsr-1-mod-n x n)
  (define (square x) (* x x))
  (define (result x)(if (= x 1) 0 x))
  (if (and (not (= x 1))
           (not (= x (- n 1)))
           (= (remainder (square x) n) 1))
      0
      (remainder (square x) n)))

(define (expmod base exp m)
  (define (even? n) (= (remainder n 2) 0))
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder-nsr-1-mod-n (expmod base (/ exp 2) m) m))
        (else
         (remainder (* base (expmod base (- exp 1) m)) m))))

;
; Prime check procedures
;
(define (fast-prime? n times)
  (define (random-test? n)
    (define (try-it a) 
      (if (= a 0) 
          (try-it (random n))
          (miller-rabin-test? n a)))
    (try-it (random n)))
  ; (fast-prime? n times)
  (cond ((= times 0) #t)
        ((random-test? n) 
         (fast-prime? n (- times 1)))
        (else #f)))

(define (all-range-test-prime? n)
  (define (all-test? n times)
    (cond ((= times 0) #t)
          ((miller-rabin-test? n times) 
           (all-test? n (- times 1)))
          (else #f)))
  (all-test? n (- n 1)))

;
; test
;
(display "normal\n")
(fast-prime? 2 10)
(fast-prime? 3 10)
(fast-prime? 4 10)
(fast-prime? 5 10)
(fast-prime? 7 10)
(fast-prime? 11 10)
(fast-prime? 121 5)
(fast-prime? 131 10)
; Camicheal Numbers
(display "Camicheal Numbers\n")
(all-range-test-prime? 5610)
(all-range-test-prime? 1105)
(all-range-test-prime? 1729)
(all-range-test-prime? 2465)
(all-range-test-prime? 2821)
(all-range-test-prime? 6601)
; Big Prime Numbers
(display "Big Prime Numbers\n")
(fast-prime? 100019 10)
(fast-prime? 100043 10)
(fast-prime? 1000033 10)