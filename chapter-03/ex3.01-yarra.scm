(load "../misc/scheme-test.scm")

; 3.1

; Accumulator 란 여러 수를 차례대로 이어 받아서 합을 내는 프로시저인데, 이 프로시저를
; 돌리면 그때까지 받은 인자 값을 모두 더한 값이 나온다고 하자.
; 새 accumulator 를 직어내는 프로시저 make-accumulator 를 정의하라.
; 단, accumulator 마다 더한 값을 따로 들게 해야 한다. make-accumulator 는 인자로 첫값을
; 받는다. 아래는 그 사례다.

;(define A (make-accumulator 5))

;(A 10) ==> 15
;(A 10) ==> 25


; solution
(define (make-accumulator initval)
  (define (sum num) 
    (begin (set! initval (+ initval num)) initval))
  sum)


; test

(define A (make-accumulator 5))

(run
 (make-testcase
  '(assert-equal? 15 (A 10))
  '(assert-equal? 25 (A 10))))