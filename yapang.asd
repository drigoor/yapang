;;;; yapang.lisp

(asdf:defsystem #:yapang
  :description "Yet Another Pang"
  :author "Rodrigo Correia (drigoor)"
  :depends-on (#:sketch
               #:easing)
  :serial t
  :components ((:file "package")
               (:file "main")))
