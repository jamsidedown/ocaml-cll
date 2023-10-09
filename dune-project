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
 (description "Circular doubly linked list with minimal operations")
 (depends ocaml dune)
 (tags
  ("circular linked list")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
