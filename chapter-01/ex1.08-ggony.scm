; 연습문제 1.8
; 이상곤 2009.01.31
(define (cube-iter guess x)
  (if (good-enough?2 guess x)
      guess
      (cube-iter (improve guess x)
                 x)))
; 이것만 문제에서 제시한 수학공식을 함수로 바꾸면 된다.

;(define (improve guess x)
;  (average guess(/ x guess)))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* guess 2)) 3))

(define (average x y)
  (/ (+ x y) 2))

; good-enough?2 는 세제곱근에 가장가까운 값인지 유추하는 함수
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.00000001))

(define (good-enough?2 guess x)
  (< (abs (- (cube guess) x)) 0.001))

(define (square x)
  (* x x))

(define (cube x)
  (* x x x))

(define (sqrt x)
  (cube-iter 1.0 x))