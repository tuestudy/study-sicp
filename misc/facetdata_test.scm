
; data
(define facetrst
  (list
   (list "main/-/sub1" 1)
   (list "main/-/sub1/-/ssub1" 1)
   (list "main/-/sub1/-/ssub2" 3)
   (list "main/-/sub2/-/ssub1" 2)
   (list "main/-/sub2/-/ssub2" 1)
   (list "main/-/sub2/-/ssub3" 1)
   (list "main/-/sub3" 2)
   (list "main/-/sub3/-/ssub1" 1)
   (list "main/-/unspecified" 10)))

(define facetrst2
  (list
   (list "main/-/sub1" 1)
   (list "main/-/sub1/-/ssub1" 1)
   (list "main/-/sub1/-/ssub2" 3)
   (list "main/-/sub2/-/ssub1" 2)
   (list "main/-/sub2/-/ssub2" 1)
   (list "main/-/sub2/-/ssub3" 1)
   (list "main/-/sub3" 2)
   (list "main/-/sub3/-/ssub1" 1)
   (list "main/-/unspecified" 10)
   (list "main/-/unspecified/-/unknown1" 10)
   (list "main/-/unspecified/-/unknown2" 10)
   (list "main/-/unspecified/-/unknown3" 10)))

; expected result
(define expectedrst
  '("main" 
    (("sub1" (("ssub1" () 1)
              ("ssub2" () 3)) 5)
     ("sub2" (("ssub1" () 2)
              ("ssub2" () 1)
              ("ssub3" () 1)) 4)
     ("sub3" (("ssub1" () 1)) 3)
     ("unspecified" () 10)) 
    22))

