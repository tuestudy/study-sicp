(require (planet dyoo/sicp-concurrency:1:2/sicp-concurrency))

(define (f1)
  (define x 10)
  (parallel-execute (lambda () (set! x (* x x)))
                    (lambda () (set! x (* x x x))))
  x)

(define (f2)
  (define x 10)
  (define s (make-serializer))
  (parallel-execute (s (lambda () (set! x (* x x))))
                    (s (lambda () (set! x (* x x x)))))
  x)

(define (simulate f n)
  (define result '())
  (define (loop n)
    (if (> n 0)
        (let ((x (f)))
          (begin
            (if (not (memq x result))
                (set! result (cons x result)))
            (loop (- n 1))))))
  (loop n)
  result)

(sort (simulate f1 10000) <) ; (100 1000 10000 100000 1000000)
(sort (simulate f2 10000) <) ; (1000000)