;2.64

; 다음에 나오는 프로시저 list->tree 는 차례 매긴 리스트를 균형잡힌 두 갈래
; 나무로 바꾼다. 도우미 프로시저 partial-tree 는 정수 n 과, 원소 수가 적어도
; n 개인 리스트를 인자로 받아서, 그 리스트의 처음 n개 원소로 균형잡힌 나무
; 를 만든다. partial-tree 는 (cons로 만든) 쌍을 결과로 내놓는데, 이 쌍의 car
; 는 새로 만든 나무를 가리키고 그 cdr는 그 나무에서 빠진 원소들의 리스트를
; 가리킨다.

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

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

(list->tree (list 1 3 5 7 9 11))

; A.
; 왼쪽 트리 크기를 구하고, 그 크기를 통해 왼쪽부터 왼쪽트리 크기만큼 트리를 만든다.
; 다시 왼쪽 트리에 포함되지 않은 원소 중에서 첫번째 요소를 루트요소로 빼고,
; 루트요소를 뺀 나머지 원소와 그 갯수를 통해 오른쪽 트리를 만든다.
; 루트요소 왼쪽트리 오른쪽트리를 통해 트리를 완성한다.
; (5 (1 () (3 () ())) (9 (7 () ()) (11 () ())))

; B. list->tree로 원소수가 n인 리스트를 바꾸는데 드는 계산 단계는 어떤 자람 차수를 보이는가?
; partial-tree는 노드를 하나씩 배치하므로 노드수만큼 호출된다.
; 최악의 경우 (full binary tree) O(n) 이다.

