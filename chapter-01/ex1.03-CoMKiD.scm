; SICP Exercise 1.03 
;                                       by CoMKiD
(load "../misc/scheme-test.scm")

(define (square n) (* n n))

(define (sum-of-squares x y)
  (+ (square x) (square y)))

(define (bigger-square-sum1 a b c)
  (cond ((and (<= a b) (<= a c)) (sum-of-squares b c))
        ((and (<= b c) (<= b a)) (sum-of-squares c a))
        (else (sum-of-squares a b))))

(define (bigger-square-sum2 a b c)
  (cond ((or (<= a b c) (<= a c b)) (sum-of-squares b c))
        ((or (<= b c a) (<= b a c)) (sum-of-squares c a))
        (else (sum-of-squares a b))))

(define (bigger-square-sum3 a b c)
  (cond ((<= a (min b c)) (sum-of-squares b c))
        ((<= b (min c a)) (sum-of-squares c a))
        (else (sum-of-squares a b))))

(define (bigger-square-sum4 nums)
  (let ((sorted-nums (sort nums >)))
    (sum-of-squares (car sorted-nums) (cadr sorted-nums))))

(define test 
  (make-testcase
   ; bigger-square-sum1
   '(assert-equal? 13 (bigger-square-sum1 1 2 3))
   '(assert-equal? 13 (bigger-square-sum1 2 1 3))
   '(assert-equal? 13 (bigger-square-sum1 2 3 1))
   '(assert-equal? 2 (bigger-square-sum1 1 1 1))
   ; bigger-square-sum2
   '(assert-equal? 13 (bigger-square-sum2 1 2 3))
   '(assert-equal? 13 (bigger-square-sum2 2 1 3))
   '(assert-equal? 13 (bigger-square-sum2 2 3 1))
   '(assert-equal? 2 (bigger-square-sum2 1 1 1))
   ; bigger-square-sum3
   '(assert-equal? 13 (bigger-square-sum3 1 2 3))
   '(assert-equal? 13 (bigger-square-sum3 2 1 3))
   '(assert-equal? 13 (bigger-square-sum3 2 3 1))
   '(assert-equal? 2 (bigger-square-sum3 1 1 1))
   ; bigger-square-sum4
   '(assert-equal? 13 (bigger-square-sum4 (list 1 2 3)))
   '(assert-equal? 13 (bigger-square-sum4 (list 2 1 3)))
   '(assert-equal? 13 (bigger-square-sum4 (list 2 3 1)))   
   '(assert-equal? 2 (bigger-square-sum4 (list 1 1 1)))   
   ; square
   '(assert-equal? 4 (square 2))
   '(assert-equal? 1 (square 1))))

(run test)
