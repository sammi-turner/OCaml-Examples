let read_file name =
  try
    let channel = open_in name in
    let contents = really_input_string channel (in_channel_length channel) in
    close_in channel;
    contents
  with
    | Sys_error _ -> ""

let content = read_file "dog.txt"
let () = print_endline content
