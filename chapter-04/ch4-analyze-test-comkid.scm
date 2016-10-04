(load "../misc/scheme-test-r5rs.scm")
(load "ch4-myeval-pkg-comkid.scm")
(load "ch4-analyze-comkid.scm")

(define env (setup-environment))

; self-evaluation
(run-named-test 
 "self-evaluation-test"
 (make-testcase
  '(assert-equal? (myeval '1 env)
                  (myeval2 '1 env))
  '(assert-equal? (myeval '"hello" env)
                  (myeval2 '"hello" env))))

; quotation
(run-named-test
 "quotation-test"
 (make-testcase 
  '(assert-equal? (myeval '(quote test) env)
                  (myeval2 '(quote test) env))))

; variable
(define-variable! 'x 123 env)
(run-named-test
 "variable-test"
 (make-testcase
  '(assert-equal? 123 (myeval2 'x env))))

; assignment
(myeval2 '(set! x 333) env)
(run-named-test
 "analyze-assignment"
 (make-testcase 
  '(assert-equal? 333 (myeval2 'x env))))

; definition
(myeval2 '(define a 111) env)
(run-named-test
 "define-test"
 (make-testcase 
  '(assert-equal? 111 (myeval2 'a env))))


; Conditional: if
(run-named-test
 "if-test"
 (make-testcase 
  '(assert-equal? (myeval '(if true 0 1) env)
                  (myeval2 '(if true 0 1) env))))


; lambda 
(myeval2 '(define cube (lambda (x) (* x x x))) env) 
(run-named-test
 "lambda-test"
 (make-testcase 
  '(assert-equal? 4 (myeval2 '((lambda (x) (* x x)) 2) env))
  '(assert-equal? 8 (myeval2 '((lambda (x) (cube x)) 2) env))
  ))

; begin
(myeval2 '(define a 5) env) 
(run-named-test
 "begin-test"
 (make-testcase 
  '(assert-equal? 14 (myeval2 '(begin (set! a 7) 
                                      (* a 2)) 
                              env))))

; Conditional: cond
(myeval2 '(define b 2) env) 
(run-named-test 
 "cond-test"
 (make-testcase 
  '(assert-equal? 2 (myeval2 'b env))
  '(assert-equal? 2 (myeval2 '(cond ((= b 1) 1)
                                    ((= b 2) 2)
                                    (else 0)) 
                             env))
  ))
