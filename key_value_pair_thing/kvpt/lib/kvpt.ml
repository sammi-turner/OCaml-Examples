open Printf

let dq = "\""

let db_exists (s:string) : bool =
  let name = s ^ ".db" in
  Sys.file_exists name

let shell (s:string) : string =
  let tmp_file = "tmp_output.txt" in
  let command = s ^ " > " ^ tmp_file in
  let _ = Sys.command command in
  let ic = open_in tmp_file in
  let n = in_channel_length ic in
  let s = Bytes.create n in
  let _ = really_input ic s 0 n in
  close_in ic;
  Sys.remove tmp_file;
  Bytes.to_string s

let is_sqlite_installed () : bool =
  let s = shell "sqlite3 --version" in
  match s.[0] with
  | '3' -> true
  | _ -> false

let create_key_value_table (t:string) : string =
  let s = sprintf "echo %sCREATE TABLE %s (key VARCHAR(50) PRIMARY KEY, value TEXT);%s | sqlite3 %s.db" dq t dq t in
  s

let insert_key_value_pair (t:string) (k:string) (v:string) : string =
  let s = sprintf "echo %sINSERT INTO %s (key, value) VALUES ('%s', '%s');%s | sqlite3 %s.db" dq t k v dq t in
  s

let select_all_pairs (t:string) : string =
  let s = sprintf "echo %sSELECT * FROM %s;%s | sqlite3 %s.db" dq t dq t in
  s

let select_all_keys (t:string) : string =
  let s = sprintf "echo %sSELECT key FROM %s;%s | sqlite3 %s.db" dq t dq t in
  s

let select_all_values (t:string) : string =
  let s = sprintf "echo %sSELECT value FROM %s;%s | sqlite3 %s.db" dq t dq t in
  s

let delete_key_value_pair (t:string) (k:string) : string =
  let s = sprintf "echo %sDELETE FROM %s WHERE key = '%s';%s | sqlite3 %s.db" dq t k dq t in
  s

let select_row_from_key (t:string) (k:string) : string =
  let s = sprintf "echo %sSELECT * FROM %s WHERE key = '%s';%s | sqlite3 %s.db" dq t k dq t in
  s

let select_value_from_key (t:string) (k:string) : string =
  let s = sprintf "echo %sSELECT value FROM %s WHERE key = '%s';%s | sqlite3 %s.db" dq t k dq t in
  s

let rec count_string_instances (lst:string list) (s:string) : int =
  match lst with
  | [] -> 0
  | head::tail ->
    let count_rest = count_string_instances tail s in
    if head = s then
      1 + count_rest
    else
      count_rest

let table_contains_key (t:string) (k:string) : bool =
  let keys_list = shell (select_all_keys t) in
  let lines_list = String.split_on_char '\n' keys_list in
  let n = count_string_instances lines_list k in
  match n with
  | 0 -> false
  | _ -> true
  