(load "../misc/scheme-test-r5rs.scm")
(load "ch4-myeval-pkg-yarra.scm")



;(begin (define var (lambda bindingnames body)) (var bindingvalues))

(define (let->combination letexp)
  (define (normlet->combination letexp)
    (define body (caddr letexp))
    (define names (map car (cadr letexp)))
    (define values (map cadr (cadr letexp)))
    (cons (list 'lambda names body) values))
  (define (namedlet->combination letexp)
    (define body (cadddr letexp))
    (define names (map car (caddr letexp)))
    (define values (map cadr (caddr letexp)))
    (define var (cadr letexp))
    (list 'begin (list 'define var (list 'lambda names body)) (cons var values)))
  (if (list? letexp)
      (namedlet->combination letexp)
      (normlet->combination letexp)))


; test
(define myexp '(let fib-iter 
                 ((a 1) (b 0) (count n))
                 (if (= count 0)
                     b
                     (fib-iter (+ a b) a (- count 1)))))
(define answer '(begin (define fib-iter 
                         (lambda (a b count) (if (= count 0) 
                                                 b
                                                 (fib-iter (+ a b) a (- count 1)))))
                       (fib-iter 1 0 n)))


(define the-global-environment (setup-environment))
(run (make-testcase
      '(assert-equal? answer (let->combination myexp))
      '(assert-equal? 4 (myeval '(let fgfg ((a 1) (b 3)) (+ a b)) the-global-environment))))





