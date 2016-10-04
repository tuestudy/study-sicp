(define (clear! cell)
  (set-car! cell false))

(define (loop-test-and-set! cell)
  (if (test-and-set! cell)
    (loop-test-and-set! cell)
    (void)))

(define (test-and-set! cell)
  (if (car cell)
      true
      (begin (set-car! cell true)
             false)))

(define (make-semaphore n)
  (let ((n (list n))
        (guard (list false)))
    (define (the-semaphore msg)
      (loop-test-and-set! guard)
      (cond [(eq? msg 'acquire)
             (if (= (car count) 0)
               (begin
                 (clear! guard)
                 (the-semaphore 'acquire))
               (begin
                 (set-car! count (sub1 (car count)))
                 (clear! guard)))]
            [(eq? msg 'release)
             (begin
               (if (< (car count) n)
                 (set-car! count (add1 (car count)))
                 (void))
               (mutex 'release))]))
    the-semaphore))
