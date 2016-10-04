(load "../misc/scheme-test.scm")

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

;a
(define (left-branch mobile)
  (car mobile))
(define (right-branch mobile)
  (cadr mobile))
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (cadr branch))

;b

;한모빌의 전체 무게는 얼마인가요?
(define (total-weight mobile)
  (mobile-function-maker mobile + branch-structure))


;c

;I자형 가지가 아니라면 검사를 다시 받아야해요.
(define (balanced? mobile)
  (let ([left (left-branch mobile)]
        [right (right-branch mobile)])
    (and (one-mobile-balanced? mobile)
         (if (not (I-type-branch? left))
             (balanced? (branch-structure left))
             true)
         (if (not (I-type-branch? right))
             (balanced? (branch-structure right))
             true))))


;일자형 가지인가요?
(define (I-type-branch? branch)
  (not (pair? (branch-structure branch))))



;한개의 모빌은 균형을 잡고 있나요?
(define (one-mobile-balanced? mobile)
  (let ([left (left-branch mobile)]
        [right (right-branch mobile)])
    (= (torque left) (torque right))))


;토크는 얼마인가요?
(define (torque branch)
  (let ([leaf (branch-structure branch)])
    (if (pair? leaf)
        (* (branch-length branch) (total-weight leaf))
        (* (branch-length branch) leaf))))

;모빌관련 빌딩블록
(define (mobile-function-maker mobile proc selector)
  (let ([left-leaf (selector (left-branch mobile))]
        [right-leaf (selector (right-branch mobile))])
    (proc (if (pair? left-leaf)
              (total-weight left-leaf)
              left-leaf)
          (if (pair? right-leaf)
              (total-weight right-leaf)
              right-leaf))))

;d
;cons로 재정의 합니다.
;(define (make-mobile left right)
;  (cons left right))
;
;(define (make-branch length structure)
;  (cons length structure))
;나중에 정의한걸로 가려지는군요...
;그러면,
;(define (
;이건좀 ..-_-

(define x (make-mobile 'left 'right))
(define y (make-branch 3 x))

(define I-branch (make-branch 1 5))
(define A-branch (λ(x y) (make-branch 1 (make-mobile x y))))
(define sample-mobile (make-mobile I-branch (A-branch I-branch (A-branch I-branch I-branch))))
; λ
;5 λ
; 5 λ
;  5 5

(define sample-balanced-mobile (make-mobile 
                                (A-branch I-branch I-branch)
                                (A-branch I-branch I-branch)))

(define sample-not-balanced-mobile (make-mobile 
                                    (A-branch I-branch (A-branch I-branch (make-branch 1 3)))
                                    (A-branch I-branch (A-branch I-branch (make-branch 1 3)))))

(define sample-balanced-mobile2 (make-mobile 
                                 (make-branch 40 1)
                                 (make-branch 1 
                                              (make-mobile 
                                               (make-branch 1 20)
                                               (make-branch 1 
                                                            (make-mobile 
                                                             (make-branch 1 10)
                                                             (A-branch I-branch I-branch)))))))
;       λ
;  40  / λ
;     /20 λ
;    /  10 λ
;   /     5 5
;  .
; .
;1

(define sample-not-balanced-mobile2 (make-mobile 
                                     (make-branch 44 1)
                                     (make-branch 1 
                                                  (make-mobile 
                                                   (make-branch 1 22)
                                                   (make-branch 1 
                                                                (make-mobile 
                                                                 (make-branch 1 11)
                                                                 (A-branch I-branch 
                                                                           (make-branch 1 6))))))))
;       λ
;      / λ
; 44  /22 λ
;    /  11 λ
;   /     5 6
;  .
; .
;1

(run (make-testcase
      '(assert-equal? (+ 1 1) 2)
      '(assert-equal? (left-branch x) 'left)
      '(assert-equal? (right-branch x) 'right)
      '(assert-equal? (branch-length y) 3)
      '(assert-equal? (branch-structure y) x)
      '(assert-equal? (total-weight sample-mobile) 20)
      '(assert-equal? (total-weight (make-mobile (make-branch 1 5) (make-branch 1 5))) 10)
      '(assert-true? (I-type-branch? (make-branch 1 5)))
      '(assert-true? (one-mobile-balanced? (make-mobile (make-branch 1 5) (make-branch 1 5))))
      '(assert-true? (one-mobile-balanced? (make-mobile (make-branch 1 sample-mobile) (make-branch 1 sample-mobile))))
      '(assert-false? (balanced? sample-mobile))
      '(assert-true? (balanced? sample-balanced-mobile))
      '(assert-false? (balanced? sample-not-balanced-mobile))
      '(assert-equal? (total-weight (branch-structure (right-branch sample-balanced-mobile2))) 40)
      '(assert-equal? (torque (left-branch sample-balanced-mobile2)) 40)
      '(assert-equal? (torque (right-branch sample-balanced-mobile2)) 40)
      '(assert-true? (balanced? sample-balanced-mobile2))
      '(assert-false? (balanced? sample-not-balanced-mobile2))
      ))
