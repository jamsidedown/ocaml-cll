(lang dune 3.10)

(name cll)

(generate_opam_files true)

(source
 (github jamsidedown/ocaml-cll))

(authors "Rob Anderson <opensource@robanderson.dev>")

(maintainers "Rob Anderson <opensource@robanderson.dev>")

(license MIT)

(documentation
  https://robanderson.dev/ocaml-cll)

(package
 (name cll)
 (synopsis "Mutable circular doubly linked list with minimal operations")
 (description "
  
 ")
 (depends
  ocaml
  dune
  (ounit2 :with-test)
  (bisect_ppx :with-test))
 (tags
  ("circular linked list")))
