(load "../misc/scheme-test-r5rs.scm")

; answer
(define (list-of-values-l2r exps env)
  (if (no-operands? exps)
      '()
      (let ((left (eval (first-operand exps) env))
            (right (list-of-values-l2r (rest-operands exps) env)))
        (cons left right))))

(define (list-of-values-r2l exps env)
  (if (no-operands? exps)
      '()
      (let ((right (list-of-values-r2l (rest-operands exps) env))
            (left (eval (first-operand exps) env)))
        (cons left right))))


(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))

; test
(define exp-for-test
  '((set! x (/ x 2))
    (set! x (+ x 2))
    (set! x (* x 3))))

(define envl2r (scheme-report-environment 5))
(eval '(define x 10) envl2r)
(define envr2l (scheme-report-environment 5))
(eval '(define x 10) envr2l)

(list-of-values-l2r exp-for-test envl2r)
(list-of-values-r2l exp-for-test envr2l)

(run (make-testcase
      '(assert-equal? 21 (eval 'x envl2r))
      '(assert-equal? 16 (eval 'x envr2l))))