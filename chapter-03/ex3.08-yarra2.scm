

(define (test a b)
  (define f
    (let ((a 1))
      (lambda (x)
        (begin (set! a (* a x)) a))))
  (+ (f a) (f b)))

(test 0 1)
(test 1 0)
