(define squares (list 1 4 9 16 26))
(define odds (list 1 3 5 7))

(define (last-pair items)
  (if (= 1 (length items))
      (car items)
      (last-pair (cdr items))))

(= 26 (last-pair squares))
(= 7 (last-pair odds))

