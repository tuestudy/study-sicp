;; prime? procedure copied from chapter 1
;; let implemtation copied from ex4.06, ex4.22
;; mzscheme -f ch4-amb-driver-loop-*.scm < this_file.scm
;;

(define (prime-sum-pair list1 list2)
  (let ((a (an-element-of list1))
        (b (an-element-of list2)))
    (require (prime? (+ a b)))
    (cons a (cons b '()))))

(define (require p)
  (if (not p) (amb)))

(define (an-element-of items)
  (require (not (null? items)))
  (amb (car items) (an-element-of (cdr items))))

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
  (cond ((= a b) true)
        ((< a b) (divides? a (- b a)))
        (else false)))

(define (prime? n)
  (= n (smallest-divisor n)))

(prime-sum-pair '(1 3 5 8) '(20 35 110))
try-again
try-again
try-again
try-again
