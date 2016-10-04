(define (inc x) (+ x 1))
(define (dec x) (- x 1))
(define (square x) (* x x))

(define (compose f g)
  (lambda (x) (f (g x))))

; solve
(define (repeated f i)
  (if (= i 1)
      f
      (compose f (repeated f (dec i)))))

(define (repeated-iter f i)
  (define (iter result counter)
    (if (= counter 1)
        result    
        (iter (compose f result) (dec counter))))
  (iter f i))

; value
((repeated square 2) 5)
((repeated square 3) 5)

((repeated-iter square 2) 5)
((repeated-iter square 3) 5)
