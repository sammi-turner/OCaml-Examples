(*

The imported function in this example is "greet".
The greet function is defined in "demo.ml".
To use the greet function in another file, we preface its name with the capitalised name of the file its from.

*)

let greeting = Demo.greet "Joe!"
let () = print_endline greeting
