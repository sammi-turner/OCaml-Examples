(*

Write a function that takes a string which will consist of a first and last name separated by a space. 

The function should return a string consisting of a capital letter initial for the first name, followed by a period, followed by a capital letter initial for the last name.

Examples:

"Joe Bloggs" => "J.B"
"Jane Smith" => "J.S"
"Tim Cook" => "T.C"

*)

let abbrev_name name =
  match String.split_on_char ' ' name with
  | [first_name; last_name] ->
    let first_initial = String.sub first_name 0 1 |> String.uppercase_ascii in
    let last_initial = String.sub last_name 0 1 |> String.uppercase_ascii in
    first_initial ^ "." ^ last_initial
  | _ -> ""

let test0 = abbrev_name "Joe Bloggs"
let test1 = abbrev_name "Jane Smith"
let test2 = abbrev_name "Tim Cook"

let () = Printf.printf "%s\n%s\n%s\n" test0 test1 test2
