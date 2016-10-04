(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-interval start end)
  (if (> start end)
      null
      (cons start (enumerate-interval (+ start 1) end))))

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

; answer
(define empty-board
  null)

(define (adjoin-position new-row k rest-of-queens)
  (accumulate cons rest-of-queens (list (list new-row k))))


(define (safe? k positions)
  (define (invalid? pos1 pos2)
    (or (equal? (car pos1) (car pos2))
        (equal? (cadr pos1) (cadr pos2))
        (equal? (abs (- (car pos1) (car pos2)))
                (abs (- (cadr pos1) (cadr pos2))))))
  (define a (car positions))
  (define b (cdr positions))
  (null? (filter
          (lambda (x) (invalid? a x))
          b)))

; problem
(define (queens board-size)
  (define (queen-cols k)
    (define safe (lambda (positions) (safe? k positions)))
    (if (= k 0)
        (list empty-board)
        (filter
         safe
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

;test-case
(equal? (list (list 3 2) (list 2 7) (list 1 3))
        (adjoin-position 3 2 (list (list 2 7) (list 1 3))))

(equal? (list (list (list 1 1)))
        (queens 1))
(equal? null
        (queens 2))
(equal? null
        (queens 3))
(define queens-4
  (list (list (list 3 4) (list 1 3) (list 4 2) (list 2 1)) (list (list 2 4) (list 4 3) (list 1 2) (list 3 1))))
(equal? queens-4
        (queens 4)) 
