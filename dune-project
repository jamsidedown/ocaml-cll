(lang dune 3.10)

(name cll)

(generate_opam_files true)

(source
 (github jamsidedown/ocaml-cll))

(authors "Rob Anderson (jamsidedown)")

(maintainers "Rob Anderson (jamsidedown)")

(license MIT)

(documentation https://github.com/jamsidedown/ocaml-cll)

(package
 (name cll)
 (synopsis "Circular linked list")
 (description "Mutable circular doubly linked list with minimal operations")
 (depends
  (ocaml (>= 4.12.0))
  (dune (>= 3.0.0))
  (ounit2 (and :with-test (>= 2.2.0)))
  (bisect_ppx (and :with-test (>= 2.0.0))))
 (tags
  ("circular linked list")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
