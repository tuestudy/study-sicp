(define (cube x) (* x x x))
(define (p x)
  (display "p ")
  (- (* 3 x) (* 4 (cube x))))
(define (sine angle)
  (if (not (> (abs angle) 0.1))
      angle
      (p (sine (/ angle 3.0)))))

(define (pow x n)
  (define (iter count result)
    (if (= count 0) 
        result
        (iter (- count 1) (* x result))))
  (iter n 1))

(sine 12.15)

(define (seq start end step)
  (define (iter cur result)
    (if (> cur end)
        result
        (iter (+ cur step) (append result (list cur)))))
  (iter start null))

(map (lambda (x) (sine (pow 3 x)) (newline)) (seq 0 10 1))
