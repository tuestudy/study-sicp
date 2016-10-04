(load "../misc/scheme-test.scm")

;제곱과 3제곱
(define (cube x)
  (* x x x))

(define (square x)
  (* x x))

(define dx 0.00001)

;테스트를 하는 고정점
(define (fixed-point-test f)
  (define (good-enough? guess next)
    (< (abs (- next guess)) 0.000000001))
  (define (try guess count)
    (let ((next (f guess)))
      (if (good-enough? guess next)
         guess
         (and (display guess) (display "--") 
             (display next) (display "--") 
             (display count) (newline) 
             (try next (+ count 1))))))
  (try 1.0 1)) 

;n제곱
(define (^ a n)
  (define (iter a n result)
    (cond ((= n 0) result)
         ((even? n) (iter (square a) (/ n 2) result))
         (else (iter a (- n 1) (* result a)))))
  (iter a n 1))

;함수g의 미분
(define (deriv g)
  (λ(x)
    (/ (- (g (+ x dx)) (g x)) dx)))

;뉴튼메서드로 나타낸 식의 고정점
(define (newtons-method g)
  (fixed-point 
   (newton-transform g)))

;뉴튼메서드
(define (newton-transform g)
  (λ(x) (- x (/ (g x) ((deriv g) x)))))

;합성함수
(define (compose2 g f) (λ (x) (g (f x))))

;함수반복
(define (repeated f n)
  (if (= n 1)
     f
     (compose2 f (repeated f (- n 1)))))

;평균
(define (avg x y)
  (/ (+ x y) 2))

;평균내어 잦아들게 하기
(define (average-damp f)
  (λ(x) (avg (f x) x)))


;n제곱근 
(define (n-root x n)
  (fixed-point-test 
   ((repeated average-damp (floor (/ n 2))) (λ(y) (/ x (^ y (- n 1)))))))

;뉴튼메서드로 구한 n 제곱근
(define (n-root-new x n)
  (fixed-point-test 
   (newton-transform (λ(y) (- (^ y n) x)))))

;테스트코드
(run (make-testcase 
      '(assert-near? 
        11
        (n-root (^ 11 9) 9) 0.001)
      '(assert-near? 
        11
        (n-root (^ 11 10) 10) 0.001)
      '(assert-near? 
        11
        (n-root-new (^ 11 10) 10) 0.001)))

;1.46
(define (iterative-improve isGood? improve-guess)
  (λ(f)  
    (define (iter guess)
      (let ((next ((improve-guess f) guess)))
        (if (isGood? guess next)
           guess
           (iter next))))
    (iter 1.0)))


(define (sqrt-avg x)
  ((iterative-improve  (λ(guess next) (< (abs (- guess next)) 0.00001)) average-damp) (λ(y) (/ x y))))

(define (fixed-point-avg f)
  ((iterative-improve  (λ(guess next) (< (abs (- guess next)) 0.00001)) average-damp) f))

(sqrt-avg 9)
(fixed-point-avg cos)



