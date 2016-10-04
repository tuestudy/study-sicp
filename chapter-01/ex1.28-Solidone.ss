(define (square x) (* x x))
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m)) m))
        (else (remainder (* base (expmod base (- exp 1) m)) m))))


(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

;answer
(define (miller-rabin n)
  (define (try-it a)
    (= (expmod a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime2? n times)
  (cond ((= times 0) true)
        ((miller-rabin n) (fast-prime2? n (- times 1)))
        (else false)))

;test-case
(and
 (equal? #t (fast-prime2? 11 11))
 (equal? #t (fast-prime2? 2 2))
 (equal? #t (fast-prime2? 3 13))
 (equal? #f (fast-prime2? 4 5))
 (equal? #t (fast-prime2? 13 100))
 )
(and
 (equal? #f (fast-prime2? 561 100))
 (equal? #f (fast-prime2? 1105 100))
 (equal? #f (fast-prime2? 1729 100))
 (equal? #f (fast-prime2? 2465 100))
 )

