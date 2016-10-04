; How to execute: mzscheme -f ch4-query.scm < ex4.56-dgoon.scm

; a. the names of all people who are supervised by Ben Bitdiddle, together with their addresses
(and (supervisor ?name (Bitdiddle Ben))
          (address ?name ?address))

; b. all people whose salary is less than Ben Bitdiddle's, together with their salary and Ben Bitdiddle's salary
(and (salary (Bitdiddle Ben) ?a)
          (salary ?name ?b)
	       (lisp-value > ?a ?b))

; c. all people who are supervised by someone who is not in the computer division, together with the supervisor's name and job.
(and (supervisor ?name ?s_name)
          (not (job ?s_name (computer . ?dummy)))
	       (job ?s_name ?s_job))
