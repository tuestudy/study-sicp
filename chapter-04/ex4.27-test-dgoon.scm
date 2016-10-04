(load "ch4-lazy-myeval-pkg-dgoon.scm")

(define test-environment (setup-environment))
(myeval '(begin
	   (define count 0)
	   (define (id x)
	     (set! count (+ count 1))
	     x)
	   (define w (id (id 10))))
	test-environment)

(display (myeval 'count test-environment))(newline)
(display (actual-value 'w test-environment))(newline)
(display (myeval 'count test-environment))(newline)