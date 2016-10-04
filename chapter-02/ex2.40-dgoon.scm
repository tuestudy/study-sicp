(load "../misc/scheme-test.scm")
(load "../misc/accumulate.scm")

(define nil '())

(define (enumerate-interval start end)
  (if (> start end)
      nil
      (cons start (enumerate-interval (+ start 1) end))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (unique-pairs n)
  (flatmap
   (lambda (i)
     (map (lambda (j) (list i j))
	  (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n)))

(enumerate-interval 1 -1)

(run
 (make-testcase
  '(assert-equal? (list 1 2 3) (enumerate-interval 1 3))
  '(assert-equal? '((2 1) (3 1) (3 2)) (unique-pairs 3))))