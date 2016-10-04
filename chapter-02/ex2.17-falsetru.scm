(define (last-pair2 items)
  (if (null? (cdr items))
    items
    (last-pair2 (cdr items))))
