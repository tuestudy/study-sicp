(load "../misc/scheme-test.scm")

(define x (list (list 1 2) (list 3 4)))
(define y (list 1 (list 1 2) (list 3 4)))
(define z (list 1 2 3 4 (list 5 6 (list 7 8 9) 10 11 (list 12 13) 14)))


(define (fringe items)
  (cond [(null? items) null]
        [(not (there-is-pair? items)) items]
        [else
         (append (if (pair? (car items))
                     (fringe (car items))
                     (list (car items)))
                 (fringe (cdr items)))]))


(define (there-is-pair? items)
  (cond [(null? items) false]
        [(pair? (car items)) true]
        [else (there-is-pair? (cdr items))]))

(run (make-testcase
      '(assert-equal? (+ 1 1) 2)
      '(assert-equal? (append '(1 2 3 4) '(1 2 3 4)) '(1 2 3 4 1 2 3 4))
      '(assert-true? (there-is-pair? '((1 2 3 4))))
      '(assert-equal? (fringe x) '(1 2 3 4))
      '(assert-equal? (fringe (list x x)) '(1 2 3 4 1 2 3 4))
      '(assert-equal? (fringe y) '(1 1 2 3 4))
      '(assert-equal? (fringe z) '(1 2 3 4 5 6 7 8 9 10 11 12 13 14))
      
      ))

