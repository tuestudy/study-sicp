; How to execute? mzscheme -f ch4-query.scm < ex4.55-dgoon.scm

; a. all people supervised by Ben Bitdiddle;
(display "c. all people supervised by Ben Bitdiddle\n")
(supervisor ?name (Bitdiddle Ben))j

; b. the names and jobs of all people in accounting division
(display "b. the names and jobs of all people in accounting division\n")
(job ?name (accounting . ?x))

; c. the names and addresses of all people who live in Slumerville
(display "c. the names and address of all people who live in Slumerville\n")
(address ?name (Slumerville . ?address))
