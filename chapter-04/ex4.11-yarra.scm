(load "../misc/scheme-test-r5rs.scm")

; answer
(define (make-frame vars vals)
  (if (null? vars)
      '()
      (cons (cons (car vars) (car vals)) (make-frame (cdr vars) (cdr vals)))))

(define (frame-variables frame) (map car frame))
(define (frame-values frame) (map cdr frame))
(define (add-binding-to-frame! var val frame)
  (let ((temp (car frame)))
    (set-car! frame (cons var val))
    (set-cdr! frame (cons temp (cdr frame)))))


; test
(define lst2 (list 'a 'b 'c 'd))
(define lst1 (list 1 2 3 4))
(define answer (list (cons 'a 1) (cons 'b 2) (cons 'c 3) (cons 'd 4)))
(define added-answer (cons (cons 'e 5) answer))


(run (make-testcase
      '(assert-equal? answer (make-frame lst2 lst1))
      '(assert-equal? lst2 (frame-variables (make-frame lst2 lst1)))
      '(assert-equal? lst1 (frame-values (make-frame lst2 lst1)))))

(define frame (make-frame lst2 lst1))
(add-binding-to-frame! 'e 5 frame)
frame
