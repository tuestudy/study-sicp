; 2.81

; Louis Reasoner 는 apply-generic 프로시저가 인자 타입이 서로 같은 경우에도,
; 한 인자 값을 다른 인자 타입으로 바꾸려 든다는 사실을 알게 되었다.
; 그런 까닭에, 한 데이터 타입을 같은 타입으로 바꾸는 프로시저도 타입 바꿈
; 표 속에 넣어주는게 옳다고 본다. 이에 따르면, 앞에서
; scheme-number->complex 타입 바꾸기 프로시저를 마련할 때, 아래 일도 같이 해야
; 한다.

(define (scheme-number->scheme-number n) n)
(define (complex->complex z) z)
(put-coercion 'scheme-number 'scheme-number
              scheme-number->scheme-number)
(put-coercion 'complex 'complex complex->complex)


; A.
; Louis 의 타입 바꾸기 프로시저를 집어넣은 다음, scheme-number 타입인
; 인자 두 개 또는 complex 타입을 가진 인자 두 개로 apply-generic 을
; 불러 쓰려 할 떄, 그런 타입에 맞는 연산을 표에서 찾지 못하면 어떤
; 일이 벌어지는가? 보기를 들어서, 아래와 같이 일반화된 거듭제곱 연산을
; 정의했다고 하자.

(define (exp x y) (apply-generic 'exp x y))

; 그런 다음, Scheme-number 꾸러미에만 거듭제곱 프로시저가 들어있고,
; 다른 꾸러미에는 없다고 하자.

; 두 복소수를 인자로 삼아 exp를 불러 쓰면 어떤 일이 벌어지는가?


; ==> 복소수 끼리의 제곱 연산이 정의되어 있지 않으므로
;     (변환할 필요가 없지만) 변환에 들어가게 되고,
;     변환 후에도 연산을 찾지 못해 변환만 하면서 무한루프에 빠진다.


;B.
; Louis 생각대로, 타입이 같은 인자를 타입을 변환하는 경우, 이에 대해 무언가를
; 하는 게 옳은가? 아니면 apply-generic 을 그대로 놔두는 게 맞는가?

; ==> 모든 연산이 모든 타입에 대해 정의되어 있다면 놔두어도 괜찮지만,
;     유지하기 힘든 조건이므로 apply-generic 을 고치는게 낫겠다.


;C.
; 두 인자가 같은 타입일 때 타입 바꾸기가 일어나지 않도록 apply-generic
; 을 고쳐라.

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (if (not (eq? type1 type2))
                    (let ((t1->t2 (get-coercion type1 type2))
                          (t2->t1 (get-coercion type2 type1)))
                      (cond (t1->t2
                             (apply-generic op (t1->t2 a1) a2))
                            (t2->t1
                             (apply-generic op a1 (t2->t1 a2)))
                            (else
                             (error "No method for these types"
                                    (list op type-tags)))))
                    (error "No method for these types"
                           (list op type-tags))))
              (error "No method for these types"
                     (list op type-tags)))))))
                          
                    
                    



