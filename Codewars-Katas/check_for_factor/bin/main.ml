(* 

Write a function should test if a number is a factor of a base.

Return true if it is a factor or false if it is not.

Factors are numbers you can multiply together to get another number.

Examples:

2 and 3 are factors of 6 because: 2 * 3 = 6

2 is not a factor of 7 because: 7 mod 2 = 1

Note: base is a non-negative number, factor is a positive number.

*)

let check_for_factor (base: int) (factor: int): bool = (base mod factor) == 0

let test0 = check_for_factor 10 2
let test1 = check_for_factor 63 7
let test2 = check_for_factor 9 2
let () = Printf.printf "%b\n" test0
let () = Printf.printf "%b\n" test1
let () = Printf.printf "%b\n" test2