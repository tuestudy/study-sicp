(load "../misc/scheme-test-r5rs.scm")

;(define env5 (scheme-report-environment 5))
(define the-global-environment (setup-environment))

; self-evaluation
(display "self-evaluating-test: ") 
(run (make-testcase
      '(assert-equal? 1 (myeval '1 the-global-environment))
      '(assert-equal? "hello" (myeval '"hello" the-global-environment))))

; variable
(define-variable! 'x 123 the-global-environment)
(display "variable-test:        ") 
(run (make-testcase
      '(assert-equal? 123 (myeval 'x the-global-environment))))

; quotation
(display "quotation-test:       ") 
(run (make-testcase 
      '(assert-equal? 'test (myeval '(quote test) the-global-environment))))

; assignment
(display "assignment-test:      ") 
(myeval '(set! x 333) the-global-environment)
(run (make-testcase 
      '(assert-equal? 333 (myeval 'x the-global-environment))))

; definition
(display "definition-test:      ") 
(myeval '(define y -2) the-global-environment)
;(myeval '(define z (* 2 7)) the-global-environment)
(run (make-testcase 
      '(assert-equal? -2 (myeval 'y the-global-environment))
      ;'(assert-equal? 14 (myeval 'z the-global-environment))
      ))

; Conditional: if
(display "if-test:              ") 
(run (make-testcase 
      '(assert-equal? 0 (myeval '(if true 0 1) the-global-environment))))

; Application
(display "application-test:     ") 
(run (make-testcase 
      '(assert-equal? 22 (myeval '(* 11 2) the-global-environment))
      '(assert-equal? 17 (myeval '(+ 12 5) the-global-environment))
      '(assert-equal? -7 (myeval '(- 3 10) the-global-environment))
      '(assert-equal? 10 (myeval '(/ 30 3) the-global-environment))
      ))

; lambda 
(display "lambda-test:          ")
(myeval '(define cube (lambda (x) (* x x x))) the-global-environment) 
(run (make-testcase 
      '(assert-equal? 4 (myeval '((lambda (x) (* x x)) 2) the-global-environment))
      '(assert-equal? 8 (myeval '((lambda (x) (cube x)) 2) the-global-environment))
      ))

; begin
(display "begin-test:           ")
(myeval '(define a 5) the-global-environment) 
(run (make-testcase 
      '(assert-equal? 14 (myeval 
                          '(begin (set! a 7) (* a 2)) 
                          the-global-environment))))

; Conditional: cond
(display "cond-test:            ")
(myeval '(define b 2) the-global-environment) 
(run (make-testcase 
      '(assert-equal? 2 (myeval 'b the-global-environment))
      '(assert-equal? 2 (myeval '(cond ((= b 1) 1)
                                       ((= b 2) 2)
                                       (else 0)) 
                                the-global-environment))
      ))


