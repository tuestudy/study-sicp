(require (planet schematics/schemeunit:3))
(require (planet schematics/schemeunit:3/text-ui))

(define x (list 1 2 3))
(define y (list 4 5 6))

(check-equal? (append x y) '(1 2 3 4 5 6))
(check-equal? (append x y) (list 1 2 3 4 5 6))

(check-equal? (cons x y) '((1 2 3) . (4 5 6)))

(check-equal? (list x y) '((1 2 3) (4 5 6)))
(check-equal? (list x y) (list (list 1 2 3) (list 4 5 6)))
