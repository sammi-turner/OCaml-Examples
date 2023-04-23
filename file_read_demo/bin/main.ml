let read_file_into_string filename =
  let ic = open_in filename in
  let n = in_channel_length ic in
  let s = Bytes.create n in
  really_input ic s 0 n;
  close_in ic;
  Bytes.to_string s

let file = "example.txt"
let content = read_file_into_string file
let () = print_endline content
