; 2.33

; 아래는 accumulate 를 이용해서 리스트 기본 연산을 몇 개 정의하려는 것이다.
; 그 중 빈 곳을 채워 보아라.

(load "../misc/accumulate.scm")
(load "../misc/scheme-test.scm")

(define (map2 p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) '() sequence))

(define (append2 seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length2 sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

(run
 (make-testcase
  '(assert-equal? '(1 4 9 16 25) (map2 (lambda (x) (* x x)) (list 1 2 3 4 5)))
  '(assert-equal? '(1 2 3 4 5 6) (append2 (list 1 2 3) (list 4 5 6)))
  '(assert-equal? 6 (length (list 1 2 3 4 5 6)))))