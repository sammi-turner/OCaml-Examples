(* 

S-EXPRESSION EVALUATOR
   
This program has four parts.

1. A lexer, which takes a string and outputs a list of tokens.
2. A parser, which checks to see if the token stream is grammatical.
3. An evaluator, which takes a token stream as input and outputs a string representing a float or int.
4. A REPL (read-evaluate-print-loop) that allows the user to enter expressions and have them evaluated.

*)

type token =
  | Int of int
  | Float of float
  | Plus
  | Minus
  | Multiply
  | Divide
  | Lparen
  | Rparen
  | Error

let token_type (s:string) : token =
  match s with
  | "+" -> Plus
  | "-" -> Minus
  | "*" -> Multiply
  | "/" -> Divide
  | "(" -> Lparen
  | ")" -> Rparen
  | _ -> 
    try Int (int_of_string s) 
    with Failure _ ->
      try Float (float_of_string s)
      with Failure _ -> Error

let pad_parens (s:string) : string =
let padded_chars =
  String.to_seq s
  |> List.of_seq
  |> List.map (function
      | '(' -> "( "
      | ')' -> " )"
      | c -> String.make 1 c
    )
in
String.concat "" padded_chars

let whitespace_delimit (s:string) : string list = String.split_on_char ' ' s

let rec remove_empty_strings (lst:string list) : string list =
  match lst with
  | [] -> []
  | "" :: tail -> remove_empty_strings tail
  | head :: tail -> head :: remove_empty_strings tail

let token_stream (s:string) : token list =
  let p = pad_parens s in
  let w = whitespace_delimit p in
  let r = remove_empty_strings w in
  let rec tokenize = function
    | [] -> []
    | head :: tail -> token_type head :: tokenize tail
  in
  tokenize r

type expr =
  | IntNode of int
  | FloatNode of float
  | PlusNode of expr * expr
  | MinusNode of expr * expr
  | MultiplyNode of expr * expr
  | DivideNode of expr * expr

let rec parse_expr (tokens: token list) : expr * token list =
  match tokens with
  | Lparen :: Plus :: rest ->
      let left, after_left = parse_expr rest in
      let right, after_right = parse_expr after_left in
      begin match after_right with
      | Rparen :: after -> PlusNode (left, right), after
      | _ -> failwith "unbalanced parentheses"
      end
  | Lparen :: Minus :: rest ->
      let left, after_left = parse_expr rest in
      let right, after_right = parse_expr after_left in
      begin match after_right with
      | Rparen :: after -> MinusNode (left, right), after
      | _ -> failwith "unbalanced parentheses"
      end
  | Lparen :: Multiply :: rest ->
      let left, after_left = parse_expr rest in
      let right, after_right = parse_expr after_left in
      begin match after_right with
      | Rparen :: after -> MultiplyNode (left, right), after
      | _ -> failwith "unbalanced parentheses"
      end
  | Lparen :: Divide :: rest ->
      let left, after_left = parse_expr rest in
      let right, after_right = parse_expr after_left in
      begin match after_right with
      | Rparen :: after -> DivideNode (left, right), after
      | _ -> failwith "unbalanced parentheses"
      end
  | Int i :: rest -> IntNode i, rest
  | Float f :: rest -> FloatNode f, rest
  | _ -> failwith "parse error"

(* 

TEST CODE FOR THE PARSER

let run_test expr_str expected =
  let tokens = token_stream expr_str in
  let result, rest = parse_expr tokens in
  if result = expected && rest = [] then
    print_endline "Test passed"
  else
    print_endline ("Test failed: " ^ expr_str)

let () =
  run_test "(+ 1 2)"
    (PlusNode (IntNode 1, IntNode 2));

  run_test "(* 3.5 2.5)"
    (MultiplyNode (FloatNode 3.5, FloatNode 2.5));

  run_test "(- (/ 10 2) (* 2 2))"
    (MinusNode (DivideNode (IntNode 10, IntNode 2), MultiplyNode (IntNode 2, IntNode 2))); 
    
*)
  
let rec eval_expr (e: expr) : string option =
  match e with
  | IntNode i -> Some (string_of_int i)
  | FloatNode f -> Some (string_of_float f)
  | PlusNode (left, right) ->
      (match eval_expr left, eval_expr right with
        | Some l, Some r ->
          if String.contains l '.' || String.contains r '.' then
            Some (string_of_float ((float_of_string l) +. (float_of_string r)))
          else
            Some (string_of_int ((int_of_string l) + (int_of_string r)))
        | _ -> None)
  | MinusNode (left, right) ->
      (match eval_expr left, eval_expr right with
        | Some l, Some r ->
          if String.contains l '.' || String.contains r '.' then
            Some (string_of_float ((float_of_string l) -. (float_of_string r)))
          else
            Some (string_of_int ((int_of_string l) - (int_of_string r)))
        | _ -> None)
  | MultiplyNode (left, right) ->
      (match eval_expr left, eval_expr right with
        | Some l, Some r ->
          if String.contains l '.' || String.contains r '.' then
            Some (string_of_float ((float_of_string l) *. (float_of_string r)))
          else
            Some (string_of_int ((int_of_string l) * (int_of_string r)))
        | _ -> None)
  | DivideNode (left, right) ->
      (match eval_expr left, eval_expr right with
        | Some l, Some r ->
          if r = "0" || r = "0." then
            None
          else if String.contains l '.' || String.contains r '.' then
            Some (string_of_float ((float_of_string l) /. (float_of_string r)))
          else
            Some (string_of_int ((int_of_string l) / (int_of_string r)))
        | _ -> None)
    
let evaluate (s: string) : string =
  let tokens = token_stream s in
  try
    let expr, rest = parse_expr tokens in
    match rest with
    | [] ->
        (match eval_expr expr with
          | Some v -> v
          | None -> "Error: Division by zero")
    | _ -> "Error: Invalid expression"
  with Failure _ -> "Error: Parsing error"

(* 

TEST CODE FOR THE EVALUATOR

let run_eval_test expr_str expected =
  let result = evaluate expr_str in
  if result = expected then
    print_endline ("Test passed: " ^ expr_str)
  else
    print_endline ("Test failed: " ^ expr_str ^ ", got: " ^ result ^ ", expected: " ^ expected)

let () =
  run_eval_test "(+ 1 2)" "3";
  run_eval_test "(* 3.5 2.5)" "8.75";
  run_eval_test "(- (/ 10 2) (* 2 2))" "1";
  run_eval_test "(/ 1 0)" "Error: Division by zero";
  run_eval_test "(+ 1 (+ 2 3))" "6";
  run_eval_test "(+ 1" "Error: Invalid expression";
  run_eval_test "(+ 1 ())" "Error: Invalid expression"; 
  
*)
  
let repl () =
  let rec loop () =
    print_string "\n> ";
    let line = read_line () in
    if line = "" then
      ()
    else
      let result = evaluate line in
      print_endline result;
      loop ()
  in loop ()

(* Run the REPL *)
let () = 
  print_endline "\nS-EXPRESSION EVALUATOR REPL\n";
  print_endline "Please enter valid nested s-expressions of the form : (operator expression expression)";
  print_endline "The operators recognised are : +, -, * and /";
  print_endline "Enter a blank input to exit the program";
  repl ();
