;fermat-test
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
; prime-test


(define (find-divisor n test-divisor)
  (define (divides? a b)
    (= (remainder b a) 0))
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (prime? n)
  (define (smallest-divisor n)
    (find-divisor n 2))
  (= n (smallest-divisor n)))

(define car_num1 561)
(define car_num2 1105)
(define car_num3 1729)
(define car_num4 2465)
(define car_num5 2821)
(define car_num6 6601)
; test-case
(define (test_car_num number)
  (not (equal? (fast-prime? number number)
               (prime? number))))

(and 
 (test_car_num car_num1)
 (test_car_num car_num2)
 (test_car_num car_num3)
 (test_car_num car_num4)
 (test_car_num car_num5)
 (test_car_num car_num6)
 )

;plus
(define (find_car_num n)
  (define (car_num? number)
    (not (equal? (fast-prime? number 1000)
                 (prime? number))))
  (define (iter count end)
    (if (>= count end)
        null
        (if (car_num? count)
            (and (display count) (newline) (iter (+ count 1) end))
            (iter (+ count 1) end))))
    (iter 2 n))

(find_car_num 10000)
;(find_car_num 100000000)
; 25 numbers below so.
;561
;1105
;1729
;2465
;2821
;6601
;8911
;10585
;15841
;29341
;41041
;46657
;52633
;62745
;63973
;75361
;101101
;115921
;126217
;162401
;172081
;188461
;ans so on