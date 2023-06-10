open Utils

let lst = ["Oh";"Denny";"Denny";"Denny";"boy"]
let count = count_string_instances lst "Denny"
let () = Printf.printf "%d\n" count