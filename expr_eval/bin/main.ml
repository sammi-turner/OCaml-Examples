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
  | f when is_float f -> "FLOAT " ^ s
  | _ -> "INVALID " ^ s

let lexer (s:string) =
  let p = pad_parens s in
  let w = whitespace_delimit p in
  let rec tokenize = function
    | [] -> []
    | head :: tail -> token_type head :: tokenize tail
  in
  tokenize w

let test0 = lexer "(2 + 3) - (7 * 41)"
let test1 = lexer "(2 + kitten) - (7 mod 41)"

let () = print_list test0
let () = print_endline ""
let () = print_list test1

