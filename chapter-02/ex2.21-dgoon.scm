(load "../misc/scheme-test.scm")

(define (square x) (* x x))

(define (square-list items)
  (if (null? items)
      (list)
      (cons (square (car items)) (square-list (cdr items)))))

(define (square-list-2 items)
  (map square items))

(define test-list (list 1 2 3 4 5 6))

(run
 (make-testcase
  '(assert-equal? (list 1 4 9 16 25 36) (square-list test-list))
  '(assert-equal? (square-list test-list) (square-list-2 test-list))))
