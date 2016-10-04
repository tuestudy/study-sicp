; 3.06

; 마구잡이수 만들개의 상태를 처음으로 되돌려 놓을 수 있다면, 정해진 수에서 시작되는 수열을 거듭
; 만들 수 있으므로 아주 쓸모가 많다. generate 나 reset 같은 말을 받아 아래처럼 돌아가는 프로시저
; rand 를 짜보아라.

; (rand 'generate) ; ==> 마구잡이 수를 내놓는다.
; ((rand 'reset) <new-value>) ; ==> 감춰 둔 상태변수 값을 new-value로 바꾼다.

; 이렇게 상태를 되돌릴 수 있으면, 똑같은 난수열을 여러 번 만들 수 있기 때문에, 난수열을 쓰는 프로그램을
; 시험하거나 고칠때 편하다.

(load "../misc/scheme-test.scm")




(define random-init 1)


; 295쪽 각주 6을 참조하여 만든 random-update
(define random-update (lambda (x) (remainder (+ (* 31 x) 23) 67)))

; solution
(define rand2
  (let ((x random-init))
    (lambda (m)
      (cond ((eq? m 'generate) (begin (set! x (random-update x)) x))
            ((eq? m 'reset) (lambda (nv) (set! x nv)))))))


; Test

(define random1 54)
(define random2 22)
(define random3 35)
(define random4 36)

(run
 (make-testcase
  '(assert-equal? random1 (rand2 'generate))
  '(assert-equal? random2 (rand2 'generate))
  '(assert-equal? random3 (rand2 'generate))
  '(assert-equal? random4 (rand2 'generate))
  '(assert-equal? (void) ((rand2 'reset) 1))
  '(assert-equal? random1 (rand2 'generate))
  '(assert-equal? random2 (rand2 'generate))
  '(assert-equal? random3 (rand2 'generate))
  '(assert-equal? random4 (rand2 'generate))))


