open Sqlite3

type todo = {
    id: int;
    task: string;
}

let db = db_open "todos.db"

let int_of_string_opt s =
  try Some (int_of_string s) with
  | Failure _ -> None

let initialize_db () =
  let create_table_sql = "CREATE TABLE IF NOT EXISTS todo (id INTEGER PRIMARY KEY, task TEXT)" in
  match exec db create_table_sql with
  | Rc.OK -> ()
  | _ -> failwith "Failed to create table"

let insert_todo todo =
  let insert_sql = Printf.sprintf "INSERT INTO todo (id, task) VALUES (%d, '%s')" todo.id todo.task in
  match exec db insert_sql with
  | Rc.OK -> true
  | _ -> false

let get_all_todos () =
  let select_sql = "SELECT * FROM todo" in
  let todos = ref [] in
  let callback row _ =
      let id = int_of_string row.(0) in
      let task = row.(1) in
      todos := {id; task} :: !todos
  in
  let _ = exec_not_null db ~cb:callback select_sql in
  !todos

let delete_todo id =
  let delete_sql = Printf.sprintf "DELETE FROM todo WHERE id = %d" id in
  match exec db delete_sql with
  | Rc.OK -> true
  | _ -> false

let user_input prompt =
  print_string prompt;
  flush stdout;
  input_line stdin

let createTodo () =
  let id_str = user_input "Enter task ID: " in
  match int_of_string_opt id_str with
  | Some id ->
      let task = user_input "Task name? " in
      ignore (insert_todo {id; task})
  | None -> print_endline "\nInvalid ID!"

let promptToDeleteTodo () =
  match int_of_string_opt (user_input "ID to delete? ") with
  | Some id -> ignore (delete_todo id)
  | None -> print_endline "\nInvalid ID!"

let () =
  print_endline "Welcome to TUI TODOS";
  initialize_db ();
  while true do
      List.iter (fun t -> Printf.printf "\n%d. %s" t.id t.task) (List.rev (get_all_todos ()));
      print_endline "";
      match String.lowercase_ascii (user_input "\nCreate (c), Delete (d) or Exit (e)? ") with
      | "c" -> createTodo ()
      | "d" -> promptToDeleteTodo ()
      | "e" -> exit 0
      | _ -> print_endline "Invalid option!"
  done
