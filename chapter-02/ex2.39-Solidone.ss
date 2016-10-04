(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))
  
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))


(define squares (list 1 4 9 16 25))
(define odds (list 1 3 5 7))

(define (reverse1 items)
  (define (iter item result)
    (if (null? item)
        result
        (iter (cdr item) (cons (car item) result))))
  (iter items null))

; answer

(define (reverse2 sequence)
  (fold-right (lambda (x y) (append y (list x))) null sequence))
; <??> : (append y (list x))

(define (reverse3 sequence)
  (fold-left (lambda (x y) (cons y x)) null sequence))
; <??> : (cons y x)

; test-case
(and
 (equal? (list 25 16 9 4 1) (reverse2 squares))
 (equal? (list 7 5 3 1) (reverse2 odds))
 (equal? (list 25 16 9 4 1) (reverse3 squares))
 (equal? (list 7 5 3 1) (reverse3 odds))
 )