let rec factorial = function
  | 0 -> 1
  | n -> n * factorial (n - 1)

let () = Printf.printf "%i %i %i %i %i\n" (factorial 0) (factorial 1) (factorial 2) (factorial 3) (factorial 4)
