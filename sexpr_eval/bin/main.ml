(* 

S-EXPRESSION EVALUATOR
   
This program is divided into three parts.

1. A lexer, which takes a string and outputs a list of tokens.
2. A parser, which checks to see if the token stream is grammatical.
3. An evaluator, which takes a token stream as input and outputs a string representing a float or int.

COMPLETED

- Lexer
- Parser

TO DOs

- Evaluator

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
  
  