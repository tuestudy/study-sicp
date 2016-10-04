; from 2.2.3 
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (enumerate-interval start end)
  (if (> start end)
      null
      (cons start (enumerate-interval (+ start 1) end))))

(define (flatmap proc seq)
  (accumulate append null (map proc seq)))

; answer
(define (sum-triple triple)
  (+ (car triple) (cadr triple) (cadr (cdr triple))))

(define (make-triple-sum triple)
  (append triple (list (sum-triple triple))))

(define (triple-sum-equal-n? n)
  (lambda (triple) (= n (sum-triple triple))))

(define (unique-triples n)
  (flatmap
   (lambda (i)
     (flatmap (lambda (j)
                (map (lambda(k) (list i j k))
                     (enumerate-interval 1 (- j 1))))
              (enumerate-interval 1 (- i 1))))
   (enumerate-interval 1 n)))

(define (n-sum-triples n)
  (map make-triple-sum
       (filter (triple-sum-equal-n? n) (unique-triples n))))


; test-case
(equal? 6
        (sum-triple (list 1 2 3)))
(equal? false
        ((triple-sum-equal-n? 10) (list 1 2 3)))
(equal? true
        ((triple-sum-equal-n? 10) (list 3 4 3)))
(equal? (list 1 2 3 6)
        (make-triple-sum (list 1 2 3)))
(equal? true
        ((triple-sum-equal-n? 10) (list 1 2 7)))

(unique-triples 5)

(n-sum-triples 6)
(n-sum-triples 7)
(n-sum-triples 8)
(n-sum-triples 9)
