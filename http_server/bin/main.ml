open Unix

let read_file (filename:string) =
  let ic = open_in filename in
  let n = in_channel_length ic in
  let data = really_input_string ic n in
  close_in ic;
  data

let handle_connection (descriptor:file_descr) =
  let ic = in_channel_of_descr descriptor in
  let oc = out_channel_of_descr descriptor in
  let response_body = try read_file "index.html" with _ -> "File not found" in
  output_string oc "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n";
  output_string oc response_body;
  flush oc;
  close_in ic;
  close_out oc

let create_server (port:file_perm) =
  let sockaddr = ADDR_INET (inet_addr_loopback, port) in
  let sock = socket PF_INET SOCK_STREAM 0 in
  setsockopt sock SO_REUSEADDR true;
  bind sock sockaddr;
  listen sock 5;
  while true do
    let (descriptor, _caller) = accept sock in
    Thread.create handle_connection descriptor |> ignore
  done;;

print_endline "Server running on localhost 3000... ";
create_server 3000
