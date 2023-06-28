let write_file (name:string) (content:string) : unit =
  let oc = open_out name in
  output_string oc content;
  close_out oc;;

write_file "example.txt" "Oh, hi Mark!"