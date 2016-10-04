(load "../misc/scheme-test.scm")

; 3.07

; 연습문제 3.3에서 설명한 대로, 계정에 암호거는 기능을 보탠 다음,
; 프로시저 make-account 로 은행 계정을 몇 개 만들었다고 하자.
; 은행 시스템에 여럿이 함께 쓸 계정을 만드는 기능이 필요하다 치고,
; 그런 일을 하는 make-joint 를 정의하라.
; 이 프로시저는 인자를 3개 받는다. 첫 인자는 암호가 걸린 계정으로,
; 이것이 함께 쓸 계정이다. 다음 인자는 계정을 함께 쓸 사람이 알아
; 두어야 할 암호인데, 이 것이 계정에 걸린 암호와 같을 떄에만 연산이
; 말을 듣는다. 마지막 인자로 새 암호를 받는데, 프로시저 make-joint는
; 새 암호로도 계정을 함께 쓸 수 있도록 한다. 예컨대, peter-acc 계정에
; open-sesame라는 암호가 걸려 있다면, 다음처럼 하여 함꼐 쓸 계정을
; 만들 수 있다.

;(define paul-acc
;  (make-joint peter-acc 'open-sesame 'rose-bud))

; 이렇게 하면 paul-acc라는 이름과 암호 rosebud를 쓰더라도, peter-acc
; 계정에서 은행 거래를 할 수 있다. 연습문제 3.3의 답을 고쳐서
; 이런 기능을 보태봐도 좋다.



; make-account
(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (err amount)
    "Incorrect password\n")
  (define (dispatch pwd m)
    (if (not (eq? pwd password))
        err
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request -- MAKE-ACCOUNT"
                           m)))))
  dispatch)


; solution
(define (make-joint account newpw oldpw)
  (define (withdraw amount)
    ((account oldpw 'withdraw) amount))
  (define (deposit amount)
    ((account oldpw 'deposit) amount))
  (define (err amount)
    "Incorrect password\n")
  (define (dispatch pwd m)
    (if (not (eq? pwd newpw))
        err
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request -- MAKE-JOINT"
                           m)))))
  dispatch)


; test
(define acc_org (make-account 100 '5656))                ; original account
(define acc_join (make-joint acc_org '5657 '5656))       ; joined account

(run
 (make-testcase
  '(assert-equal? 60 ((acc_org '5656 'withdraw) 40))
  '(assert-equal? 40 ((acc_org '5656 'withdraw) 20))
  '(assert-equal? "Incorrect password\n" ((acc_join '5658 'withdraw) 10))
  '(assert-equal? 60 ((acc_join '5657 'deposit) 20))
  '(assert-equal? 30 ((acc_org '5656 'withdraw) 30))))