(load "../misc/scheme-test.scm")

; accumulate
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))
; ex2.33
;
(define (map! p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) null sequence))

(define (append! seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length! sequence)
  (accumulate (lambda (x y) (+ y 1)) 0 sequence))

(run (make-testcase
      '(assert-equal? 55 (accumulate + 0 '(1 2 3 4 5 6 7 8 9 10)))
      '(assert-equal? '(1 4 9) (map! (lambda (x) (* x x)) '(1 2 3)))
      '(assert-equal? '(1 2 3 4 5) (append! '(1 2 3) '(4 5)))
      '(assert-equal? 5 (length! '(1 2 3 4 5)))
      ))