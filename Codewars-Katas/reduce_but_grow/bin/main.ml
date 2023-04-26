(* 

Given a non-empty list of integers, return the result of multiplying the values together.

Examples:

[1; 2; 3; 4] => 1 * 2 * 3 * 4 = 24
[2; 3; 5] => 2 * 3 * 5 = 30
[7; 7] => 7 * 7 = 49 

*)

let grow = List.fold_left ( * ) 1

let l0 = [1; 2; 3; 4]
let l1 = [2; 3; 5]
let l2 = [7; 7]

let r0 = grow l0
let r1 = grow l1
let r2 = grow l2

let () = Printf.printf("%d\n") r0
let () = Printf.printf("%d\n") r1
let () = Printf.printf("%d\n") r2
