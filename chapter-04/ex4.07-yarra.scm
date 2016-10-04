(load "../misc/scheme-test-r5rs.scm")
;(let* ((x 3)
;       (y (+ x 2))
;       (z (+ x y 5)))
;  (* x z))

; answer
(define (let*->nested-lets myexp)
  (define (argslist exp) (cadr exp))
  (define (body exp) (caddr exp))
  (define firstarg car)
  (define argname car)
  (define argvalue cadr)
  (define (iter args body)
    (if (null? (cdr args))
        (list (list 'lambda 
                    (list (argname (firstarg args))) 
                    body) 
              (argvalue (firstarg args)))
        (list (list 'lambda 
                    (list (argname (firstarg args))) 
                    (iter (cdr args) body))
              (argvalue (firstarg args)))))
  (iter (argslist myexp) (body myexp)))

;test
(define expp '(let* ((x 3) (y (+ x 2)) (z (+ x y 5))) (* x z)))
(define answer '((lambda (x) ((lambda (y) ((lambda (z) (* x z)) (+ x y 5))) (+ x 2))) 3))

(run (make-testcase
      '(assert-equal? answer (let*->nested-lets expp))))