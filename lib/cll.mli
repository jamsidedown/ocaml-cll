type 'a node = private {
  value: 'a;
  mutable left: 'a node;
  mutable right: 'a node;
}

type 'a cll = private {
  mutable head : 'a node option;
  mutable length: int;
}

val add : 'a cll -> 'a -> unit
val pop : 'a cll -> 'a option
val next : 'a cll -> unit
val prev : 'a cll -> unit
val init : 'a list -> 'a cll
val to_list : 'a cll -> 'a list
val seek : 'a cll -> 'a -> bool