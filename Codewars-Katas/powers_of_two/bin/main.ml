(* 

Complete the function that takes a non-negative integer n as input, and returns a list of all the powers of 2 with the exponent ranging from
0 to n inclusive.

Examples:

n = 0  ==> [1]
n = 1  ==> [1, 2]
n = 2  ==> [1, 2, 4] 

*)

let powers_of_two (n:int) : int list = 
  List.init (n + 1) ((lsl) 1)

let a = powers_of_two 0
let b = powers_of_two 1
let c = powers_of_two 2

let () = List.iter (Printf.printf "%d ") a
let () = print_endline("")
let () = List.iter (Printf.printf "%d ") b
let () = print_endline("")
let () = List.iter (Printf.printf "%d ") c
let () = print_endline("")
