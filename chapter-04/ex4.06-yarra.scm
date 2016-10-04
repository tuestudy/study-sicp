(load "../misc/scheme-test-r5rs.scm")

(define (let->combination letexp)
  (define body (caddr letexp))
  (define names (map car (cadr letexp)))
  (define values (map cadr (cadr letexp)))
  (cons (list 'lambda names body) values))


(define letexp '(let ((a 10) (b 20)) (+ a b)))
(define answer '((lambda (a b) (+ a b)) 10 20))

;test
(run (make-testcase
      '(assert-equal? answer (let->combination letexp))))

