(load "../misc/scheme-test.scm")
(load "ex2.40-dgoon.scm")

(define true #t)
(define false #f)

(define (queens board-size)
  (define (queen-cols k)  
    (if (= k 0)
      (list empty-board)
      (filter
        (lambda (positions) (safe? k positions))
        (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define (safe? k positions)
  (if (=
        (let ((cur (car positions))
              (sofar (cdr positions)))
          (reduce + 0 (map
                        (lambda (x)
                          (if (or (= (car cur) (car x))
                                  (= (cadr cur) (cadr x))
                                  (= (abs (- (car cur) (car x)))
                                     (abs (- (cadr cur) (cadr x)))))
                            1 
                            0))
                        sofar)))
        0)
    true
    false))

(define (adjoin-position row col rest-of-queens)
  (cons (list row col) rest-of-queens))

(define empty-board '())

(queens 0)
(queens 1)
(queens 2)
(queens 3)
(queens 4)
(queens 5)
(queens 6)
