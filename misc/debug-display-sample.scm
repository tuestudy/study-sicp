(load "../misc/debug-display.scm")


(define (fact n)
  (define (fact-iter x result)
    (debug-display (list  "fact-iter" "x =" x  "result =" result))
    (if (= x 0)
        result
        (fact-iter (- x 1) (* result x))))
  (fact-iter n 1))

(set-enable-debug-display #t)
(fact 10)

(set-enable-debug-display #f)
(fact 5)
