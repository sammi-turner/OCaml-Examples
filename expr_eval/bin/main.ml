open Utils

let whitespace_delimit (s:string) = sentence_to_slices s ' '

let pad_parens (s:string) =
let padded_chars =
  String.to_seq s
  |> List.of_seq
  |> List.map (function
      | '(' -> " ( "
      | ')' -> " ) "
      | c -> String.make 1 c
    )
in
String.concat "" padded_chars

let token_type (s:string) =
  match s with
  | "(" -> "LPAREN"
  | ")" -> "RPAREN"
  | "+" -> "PLUS"
  | "-" -> "MINUS"
  | "*" -> "MULTIPLY"
  | "/" -> "DIVIDE"
  | "mod" -> "MOD"
  | f when is_float f -> "FLOAT: " ^ s
  | _ -> "INVALID"

let lexer (lst:string list) =
  let rec tokenize = function
    | [] -> []
    | head :: tail -> token_type head :: tokenize tail
  in
  tokenize lst

let test0 = pad_parens "(2 + 3) - (7 * 41)"
let test1 = whitespace_delimit test0
let test2 = lexer test1

let () = print_list test2