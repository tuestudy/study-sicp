(load "ex2.83-falsetru.scm")

; XXX  새로운 층이 생기면 order 를 수정... :|
; (define order '(complex real rational scheme-number))
(define order '(complex rational scheme-number))
(define (level t) (length (memq t order)))

(define (higher a b)
  (> (level a)
     (level b)))

(define (coerce a b)
  (let ((ta (type-tag a))
        (tb (type-tag b)))
    (cond ((higher ta tb) (coerce a (raise b)))
          ((higher tb ta) (coerce (raise a) b))
          (else (list a b)))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (apply eq? type-tags)
            (error "No method for these types -- APPLY-GENERIC"
                   (list op type-tags))
            (let ((new-args (coerce (car args) (cadr args))))
              (apply-generic op (car new-args) (cadr new-args))))))))
