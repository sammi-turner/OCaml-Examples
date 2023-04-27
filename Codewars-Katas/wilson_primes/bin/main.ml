(*

Wilson primes satisfy the following condition. Let P represent a prime number.

Then,

((P-1)! + 1) / (P * P)

should give a whole number.

Your task is to create a function that returns true if the given number is a Wilson prime.

*)

let i_am_a_wilson_prime n = n == 5 || n == 13 || n == 563

let test0 = i_am_a_wilson_prime 2
let test1 = i_am_a_wilson_prime 3
let test2 = i_am_a_wilson_prime 5

let () = Printf.printf "%b\n" test0
let () = Printf.printf "%b\n" test1
let () = Printf.printf "%b\n" test2