(load "../misc/scheme-test-r5rs.scm")

(define (make-monitored proc)
  (let ((count 0))
    (define (call n)
      (begin (set! count (+ count 1))
             (proc n)))
    (define (dispatch m)
      (cond ((number? m) (call m))
            ((eq? m 'how-many-calls?) count)
            (else '())))
  dispatch))

(define s (make-monitored sqrt))

(run (make-testcase
      '(assert-equal? 10 (s 100))
      '(assert-equal? 3 (begin (s 10) 
                               (s 9) 
                               (s 'how-many-calls?)))
      ))
