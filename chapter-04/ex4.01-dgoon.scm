; Written by dgoon with mzscheme
;(require (lib "r5rs"))
;How to use commandline mzscheme:
; alias mzscheme='mzscheme -l r5rs'
; mzscheme < ex4.05-test-dgoon.scm | mzscheme -f ex4.05-test-dgoon.scm
(load "../misc/myeval.scm")

(define first-operand car)
(define rest-operands cdr)
(define no-operands? null?)

(define (list-of-values exps env)
  (if (no-operands? exps)
      '()
      (cons (myeval (first-operand exps) env)
	    (list-of-values (rest-operands exps) env))))

(define (list-of-values> exps env)
  (if (no-operands? exps)
      '()
      (let ((left (myeval (first-operand exps) env))
	    (right (list-of-values
		    (rest-operands exps) env)))
	(cons left right))))

(define (list-of-values< exps env)
  (if (no-operands? exps)
      '()
      (let ((right (list-of-values
		    (rest-operands exps) env))
	    (left (myeval (first-operand exps) env)))
	(cons left right))))

(define a-environment (setup-environment))
(define b-environment (setup-environment))

(myeval '(define a 3) a-environment)
(myeval '(define a 3) b-environment)

(list-of-values> '((set! a (+ a 3)) (set! a (* a 2))) a-environment)
(list-of-values< '((set! a (+ a 3)) (set! a (* a 2))) b-environment)

(display (lookup-variable-value 'a a-environment)) (newline)
(display (lookup-variable-value 'a b-environment)) (newline)

