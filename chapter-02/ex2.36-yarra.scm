; 2.36

; accumulate-n 의 정의를 마무리 하라.


(load "../misc/accumulate.scm")
(load "../misc/scheme-test.scm")


(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      '()
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))


(run
 (make-testcase
  '(assert-equal? '(22 26 30) (accumulate-n +
                                            0
                                            (list (list 1 2 3) 
                                                  (list 4 5 6) 
                                                  (list 7 8 9) 
                                                  (list 10 11 12))))))
 