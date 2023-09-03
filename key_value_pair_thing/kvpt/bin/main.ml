open Kvpt
open Printf

let check_table () : unit =
  if db_exists "kv" then
    printf "Table already exists.\n"
  else
    let _ = shell (create_key_value_table "kv") in
    let _ = shell (insert_key_value_pair "kv" "John" "Plumber") in
    let _ = shell (insert_key_value_pair "kv" "Bill" "Firefighter") in
    let _ = shell (insert_key_value_pair "kv" "Susan" "Engineer") in
  ()

let query_table () : unit = 
  let _ = check_table () in
  let v0 = shell (select_all_pairs "kv") in
  let v1 = shell (select_all_keys "kv") in
  let v2 = shell (select_all_values "kv") in

  let _ = shell (delete_key_value_pair "kv" "Bill") in
  let v3 = table_contains_key "kv" "Bill" in

  let v4 = shell (select_all_keys "kv") in
  let v5 = shell (select_all_values "kv") in

  let v6 = shell (select_row_from_key "kv" "John") in
  let v7 = shell (select_value_from_key "kv" "Susan") in

  let _ = printf "\n%s\n%s\n%s\n%b\n\n%s\n%s\n%s\n%s\n" v0 v1 v2 v3 v4 v5 v6 v7 in
  ()

  let () =
  match is_sqlite_installed () with
  | true -> query_table ()
  | false -> printf "Sqlite3 is not installed.\n"