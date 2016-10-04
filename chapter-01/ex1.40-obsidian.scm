(load "../misc/scheme-test.scm")

;제곱과 3제곱
(define (cube x)
  (* x x x))

(define (square x)
  (* x x))

(define dx 0.00001)

;고정점찾기
(define (fixed-point f)
  (define (good-enough? guess next)
    (< (abs (- next guess)) 0.000000001))
  (define (try guess)
    (let ((next (f guess)))
      (if (good-enough? guess next)
         guess
         (try (f guess)))))
  (try 1.0)) 

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

(define (cubic a b c)
  (λ(x) (+ (cube x) (* a (square x)) (* b x) c)))

;아나..3방..
(define (3bang a b c)
  (newtons-method (cubic a b c)))

;테스트코드 
(run (make-testcase 
      '(assert-near? 
        0
        ((cubic 1 2 3) (3bang 1 2 3)) 0.001)
      
      '(assert-near? 
        0
        ((cubic 2 3 4) (3bang 2 3 4)) 0.001)
      
      '(assert-near? 
        0
        ((cubic 44 23 33) (3bang 44 23 33)) 0.001)))

