;-) 한글버전
(define (세수중큰두숫자의제곱의합 a b c)
  (cond ((= (세수중젤작은숫자 a b c) a) (두숫자의제곱의합 b c))
        ((= (세수중젤작은숫자 a b c) b) (두숫자의제곱의합 a c))
        ((= (세수중젤작은숫자 a b c) c) (두숫자의제곱의합 a b))))


(define (두숫자의제곱의합 x y)
  (+ (제곱 x)(제곱 y)))

(define (세수중젤작은숫자 a b c)
  (더작은숫자(더작은숫자 a b)c))

(define (더작은숫자 a b)
  (if (< a b)
      a
      b))
(define (제곱 x) (* x x))