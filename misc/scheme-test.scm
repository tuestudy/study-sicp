;
; Unit Test Framework for PLT Scheme
;
;  -- by comkid (icomkid at gmail dot com)
;

; structures & constants
;
(define make-testcase list)

(define (make-test-report pass fail error) (list pass fail error))
(define (pass-count result) (car result))
(define (fail-count result) (cadr result))
(define (error-count result) (cadr (cdr result)))

(define (make-test-result result expected)
  (cons result expected))

; result codes
(define result-pass 1)
(define result-fail 2)
(define result-error 3)

; assert procedures
;
(define (assert-true? exp) 
  (make-test-result (equal? exp #t) "true"))

(define (assert-false? exp) 
  (make-test-result (equal? exp #f) "false"))

(define (assert-equal? exp1 exp2) 
  (make-test-result (equal? exp1 exp2) (list exp1 exp2)))

(define (assert-near? exp1 exp2 tolerance)
  (make-test-result 
   (< (abs (- exp1 exp2)) (abs tolerance))
   (list exp1 exp2)))

(define (assert-exp? test)
  (define assert-exp-list
    (list
     'assert-true?
     'assert-false?
     'assert-equal?
     'assert-near?))
  (define (find-proc proc-name proc-list)
    (cond ((null? proc-list) #f)
          ((equal? proc-name (car proc-list)) #t)
          (else
           (find-proc proc-name (cdr proc-list)))))
  (find-proc (car test) assert-exp-list))

; log procedure
;
(define (fail-log test expected)
  (cond
    ((pair? expected)
     (display "FAILED : ")
     (display test)
     (display " : ")
     (display (car expected)) 
     (display " is not ")
     (display (cadr expected))
     (display ".\n"))
    (else
     (display "FAILED : ")
     (display test)
     (display " is expceted to be ")
     (display expected)
     (display ".\n"))))

(define (error-log-unknow-proc proc-name)
  (display "ERROR : \"")
  (display proc-name)
  (display "\" is an unknown assert procedure.")
  (newline))

(define (result-log result)
  (display "**** Test finished")
  (display " (Pass  : ") (display (pass-count result))
  (display ", Fail  : ") (display (fail-count result))
  (display ", Error : ") (display (error-count result))
  (display ")\n"))

; test evaluations
;
(define (eval-test test)
  (cond 
    ((equal? (assert-exp? test) #f)
     (error-log-unknow-proc (car test))
     result-error)
    ((equal? (car (eval test)) #t)
     result-pass)
    (else
     (fail-log test (cdr (eval test)))
     result-fail)))

(define (run-one-step testset pass fail error)
  (define (inc x) (+ x 1))
  (cond ((null? testset) (make-test-report pass fail error))
        (else
         (let ((result (eval-test (car testset))))
           (cond 
             ((= result result-pass)
              (run-one-step (cdr testset) (inc pass) fail error))
             ((= result result-fail)
              (run-one-step (cdr testset) pass (inc fail) error))
             ((= result result-error)
              (run-one-step (cdr testset) pass fail (inc error)))
             (else
              (run-one-step (cdr testset) pass fail error)))))))

(define (run test)
  (result-log (run-one-step test 0 0 0)))
