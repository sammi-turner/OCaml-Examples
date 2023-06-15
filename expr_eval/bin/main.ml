open Utils

let whitespace_delimit (s:string) = String.split_on_char ' ' s

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
  | "+" | "-" | "*" | "/" | "pow" | "mod" -> "BINOP " ^ s
  | f when is_float f -> "FLOAT " ^ s
  | _ -> "INVALID " ^ s

let lexer (s:string) =
  let p = pad_parens s in
  let w = whitespace_delimit p in
  let r = remove_empty_strings w in
  let rec tokenize = function
    | [] -> []
    | head :: tail -> token_type head :: tokenize tail
  in
  tokenize r
  
let test0 = lexer "(2 + 3) - (7 * 41)"
let () = print_list test0
