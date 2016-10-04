(define (square x)
  (* x x))

(define (n-square x n)
  (define (iter x count result)
    (if (= count n)
        result
        (iter x (+ count 1) (* result x))))
  (iter x 0 1))
  
(define (natural-number pair)
  (let ((a (car pair))
    (b (cdr pair)))
    (* (n-square 2 a) (n-square 3 b))))

; test-case
(= 4 (square 2))
(= 8 (n-square 2 3))
(define pair (cons 2 3))
(= (* 2 2 3 3 3) (natural-number pair))