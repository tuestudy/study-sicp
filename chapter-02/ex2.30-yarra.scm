; 2.30

; 연습문제 2.21 의 square-list 프로시저처럼 square-tree 프로시저를 정의해보자.
; 다시 말해, square-tree 프로시저는 다음과 같이 돌아가야 한다.

(load "../misc/scheme-test.scm")

(define (square x) (* x x))
(define (square-tree tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (square tree))
        (else (cons (square-tree (car tree))
                    (square-tree (cdr tree))))))

(run
 (make-testcase
  '(assert-equal? (square-tree
                   (list 1
                         (list 2 (list 3 4) 5)
                         (list 6 7)))
                  '(1 (4 (9 16) 25) (36 49)))))