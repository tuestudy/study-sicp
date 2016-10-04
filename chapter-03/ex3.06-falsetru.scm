(define (rand m)
  (cond ((eq? m 'generate) (random))
        ((eq? m 'reset) random-seed)
        (else (error "Unknown message -- RAND" m))))
