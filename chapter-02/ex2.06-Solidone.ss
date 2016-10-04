; I just get a hint from D-Gun's wiki.
; from url - http://deisys.upnl.org/wiki/doku.php?id=sicp:exercise_ch2.1

(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))

(define (inc x) (+ x 1))

;(add-1 zero)

(define one
  (lambda (f) (lambda (x) (f x))))

(define two
  (lambda (f) (lambda (x) (f (f x)))))

(define (add a b)
  (lambda (f) (lambda (x) ((a f) ((b f) x)))))

(define (tonum n)
  ((n (lambda (x) (+ x 1))) 0))


; test-case
(tonum zero)
(tonum (add-1 zero))
(tonum one)
(tonum two)
(tonum (add one two))
