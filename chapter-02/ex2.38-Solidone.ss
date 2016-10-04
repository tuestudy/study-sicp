(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (fold-right op initial sequence)
  (accumulate op initial sequence))
  
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))


(fold-right / 1 (list 1 2 3))
(fold-left / 1 (list 1 2 3))
(fold-right list null (list 1 2 3))
(fold-left list null (list 1 2 3))
(fold-right + 0 (list 1 2 3))
(fold-left + 0 (list 1 2 3))

; if operator is commutative,  the answers of fold-right and fold-left are the same.
; reference : http://en.wikipedia.org/wiki/Commutative_law
;             http://ko.wikipedia.org/wiki/%EA%B5%90%ED%99%98%EB%B2%95%EC%B9%99