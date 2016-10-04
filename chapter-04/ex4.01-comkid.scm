(load "../misc/scheme-test-r5rs.scm")

(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))

; list-of-values> : evaluates operands from left to right 
(define (list-of-values> exps env)
  (if (no-operands? exps)
      '()
      (let ((left (eval (first-operand exps) env))
            (right (list-of-values> (rest-operands exps) env)))
        (cons left right))))

; list-of-values< : evaluates operands from right to left 
(define (list-of-values< exps env)
  (if (no-operands? exps)
      '()
      (let ((right (list-of-values< (rest-operands exps) env))
            (left (eval (first-operand exps) env)))
        (cons left right))))

; for test
(define test-exps 
  '((set! x (/ x 2)) 
    (set! x (+ x 2))
    (set! x (* x 3))))

(define env> (scheme-report-environment 5))
(eval '(define x 10) env>)
(define env< (scheme-report-environment 5))
(eval '(define x 10) env<)

(list-of-values> test-exps env>)
(list-of-values< test-exps env<)

(run (make-testcase
      '(assert-equal? 21 (eval 'x env>))
      '(assert-equal? 16 (eval 'x env<))))