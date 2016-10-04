(load "ch4-analyze-dgoon.scm")

;; Reuse procedures in ex4.06

(define (install-analyze-let-combination)
  (put 'myanalyze 'let (lambda (exp)
			 (myanalyze (let-combination exp)))))

(install-analyze-let-combination)
