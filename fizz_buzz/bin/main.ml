let fizzbuzz n =
  for i = 1 to n do
    if i mod 3 = 0 && i mod 5 = 0 then
      print_endline "FizzBuzz"
    else if i mod 3 = 0 then
      print_endline "Fizz"
    else if i mod 5 = 0 then
      print_endline "Buzz"
    else
      Printf.printf "%d\n" i
  done

let () = fizzbuzz 100