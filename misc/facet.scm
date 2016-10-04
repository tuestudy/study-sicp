(load "scheme-test.scm")
(load "accumulate.scm")
(load "facetdata_test.scm")
(require scheme/list)

(define (make-tree nodelist)
  (define separator (regexp "/-/"))
  (define (myfilter prefix lst)
    (cond ((null? lst) '())
          ((null? (caar lst)) (myfilter prefix (cdr lst)))
          ((equal? prefix (caaar lst)) (cons (car lst) (myfilter prefix (cdr lst))))
          (else (myfilter prefix (cdr lst)))))
  (if (null? nodelist)
      '()
      (let ((processed-rst (map (lambda (x) (map (lambda (y) (if (string? y) (regexp-split separator y) y)) x)) nodelist)))
        (let ((shared-pfx (caaar processed-rst))
              (processed-rst2 (map (lambda (x) (map (lambda (y) (if (list? y) (cdr y) y)) x)) processed-rst)))
          (let ((pfxset (remove (void 1) (remove-duplicates (map (lambda (x) (if (not (null? (car x))) (caar x))) processed-rst2) equal?))))
            (let ((subtree (map (lambda (x) (make-tree (myfilter x processed-rst2))) pfxset)))             
              (list shared-pfx subtree (accumulate + 0 (map cadr nodelist)))))))))

; test
(run
 (make-testcase '(assert-equal? expectedrst (make-tree facetrst))))


; print tree
(define (draw-tree tree)
  (define indentsize 2)
  (define (draw-tree-inner tree ind)
    (define (indent i)
      (if (= i 0)
          (void 1)
          (begin (display " ") (indent (- i 1)))))
    (if (not (null? tree))
        (begin (indent ind) 
               (display (car tree)) 
               (display " (") 
               (display (car (cdr (cdr tree)))) 
               (display ") ") 
               (newline) 
               (map (lambda (x) (draw-tree-inner x (+ ind indentsize))) (cadr tree)) 
               (void 1))))
  (draw-tree-inner tree 0))

(draw-tree (make-tree facetrst))


;; 아래는 메모메모

;; 트리 구조 ("해당 분류 이름" 가지리스트 해당분류히트수)

;; processed-rst 는 경로 문자열을 분리자로 분할한 리스트로 바꾼것

;; processed-rst2 는 processed-rst 에서 분할한 리스트를 cdr 한 것.

;; pfxset 은 processed-rst2 의 리스트를 car 해서 모아 중복을 제거한 것.

;(remove-duplicates (map (lambda (x) (caar x)) processed-rst2) equal?)


;; subtree 는 pfxset 의 각요소로 시작하는 노드들을 골라 그 노드들에 대해 make-tree를 실행한 결과의 리스트

;(map (lambda (x) (make-tree (myfilter x processed-rst2))) pfxset)

;(lambda (x) (make-tree (myfilter x processed-rst2)))


