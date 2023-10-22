# ocaml-cll
OCaml circular linked list library

[![build and test](https://github.com/jamsidedown/ocaml-cll/actions/workflows/main.yml/badge.svg)](https://github.com/jamsidedown/ocaml-cll/actions/workflows/main.yml)

## Requirements

- OCaml
- opam
- Dune

```sh
$ ocaml --version
The OCaml toplevel, version 5.1.0

$ opam --version
2.1.5

$ dune --version
3.11.0
```

## Setup

Install dependencies
```sh
opam install . --deps-only --with-test -y
```

Build code
```sh
dune build
```

## Testing

Run unit tests
```sh
$ dune test
.................
Ran: 17 tests in: 0.11 seconds.
OK
```

Check code coverage
```sh
dune test --instrument-with bisect_ppx --force

# show coverage summary
bisect-ppx-report summary

# create html coverage report
bisect-ppx-report html
```

## Usage

```ocaml
let cll = Cll.init [1; 2; 3; 4; 5; 6];;
(* 
 head
  |
  V
  1
6   2
5   3
  4
*)

Printf.printf "%i\n" cll.length;;
(* prints 6 *)

match cll.head with
| Some node -> Printf.printf "%i\n" node.value
| None -> ();;
(* prints 1 *)

Cll.next cll;;
(*
 head
  |
  V
  2
1   3
6   4
  5
*)

Cll.prev cll;;
Cll.prev cll;;
(*
 head
  |
  V
  6
5   1
4   2
  3
*)

Cll.add cll 7;;
(*
 head
  |
  V
  7
6   1
5   2
 4 3
*)

match Cll.pop cll with
| Some node -> Printf.printf "%i\n" node
| None -> ();;
(* prints 7 *)
(*
 head
  |
  V
  6
5   1
4   2
  3
*)

Printf.printf "%b\n" (Cll.seek cll 3);;
(* prints true *)
(*
 head
  |
  V
  3
2   4
1   5
  6
*)

Cll.to_list cll;;
(* returns [3; 4; 5; 6; 1; 2] *)

```

## Running examples

### Codewars: Josephus problem

From the project's root directory:

```sh
# intall utop
$ opam install utop

# install cll dev with opam
$ opam install .

# run the josphus_problem.ml toplevel script
$ utop examples/josephus_problem.ml
4
```
