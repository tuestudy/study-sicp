(load "ch4-myeval-pkg-gsong.scm")
(load "../misc/scheme-test-r5rs.scm")
(load "ex4.22-test-gsong.scm")

(define tge (setup-environment))

(display "[ex4.23 - Tests]\n")

; Alyssa's solution
;(define (analyze-sequence exps)
;  (define (execute-sequence procs env)
;    (cond ((null? (cdr procs)) ((car procs) env))
;          (else ((car procs) env)
;                (execute-sequence (cdr procs) env))))
;  (let ((procs (map analyze exps)))
;    (if (null? procs)
;        (error "Empty sequence -- ANALYZE"))
;    (lambda (env) (execute-sequence procs env))))

  
(run (make-testcase
      '(assert-equal? 11 (myeval '(begin (+ 1 2) (+ 3 4) (+ 5 6)) tge));
      ))
