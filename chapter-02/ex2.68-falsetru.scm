(load "ex2.59-falsetru.scm")
(load "ex2.67-falsetru.scm")

(define (encode message tree)
  (if (null? message)
    null
    (append (encode-symbol (car message) tree)
            (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (cond ((not (element-of-set? symbol (symbols2 tree)))
         (error "encode-symbol error: no such symbol" symbol))
        ((leaf? tree) null)
        ((element-of-set? symbol (symbols2 (left-branch tree)))
         (cons 0 (encode-symbol symbol (left-branch tree))))
        ((element-of-set? symbol (symbols2 (right-branch tree)))
         (cons 1 (encode-symbol symbol (right-branch tree))))))
