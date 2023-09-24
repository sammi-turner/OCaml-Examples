let rec factorial = function
  | 0 -> 1
  | n -> n * factorial (n - 1)

let test0 = factorial 0
let test1 = factorial 1
let test2 = factorial 2
let test3 = factorial 3
let test4 = factorial 4

let () = Printf.printf "%i %i %i %i %i" test0 test1 test2 test3 test4
