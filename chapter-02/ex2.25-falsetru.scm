(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))

(define lst1 '(1 3 (5 7) 9))
(define lst2 '((7)))
(define lst3 '(1 (2 (3 (4 (5 (6 7)))))))

(check-equal? (car (cdr (car (cdr (cdr lst1))))) 7)
(check-equal? (car (car lst2)) 7)
(check-equal?
    (car      ; 7
    (cdr      ; (7)
    (car (cdr ; (6 7)
    (car (cdr ; (5..
    (car (cdr ; (4..
    (car (cdr ; (3..
    (car (cdr ; (2..
    lst3      ; (1..
    ))))))))))))
    7)
