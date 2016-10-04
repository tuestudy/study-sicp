(load "ch4-myeval-pkg-gsong.scm")
(load "../misc/scheme-test-r5rs.scm")
(load "ex4.23-test-gsong.scm")
(load "ex4.27-gsong.scm")

(define tge (setup-environment))

(display "[ex4.27 - Tests]\n")


(define input-prompt ";;; L-Eval input:")
(define output-prompt ";;; L-Eval value:")
(define (driver-loop)
  (prompt-for-input input-prompt)
  (let ((input (read)))
    (let ((output
           (actual-value input tge)))
      (announce-output output-prompt)
      (user-print output)))
  (driver-loop))


;(driver-loop)
;(actual-value '(define (try a b) (if (= a 0) 1 b)) tge)
; ERROR !!!!!
;(actual-value '(try 0 (/ 1 0)) tge)


;(actual-value '(define count 0) tge)
;(actual-value '(define (id x) (set! count (+ count 1)) x) tge)
;(actual-value '(define w (id (id 10))) tge)
;(actual-value 'count tge)
;(actual-value 'w tge)
;(actual-value 'count tge)

(run (make-testcase
      '(assert-equal? 'ok (actual-value '(define (try a b) (if (= a 0) 1 b)) tge))
      '(assert-equal? 1 (actual-value '(try 0 (/ 1 0)) tge))
      '(assert-equal? 'ok (actual-value '(define count 0) tge))
      '(assert-equal? 'ok (actual-value '(define (id x) (set! count (+ count 1)) x) tge))
      '(assert-equal? 'ok (actual-value '(define w (id (id 10))) tge))
      '(assert-equal? 1 (actual-value 'count tge))
      '(assert-equal? 10 (actual-value 'w tge))
      '(assert-equal? 2 (actual-value 'count tge))
      '(assert-equal? 10 (actual-value 'w tge))
      '(assert-equal? 2 (actual-value 'count tge))
      ))

