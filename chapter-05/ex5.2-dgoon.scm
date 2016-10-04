(data-paths
 (registers
  ((name n))
  ((name p)
   (buttons ((name p<-d) (source (register d))))
   (buttons ((name p<-1) (source (const 1)))))
  ((name c)
   (buttons ((name c<-d) (source (register d))))
   (buttons ((name c<-1) (source (const 1)))))
  ((name d)
   (buttons ((name c++) (source (operation inc))))
   (buttons ((name p*c) (source (operation mult))))))

 (operations
  ((name inc)
   (inputs (register c) (const 1)))
  ((name mult)
   (inputs (register p) (register c)))
  ((name >)
   (inputs (register c) (register n))))

 (controller
  factorial-init
  (p<-1)
  (c<-1)
  factorial
  (test >)
  (branch (label factorial-done))
  (c++)
  (c<-d)
  (p*c)
  (p<-d)
  (goto (label factorial))
  factorial-done))

;; or
(controller
 (assign n (op read))
 (assign p (const 1))
 (assign c (const 1))
 factorial
 (test (op =) (reg c) (reg n))
 (branch (label factorial-done))
 (assign p (op *) (reg p) (reg count))
 (assign count (op +) (reg count) (const 1))
 (goto (label factorial))
 factorial-done)