;; append-to-form in textbook
;; mzscheme -f ch4-query.scm < ex4.68-dgoon.scm

(rule (append-to-form () ?y ?y))

(rule (append-to-form (?u . ?v) ?y (?u . ?z))
      (append-to-form ?v ?y ?z))

(rule (reverse () ()))

(rule (reverse (?u . ?v) ?z)
      (and (reverse ?v ?x)
	   (append-to-form ?x (?u) ?z)))

(reverse () ?x)
(reverse (1) ?x)
(reverse (1 2 3) ?x)
(reverse (1 3 2 1 23 1 2) ?x)

