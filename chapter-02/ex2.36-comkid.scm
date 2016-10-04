(load "../misc/scheme-test.scm")
(load "../misc/accumulate.scm")

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      null
      (cons (accumulate op init (map (lambda (x) (car x)) seqs))
            (accumulate-n op init (map (lambda (x) (cdr x)) seqs)))))

; Test
(define x '((1 2 3) (4 5 6) (7 8 9) (10 11 12)))

(run (make-testcase
      '(assert-equal? '(22 26 30) (accumulate-n + 0 x))
      ))