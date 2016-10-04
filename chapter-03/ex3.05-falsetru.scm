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
  (let ((range (- high low)))
    (+ low (random range))))


(define (estimate-integral P x1 x2 y1 y2 trials)
  (define r (/ (- x2 x1) 2))
  (define xc (+ x1 r))
  (define yc (+ y1 r))
  (define (call-p)
    (P (random-in-range x1 x2)
       (random-in-range y1 y2)
       xc
       yc
       r))
  (* (monte-carlo trials call-p)
     (- x2 x1)
     (- y2 y1)))

(define (square x) (* x x))
(define (P x y xc yc r)
  (<=
   (+ (square (- x xc))
      (square (- y yc)))
   (square r)))
