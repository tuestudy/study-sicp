(namespace-require 'r5rs)

(define (make-node x prev next) (cons x (cons prev next)))
(define (node-data n) (car n))
(define (node-link n) (cdr n))
(define (prev-node n) (car (node-link n)))
(define (next-node n) (cdr (node-link n)))
(define (set-prev-node! n x)
  (set-car! (node-link n) x)
  (if (not (null? x))
    (set-cdr! (node-link x) n)))
(define (set-next-node! n x)
  (set-cdr! (node-link n) x)
  (if (not (null? x))
    (set-car! (node-link x) n)))
(define (print-node n)
  (if (null? n)
    null
    (cons (node-data n)
          (print-node (next-node n)))))

(define (make-deque)
  (let ((front-ptr null)
        (rear-ptr null))
    (define (empty-deque?) (null? front-ptr))
    (define (front-deque)
      (if (empty-deque?)
        (error "FRONT-DEQUE called with an empty deque")
        (car front-ptr)))
    (define (rear-deque)
      (if (empty-deque?)
        (error "REAR-DEQUE called with an empty deque")
        (car rear-ptr)))
    (define (print-deque) (print-node front-ptr))
    (define (front-insert-deque! x)
      (let ((new-node (make-node x null null)))
        (if (empty-deque?)
          (set! rear-ptr new-node)
          (set-prev-node! front-ptr new-node))
        (set! front-ptr new-node)))
    (define (rear-insert-deque! x)
      (let ((new-node (make-node x null null)))
        (if (empty-deque?)
          (set! front-ptr new-node)
          (set-next-node! rear-ptr new-node))
        (set! rear-ptr new-node)))
    (define (front-delete-deque!)
      (if (empty-deque?)
        (error "FRONT-DELETE-DEQUE! called with an empty deque"))
      (set! front-ptr (next-node front-ptr))
      (if (null? front-ptr)
        (set! rear-ptr null)
        (set-prev-node! front-ptr null)))
    (define (rear-delete-deque!)
      (if (empty-deque?)
        (error "REAR-DELETE-DEQUE! called with an empty deque"))
      (set! rear-ptr (prev-node rear-ptr))
      (if (null? rear-ptr)
        (set! front-ptr null)
        (set-next-node! rear-ptr null)))
    (define (dispatch m)
      (cond ((eq? m 'empty-deque?) empty-deque?)
            ((eq? m 'front-deque) front-deque)
            ((eq? m 'rear-deque) rear-deque)
            ((eq? m 'front-insert-deque!) front-insert-deque!)
            ((eq? m 'rear-insert-deque!)  rear-insert-deque!)
            ((eq? m 'front-delete-deque!) front-delete-deque!)
            ((eq? m 'rear-delete-deque!)  rear-delete-deque!)
            ((eq? m 'print-deque)  print-deque)
            ))
    dispatch))

(define (empty-deque? q) ((q 'empty-deque?)))
(define (front-deque q) ((q 'front-deque)))
(define (rear-deque q) ((q 'rear-deque)))

(define (front-insert-deque! q x) ((q 'front-insert-deque!) x))
(define (rear-insert-deque! q x) ((q 'rear-insert-deque!) x))
(define (front-delete-deque! q) ((q 'front-delete-deque!)))
(define (rear-delete-deque! q) ((q 'rear-delete-deque!)))
(define (print-deque q) ((q 'print-deque)))
