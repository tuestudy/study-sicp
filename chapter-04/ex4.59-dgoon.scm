;; Ben Bitdiddle's assertions

(assert! (meeting accounting (Monday 9am)))
(assert! (meeting administration (Monday 10am)))
(assert! (meeting computer (Wednesday 3pm)))
(assert! (meeting administration (Friday 1pm)))

(assert! (meeting whole-company (Wednesday 4pm)))

;; a. On Friday morning, Ben wants to query the data base for all the meetings that occur that day. What query should he use?

(and (meeting ?where (Friday ?time))
     (or (lisp-value eq? ?where whole-company)
	 (job (Bitdiddle Ben) (?where . ?rest))))

;; b. Alyssa P. Hacker is unimpressed. She thinks it would be much more useful to be able to ask for her meetings by specifying her name. So she designs a rule that says that a person's meetings include all whole-company meetings plus all meetings of that person's division. Fill in the body of Alyssa's rule.

(rule (meeting-time ?person ?day-and-time)
      (and (meeting ?division ?day-and-time)
	   (or (job ?person (?division . ?rest))
	       (lisp-value eq? ?division whole-company))))

;; c. Alyssa arrives at work on Wednesday morning and wonders what meetings she has to attend that day. Having defined the above rule, what query should she make to find this out?
(meeting-time (Hacker Alyssa P) ?day-and-time)
