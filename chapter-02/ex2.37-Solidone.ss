(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

(define m (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9)))
(define m2 (list (list 1 5 9) (list 2 6 10) (list 3 7 11) (list 4 8 12)))

(define v (car m))
(define w (cadr m))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

; solving part
(define (matrix-*-vector m v)
  (map (lambda (x) (accumulate + 0 (map * v x))) m))

; <??> : (lambda (x) (accumulate + 0 (map * v x)))

(define (transpose mat)
  (accumulate-n cons null mat))

; <??> : cons , <??> : null (nil or '())

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (x) 
           (accumulate cons null (matrix-*-vector cols x))) m)))
; <??> : (lambda (x) (accumulate cons null (matrix-*-vector cols x)))

; test-case
(= (+ 4 10 18 24) (dot-product v w))

(equal? (list (+ (* 1 1) (* 2 2) (* 3 3) (* 4 4))
              (+ (* 4 1) (* 5 2) (* 6 3) (* 6 4))
              (+ (* 6 1) (* 7 2) (* 8 3) (* 9 4)))
        (matrix-*-vector m v))

(equal? (list (list 1 4 6) (list 2 5 7) (list 3 6 8) (list 4 6 9))
        (transpose m))

(define after-*-matrix
  (list
   (list (+ (* 1 1) (* 2 2) (* 3 3) (* 4 4)) (+ (* 1 5) (* 2 6) (* 3 7) (* 4 8)) (+ (* 1 9) (* 2 10) (* 3 11) (* 4 12)))
   (list (+ (* 4 1) (* 5 2) (* 6 3) (* 6 4)) (+ (* 4 5) (* 5 6) (* 6 7) (* 6 8)) (+ (* 4 9) (* 5 10) (* 6 11) (* 6 12)))
   (list (+ (* 6 1) (* 7 2) (* 8 3) (* 9 4)) (+ (* 6 5) (* 7 6) (* 8 7) (* 9 8)) (+ (* 6 9) (* 7 10) (* 8 11) (* 9 12)))
   ))

(equal?
 after-*-matrix
 (matrix-*-matrix m m2))
