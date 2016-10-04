(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))



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


(define (element-of-set? x set)
  (cond ((null? set) #f)
        ((= x (entry set)) #t)
        ((< x (entry set))
         (element-of-set? x (left-branch set)))
        ((> x (entry set))
         (element-of-set? x (right-branch set)))))

(define (adjoin-set x set)
  (cond ((null? set) (make-tree x '() '()))
        ((= x (entry set)) set)
        ((< x (entry set))
         (make-tree (entry set)
                    (adjoin-set x (left-branch set))
                    (right-branch set)))
        ((> x (entry set))
         (make-tree (entry set)
                    (left-branch set)
                    (adjoin-set x (right-branch set))))))



(define set1 (list 7 
                   (list 3 (list 1 '() '()) (list 5 '() '())) 
                   (list 9 '() (list 11 '() '()))))
(define set2 (list 3
                   (list 1 '() '())
                   (list 7
                         (list 5 '() '())
                         (list 9 
                               '()
                               (list 11 '() '())))))
(define set3 (list 5
                   (list 3 
                         (list 1 '() '())
                         '())
                   (list 9
                         (list 7 '() '())
                         (list 11 '() '()))))

(and
 (equal? (tree->list-1 set1) (tree->list-2 set1))
 (equal? (tree->list-1 set2) (tree->list-2 set2))
 (equal? (tree->list-1 set3) (tree->list-2 set3))
 )

(and
 (equal? (tree->list-1 set1) (list 1 3 5 7 9 11))
 (equal? (tree->list-1 set2) (list 1 3 5 7 9 11))
 (equal? (tree->list-1 set3) (list 1 3 5 7 9 11))
 )


;; 두 프로시저가 모두 좌우측 트리를 재귀호출을 통해 리스트로 바꾼후 
;; 엔트리와 양쪽 서브트리를 연결하는 식으로 트리를 평평한 리스트로 변환한다.
;; tree->list-2 는 트리의 가장 루트에서 우측으로 먼 서브트리부터 빈 리스트에 차례차례 담아 답을 내는 반면, ==> O(n)
;; tree->list-1 은 서브트리를 계속 append를 통해 연결하므로 트리구조가 최악의 경우
;; (왼쪽으로 균형이 깨진) O(n^2)를 보일 수 있다.



