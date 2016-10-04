(define (make-mutex)
  (let ((cell (list false)))            
    (define (the-mutex m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
                 (the-mutex 'acquire)
                 (void))) ; retry
            ((eq? m 'release) (clear! cell))))
    the-mutex))
(define (clear! cell)
  (set-car! cell false))

(define (test-and-set! cell)
  (if (car cell)
      true
      (begin (set-car! cell true)
             false)))

(define (make-semaphore n)
  (let ((n (list n))
        (mutex (make-mutex)))
    (define (the-semaphore msg)
      (mutex 'acquire)
      (cond [(eq? msg 'acquire)
             (if (= (car count) 0)
               (begin
                 (mutex 'release)
                 (the-semaphore 'acquire))
               (begin
                 (set-car! count (sub1 (car count)))
                 (mutex 'release)))]
            [(eq? msg 'release)
             (begin
               (if (< (car count) n)
                 (set-car! count (add1 (car count)))
                 (void))
               (mutex 'release))]))
    the-semaphore))
