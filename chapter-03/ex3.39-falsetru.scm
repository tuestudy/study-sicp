(require (planet dyoo/sicp-concurrency:1:2/sicp-concurrency))

(define (simul)
  (define x 10)
  (define s (make-serializer))
  (parallel-execute (lambda () (set! x ((s (lambda () (* x x))))))
                    (s (lambda () (set! x (+ x 1)))))
  (if (not (or (= x 101) (= x 121)))
      (begin (display x)
             (display " "))))

(define (loop n)
  (if (> n 0)
      (begin (simul)
             (loop (- n 1)))))

(loop 100000) ; 101, 121, 11, 100