(define (let? exp)
  (eq? 'let (car exp)))

; for let->combination
(load "ex4.06-comkid.scm")