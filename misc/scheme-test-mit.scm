(load "../misc/scheme-test-r5rs.scm");

(define (evaluate exp)
  (eval exp user-initial-environment)) ; modified to work in mit-scheme terminal mode... branched by d-goon T_T

(define _result-log result-log)
(define (result-log result)
  (newline)
  (_result-log result)) ; add newline ... 

(define (run test)
  (result-log (run-one-step test 0 0 0))
  #t)
