let fizzbuzz (n:int) : unit =
  for i = 1 to n do
    match i mod 3, i mod 5 with
    | 0, 0 -> print_endline "FizzBuzz"
    | 0, _ -> print_endline "Fizz"
    | _, 0 -> print_endline "Buzz"
    | _, _ -> Printf.printf "%d\n" i
  done;;

fizzbuzz 100
