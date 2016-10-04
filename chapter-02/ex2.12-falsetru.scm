(load "ex2.07-falsetru.scm")

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (percent i)
  (let ((c (center i)))
    (* (/ (- (upper-bound i) c)
          c)
       100)))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (make-center-percent center percent)
  (let ((width (* center (/ percent 100))))
    (make-interval (- center width)
                   (+ center width))))
