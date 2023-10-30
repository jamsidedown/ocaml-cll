(** A mutable circular linked list.

Designed for [O(1)] insertion and removal, [O(n)] traversal, and
close to [O(1)] search using a backing hashtable. *)

type 'a t
(** The type of circular linked lists with elements of type ['a]. *)

(** {1 Creation} *)

(** {2 init} *)

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

(** {1 Operations without side effects}
    These functions can safely be called without modifying the underlying
    circular linked list. *)

(** {2 head} *)

val head : 'a t -> 'a option
(** [Cll.head cll] returns the value at the current head of the circular linked
    list, or None if the list is empty.

    {[
        let cll = Cll.init [ 1; 2; 3; 4 ] in
        Cll.head cll
        (* int option = Some 1 *)
    ]}
*)

(** {2 length} *)

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

(** {2 to_list} *)

val to_list : 'a t -> 'a list
(** [Cll.to_list cll] traverses and returns a list of all of the values in the
    circular linked list in order starting at the [head].

    {[
        let cll = Cll.init [ 1; 2; 3; 4 ] in
        Cll.to_list cll
        (* int list = [1; 2; 3; 4] *)
    ]}
*)

(** {1 Traversal} *)

(** {2 next} *)

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

(** {2 prev} *)

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

(** {2 find} *)

val find: 'a t -> 'a -> bool
(** [Cll.find cll value] searches for a value in the circular linked list using
    the backing hashtable. If the value exists in the list, the head of the
    list will be set to that node, and [Cll.find] will return [true]. If the
    value isn't in the list, then the head of the list will not be changed, and
    [Cll.find] will return [false].
    If there is more than one matching value in the list, then the most
    recently added value will become the new head.
    This function is significantly faster than [Cll.seek] for large lists.

    {[
        let cll = Cll.init [ 1; 2; 3; 4 ] in
        Cll.find cll 3
        (* bool = true *)
        (*
             head
              |
              V
              3
            2   4
              1
        *)
    ]}
*)

(** {2 seek} *)

val seek : 'a t -> 'a -> bool
(** [Cll.seek cll value] searches for a value in the circular linked list by
    looking through the values in the list one by one, in order. If the value
    exists in the list, the head of the list will be set to that nde, and
    [Cll.seek] with return [true]. If the value isn't in the list, then the
    head of the list will set back to the original head, and [Cll.seek] will
    return [false].
    Because this function searches through in order one element at a time, if
    there is more than one matching value in the list, then the closest
    clockwise value will become the new head.
    This function is slower than [Cll.find] for large lists, and should be used
    when the order of the values in the list is important.

    {[
        let cll = Cll.init [ 1; 2; 3; 4 ] in
        Cll.find cll 3
        (* bool = true *)
        (*
             head
              |
              V
              3
            2   4
              1
        *)
    ]}
*)

(** {1 Modification} *)

(** {2 add} *)

val add : 'a t -> 'a -> unit
(** [Cll.add cll value] adds a new value to the circular linked list. The new
    value is inserted between the current head and the next value clockwise of
    the head. The new value becomes the new head of the list.
    If the value added is the first element in the list, both [next] and
    [previous] will also be the value being added.

    {[
        let cll = Cll.init [ 1; 2; 3; 4 ] in
        Cll.add cll 9
        (*
             head
              |
              V
              9
            1   2
             4 3
        *)
    ]}
*)

(** {2 pop} *)

val pop : 'a t -> 'a option
(** [Cll.pop cll] removes the element currently at the head of the circular
    linked list and returns the value.
    The [next] and [previous] values of the old head will then point to each
    other, and the [next] value will become the new head.
    If the list is empty, [Cll.pop] will return [None].

    {[
        let cll = Cll.init [ 1; 2; 3; 4; 5 ] in
        Cll.pop cll
        (* int option = Some 1 *)
        (*
             head
              |
              V
              2
            5   3
              4
        *)
    ]}
*)
