(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))


(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b) dx))

(define (cube x) (* x x x))


(define (integral2 f a b)
  (define h (/ (- b a) 1000.0))
  (* (/ h 3.0)
     (+ (sum (lambda (x) (* 2.0 (f x))) a (lambda (x) (+ (* 2.0 h) x)) b)
        (sum (lambda (x) (* 4.0 (f x))) (+ a h) (lambda (x) (+ (* 2.0 h) x)) b)
        (* -1 (f a))
        (* -1 (f (+ a (* 1000.0 h)))))))

(integral2 cube 0 1)
(integral cube 0 1 0.01)