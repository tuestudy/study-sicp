(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

; solve
(define (make-rat n d)
  (let ((g (gcd n d)))
    (cond ((< d 0) (cons (/ (* -1 n) g) (/ (* -1 d) g)))
          ((>= d 0) (cons (/ n g) (/ d g))))))
(print-rat (make-rat 1 -2))
(print-rat (make-rat 1 -3))
(print-rat (make-rat -1 -3))
(print-rat (make-rat 0 -3))
