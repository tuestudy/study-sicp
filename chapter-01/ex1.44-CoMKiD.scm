(define (compose f g) (lambda (x) (f (g x))))

(define (repeated-iter f n)
  (define (iter result n)
    (if (= n 1) 
        result
        (iter (compose f result) (- n 1))))
  (iter f n))

(define (smooth f)
  (define dx 0.001)
  (lambda (x) (/ 
               (+ (f (- x dx)) 
                  (f x) 
                  (f (+ x dx))) 
               3.0)))

(define (smooth-n-times n f)
  ((repeated-iter smooth n) f))