(define nil '())

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (map2 p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) nil sequence))

(define (append2 seq1 seq2)
  (accumulate cons seq2 seq1))

(define (length2 sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

(define t1 '(1 2 3 4 5))
(define t2 '(6 7 8 9 10))

(map2 (lambda (x) (* x x)) t1)
(append2 t1 t2)
(length2 t1)