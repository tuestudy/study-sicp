(define (flatmap proc seq)
  (foldr append null (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
    null
    (cons low (enumerate-interval (+ low 1) high))))

(define empty-board null)
(define (adjoin-position new-row k rest-of-queens)
  (cons new-row rest-of-queens))
(define (safe-move? k positions delta)
  (cond ((null? positions) true)
        ((= k (car positions)) false)
        (else (safe-move? (+ k delta) (cdr positions) delta))))
(define (safe? positions)
  (let ((ret
          (and (safe-move? (+ (car positions) -1) (cdr positions) -1)
               (safe-move? (+ (car positions)  0) (cdr positions)  0)
               (safe-move? (+ (car positions) +1) (cdr positions) +1))))
    ret))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
      (list empty-board)
      (filter
        safe?
        (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))
