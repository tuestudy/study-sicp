(load "../misc/scheme-test.scm")

(define golden-ratio 1.61803399)

(define (cont-frac n d k)
    (define (p start end)
        (if (= start end)
            (/ (n start) (d start))
            (/ (n start) (+ (d start) (p (+ start 1) end)))))
    (p 1 k))

(define (cont-frac-2 n d k)
    (define (p start result)
        (if (= start 0)
            result
            (p (- start 1) (/ (n start) (+ (d start) result)))))
    (p k 0.0))

(run (make-testcase
    '(assert-near? 1.0
                   (cont-frac-2 (lambda (i) 1.0)
                              (lambda (i) 1.0)
                              1)
                   0.01)
    '(assert-near? 0.5
                   (cont-frac-2 (lambda (i) 1.0)
                              (lambda (i) 1.0)
                              2)
                   0.01)
    '(assert-near? (/ 1.0 golden-ratio)
                   (cont-frac-2 (lambda (i) 1.0)
                              (lambda (i) 1.0)
                              10)
                   0.001)
    '(assert-near? 1.0
                   (cont-frac (lambda (i) 1.0)
                              (lambda (i) 1.0)
                              1)
                   0.01)
    '(assert-near? 0.5
                   (cont-frac (lambda (i) 1.0)
                              (lambda (i) 1.0)
                              2)
                   0.01)
    '(assert-near? (/ 1.0 golden-ratio)
                   (cont-frac (lambda (i) 1.0)
                              (lambda (i) 1.0)
                              10)
                   0.001)))
