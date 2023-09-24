(*

Write a function that takes a list of numbers and returns the sum of all the positive elements.

Examples:

[] => 0
[0;-3] => 0
[1;-4;7;12] => 20

*)

let positive_sum (lst:int list) : int =
  let sum = ref 0 in
  List.iter (fun x -> if x > 0 then sum := !sum + x) lst;
  !sum

let test0 = positive_sum []
let test1 = positive_sum [0;-3]
let test2 = positive_sum [1;-4;7;12]
let () = Printf.printf "%d\n%d\n%d\n" test0 test1 test2
