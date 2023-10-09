# ocaml-cll
OCaml circular linked list library

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

## Testing

```sh
$ dune test
.................
Ran: 17 tests in: 0.11 seconds.
OK
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