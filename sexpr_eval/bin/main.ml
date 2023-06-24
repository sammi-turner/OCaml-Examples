(* 

S-EXPRESSION EVALUATOR
   
This program is divided into three parts.

1. A lexer, which takes a string and outputs a list of tokens.
2. A parser, which checks to see if the token stream is grammatical.
3. An evaluator, which takes a token stream as input and outputs a string representing a float or int.

COMPLETED

- Lexer

TO DOs

- Parser
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

let is_open (lst:token list) : bool  = 
  match lst with
  | Lparen :: _ -> true
  | _ -> false

let is_closed (lst:token list) : bool =
  let s = List.nth lst (List.length lst - 1) in
  match s with
  | Rparen -> true
  | _ -> false

let is_enclosed (lst:token list) : bool =
  is_open lst && is_closed lst

let print_token token =
  match token with
  | Int i -> Printf.printf "Int: %d\n" i
  | Float f -> Printf.printf "Float: %f\n" f
  | Plus -> print_endline ("Plus")
  | Minus -> print_endline ("Minus")
  | Multiply -> print_endline ("Multiply")
  | Divide -> print_endline ("Divide")
  | Lparen -> print_endline ("Lparen")
  | Rparen -> print_endline ("Rparen")
  | _ -> print_endline ("Error")

let rec print_token_list tokens =
  match tokens with
  | [] -> ()
  | token :: rest ->
      print_token token;
      print_token_list rest

let test0 = token_stream "(* (+ 2 3.5) 7)"
let test1 = is_enclosed test0

let () = Printf.printf "Token stream enclosed? %b\n\n" test1
let () = print_token_list test0