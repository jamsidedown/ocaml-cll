# ocaml-cll
OCaml circular linked list library

[![build and test](https://github.com/jamsidedown/ocaml-cll/actions/workflows/main.yml/badge.svg)](https://github.com/jamsidedown/ocaml-cll/actions/workflows/main.yml)

[Cll documentation](https://robanderson.dev/ocaml-cll/cll)

## Installation

```sh
$ opam install cll
```

## Usage

To be run in the ocaml toplevel

```ocaml
let cll = Cll.init [ 1; 2; 3; 4; 5; 6 ];;

Cll.head cll;;
(* int option = Some 1 *)

Cll.length cll;;
(* int = 6 *)

Cll.next cll;;
Cll.head cll;;
(* int option = Some 2 *)

Cll.prev cll;;
Cll.prev cll;;
Cll.head cll;;
(* int option = Some 6 *)

Cll.add cll 7;;
Cll.head cll;;
(* int option = Some 7 *)

Cll.pop cll;;
(* int option = Some 7 *)
Cll.head cll;;
(* int option = Some 1 *)

Cll.find cll 4;;
(* bool = true *)
Cll.head cll;;
(* int option = Some 4 *)

Cll.to_list cll;;
(* int list = [4; 5; 6; 1; 2; 3] *)
```

## Development requirements

- OCaml
- Opam
- Dune

```sh
$ ocaml --version
The OCaml toplevel, version 5.1.0

$ opam --version
2.1.5

$ dune --version
3.11.0
```

## Development setup

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
open _coverage/index.html
```

## Running examples

There aren't many uses I'm aware of for a circular linked list, but I have found two programming puzzles where it's been handy.

### Prerequisites

From the project's root directory:

```sh
# install utop
$ opam install utop
```

### Codewars: Josephus problem

```sh
# run the josphus_problem.ml toplevel script
$ dune utop . -- examples/josephus_problem.ml
4
```

### Advent of Code 2020 day 23: Crab Cups

By default only part one of this puzzle will run, as part two takes about 40 seconds on my laptop when running with utop.

To enable part two, uncomment the last three lines in `examples/crab_cups.ml`.

```sh
# run part one of the crab cups toplevel script
$ dune utop . -- examples/crab_cups.ml
part one: 67384529
```
