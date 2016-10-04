(load "../misc/scheme-test.scm")

(define zero (lambda (f) (lambda (x) x)))
(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))
(define three (lambda (f) (lambda (x) (f (f (f x))))))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define (add a b)
  (lambda (f) (lambda (x) ((a f) ((b f) x)))))

(define (to-i x) ((x (lambda (n) (+ n 1))) 0))

(run (make-testcase
      '(assert-equal? 0 (to-i zero))
      '(assert-equal? 1 (to-i one))
      '(assert-equal? 2 (to-i two))
      '(assert-equal? 3 (to-i three))
      '(assert-equal? 0 (to-i (add zero zero)))
      '(assert-equal? 1 (to-i (add zero one)))
      '(assert-equal? 1 (to-i (add one zero)))
      '(assert-equal? 2 (to-i (add one one)))
      '(assert-equal? 3 (to-i (add one two)))
      '(assert-equal? 4 (to-i (add one three)))
      '(assert-equal? 5 (to-i (add two three)))
      ))
