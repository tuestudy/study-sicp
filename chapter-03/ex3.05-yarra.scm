; 3.05

; 몬테카를로 적분은 몬테카를로 시뮬레이션을 써서 정적분 값을 어림잡는 방법.
; 몬테카를로 적분을 수행하는 estimate-integral 이라는 프로시저를 작성하라.

(load "../misc/scheme-test.scm")

; monte-carlo
(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))


; estimate-integral
(define (estimate-integral pred x1 x2 y1 y2 trials)
  (define (random-in-range low high)
    (let ((range (- high low)))
      (+ low (* (random) range))))
  (* (* (- x2 x1) (- y2 y1))
     (monte-carlo trials (lambda () (pred (random-in-range x1 x2) 
                                          (random-in-range y1 y2)))) 
     1.0))


; predicate
(define (in-the-circle? x y)
  (define square (lambda (x) (* x x)))
  (<= (+ (square (- x 5)) (square (- y 7))) (square 3)))


; TEST

(run
 (make-testcase
  '(assert-near? (* 9 pi) (estimate-integral in-the-circle? 2 8 4 10 100000) 0.1)))




