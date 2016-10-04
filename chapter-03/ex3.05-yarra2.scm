#lang scheme
(random-seed (current-milliseconds))

(define (square x) (* x x))
(define (random-in-range low high)
  (+ low (* (random) (- high low))))

(define (estimate-integrals p x1 x2 y1 y2 trials)
  (define (experiment)
    (let ((x (random-in-range x1 x2))
          (y (random-in-range y1 y2)))
      (p x y)))
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (* (/ trials-passed trials)
              (* (- x2 x1) (- y2 y1))))
          ((experiment)
           (iter (- trials-remaining 1)
                 (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1)
                 trials-passed))))
  (iter trials 0))

(/ (estimate-integrals (lambda (x y)
                         (<= (+ (square (- x 5))
                                (square (- y 7)))
                             (square 3)))
                       2
                       8
                       4
                       10
                       10000)
   9.0)



