(define (make-monitored f)
  (define call-count 0)
  (define (mf n)
    (cond ((eq? n 'how-many-calls?) call-count)
          ((eq? n 'reset-count) (set! call-count 0))
          (else (set! call-count (+ call-count 1))
                (f n))))
  mf)
