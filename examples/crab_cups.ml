(* https://adventofcode.com/2020/day/23 *)

let parse (cups: string) : int list =
  cups
  |> String.to_seq
  |> List.of_seq
  |> List.map int_of_char
  |> List.map (fun x -> x - (int_of_char '0'));;

let pick_up (cups: int Cll.t) : int list =
  match Cll.pop cups :: Cll.pop cups :: Cll.pop cups :: [] with
  | [Some a; Some b; Some c] -> [c; b; a]
  | _ -> assert false;;

let rec insert (cups: int Cll.t) = function
  | [] -> ()
  | head :: tail ->
    Cll.add cups head;
    insert cups tail;;

let play (turns: int) (cup_list: int list) : int Cll.t =
  let cups = Cll.init cup_list in
  let min_cup = List.fold_left min 10 cup_list in
  let max_cup = List.fold_left max 0 cup_list in
  let rec seek (n: int) : unit =
    if n < min_cup then seek max_cup
    else if Cll.find cups n then ()
    else seek (n - 1)
  in
  let rec recurse (turns: int) : int Cll.t =
    let start =
      match Cll.head cups with
      | None -> assert false
      | Some n -> n
    in
    match turns with
    | 0 -> cups
    | _ ->
      Cll.find cups start |> ignore;
      Cll.next cups;
      let picked_up = pick_up cups in
      seek (start - 1);
      insert cups picked_up;
      Cll.find cups start |> ignore;
      Cll.next cups;
      recurse (turns - 1)
  in
  recurse turns;;

let part_one (cup_list: int list) : int =
  let cups = play 100 cup_list in
  Cll.find cups 1 |> ignore;
  match Cll.to_list cups with
  | [] -> assert false
  | _ :: tail ->
    tail
    |> List.map string_of_int
    |> String.concat ""
    |> int_of_string;;

let[@tail_mod_cons] rec range (start: int) (stop: int) : int list =
  if start > stop then [] else start :: range (start + 1) stop;;

let part_two (cup_list: int list) : int =
  let max_cup = List.fold_left max 0 cup_list in
  let full_cup_list = cup_list @ (range (max_cup + 1) 1_000_000) in
  let cups = play 10_000_000 full_cup_list in
  Cll.find cups 1 |> ignore;
  Cll.next cups;
  match (Cll.pop cups, Cll.pop cups) with
  | Some a, Some b -> a * b
  | _ -> assert false;;

parse "389125467"
|> part_one
|> Printf.printf "part one: %i\n%!";;

(* parse "389125467"
|> part_two
|> Printf.printf "part two: %i\n";; *)