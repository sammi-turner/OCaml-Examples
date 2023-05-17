open Utils

let print_file_contents (x:string option) =
  match x with
  | Some x -> Printf.printf "%s\n" x
  | None -> Printf.printf "That file does not exist in the working directory.\n"

let file = "example.txt"
let content = read_file file
let () = print_file_contents content