(load "../misc/scheme-test.scm")

(define (square x) (* x x))

(define (square-list1 items)
  (if (null? items)
      null
      (cons (square (car items)) 
            (square-list1 (cdr items)))))

(define (square-list2 items)
  (map (lambda (x) (* x x)) items))

(run (make-testcase
      '(assert-equal? (list 1 4 9 16) (square-list1 (list 1 2 3 4)))
      '(assert-equal? (list 1 4 9 16) (square-list2 (list 1 2 3 4)))
      ))