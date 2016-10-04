(load "../misc/scheme-test.scm")

(define (map2 proc items)
  (if (null? items)
      '()
      (cons (proc (car items))
            (map proc (cdr items)))))

; 2.21

(define (square x) (* x x))

(define (square-list1 items)
  (if (null? items)
      '()
      (cons (square (car items)) (square-list1 (cdr items)))))

(define (square-list2 items)
  (map2 (lambda (x) (* x x)) items))


(equal?
(square-list1 (list 1 2 3 4 5))
(square-list2 (list 1 2 3 4 5)))

(define list1 (list 1 2 3 4 5))

(run 
 (make-testcase
  '(assert-equal? (square-list1 list1) '(1 4 9 16 25))
  '(assert-equal? (square-list2 list1) '(1 4 9 16 25))))