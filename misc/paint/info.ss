(module info (lib "infotab.ss" "setup")
  (define name "SICP")
  (define blurb
    (list '(div "The SICP Picture Language.")))
  (define primary-file "sicp.ss")
  (define doc.txt "doc.txt")
  (define categories '(media))

  (define compile-omit-files
    '("einstein.gif"
      "einstein.pgm"
      "example.scm"
      "hend.scm"
      "hutils.scm"
      "mit-support.scm"
      "prmpnt.scm"
      "psgo.scm"
      "primitives.scm"
      "mit-macros.scm")))