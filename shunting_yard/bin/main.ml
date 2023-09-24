(* Stack implementation *)
let stack_create () = ref []
let stack_push x s = s := x :: !s
let stack_pop s =
  match !s with
  | [] -> None
  | x :: xs -> s := xs; Some x
let stack_peek s =
  match !s with
  | [] -> None
  | x :: _ -> Some x

(* Operator precedence *)
let precedence op =
  match op with
  | "+" | "-" -> 1
  | "*" | "/" -> 2
  | "^" -> 3
  | _ -> failwith "Invalid operator"

(* Check if the token is an operator *)
let is_operator token = List.mem token ["+"; "-"; "*"; "/"; "^"]

(* Shunting Yard Algorithm *)
let shunting_yard tokens =
  let output = ref [] in
  let operators = stack_create () in
  List.iter (fun token ->
      if is_operator token then (
        while (match stack_peek operators with None -> false | Some x -> is_operator x) &&
              (match stack_peek operators with None -> 0 | Some x -> precedence x) >= precedence token do
          match stack_pop operators with
          | Some op -> stack_push op output
          | None -> ()
        done;
        stack_push token operators
      ) else if token = "(" then
        stack_push token operators
      else if token = ")" then (
        while stack_peek operators <> Some "(" do
          match stack_pop operators with
          | Some op -> stack_push op output
          | None -> ()
        done;
        ignore (stack_pop operators)
      ) else
        stack_push token output
    ) tokens;
  while Option.is_some (stack_peek operators) do
    match stack_pop operators with
    | Some op -> stack_push op output
    | None -> ()
  done;
  List.rev !output

let eval_postfix postfix_tokens =
  let stack = stack_create () in
  List.iter (fun token ->
    if is_operator token then (
      let b = match stack_pop stack with Some x -> float_of_string x | None -> failwith "Stack underflow" in
      let a = match stack_pop stack with Some x -> float_of_string x | None -> failwith "Stack underflow" in
      let result = 
        match token with
        | "+" -> a +. b
        | "-" -> a -. b
        | "*" -> a *. b
        | "/" -> a /. b
        | "^" -> a ** b
        | _ -> failwith "Invalid operator" in
      stack_push (string_of_float result) stack
    ) else (
      stack_push token stack
    )
  ) postfix_tokens;
  match stack_pop stack with
  | Some x -> float_of_string x
  | None -> failwith "Evaluation failed"

(* Main function *)
let () =
  let infix = "3 + 4 * ( 2 - 1 )" in
  let tokens = Str.split (Str.regexp " \\|\\|") infix in
  let postfix = shunting_yard tokens in
  Printf.printf "Infix: %s\n" infix;
  print_endline ("Postfix: " ^ (String.concat " " postfix));
  let result = eval_postfix postfix in
  Printf.printf "Result: %.2f\n" result
