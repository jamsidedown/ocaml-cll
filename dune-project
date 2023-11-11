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
 (synopsis "Mutable circular doubly linked list")
 (description "A mutable circular doubly linked list designed for O(1) insertion and removal, O(n) traversal, and close to O(1) search using a backing hashtable.")
 (depends
  (ocaml (>= 4.05))
  dune
  (ounit2 :with-test)
  (bisect_ppx :with-test))
 (tags
  ("circular linked list")))
