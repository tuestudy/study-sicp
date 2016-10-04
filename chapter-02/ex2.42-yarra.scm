(load "../misc/accumulate.scm")


; 필요한 정의들.
(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (enumerate-interval start end)
  (if (= start end)
      (list end)
      (cons start (enumerate-interval (+ 1 start) end))))

; solutions
; safe? 의 명세를 잘못 읽어서 작동을 안했었는데,
; 다시 짜기 귀찮아서 그냥 조금 고쳐 썼습니다.
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

(define (safe? k poss)
  (define (safe2? k positions)
    (if (null? positions)
        #t
        (if (or (= k (car positions))
                (= k (- (car positions) (length positions)))
                (= k (+ (car positions) (length positions))))
            #f
            (safe2? k (cdr positions)))))
  (let ((reversed (reverse poss)))
    (safe2? (car reversed) (reverse (cdr reversed)))))


(define (adjoin-position new-row k rest-of-queens)
  (append rest-of-queens (list new-row)))



; test
(queens 8)