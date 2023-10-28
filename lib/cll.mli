(* type 'a node = private {
  value : 'a;
  mutable left : 'a node;
  mutable right : 'a node;
} *)

(* type 'a cll = private {
  mutable head : 'a node option;
  mutable length : int
} *)

type 'a t

val add : 'a t -> 'a -> unit
val pop : 'a t -> 'a option
val next : 'a t -> unit
val prev : 'a t -> unit
val init : 'a list -> 'a t
val to_list : 'a t -> 'a list
val find: 'a t -> 'a -> bool
val seek : 'a t -> 'a -> bool
val head : 'a t -> 'a option
val length : 'a t -> int
