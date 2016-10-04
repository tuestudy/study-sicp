(load "ex4.22-dgoon.scm")

(define unless-cond cadr)
(define unless-usual caddr)
(define unless-exceptional cadddr)

(define (unless->if exp)
  (make-if (unless-cond exp)
	   (unless-exceptional exp)
	   (unless-usual exp)))

(define (install-unless)
  (put 'myanalyze 'unless (lambda (exp)
			    (myanalyze (unless->if exp)))))

(install-unless)