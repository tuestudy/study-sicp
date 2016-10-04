(load "../misc/scheme-test-r5rs.scm")
(load "ch4-myeval-pkg-yarra.scm")


;(while <init> <pred> <body>)

;(let whilebody <init> (if <pred> (begin <body> (whilebody <varlist>))))

; answer
(define (while->namedlet exp)
  (let ((varlist (map car (cadr exp)))
        (init (cadr exp))
        (pred (caddr exp))
        (body (cadddr exp)))
    (list 'let '_whilebody init (list 'if pred (list 'begin body (cons '_whilebody varlist))))))

;test
(define myexp '(while ((a 0)) (< a 5) (begin (display a) (set! a (+ a 1)))))
(define myexp2 '(while ((a 0)) (< a 5) (begin (set! a (+ a (+ a 1))))))
(define answer '(let _whilebody ((a 0)) (if (< a 5) (begin (begin (display a) (set! a (+ a 1))) (_whilebody a)))))

(define the-global-environment (setup-environment))

(run (make-testcase
      '(assert-equal? answer (while->namedlet myexp))))