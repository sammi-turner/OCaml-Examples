(* 

Complete the function that takes a non-negative integer n as input, and returns a list of all the powers of 2 with the exponent ranging from
0 to n inclusive.

Examples:

n = 0  ==> [1]
n = 1  ==> [1, 2]
n = 2  ==> [1, 2, 4] 

*)

let powersOfTwo (n:int) = List.init (n + 1) ((lsl) 1)

let a = powersOfTwo 0
let b = powersOfTwo 1
let c = powersOfTwo 2

let () = List.iter (Printf.printf "%d ") a
let () = print_endline("")
let () = List.iter (Printf.printf "%d ") b
let () = print_endline("")
let () = List.iter (Printf.printf "%d ") c
let () = print_endline("")
