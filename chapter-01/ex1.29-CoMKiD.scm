(define (simpson-integral f a b n)
  (define (inc x) (+ x 1))
  (define (even? x) (= (remainder x 2) 0))  
  (define (h) 
    (if (even? n)
        (/ (- b a) n)
        (/ (- b a) (+ n 1))))
  (define (y k) (f (+ a (* k (h)))))
  (define (kth-term k)
    (cond ((or (= k 0) (= k n)) (y k) )
          ((even? k) (* 2 (y k)))
          (else (* 4 (y k)))))
  (* 
   (sum kth-term 0 inc n)
   (/ (h) 3.0)))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (cube x) (* x x x))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

; 
; Test
;
(integral cube 0 1 0.01)
(integral cube 0 1 0.001)
(integral cube 0 1 0.0001)
(integral cube 0 1 0.00001)

(simpson-integral cube 0 1 100)
(simpson-integral cube 0 1 1000)
(simpson-integral cube 0 1 10000)
