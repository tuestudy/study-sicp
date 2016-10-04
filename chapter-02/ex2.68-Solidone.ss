(load "ex2.67-Solidone.ss")

(define (entry tree) (car tree))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

; answer
(define (encode-symbol character tree)
  (define (iter tree)
    (cond ((leaf? tree) null)
          ((element-of-set? character (symbols (left-branch tree)))
           (cons 0 (iter (left-branch tree))))
          (else (cons 1 (iter (right-branch tree))))))
  (if (memq character (symbols tree))
      (iter tree)
      (display "No such character in tree\n")))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

;test-case
(encode-symbol 'A sample-tree)
(and 
 (equal? (list 0) (encode-symbol 'A sample-tree))
 (equal? (list 1 0) (encode-symbol 'B sample-tree))
 (not (list? (encode-symbol 'K sample-tree)))
 (equal? (list 1 1 0) (encode-symbol 'D sample-tree))
 (equal? (list 1 1 1) (encode-symbol 'C sample-tree))
 (equal? '(A D A B B C A)
         (decode (encode '(A D A B B C A) sample-tree) sample-tree)))