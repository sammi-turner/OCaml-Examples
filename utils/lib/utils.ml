(* 

USER INPUT

The user_input function prompts the user with a string and returns the user input as another string.

Example:

open Utils

let () =
  let s = user_input "Hello, what is your name? " in
  Printf.printf "Nice to meet you %s!\n" s

*)

let user_input s =
  print_string s;
  flush stdout;
  read_line ()

(*
   
IS UNIX

The is_unix function returns true if the command is being run on a unix-like operating system, or false otherwise.

*)

let is_unix () =
  let os_type = Sys.os_type in
  match os_type with
  | "Unix" | "Cygwin" | "MacOS" -> true
  | _ -> false

(*

SHELL

The shell function flushes stdout and then executes its string argument as a shell command.

Unix example:

open Utils

let () = print_endline "The files in the working directory are:"
let () = shell "ls -1"

*)

let shell (s) = 
  flush stdout;
  ignore (Sys.command(s))

(*
   
READ FILE

The read_file function will return an empty string if the file does not exist in the working directory, or the contents of the file as a string, if it does.

Example:

open Utils

let file = "example.txt"
let content = read_file file
let () = print_endline content

*)

let read_file name =
  try
    let channel = open_in name in
    let contents = really_input_string channel (in_channel_length channel) in
    close_in channel;
    contents
  with
    | Sys_error _ -> ""


(*
   
WRITE FILE

The write_file function takes two string arguments. One for a file name and one for the string to write to the named file.

Example:

open Utils

let file = "example.txt"
let message = "Hello, world!"
let () = write_file file message

*)

let write_file name content =
  let oc = open_out name in
  output_string oc content;
  close_out oc

(*
   
APPEND TO FILE

The append_to_file function takes two string arguments. One for a file name and one for the string that is appended to the named file.

Example:

open Utils

let file = "example.txt"
let message = "add this text to the end."
let () = append_to_file file message

*)

let append_to_file name content =
  let channel = open_out_gen [Open_append; Open_creat] 0o666 name in
  output_string channel content;
  close_out channel

(*

PSEUDO

The pseudo function takes a non-negative integer argument n, and returns an integer between 0 and n - 1.

Example:

open Utils

let die0 = (pseudo 6) + 1
let die1 = (pseudo 6) + 1
let die2 = (pseudo 6) + 1

let () = Printf.printf "%d %d %d\n" die0 die1 die2

*)

let pseudo n =
  Random.self_init ();
  match n with
    _ when n > 0 -> Random.int(n)
    | _ -> 0

(*
   
WORDS TO SENTENCE

The words_to_sentence function converts a list of strings into a string with a single space between each list element.

Example:

open Utils

let test = ["Mary";"had";"a";"little";"lamb."]
let () = words_to_sentence test

*)

let words_to_sentence lst = String.concat " " lst

(*
   
SENTENCE TO WORDS

The sentence_to_words function converts a strings into a list of words with whitespace as delimiter.

Example:

open Utils

let sentence = "Mary   had   a   little   lamb"
let words = sentence_to_words sentence
let test = words_to_sentence words
let () = Printf.printf "Sentence: %s.\n" test

*)

let sentence_to_words s =
  let open String in
  let rec aux acc i =
    if i >= length s then List.rev acc
    else
      let j = try index_from s i ' ' with Not_found -> length s in
      let word = sub s i (j - i) in
      let acc' = if word = "" then acc else word :: acc in
      aux acc' (j + 1)
  in
  aux [] 0

(*
   
REMOVE EMPTY STRINGS

The remove_empty_strings function takes a list of strings as its argument and returns the list with all the empty strings removed. 

open Utils

let test = ["hello";"";"world";"";"ocaml";""]
let non_empty_strings = remove_empty_strings test
let () = print_words non_empty_strings

*)

let rec remove_empty_strings lst =
  match lst with
  | [] -> []
  | "" :: tail -> remove_empty_strings tail
  | head :: tail -> head :: remove_empty_strings tail

(*
   
NTH CHAR

The nth_char function takes a string (s) and a non-negative int (n) as arguments. 

It returns either the empty string, or a string containing the nth char of s.

Example:

open Utils

let test = "Mary had a little lamb."
let result = nth_char test 25
let () = print_endline result

*)

let nth_char (s: string) (n: int) : string =
  if n >= String.length s || n < 0 then ""
  else String.make 1 (String.get s n)

(*
   
NTH STRING

The nth_string function takes a list of strings as its argument and returns an option type.

Example:

open Utils

let print_string_option (x : string option) : unit =
  match x with
  | Some x -> Printf.printf "%s\n" x
  | None -> Printf.printf "error\n"

let capitals = ["London";"Paris";"Berlin"]

let city0 = nth_string capitals 0
let city1 = nth_string capitals 1
let city2 = nth_string capitals 2
let city3 = nth_string capitals 3

let () = print_string_option city0
let () = print_string_option city1
let () = print_string_option city2
let () = print_string_option city3

*)

let rec nth_string lst n =
  match lst with
  | [] -> None
  | head :: tail ->
    if n = 0 then Some head
    else nth_string tail (n-1)

(*
   
IS DIGITS

The is_digits function takes a string argument and returns the boolean true if it consists only of decimal digits, or false if it does not.

Example:

open Utils

let test0 = is_digits "12345"
let test1 = is_digits "00671"
let test2 = is_digits "a1234"

let () = Printf.printf "%b %b %b\n" test0 test1 test2

*)

let is_digits s =
  let is_digit c = Char.code c >= 48 && Char.code c <= 57 in
  String.for_all is_digit s

(*

TO INT

The to_int function takes a string argument and returns an int option.

Example:

open Utils

let print_int_option (x : int option) : unit =
  match x with
  | Some x -> Printf.printf "%d\n" x
  | None -> Printf.printf "error\n"

let () = print_int_option(to_int "420.69")
let () = print_int_option(to_int "69")

*)

let to_int (s : string) : int option =
  try Some (int_of_string s)
  with Failure _ -> None

(*

TO FLOAT

The to_float function takes a string argument and returns a float option.

Example:

open Utils

let print_float_option (x : float option) : unit =
  match x with
  | Some x -> Printf.printf "%f\n" x
  | None -> Printf.printf "error\n"

let () = print_float_option(to_float "420.69")
let () = print_float_option(to_float "69")

*)

let to_float (s : string) : float option =
  try Some (float_of_string s)
  with Failure _ -> None

(*
   
WORD COUNT

The word_count function takes a string argument and returns the number of words in the string, as delmited by whitespace.

Example:

open Utils

let test = word_count "Mary had a little lamb."
let () = Printf.printf "%d\n" test

*)

let word_count s =
  let rec count_words acc = function
    | [] -> acc
    | "" :: tail -> count_words acc tail
    | _ :: tail -> count_words (acc + 1) tail
  in
  s |> String.split_on_char ' ' |> count_words 0
