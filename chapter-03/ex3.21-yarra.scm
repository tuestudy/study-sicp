; 3.21

; queue 물체를 올바르게 화면에 나타낼 수 있는 print-queue 프로시저를 정의하라.


; queue 의 정의.
(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))

(define (empty-queue? queue) (null? (front-ptr queue)))

(define (make-queue) (cons '() '()))

(define (front-queue queue)
  (if (empty-queue? queue)
      (error "FRONT called with an empty queue" queue)
      (car (front-ptr queue))))

(define (insert-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
           (set-front-ptr! queue new-pair)
           (set-rear-ptr! queue new-pair)
           queue)
          (else
           (set-cdr! (rear-ptr queue) new-pair)
           (set-rear-ptr! queue new-pair)
           queue))))

(define (delete-queue! queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with an empty queue" queue))
        (else
         (set-front-ptr! queue (cdr (front-ptr queue)))
         queue)))


; solution
(define (print-queue queue)
  (car queue))


; test
(define q1 (make-queue))

(begin (insert-queue! q1 'a) (print-queue q1)) ; a 삽입.
(begin (insert-queue! q1 'b) (print-queue q1)) ; b 삽입.
(begin (insert-queue! q1 'c) (print-queue q1)) ; c 삽입.
(begin (delete-queue! q1) (print-queue q1))    ; 삭제.
(begin (delete-queue! q1) (print-queue q1))    ; 삭제.