(define (eval-and exp env)
  (define (iter ps last-value)
    (cond ((null? ps) last-value)
          ((false? last-value) false)
          (else
           (iter (cdr ps) (myeval (car ps) env)))))
  (if (null? (cdr exp))
      true
      (iter (cdr exp) true)))

(define (eval-or exp env)
  (define (iter ps last-value)
    (cond ((null? ps) last-value)
          ((true? last-value) last-value)
          (else
           (iter (cdr ps) (myeval (car ps) env)))))
  (if (null? (cdr exp))
      false
      (iter (cdr exp) false)))