(load "scheme-test.scm")
(load "accumulate.scm")

(define (subset lst)
  (if (null? lst)
      '(())
      (let ((rest (subset (cdr lst))))
        (append (map (lambda (x) (cons (car lst) x)) rest) rest))))

(define (filterit lst filter)
  (if (null? lst)
      '()
      (if (filter (car lst))
          (cons (car lst) (filterit (cdr lst) filter))
          (filterit (cdr lst) filter))))

(define (myfilter x)
  (define (accumulate op initial sequence)
    (if (null? sequence)
        initial
        (op (car sequence)
            (accumulate op initial (cdr sequence)))))
  (if (= (remainder (accumulate + 0 x) 2) 0)
      #t
      #f))

(define (myfilter2 x)
  (define (inner-filter x)
    (if (= (sum x) (/ thesum 2))
        #t
        #f))
  (let ((thesum (sum x))
        (subsets (subset x)))
    (if (null? (filterit subsets (lambda (x) (if (= (sum x) (/ thesum 2)) #t #f))))
        #f
        #t)))

(define (height lst)
  (let ((theset (filterit (filterit (subset lst) myfilter) myfilter2)))
    (if (null? theset)
        -1
        (/ (sum (car theset)) 2))))

(define (sum lst)
  (if (null? lst)
      0
      (+ (car lst) (sum (cdr lst)))))


(run
 (make-testcase
  '(assert-equal? 5 (height (list 2 3 5)))
  '(assert-equal? 11 (height (list 11 11)))
  '(assert-equal? 64 (height (list 14 3 20 15 15 14 24 23 15)))))