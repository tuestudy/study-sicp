(define (same-parity x . xs)
  (filter (if (odd? x) odd? even?) (cons x xs)))
