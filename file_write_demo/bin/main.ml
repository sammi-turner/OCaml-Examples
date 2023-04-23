let file = "example.txt"
let message = "Mary had a little lamb."

let () =
  let oc = open_out file in
  Printf.fprintf oc "%s\n" message;
  close_out oc;