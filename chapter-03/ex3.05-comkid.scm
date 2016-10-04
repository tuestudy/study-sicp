#lang scheme
(require scheme/base)
(random-seed (current-milliseconds))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))

(define (random-in-range low high)
  (+ low (* (random) (- high low))))

(define (estimate-integral pred x1 x2 y1 y2 trials)
  (* (monte-carlo 
      trials 
      (lambda () (pred (random-in-range x1 x2) (random-in-range y1 y2))))
     (* (- x2 x1) (- y2 y1))))

(define (square k) (* k k))

(define (in-circle? xc yc radius)
  (lambda (x y)
    (<= (+ (square (- xc x)) (square (- yc y))) (square radius))))

(define (estimate-pi trials)
  (estimate-integral (in-circle? 1 1 1)
                     0.0 2.0 0.0 2.0 
                     trials))

(estimate-pi 100)
(estimate-pi 1000)
(estimate-pi 10000)
(estimate-pi 100000)
(estimate-pi 1000000)
