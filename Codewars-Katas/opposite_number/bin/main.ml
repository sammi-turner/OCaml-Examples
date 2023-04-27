(* 

Given an integer or a floating-point number, find its opposite. 

Examples:

1 => -1
14 => -14
-34 => 34

*)

let opposite (number : int) : int =
  if number = 0 then 0 else (-1) * number

let test0 = opposite 1
let test1 = opposite 14
let test2 = opposite (-34)

let () = Printf.printf "%d\n" test0
let () = Printf.printf "%d\n" test1
let () = Printf.printf "%d\n" test2
