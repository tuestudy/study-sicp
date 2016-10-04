(define-syntax delay
  (syntax-rules ()
    ((delay x)
     (lambda () x))))

(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream x y)
     (cons x (delay y)))))

(define force (lambda (x) (x)))

(define (memo-proc proc)
  (let ((already-run? false) (result false))
    (lambda ()
      (if (not already-run?)
          (begin (set! result (proc))
                 (set! already-run? true)
                 result)
          result))))

; memoized delay
(define-syntax delay
  (syntax-rules ()
    ((delay x)
     (memo-proc (lambda () x)))))


(define (stream-car stream) (car stream))
(define (stream-cdr stream) (force (cdr stream)))
(define the-empty-stream '())
(define stream-null? null?)
(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

; code of stream-map in the book
(define (stream-map proc s)
  (if (stream-null? s)
      the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))

; code of stream-for-each in the book
(define (stream-for-each proc s)
  (if (stream-null? s)
      'done
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))

(define (display-stream s)
  (stream-for-each display-line s))

(define (display-line x)
  (newline)
  (display x))

; written by dgoon
(define (partial-stream s n)
  (define (iter cur-stream cur)
    (if (> cur n)
	the-empty-stream
	(cons-stream (stream-car cur-stream)
		     (iter (stream-cdr cur-stream)
			   (+ cur 1)))))
  (iter s 0))