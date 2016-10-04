(load "ex2.46-falsetru.scm")

(define (make-frame-1 origin edge1 edge2)
  (list origin edge1 edge2))

(define (make-frame-2 origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define origin-frame-1 car)
(define edge1-frame-1 cadr)
(define edge2-frame-1 caddr)

(define origin-frame-2 car)
(define edge1-frame-2 cadr)
(define edge2-frame-2 cddr)
