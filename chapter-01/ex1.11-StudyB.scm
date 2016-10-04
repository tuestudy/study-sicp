(define (f n)
  (if (< n 3)
      n
      (+ (f (- n 1)) 
         (* 2 (f (- n 2))) 
         (* 3 (f (- n 3))))))

(define (f-iter n)
  (define (iter i a b c)
    (if (= i n)
        a
        (iter (+ i 1)
              (+ a (* 2 b) (* 3 c))
              a
              b)))
  (if (< n 3)
      n
      (iter 2 2 1 0)))

(= (f 4) (+ (f 3) (* 2 (f 2)) (* 3 (f 1))))

(= (f 4) (f-iter 4))

(map (lambda (x) (= (f x) (f-iter x))) (list 1 2 3 4 5 6 7 8 9))

(map f (list 1 2 3 4 5 6 7 8 9))
(map f-iter (list 1 2 3 4 5 6 7 8 9))
