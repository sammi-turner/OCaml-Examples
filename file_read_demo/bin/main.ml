let read_file (name:string) : string option =
  try
    let channel = open_in name in
    let contents = really_input_string channel (in_channel_length channel) in
    close_in channel;
    Some (contents)
  with
    | Sys_error _ -> None

let print_file_contents (x:string option) =
  match x with
  | Some x -> Printf.printf "File contents : %s\n" x
  | None -> Printf.printf "That file does not exist in the working directory.\n"

let file = "example.txt"
let content = read_file file;;
print_file_contents content