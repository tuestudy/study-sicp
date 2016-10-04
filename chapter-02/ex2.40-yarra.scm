; 2.40

(load "../misc/accumulate.scm")
(load "../misc/scheme-test.scm")


; 필요한 정의 
(define (flatmap proc seq)
  (accumulate append '() (map proc seq)))

(define (enumerate-interval start end)
  (if (= start end)
      (list end)
      (cons start (enumerate-interval (+ start 1) end))))

; solutions
(define (unique-pairs n)
  (filter (lambda (x) (if (> (car x) (cdr x)) #t #f))
          (flatmap (lambda (i) (map (lambda (j) (cons i j)) (enumerate-interval 1 i)))
                   (enumerate-interval 1 n))))



(run
 (make-testcase
  '(assert-equal? (list (cons 2 1)
                        (cons 3 1)
                        (cons 3 2)
                        (cons 4 1)
                        (cons 4 2)
                        (cons 4 3)
                        (cons 5 1)
                        (cons 5 2)
                        (cons 5 3)
                        (cons 5 4))
                  (unique-pairs 5))))