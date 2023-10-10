type 'a node = {
  value: 'a;
  mutable left: 'a node;
  mutable right: 'a node;
}

type 'a cll = {
  mutable head : 'a node option;
  mutable length: int;
}

let add (lst: 'a cll) (elem: 'a) : unit =
  match lst.head with
  | None ->
    let rec first_node = { value = elem; left = first_node; right = first_node} in
    lst.head <- Some first_node;
    lst.length <- 1;
  | Some head ->
    (* rotate head ccw, insert new node at head *)
    let next = head.right in
    let new_node = { value = elem; left = head; right = next } in
    head.right <- new_node;
    next.left <- new_node;
    lst.head <- Some new_node;
    lst.length <- lst.length + 1;;

let pop (lst: 'a cll) : 'a option =
  match lst.head with
  | None -> None
  | Some head when head.left == head ->
    lst.head <- None;
    lst.length <- 0;
    Some head.value
  | Some { value = value; left = left; right = right } ->
    left.right <- right;
    right.left <- left;
    lst.head <- Some right;
    lst.length <- lst.length - 1;
    Some value;;

let next (lst: 'a cll) : unit =
  match lst.head with
  | None -> ()
  | Some head -> lst.head <- Some head.right;;

let prev (lst: 'a cll) : unit =
  match lst.head with
  | None -> ()
  | Some head -> lst.head <- Some head.left;;

let init (lst: 'a list) : 'a cll =
  let c_list = { head = None; length = 0 } in
  let rec recurse (remaining: 'a list) : unit =
    match remaining with
    | [] -> next c_list
    | head :: tail ->
      add c_list head;
      recurse tail
  in
  match lst with
  | [] -> c_list
  | _ ->
    recurse lst;
    c_list;;

let to_list (lst: 'a cll) : 'a list =
  let rec recurse (start: 'a node) : 'a list =
    match lst.head with
    | None -> []
    | Some head when head == start -> []
    | Some head ->
      next lst;
      head.value :: recurse start
  in
  match lst.head with
  | None -> []
  | Some head ->
    next lst;
    head.value :: recurse head;;

let seek (lst: 'a cll) (value: 'a) : bool =
  let rec recurse (start: 'a node) : bool =
    match lst.head with
    | None -> false
    | Some head when head == start -> false
    | Some head when head.value = value -> true
    | _ ->
      next lst;
      recurse start
  in
  match lst.head with
  | None -> false
  | Some head ->
    next lst;
    recurse head;;
