(define balance 100)
(define (Peter) (set! balance (+ balance 10)))
(define (Paul)  (set! balance (- balance 20)))
(define (Mary)  (set! balance (- balance (/ balance 2))))
