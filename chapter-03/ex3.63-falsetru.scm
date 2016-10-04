#lang racket

(require "stream-base-falsetru.scm")

(define (square x) (* x x))

(define (average a b)
  (/ (+ a b) 2))

(define call-count 0)
(define (inc-call-count!) (set! call-count (+ call-count 1)))
(define (reset-call-count!) (set! call-count 0))

(define (sqrt-improve guess x)
  (inc-call-count!)
  (average guess (/ x guess)))

(define (sqrt-stream x)
  (define guesses
    (cons-stream 1.0
                 (stream-map (lambda (guess)
                               (sqrt-improve guess x))
                             guesses)))
  guesses)


(define (sqrt-stream-reasoner x)
  (cons-stream 1.0
               (stream-map (lambda (guess)
                             (sqrt-improve guess x))
                           (sqrt-stream-reasoner x))))

(reset-call-count!)
(void (stream-take (sqrt-stream 2) 10))
(display call-count) (newline)

(reset-call-count!)
(void (stream-take (sqrt-stream-reasoner 2) 10))
(display call-count) (newline)

; memoized delay 사용했을때 sqrt-improve 호출횟수
; sqrt-stream: 10
; sqrt-stream-reasoner: 55

; non-memoized delay 사용했을때 sqrt-improve 호출횟수
; sqrt-stream: 55
; sqrt-stream-reasoner: 55

; => sqrt-stream-reasoner 은 memo-proc를 통한
;    memoization이 안먹히게 재귀호출함. 덜 효과적.
