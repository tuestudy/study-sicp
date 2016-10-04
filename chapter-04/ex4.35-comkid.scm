; Example 4.32 - comkid
;
; 아직 amb를 정의하지 않아 실행되지는않음

(define (an-integer-starting-from n)
  (amb n (an-integer-starting-from (+ n 1))))

(define (an-integer-between low high)
  (let ((a (an-integer-starting-from low)))
    (require (and (< low a) (< a high)))
    a))