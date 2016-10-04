(load "../misc/scheme-test.scm")

(define (deep-reverse items)
  (define (iter items result)
    (cond ((null? items) result)
          ((not (list? items)) items)
          (else
           (iter (cdr items)
                 (cons (iter (car items) null)
                       result)))))
  (iter items null))

(define deep-reverse-test
  (make-testcase
   '(assert-equal? '(1) (deep-reverse '(1)))
   '(assert-equal? '(3 2 1) (deep-reverse '(1 2 3)))
   '(assert-equal? '((4 3) (2 1)) (deep-reverse '((1 2) (3 4))))
   '(assert-equal? '(3 (3 2 1) 1) (deep-reverse '(1 (1 2 3) 3)))
   ))

(run deep-reverse-test)