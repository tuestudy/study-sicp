(define (pascal-triangle a b)
  (if(= b 0)
  1
  (if(= a b)
     1
     (+ (pascal-triangle (- a 1) (- b 1))
        (pascal-triangle (- a 1) b) )
     )
  ))

(define (p row col)
  (if (or (= col 1) (= col row))
      1
      (+ (p (- row 1) (- col 1))
         (p (- row 1) col))))