; ex4.58-dgoon.scm
; mzscheme -f ch4-query.scm < ex4.58-dgoon.scm
      
(rule (big shot ?person)
      (and (job ?person (?division . ?r1))
	   (or (not (supervisor ?person ?anybody))
	       (and (supervisor ?person ?s-person)
		    (job ?s-person (?s-division . ?r2))
		    (not (same ?division ?s-division))))))

(rule (supervisor in same division ?person)
      (and (job ?person (?d . ?x))
	   (job ?s-person (?d . ?y))
	   (supervisor ?person ?s-person)))

(rule (big shot2 ?who)
      (and (job ?who ?j)
           (not (supervisor in same division ?who))))

(big shot ?who)
(big shot2 ?who)
