(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (element-of-set?-tree x set)
  (cond ((null? set) #f)
        ((= x (entry set)) #t)
        ((> x (entry set))
         (element-of-set?-tree x (left-branch set)))
        ((> x (entry set))
         (element-of-set?-tree x (right-branch set)))))

(define (element-of-set?-list x set)
  (cond ((null? set) #f)
        ((= x (car set)) #t)
        ((< x (car set)) #f)
        (else (element-of-set?-list x (cdr set)))))

(define (adjoin-set-tree x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set-tree x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set-tree x (right-branch set))))))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '() ))

(define (union-set-list set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((element-of-set?-list (car set1) set2)
         (union-set-list (cdr set1) set2))
        (else (cons (car set1)
                    (union-set-list (cdr set1) set2)))))

(define (intersection-set-list set1 set2)
  (if (or (null? set1) (null? set2))
      '()
      (let ((x1 (car set1)) (x2 (car set2)))
        (cond ((= x1 x2)
               (cons x1
                     (intersection-set-list (cdr set1)
                                            (cdr set2))))
              ((< x1 x2)
               (intersection-set-list (cdr set1) set2))
              ((< x2 x1)
               (intersection-set-list set1 (cdr set2)))))))


;2.65
;
; 연습문제 2.63 2.64 에서 얻은 결과를 빌려서, (균형 잡힌) 두 갈래 나무로 집합을 표현하였을 때,
; 집합 연산 union-set 과 intersection-set 의 자람 차수가 O(n) 이 되도록 구현하라.

(define (union-set-tree set1 set2)
  (list->tree (union-set-list (tree->list-2 set1) (tree->list-2 set2))))

;-> 리스트로 바꿔서 O(m+n)
;-> 합친다.          O(m+n)
;-> 트리로 바꾼다.  O(m+n)
; ===> 모두 두 집합의 원소의 합에 대해 자라는 프로시저이므로 합친 프로시저도 O(m+n)이다.

(define (intersection-set-tree set1 set2)
  (list->tree (intersection-set-list (tree->list-2 set1) (tree->list-2 set2))))

;-> 리스트로 바꿔서   O(m+n)
;-> 교집합을 구한다.  O(m+n)
;-> 트리로 바꾼다.    O(m+n)
; ===> 모두 두 집합의 원소의 합에 대해 자라는 프로시저이므로 합친 프로시저도 O(m+n)이다.

