# ocaml-cll
OCaml circular linked list library

[![build and test](https://github.com/jamsidedown/ocaml-cll/actions/workflows/main.yml/badge.svg)](https://github.com/jamsidedown/ocaml-cll/actions/workflows/main.yml)

[Documentation is available here](https://robanderson.dev/ocaml-cll/cll/Cll)

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
