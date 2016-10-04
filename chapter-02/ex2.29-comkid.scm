(load "../misc/scheme-test.scm")

(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cadr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cadr branch))

(define (total-weight mobile)
  (define (branch-weight branch)
    (let ((x (branch-structure branch)))
      (if (pair? x)
          (total-weight x)
          x)))
  (+ (branch-weight (left-branch mobile))
     (branch-weight (right-branch mobile))))

(define (torque branch)
  (let ((x (branch-structure branch)))
    (* (branch-length branch)
       (if (list? x) (total-weight x) x))))

(define (balanced? mobile)
  (if (pair? mobile)
      (and (= (torque (left-branch mobile))
              (torque (right-branch mobile)))
           (balanced? (branch-structure (left-branch mobile)))
           (balanced? (branch-structure (right-branch mobile))))
      #t))

;;; Test
(define left (make-branch 3 2))
(define right (make-branch 4 1))
(define mobile (make-mobile left right))

(run (make-testcase
      '(assert-equal? left (left-branch mobile))
      '(assert-equal? right (right-branch mobile))
      '(assert-equal? 3 (branch-length left))
      '(assert-equal? 2 (branch-structure left))
      '(assert-equal? 3 (total-weight mobile))
      '(assert-equal? 5 (total-weight (make-mobile left (make-branch 3 mobile))))
      '(assert-equal? 6 (total-weight (make-mobile 
                                       (make-branch 2 mobile) 
                                       (make-branch 3 mobile))))
      '(assert-equal? 6 (torque left))
      '(assert-equal? 9 (torque (make-branch 3 mobile)))
      '(assert-equal? 3 (torque (make-branch 3 1)))
      '(assert-equal? #t (balanced? (make-mobile left left)))
      '(assert-equal? #f (balanced? mobile))
      ))