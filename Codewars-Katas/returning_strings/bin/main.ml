(* 

Make a function that will return a greeting statement that uses an input; your program should return, "Hello, <name> how are you doing today?"

*)

let greet (name:string) = "Hello, " ^ name ^ " how are you doing today?"
let () = print_endline (greet "Mary")
