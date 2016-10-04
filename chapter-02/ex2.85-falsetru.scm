(load "ex2.80-falsetru.scm")

(define (raise x) (apply-generic 'raise x))
(put 'raise '(scheme-number) (lambda (n) (make-rational n 1)))
(put 'raise '(rational)
     (lambda (r) (make-complex-from-real-imag (/ (numer r) (denom r)) 0)))

(define (project x) (apply-generic 'project x))
(put 'project '(complex)
     (lambda (x) (make-rational (real-part x) 1)))
(put 'project '(rational)
     (lambda (x) (make-scheme-number (numer x))))
(put 'project '(scheme-number)
     (lambda (x) (make-scheme-number x)))

(define (drob x)
  (cond ((eq? (type-tag x) 'scheme-number) x)
        ((equ? (raise (project x)) x) (drob (project x)))
        (else x)))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
        (let ((result (apply proc (map contents args))))
          (if (memq op '(add sub mul div))
            (drob result)
            result))
        (error "No method for these types -- APPLY-GENERIC"
               (list op type-tags))))))
