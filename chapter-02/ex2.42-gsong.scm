(load "../misc/scheme-test.scm")

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define nil '())
(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

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

(define empty-board '())

(define (safe? n position)
  (if (= n 1) #t
      (and (safe? (- n 1) (cdr position))
           (safe-check (car position) (cdr position)))))

(define (safe-check n prev_position)
  (and (safe-row n prev_position)
       (safe-up n prev_position)
       (safe-bottom n prev_position)))

(define (safe-diagonal n prev_position op)
  (define (safe-diagonal-iter position i)
    (cond ((null? position) #t)
          ((= (car position) (op n i)) #f)
          (else (safe-diagonal-iter (cdr position) (+ i 1)))))
  (safe-diagonal-iter prev_position 1))
(define (safe-up n prev_position)
  (safe-diagonal n prev_position (lambda (x y) (- x y))))
        
(define (safe-bottom n prev_position)
  (safe-diagonal n prev_position (lambda (x y) (+ x y))))
  
(define (safe-row n prev_position)
  (cond ((null? prev_position) #t)
        ((= n (car prev_position)) #f)
        (else (safe-row n (cdr prev_position)))))

(define (adjoin-position new-row k position)
  (if (= (- k 1) (length position))
      (cons new-row position)
      nil))
 
(run (make-testcase
      '(assert-equal? (accumulate * 1 (list 1 2 3 4 5)) 120)
      '(assert-equal? (flatmap (lambda (x) (list x)) (list 1 2 3 4 5)) '(1 2 3 4 5))
      '(assert-equal? (enumerate-interval 3 5) '(3 4 5))
      '(assert-equal? (safe-row 3 '(1 2)) #t)
      '(assert-equal? (safe-row 2 '(2)) #f)
      '(assert-equal? (safe-row 5 '(1 2 3 4)) #t)
      '(assert-equal? (safe-up 4 '(4 3 2 1)) #t)
      '(assert-equal? (safe-up 4 '(4 3 1)) #f)
      '(assert-equal? (safe-bottom 1 '(2 3 4)) #f)
      '(assert-equal? (safe-bottom 1 '(1 2 3)) #t)
      '(assert-equal? (safe-check 1 '()) #t)
      '(assert-equal? (safe-check 4 '(1 2 3 4)) #f)
      '(assert-equal? (safe? 1 empty-board) #t)
      '(assert-equal? (safe? 1 '(1)) #t)
      '(assert-equal? (safe? 1 '(1 1)) #t)
      '(assert-equal? (safe? 2 '(1 1)) #f)
      '(assert-equal? (safe? 8 '(6 4 1 5 8 2 7 3)) #t)
      '(assert-equal? (adjoin-position 3 5 '(1 2 3 4)) '(3 1 2 3 4))
      '(assert-equal? (adjoin-position 3 1 '()) '(3))
      ))