(load "../misc/scheme-test.scm")

; 3.08

; 앞서 1.1.3 절에서 계산 방식을 정할 떄, 전체 식을 계산하려면 먼저 그 부분식부터 계산하기로
; 했다. 하지만 부분 식이 여럿일 때, 어떤 차례로 계산해야 하는지 따로 밝힌 적은 없다.
; 변수 값을 바꿀 수 있으면, 프로시저 인자를 어떤 차례로 계산하느냐에 따라 프로시저 값이 달라
; 질 수 있다. (+ (f 0) (f 1)) 식을 계산 할 때, +의 인자를 왼쪽에서 오른쪽으로 계산하면 0, 
; 거꾸로 계산하면 1이 나오게끔 프로시저 f 를 정의해 보라.


; solution
(define (make-fct init)
  (let ((num init))
    (define (setset input)
      (if (not (= 0 num))
          (begin (set! num input) num)
          (begin num)))
    setset))
; 인자로 0이 들어오면 0 을 값으로 갖고 이후 어떤 입력이 들어와도 값은 0
; 인자에 0이 들어온 적이 없고 0 이외의 인자가 들어오면 해당 인자를 값으로.


; test
(define f (make-fct 1))  ; 테스트 도중에 상태가 바뀌기 때문에 
(define g (make-fct 1))  ; 같은 물체를 이름만 다르게 두개 만듬.

(run
 (make-testcase
  '(assert-equal? 0 (+ (f 0) (f 1)))
  '(assert-equal? 1 (+ (g 1) (g 0)))))





