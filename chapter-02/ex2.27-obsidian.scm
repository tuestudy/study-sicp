(load "../misc/scheme-test.scm")

(define x (list (list 1 2) (list 3 4)))
(define y (list 1 (list 1 2) (list 3 4)))
(define z (list 1 2 3 4 (list 5 6 (list 7 8 9) 10 11 (list 12 13) 14)))

(define (deep-reverse items)
  (cond [(null? items) null]
        [(not (there-is-pair? items)) (reverse items)]
        [else
         (list+ (deep-reverse (cdr items)) (if (pair? (car items))
                                                      (deep-reverse (car items))
                                                      (car items)))]))

(define (list+ lst1 lst2)
  (append lst1 (list lst2)))


(define (there-is-pair? items)
  (cond [(null? items) false]
        [(pair? (car items)) true]
        [else (there-is-pair? (cdr items))]))

(run (make-testcase
      '(assert-equal? (+ 1 1) 2)
      '(assert-equal? (deep-reverse x) '((4 3) (2 1)))
      '(assert-true? (there-is-pair? '(1 (2 3) 4)))
      '(assert-false? (there-is-pair? '(1 2 3 4)))
      
      '(assert-equal? (list+ '((1 2 3)) '(4 5 6)) '((1 2 3) (4 5 6)) )
      
      '(assert-equal? (deep-reverse y) '((4 3) (2 1) 1))
      '(assert-equal? (deep-reverse z) '((14 (13 12)11 10 (9 8 7) 6 5) 4 3 2 1))
      
      ))

