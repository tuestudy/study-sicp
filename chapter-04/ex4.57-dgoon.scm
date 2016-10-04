; ex4.57-dgoon.scm
; mzscheme -f ch4-query.scm < ex4.57-dgoon.scm

(rule (same-job ?person-1 ?person-2)
   (and (job ?person-1 ?job)
        (job ?person-2 ?job)))

(rule (?person-1 can replace ?person-2)
  (and (or (same-job ?person-1 ?person-2)
           (and (job ?person-1 ?job-1)
                (job ?person-2 ?job-2)
                (can-do-job ?job-1 ?job-2)))
       (not (same ?person-1 ?person-2))))

; a. all people who can replace Cy D. Fect;
(?who can replace (Fect Cy D))

; b. all people who can replace someone who is being paid more than they are, together with two salaries
(and (salary ?person-1 ?salary-1)
     (salary ?person-2 ?salary-2)
     (lisp-value < ?salary-1 ?salary-2)
     (?person-1 can replace ?person-2))
