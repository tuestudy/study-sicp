(define (factorial n)
  (unless (= n 1)
    (* n (factorial (- n 1)))
    1))

(define (unless condition usual-value exceptional-value)
  (if condition exceptional-value usual-value))

; Infinite loop!!
;(factorial 3)
;
;(unless (= 3 1) (* 3 (factorial (- 3 1))) 1)
;(unless #f (* 3 (factorial 2)) 1)
;(unless #f (* 3 (unless (= 2 1) (* 2 (factorial (- 2 1))) 1)))
;(unless #f (* 3 (unless #f (* 2 (factorial 1)) 1)))
;(unless #f (* 3 (unless #f (* 2 (unles (= 1 1) (* 1 (factorial (- 1 1))) 1)) 1)) 1)
