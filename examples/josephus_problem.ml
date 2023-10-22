#require "cll"

(* https://www.codewars.com/kata/555624b601231dc7a400017a *)

let rec range (start: int) (stop: int) : int list =
  if start > stop then [] else start :: range (start + 1) stop;;

(* n is number of people in circle, every kth person is eliminated *)
let josephus (n: int) (k: int) : int =
  let cll = (range 1 n) |> Cll.init in
  let rec recurse : int -> int = function
    | 1 ->
      (match Cll.pop cll with
        | None -> assert false
        | Some value -> if cll.head = None then value else recurse k)
    | x when x < 0 -> assert false
    | x ->
      Cll.next cll;
      recurse (x - 1)
  in
  recurse k;;

josephus 7 3 |> Printf.printf "%i\n";;
