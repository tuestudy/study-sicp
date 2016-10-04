(load "scheme-test.scm")

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define nil '())
(define (square x) (* x x))

(define (map2 p sequence)
  (accumulate (lambda (x y) (cons (p x) y)) nil sequence))

; <??> : (cons (p x) y)

(define (append1 seq1 seq2)
  (accumulate cons seq2 seq1))

; <??> : seq2, <??> : seq1

(define (length1 sequence)
  (accumulate (lambda (x y) (+ (if (null? x) 0 1) y)) 0 sequence))

; <??> : (lambda (x y) (+ (if (null? x) 0 1) y))

(run
 (make-testcase
  '(assert-equal? (list 1 4 9 16)
                  (map2 square (list 1 2 3 4)))
  '(assert-equal? (list 1 2 3 4 5 6)
                  (append1 (list 1 2 3) (list 4 5 6)))
  '(assert-equal? 3
                  (length1 (list 1 2 3)))
  '(assert-equal? 4
                  (length1 (list 1 2 (list 3 4) 5)))
  ))
                  
                  



  