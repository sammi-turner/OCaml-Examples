(*
   
Write a function that takes an integer and returns a square of plus symbols as long and wide as the integer. 

The integer will be a whole number between 1 and 50.

Example:

n = 3, so I expect a 3x3 square back just like below as a string.

+++
+++
+++

*)

let generate_shape (n: int) : string =
  List.init n (fun _ -> String.make n '+')
  |> String.concat "\n"

let test0 = generate_shape 5
let test1 = generate_shape 3
let test2 = generate_shape 1

let () = Printf.printf "%s\n%s\n%s\n" test0 test1 test2
