(*

Write a program that finds the summation of every number from 1 to num.

The number will always be a positive integer greater than 0.

Example:

2 => 3
3 => 6
8 => 36

*)

let rec summation (n:int) : int =
  if n <= 0 then 0
  else n + summation (n - 1)

let test0 = summation 2
let test1 = summation 3
let test2 = summation 8;;

Printf.printf "%d\n%d\n%d\n" test0 test1 test2
