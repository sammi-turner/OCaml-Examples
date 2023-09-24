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

let () = Printf.printf "%d %d %d\n" (summation 2) (summation 3) (summation 8)
