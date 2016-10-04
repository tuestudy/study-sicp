(load "../misc/scheme-test-r5rs.scm")

; ------------------------------------------------------------------------------
; exercise 4.21 example
; ------------------------------------------------------------------------------

(define (fact n)
  (if (= n 1)
      1
      (* n (fact (- n 1)))))

(define test-fact-exp
  ((lambda (n)
     ((lambda (fact)
        (fact fact n))
      (lambda (ft k)
        (if (= k 1)
            1
            (* k (ft ft (- k 1)))))))
   10))

(display "exercise 4.21.a - fact\n")
(run (make-testcase
      '(assert-equal? (fact 10) test-fact-exp)))

; ------------------------------------------------------------------------------
; exercise 4.21.a
; ------------------------------------------------------------------------------
;
; fib & fib-iter
;  1.2.2 Tree Recursion
;  http://mitpress.mit.edu/sicp/full-text/book/book-Z-H-4.html#%_toc_%_sec_1.2.2
;

(define (fib n)
  (define (fib-iter a b count)
    (if (= count 0)
        b
        (fib-iter (+ a b) a (- count 1))))
  (fib-iter 1 0 n))

(define test-fib-exp
  ((lambda (n)
     ((lambda (fib)
        (fib fib 1 0 n))
      (lambda (fb a b count)
        (if (= count 0)
            b
            (fb fb (+ a b) a (- count 1))))))
   10))

(display "exercise 4.21.a - fib\n")
(run (make-testcase
      '(assert-equal? (fib 10) test-fib-exp)))

; ------------------------------------------------------------------------------
; exercise 4.21.b
; ------------------------------------------------------------------------------
;
;(define (f x)
;  (define (even? n)
;    (if (= n 0)
;        true
;        (odd? (- n 1))))
;  (define (odd? n)
;    (if (= n 0)
;        false
;        (even? (- n 1))))
;  (even? x))

(define (f x)
  ((lambda (even? odd?)
     (even? even? odd? x))
   (lambda (ev? od? n)
     (if (= n 0) #t (od? ev? od? (- n 1))))
   (lambda (ev? od? n)
     (if (= n 0) #f (ev? ev? od? (- n 1))))))

(display "exercise 4.21.b - even? and odd?\n")
(run (make-testcase
      '(assert-equal? #t (f 1024))
      '(assert-equal? #f (f 513))
      ))
