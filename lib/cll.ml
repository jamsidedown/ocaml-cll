type 'a node = {
  value : 'a;
  mutable left : 'a node;
  mutable right : 'a node
}

type 'a t = {
  mutable head : 'a node option;
  mutable length : int;
  lookup: ('a, 'a node list) Hashtbl.t;
}

let add (lst : 'a t) (elem : 'a) : unit =
  match lst.head with
  | None ->
    let rec first_node = {
      value = elem;
      left = first_node;
      right = first_node
    } in
    lst.head <- Some first_node;
    lst.length <- 1;
    Hashtbl.add lst.lookup elem [first_node]
  | Some head ->
    (* rotate head ccw, insert new node at head *)
    let next = head.right in
    let new_node = {
      value = elem;
      left = head;
      right = next
    } in
    head.right <- new_node;
    next.left <- new_node;
    lst.head <- Some new_node;
    lst.length <- lst.length + 1;
    match Hashtbl.find_opt lst.lookup elem with
    | None -> Hashtbl.add lst.lookup elem [new_node]
    | Some nodes -> Hashtbl.replace lst.lookup elem (new_node :: nodes)

let pop (lst : 'a t) : 'a option =
  let pop_node (node: 'a node) : unit =
    match Hashtbl.find_opt lst.lookup node.value with
    | None | Some [] -> () [@coverage off] (* should never reach here *)
    | Some [_] -> Hashtbl.remove lst.lookup node.value
    | Some nodes ->
      nodes
      |> List.filter (fun n -> not (n == node))
      |> Hashtbl.replace lst.lookup node.value
  in
  match lst.head with
  | None -> None
  | Some head when head.left == head ->
    lst.head <- None;
    lst.length <- 0;
    Hashtbl.remove lst.lookup head.value;
    Some head.value
  | Some head ->
    let { value; left; right } = head in
    left.right <- right;
    right.left <- left;
    lst.head <- Some right;
    lst.length <- lst.length - 1;
    pop_node head;
    Some value

let next (lst : 'a t) : unit =
  match lst.head with
  | None -> ()
  | Some head -> lst.head <- Some head.right

let prev (lst : 'a t) : unit =
  match lst.head with
  | None -> ()
  | Some head -> lst.head <- Some head.left

let init (lst : 'a list) : 'a t =
  let c_list = {
    head = None;
    length = 0;
    lookup = Hashtbl.create 1024;
  } in
  let rec recurse (remaining : 'a list) : unit =
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
    c_list

let to_list (lst : 'a t) : 'a list =
  let rec recurse (start : 'a node) : 'a list =
    match lst.head with
    | None -> [] [@coverage off] (* should never reach here *)
    | Some head when head == start -> []
    | Some head ->
      next lst;
      head.value :: recurse start
  in
  match lst.head with
  | None -> []
  | Some head ->
    next lst;
    head.value :: recurse head

let find (lst: 'a t) (value: 'a) : bool =
  match Hashtbl.find_opt lst.lookup value with
  | None -> false
  | Some [] -> false [@coverage off] (* should never reach here *)
  | Some (first :: _) ->
    lst.head <- Some first;
    true

let seek (lst : 'a t) (value : 'a) : bool =
  let rec recurse (start : 'a node) : bool =
    match lst.head with
    | None -> false [@coverage off] (* should never reach here *)
    | Some head when head == start -> false
    | Some head when head.value = value -> true
    | _ ->
      next lst;
      recurse start
  in
  match lst.head with
  | None -> false
  | Some head when head.value = value -> true
  | Some head ->
    next lst;
    recurse head

let length (lst: 'a t) : int =
  lst.length

let head (lst: 'a t) : 'a option =
  match lst.head with
  | None -> None
  | Some node -> Some node.value
