; 2.29
(load "../misc/scheme-test.scm")


(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

;a.

(define (left-branch mob) (car mob))
(define (right-branch mob) (cadr mob))
(define (branch-length bran) (car bran))
(define (branch-structure bran) (cadr bran))

(define (branch-weight bran) 
  (let ((structure (branch-structure bran)))
    (if (pair? structure)
        (mobile-weight structure)
        structure)))

(define (mobile-weight mob) 
  (+ (branch-weight (left-branch mob))
     (branch-weight (right-branch mob))))

;b.

(define (total-weight mob)
  (mobile-weight mob))


;c.

(define (balanced? mob)
  (if (not (pair? mob))
      #t
      (and (= (torque (left-branch mob)) (torque (right-branch mob)))
           (balanced? (branch-structure (left-branch mob))) 
           (balanced? (branch-structure (right-branch mob))))))

(define (torque bran)
  (* (branch-length bran) (branch-weight bran)))


;d.






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
     ; '(assert-true? (I-type-branch? (make-branch 1 5)))
     ; '(assert-true? (one-mobile-balanced? (make-mobile (make-branch 1 5) (make-branch 1 5))))
     ; '(assert-true? (one-mobile-balanced? (make-mobile (make-branch 1 sample-mobile) (make-branch 1 sample-mobile))))
      '(assert-false? (balanced? sample-mobile))
      '(assert-true? (balanced? sample-balanced-mobile))
      '(assert-false? (balanced? sample-not-balanced-mobile))
      '(assert-equal? (total-weight (branch-structure (right-branch sample-balanced-mobile2))) 40)
      '(assert-equal? (torque (left-branch sample-balanced-mobile2)) 40)
      '(assert-equal? (torque (right-branch sample-balanced-mobile2)) 40)
      '(assert-true? (balanced? sample-balanced-mobile2))
      '(assert-false? (balanced? sample-not-balanced-mobile2))
      ))