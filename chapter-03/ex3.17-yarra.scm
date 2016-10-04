; 3.17
(load "../misc/scheme-test.scm")


; solution

(define (count-pairs x)
  (define cp-inner 
    ((lambda (nodelist)
       (define (exists?? list obj)
         (cond ((null? list) #f)
               ((eq? (car list) obj) #t)
               (else (exists?? (cdr list) obj))))
       (lambda (x) 
         (if (not (pair? x))
             0
             (if (exists?? nodelist x)
                 (+ (cp-inner (car x))
                    (cp-inner (cdr x)))
                 (begin (set! nodelist (cons x nodelist)) (+ (cp-inner (car x))
                                                             (cp-inner (cdr x))
                                                             1))))))'()))
  (cp-inner x))

;test
(define ab (cons 'a 'b))
(define cd (cons 'c 'd))
(define three (cons ab cd))
(define four (cons (cons ab ab) '()))
(define double_ab (cons ab ab))
(define seven (cons double_ab double_ab))

(run
 (make-testcase
  '(assert-equal? 3 (count-pairs seven))
  '(assert-equal? 3 (count-pairs four))
  '(assert-equal? 3 (count-pairs three))))

; 한번 수행이 끝나면 nodelist를 빈리스트로 초기화해야 하는데;;; 어떻게??
; 에잇! 환경을 하나 더 만들어서 매번 다시 정의하면 되겠구나. 해결!








