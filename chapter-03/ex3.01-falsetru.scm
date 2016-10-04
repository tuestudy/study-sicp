(define (make-accumulator value)
  (lambda (delta)
    (begin (set! value (+ value delta))
           value)))
