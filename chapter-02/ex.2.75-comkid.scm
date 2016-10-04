(require scheme/math)
(load "../misc/scheme-test.scm")

(define (square x) (* x x))

(define (make-from-real-imag x y)
  (define (dispatch op)
    (cond ((eq? op 'real-part) x)
          ((eq? op 'imag-part) y)
          ((eq? op 'magnitude)
           (sqrt (+ (square x) (square y))))
          ((eq? op 'angle) (atan y x))
          (else
           (error "Unknown op -- MAKE-FROM-REAL-IMAG" op))))
  dispatch)

(define (make-from-mag-ang r a)
  (define (dispatch op)
    (cond ((eq? op 'magnitude) r)
          ((eq? op 'angle) a)
          ((eq? op 'real-part) (* r (cos a)))
          ((eq? op 'imag-part) (* r (sin a)))
          (else
           (error "Unknown op -- MAKE-FROM-REAL-IMAG" op))))
  dispatch)

(define p (make-from-mag-ang 1 (* pi 0.25)))
(define r (make-from-real-imag (p 'real-part)
                               (p 'imag-part)))

(run (make-testcase
      '(assert-equal? 1 (p 'magnitude))
      '(assert-equal? (* pi 0.25) (p 'angle))
      '(assert-near? (r 'magnitude) 
                     (p 'magnitude)
                     0.001)      
      '(assert-near? (r 'angle) 
                     (p 'angle)
                     0.001)      
      ))


