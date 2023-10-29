type 'a t
(** The type of circular linked lists with elements of type ['a]. *)

val init : 'a list -> 'a t
(** [Cll.init lst] initialises a circular linked list from the list [lst].
    After initialisation, the element at the start of the original list will be
    at the head of the circular linked list.

    {[
        let cll = Cll.init [ 1; 2; 3; 4 ]
        (*
         head
          |
          V
          1
        4   2
          3
        *)
    ]}
*)

val head : 'a t -> 'a option
(** [Cll.head cll] returns the value at the current head of the circular linked
    list, or None if the list is empty.

    {[
        let cll = Cll.init [ 1; 2; 3; 4 ] in
        Cll.head cll
        (* int option = Some 1 *)
    ]}
*)

val length : 'a t -> int
(** [Cll.length cll] returns the number of values stored in the circular linked
    list. The length is updated when values are added and removed, so calling
    [Cll.length] returns in [O(1)].

    {[
        let cll = Cll.init [ 1; 2; 3; 4 ] in
        Cll.length cll
        (* int = 4 *)
    ]}
*)

val next : 'a t -> unit
(** [Cll.next cll] moves the head of the circular linked list to the node to
    the right of the current head. Equivalent of moving the head clockwise on
    a clock face, or moving the entire clock face anticlockwise.

    {[
        let cll = Cll.init [ 1; 2; 3; 4 ] in
        Cll.next cll
        (*
             head
              |
              V
              2
            1   3
              4
        *)
    ]}
*)

val prev : 'a t -> unit
(** [Cll.prev cll] moves the head of the circular linked list to the node to
    the left of the current head. Equivalent of moving the head anticlockwise on
    a clock face, or moving the entire clock face clockwise.

    {[
        let cll = Cll.init [ 1; 2; 3; 4 ] in
        Cll.prev cll
        (*
             head
              |
              V
              4
            3   1
              2
        *)
    ]}
*)

val add : 'a t -> 'a -> unit
val pop : 'a t -> 'a option

val find: 'a t -> 'a -> bool
val seek : 'a t -> 'a -> bool

val to_list : 'a t -> 'a list
