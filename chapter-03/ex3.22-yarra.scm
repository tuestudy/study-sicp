(define (make-queue)
  (let ((frnt-ptr '())
        (rear-ptr '()))
    (define (set-frnt-ptr! item) (set! frnt-ptr item))
    (define (set-rear-ptr! item) (set! rear-ptr item))
    (define (empty-queue?) (and (null? frnt-ptr) (null? rear-ptr)))
    (define (frnt-queue) (if (empty-queue?)
                             (error "Empty queue has no element")
                             (car frnt-ptr)))
    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
        (cond ((empty-queue?)
               (begin
                 (set-frnt-ptr! new-pair)
                 (set-rear-ptr! new-pair)
                 (print-queue)))
              (else
               (begin
                 (set-cdr! rear-ptr new-pair)
                 (set-rear-ptr! new-pair)
                 (print-queue))))))
    (define (delete-queue!)
      (cond ((empty-queue?)
             (error "DELETE! called with an empty queue"))
            (else
             (begin
               (set-frnt-ptr! (cdr frnt-ptr))
               (print-queue)))))
    (define (print-queue)
      frnt-ptr)
    (define (dispatch m)
      (cond ((eq? m 'delete) delete-queue!)
            ((eq? m 'insert) insert-queue!)
            ((eq? m 'print) print-queue)
            ((eq? m 'front) frnt-queue)))
  dispatch))

(define qqq (make-queue))
((qqq 'insert) 4)
((qqq 'insert) 5)
((qqq 'front))
((qqq 'delete))
((qqq 'delete))