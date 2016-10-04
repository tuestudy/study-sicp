(load "../misc/scheme-test.scm")

; 3.2

; 소프트웨어를 시험할 떄, 전체 계산 과정에서 어떤 프로시저를 몇 번 썼는지 알아내는 기능이 있으면
; 아주 쓸모가 많다. 인자가 하나인 프로시저 f 가 있다고 할 때, 다시 이 f를 인자로 받는 make-monitored
; 라는 프로시저를 만들어 보자. make-monitored 를 계산한 결과 또 다른 프로시저 mf 가 나오는데, mf 속에
; 는 자기가 불린 횟수를 스스로 헤아리는 변수가 들어 있다. mf 프로시저에 how-many-calls? 라는 말을 건네면
; 그때까지 불린 횟수가 나오고, reset-count 라는 말을 건네면 불린 횟수가 0이 된다. 그밖에 딴 값이
; 들어오면 mf는 그 값을 f에 건네주고 계산한 결과 값을 내놓는다. 이때 불린 횟수를 하나 올린다. 이를테면
; sqrt 프로시저가 몇번 불렸는지 알아보려면 다음처럼 한다.


; solution

(define (make-monitored fct)
  (define kaisu 0)
  (define (calc arg1)
    (begin (set! kaisu (+ kaisu 1)) (fct arg1)))
  (define reset (lambda () (begin (set! kaisu 0))))
  (define (dispatch m)
    (cond ((eq? m 'how-many-calls?) kaisu)
          ((eq? m 'reset-count) (reset))
          ((not (symbol? m)) (calc m))))
  dispatch)


; test
(define s (make-monitored sqrt))

(run
 (make-testcase
  '(assert-equal? 10 (s 100))
  '(assert-equal? 1 (s 'how-many-calls?))
  '(assert-equal? (void) (s 'reset-count))
  '(assert-equal? 0 (s 'how-many-calls?))
  '(assert-equal? 10 (s 100))
  '(assert-equal? 10 (s 100))
  '(assert-equal? 2 (s 'how-many-calls?))))