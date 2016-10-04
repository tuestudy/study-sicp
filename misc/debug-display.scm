(define enable-debug-display #f)

(define (set-enable-debug-display enable?)
  (set! enable-debug-display enable?))

(define (debug-display xs)
  (define (display-list xs)
    (cond ((null? xs) (newline))
          (else
           (display (car xs))
           (display " ")
           (display-list (cdr xs)))))
  (cond ((eq? #t enable-debug-display)
         (display "DEBUG: ")
         (display-list xs))))