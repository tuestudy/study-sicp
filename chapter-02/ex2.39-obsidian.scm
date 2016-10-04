(load "../misc/scheme-test.scm")

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define (reverse1 sequence)
  (foldr (lambda (x y) (append y (list x))) 
         null 
         sequence))

(define (reverse2 sequence)
  (fold-left (lambda (x y) (cons y x)) 
             null 
             sequence))


(run (make-testcase
      '(assert-equal? (+ 1 1) 2)
      '(assert-equal? (reverse1 '(1 2 3 4 5 6 7 8)) '(8 7 6 5 4 3 2 1))
      '(assert-equal? (reverse2 '(1 2 3 4 5 6 7 8)) '(8 7 6 5 4 3 2 1))
      ))
