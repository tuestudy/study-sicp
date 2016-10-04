; prime number
(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (define (next x) 
    (if (= x 2) (+ x 1) (+ x 2)))
  (define (square x) (* x x))
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? n)
  (= n (smallest-divisor n)))

; fermat-prime
(define (fermat-prime? n)
  (fast-prime? n (- n 1)))

(define (fast-prime? n times)
  (define (fermat-test n a) (= (expmod a n n) a))
  (cond ((= times 0) #t)
        ((fermat-test n times) (fast-prime? n (- times 1)))
        (else #f)))

(define (expmod base exp m)
  (define (even? n) (= (/ n 2) 0))
  (define (square x) (* x x))
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m)) m))
        (else
         (remainder (* base (expmod base (- exp 1) m)) m))))

; test
(display 561)(newline)
(prime? 561)
(fermat-prime? 561)
(display 1105)(newline)
(prime? 1105)
(fermat-prime? 1105)
(display 1729)(newline)
(prime? 1729) 
(fermat-prime? 1729)
(display 2465)(newline)
(prime? 2465) 
(fermat-prime? 2465)
(display 2821)(newline)
(prime? 2821) 
(fermat-prime? 2821)
(display 6601)(newline)
(prime? 6601) 
(fermat-prime? 6601)
