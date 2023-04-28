(*
   
Write a function that takes a value (integer) and returns a list of its multiples up to another value (limit). 

If limit is a multiple of integer, it should be included as well. 

Only positive integers will be passed into the function.

The limit will always be higher than the base.

Examples:

2 and 6 => [2;4;6]
3 and 5 => [3]
4 and 20 => [4;8;12;16;20]

*)

let rec find_multiples (integer:int) (limit:int): int list =
  List.init (limit/ integer) (fun x -> (x + 1) * integer)

let test0 = find_multiples 2 6
let test1 = find_multiples 3 5
let test2 = find_multiples 4 20
