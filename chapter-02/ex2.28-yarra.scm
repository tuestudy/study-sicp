; 2.28

; 리스트로 나타낸 나무를 인자로 받아서, 모든 나뭇잎을 왼쪽에서 오른쪽으로
; 늘어놓은 리스트를 결과로 내놓는 fringe 프로시저를 정의하라.
; fringe 프로시저를 만들어 돌려보았을 때 그 결과는 아래와 같다.

(load "../misc/scheme-test.scm")

(define y (list (list 1 2) (list 3 4)))

(define (fringe x)
  (if (null? x)
      '()
      (if (pair? (car x)) 
          (append (fringe (car x)) (fringe (cdr x)))
          (cons (car x) (fringe (cdr x))))))
  


(run
 (make-testcase
  '(assert-equal? (fringe (list y y)) '(1 2 3 4 1 2 3 4))
  '(assert-equal? (fringe y) '(1 2 3 4))))
  