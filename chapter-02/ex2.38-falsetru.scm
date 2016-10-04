(load "ex2.33-falsetru.scm")
(define fold-right2 accumulate)
(define (fold-left2 op initial sequence)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest))
            (cdr rest))))
  (iter initial sequence))
