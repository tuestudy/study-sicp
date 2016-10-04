;; ex 4.62 by dgoon
;; mzscheme -f ch4-query.scm < ex4.62-dgoon.scm

(rule (last-pair (?x) ?x))
(rule (last-pair (?x . ?y) ?z)
      (last-pair ?y ?z))

(last-pair (3) ?x)
(last-pair (1 2 3) ?x)
(last-pair (2 ?x) (3))
;(last-pair ?x (3)) ; doesn't work. infinite loop 
