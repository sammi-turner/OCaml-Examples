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

let paren_balance (lst:string list) =
  (count_string_instances lst "LPAREN") == (count_string_instances lst "RPAREN")

let valid_parens (lst:string list) =
  let rec check_parens lp_count rp_count = function
    | [] -> true
    | "LPAREN"::tail -> check_parens (lp_count + 1) rp_count tail
    | "RPAREN"::tail ->
      if lp_count > rp_count then check_parens lp_count (rp_count + 1) tail
      else false
    | _::tail -> check_parens lp_count rp_count tail
  in
  check_parens 0 0 lst && paren_balance lst
  
let test0 = lexer "(2 + 3) - (7 * 41)"

let () = Printf.printf "%b\n" (valid_parens test0)
