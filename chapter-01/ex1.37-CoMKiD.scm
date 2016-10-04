(define (cont-frac n d k)
  (define (k-term i k) 
    (if (= i k) 
        (/ (n i) (d i))
        (/ (n i) (+ (d i) (k-term (+ i 1) k)))))
  (k-term 1 k))

(define (cont-frac-iter n d k)
  (define (iter i result)
    (if (= i 0) 
        result
        (iter (- i 1) (/ (n i) (+ (d i) result)))))
  (iter k 0))

(define PHI 1.6180)

(define (for i n f)
  (cond ((< i n) 
         (display i)
         (display "\t")
         (display (f i))
         (newline)
         (for (+ i 1) n f))))


(define (golden-ratio-reciprocal? k)
  (> 0.00001
     (abs (- (/ 1 PHI)
             (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) k)))))

(define (find-k pred)
  (define (find i)
    (if (pred i) i (find (+ i 1))))
  (find 1))

(display "recusive process\n")
(display "kth\tresult\n")
(for 1 15 (lambda (k) (cont-frac (lambda (i) 1.0) (lambda (i) 1.0) k)))
(newline)
(display "iterative process\n")
(display "kth\tresult\n")
(for 1 15 (lambda (k) (cont-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) k)))
(newline)
(find-k golden-ratio-reciprocal?)
