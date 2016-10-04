; 2.66
; 레코드 집합을 두 갈래 나무로 짜 맞춘다고 할 때, 그에 알맞은 lookup 프로시저를 
; 구현해 보라.

(define (lookup-tree given-key set-of-records)
  (cond ((null? set-of-records) #f)
        ((equal? given-key (key (entry set-of-records))) (entry set-of-records))
        ((<? given-key (key (entry set-of-records))) (lookup-tree given-key (left-branch set-of-records)))
        ((>? given-key (key (entry set-of-records))) (lookup-tree given-key (right-branch set-of-records)))))

        

