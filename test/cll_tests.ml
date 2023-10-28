open OUnit2

let create_empty_list _ =
  let cll = Cll.init [] in
  assert_equal (Cll.length cll) 0;
  assert_equal (Cll.head cll) None

let create_init _ =
  let cll = Cll.init [ 1; 2; 3 ] in
  assert_equal (Cll.length cll) 3;
  assert_equal (Cll.head cll) (Some 1)

let initialise_tests =
  "initialise" >::: [
    "from empty list" >:: create_empty_list;
    "from list of ints" >:: create_init;
  ]

let add_to_empty _ =
  let cll = Cll.init [] in
  Cll.add cll 1;
  assert_equal (Cll.length cll) 1;
  assert_equal (Cll.head cll) (Some 1)

let add_to_list _ =
  let cll = Cll.init [ 1; 2; 3 ] in
  Cll.add cll 4;
  assert_equal (Cll.length cll) 4;
  assert_equal (Cll.head cll) (Some 4)

let add_multiple _ =
  let cll = Cll.init [] in
  Cll.add cll 1;
  Cll.add cll 2;
  Cll.add cll 2;
  Cll.add cll 3;
  assert_equal (Cll.length cll) 4;
  assert_equal (Cll.head cll) (Some 3)

let add_tests =
  "add" >::: [
    "to empty list" >:: add_to_empty;
    "to list of ints" >:: add_to_list;
    "multiple to empty list" >:: add_multiple;
  ]

let pop_from_empty _ =
  let cll = Cll.init [] in
  assert_equal (Cll.pop cll) None;
  assert_equal (Cll.head cll) None

let pop_init _ =
  let cll = Cll.init [ 1; 2; 3; 4 ] in
  assert_equal (Cll.pop cll) (Some 1);
  assert_equal (Cll.length cll) 3;
  assert_equal (Cll.head cll) (Some 2)

let pop_from_single _ =
  let cll = Cll.init [ 1 ] in
  assert_equal (Cll.pop cll) (Some 1);
  assert_equal (Cll.length cll) 0;
  assert_equal (Cll.head cll) None

let pop_all _ =
  let cll = Cll.init [ 1; 2; 2; 3 ] in
  assert_equal (Cll.pop cll) (Some 1);
  assert_equal (Cll.pop cll) (Some 2);
  assert_equal (Cll.pop cll) (Some 2);
  assert_equal (Cll.pop cll) (Some 3);
  assert_equal (Cll.pop cll) None

let pop_tests =
  "pop" >::: [
    "from empty list" >:: pop_from_empty;
    "from list of ints" >:: pop_init;
    "from list with single value" >:: pop_from_single;
    "all from list" >:: pop_all;
  ]

let next_on_empty _ =
  let cll = Cll.init [] in
  Cll.next cll;
  assert_equal (Cll.length cll) 0;
  assert_equal (Cll.head cll) None

let next_on_list _ =
  let cll = Cll.init [ 1; 2; 3; 4 ] in
  Cll.next cll;
  assert_equal (Cll.length cll) 4;
  match (Cll.head cll) with
  | None -> assert false
  | Some n ->
    assert_equal n 2

let next_tests =
  "next" >::: [
    "on empty list" >:: next_on_empty;
    "on list of ints" >:: next_on_list
  ]

let prev_on_empty _ =
  let cll = Cll.init [] in
  Cll.prev cll;
  assert_equal (Cll.length cll) 0;
  assert_equal (Cll.head cll) None

let prev_on_list _ =
  let cll = Cll.init [ 1; 2; 3; 4 ] in
  Cll.prev cll;
  assert_equal (Cll.length cll) 4;
  match (Cll.head cll) with
  | None -> assert false
  | Some n ->
    assert_equal n 4

let prev_tests =
  "previous" >::: [
    "on empty list" >:: prev_on_empty;
    "on list of ints" >:: prev_on_list
  ]

let to_list_from_empty _ =
  let cll = Cll.init [] in
  assert_equal (Cll.to_list cll) []

let to_list_init _ =
  let cll = Cll.init [ 1; 2; 3; 4 ] in
  assert_equal (Cll.to_list cll) [ 1; 2; 3; 4 ]

let to_list_tests =
  "to list" >::: [
    "from empty list" >:: to_list_from_empty;
    "from list of ints" >:: to_list_init;
  ]

let find_on_empty _ =
  let cll = Cll.init [] in
  assert_equal (Cll.find cll 1) false

let find_in_list _ =
  let cll = Cll.init [ 1; 2; 3; 4 ] in
  assert_equal (Cll.find cll 3) true;
  assert_equal (Cll.head cll) (Some 3)

let find_in_repeating_list _ =
  let cll = Cll.init [ 1; 2; 2; 3 ] in
  assert_equal (Cll.find cll 2) true;
  assert_equal (Cll.head cll) (Some 2)

let find_when_not_in_list _ =
  let cll = Cll.init [ 1; 2; 3; 4 ] in
  assert_equal (Cll.find cll 5) false;
  assert_equal (Cll.head cll) (Some 1)

let find_tests =
  "find" >::: [
    "on empty list" >:: find_on_empty;
    "in list of ints" >:: find_in_list;
    "in list with repeating values" >:: find_in_repeating_list;
    "when value not in list" >:: find_when_not_in_list;
  ]

let seek_on_empty _ =
  let cll = Cll.init [] in
  assert_equal (Cll.seek cll 1) false

let seek_when_contains_value _ =
  let cll = Cll.init [ 1; 2; 3; 4 ] in
  assert_equal (Cll.seek cll 2) true;
  assert_equal (Cll.length cll) 4;
  match (Cll.head cll) with
  | None -> assert false
  | Some n ->
    assert_equal n 2

let seek_when_doesn't_contain_value _ =
  let cll = Cll.init [ 1; 2; 3; 4 ] in
  assert_equal (Cll.seek cll 5) false;
  assert_equal (Cll.length cll) 4;
  match (Cll.head cll) with
  | None -> assert false
  | Some n ->
    assert_equal n 1

let seek_when_already_at_value _ =
  let cll = Cll.init [ 1; 2; 3; 4 ] in
  assert_equal (Cll.seek cll 1) true;
  match (Cll.head cll) with
  | None -> assert false
  | Some n -> assert_equal n 1

let seek_tests =
  "seek" >::: [
    "on empty list" >:: seek_on_empty;
    "on list containing value" >:: seek_when_contains_value;
    "on list not containing value" >:: seek_when_doesn't_contain_value;
    "on list with head already at value" >:: seek_when_already_at_value;
  ]

let tests =
  "Test" >::: [
    initialise_tests;
    add_tests;
    pop_tests;
    next_tests;
    prev_tests;
    to_list_tests;
    find_tests;
    seek_tests;
  ]

let _ = run_test_tt_main tests
