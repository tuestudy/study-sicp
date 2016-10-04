(define (make-f)
  (define first true)
  (define (f n)
    (if first
      (begin (set! first false)
             n)
      0))
  f)
