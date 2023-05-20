(* 

USER INPUT

The user_input function prompts the user with a string and returns the user input as another string.

Example:

open Utils

let () =
  let s = user_input "Hello, what is your name? " in
  Printf.printf "Nice to meet you %s!\n" s

*)

let user_input (s:string) =
  print_string s;
  flush stdout;
  read_line ()

(*
   
IS UNIX

The is_unix function returns true if the program is being run on a unix-like operating system, or false if it is not.

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

let shell (s:string) = 
  flush stdout;
  ignore (Sys.command(s))

(*
   
READ FILE

The read_file function returns a string option.

Example:

open Utils

let print_file_contents (x:string option) =
  match x with
  | Some x -> Printf.printf "%s\n" x
  | None -> Printf.printf "That file does not exist in the working directory.\n"

let file = "example.txt"
let content = read_file file
let () = print_file_contents content

*)

let read_file (name:string) =
  try
    let channel = open_in name in
    let contents = really_input_string channel (in_channel_length channel) in
    close_in channel;
    Some (contents)
  with
    | Sys_error _ -> None

(*
   
WRITE FILE

The write_file function writes a string to a particular file, or overwrites it, if it already exists.

Example:

open Utils

let file = "example.txt"
let message = "Hello, world!"
let () = write_file file message

*)

let write_file (name:string) (content:string) =
  let oc = open_out name in
  output_string oc content;
  close_out oc

(*
   
APPEND TO FILE

The append_to_file function either appends a string to a file, or writes to the file if it does not already exist.

Example:

open Utils

let file = "example.txt"
let message = "add this text to the end."
let () = append_to_file file message

*)

let append_to_file (name:string) (content:string) =
  let channel = open_out_gen [Open_append; Open_creat] 0o666 name in
  output_string channel content;
  close_out channel

(*

PSEUDO

The pseudo function returns either 0 or an integer between 0 and n - 1.

Example:

open Utils

let die0 = (pseudo 6) + 1
let die1 = (pseudo 6) + 1
let die2 = (pseudo 6) + 1

let () = Printf.printf "%d %d %d\n" die0 die1 die2

*)

let pseudo (n:int) =
  Random.self_init ();
  match n with
    _ when n > 0 -> Random.int(n)
    | _ -> 0

(*
   
SLICES TO SENTENCE

The slices_to_sentence function converts a list of strings into a string with an arbitrary character between each list element.

Example:

open Utils

let test = slices_to_sentence ["Mary";"had";"a";"little";"lamb."] ' '
let () = print_endline test

*)

let slices_to_sentence (lst:string list) (ch:char) =
  let rec join acc = function
    | [] -> acc
    | [x] -> acc ^ x
    | x :: xs -> join (acc ^ x ^ String.make 1 ch) xs
  in
  join "" lst

(*
   
SENTENCE TO SLICES

The sentence_to_slices function converts a string into a list of strings with an arbitrary character as delimiter.

Example:

open Utils

let sentence = "Mary,had,a,little,lamb"
let slices = sentence_to_slices sentence ','
let test = slices_to_sentence slices '#'
let () = Printf.printf "Sentence: %s.\n" test

*)

let sentence_to_slices (s:string) (ch:char) =
  let words = String.split_on_char ch s in
  List.filter (fun w -> w <> "") words

(*
   
REMOVE EMPTY STRINGS

The remove_empty_strings function returns the non-empty strings from a list. 

open Utils

let test = ["hello";"";"world";"";"ocaml";""]
let non_empty_strings = remove_empty_strings test
let () = print_words non_empty_strings

*)

let rec remove_empty_strings (lst:string list) =
  match lst with
  | [] -> []
  | "" :: tail -> remove_empty_strings tail
  | head :: tail -> head :: remove_empty_strings tail

(*
   
NTH CHAR

The nth_char function returns a char option.

Example:

open Utils

let print_char_option (x:char option) =
  match x with
  | Some x -> Printf.printf "%c\n" x
  | None -> Printf.printf "error\n"

let test = nth_char "OCaml" 2
let () = print_char_option test

*)

let nth_char (s:string) (n:int) =
  if n < 0 || n >= String.length s then None
  else Some s.[n]

(*
   
NTH STRING

The nth_string function returns a string option.

Example:

open Utils

let print_string_option (x:string option) =
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

let rec nth_string (lst:string list) (n:int) =
  match lst with
  | [] -> None
  | head :: tail ->
    if n = 0 then Some head
    else nth_string tail (n-1)

(*
   
IS DIGITS

The is_digits function returns the boolean true if a string consists only of decimal digits, or false if it does not.

Example:

open Utils

let test0 = is_digits "12345"
let test1 = is_digits "00671"
let test2 = is_digits "a1234"

let () = Printf.printf "%b %b %b\n" test0 test1 test2

*)

let is_digits (s:string) =
  let is_digit c = Char.code c >= 48 && Char.code c <= 57 in
  String.for_all is_digit s

(*

TO INT

The to_int function returns an int option.

Example:

open Utils

let print_int_option =
  match x with
  | Some x -> Printf.printf "%d\n" x
  | None -> Printf.printf "error\n"

let () = print_int_option(to_int "420.69")
let () = print_int_option(to_int "69")

*)

let to_int (s:string) =
  try Some (int_of_string s)
  with Failure _ -> None

(*

TO FLOAT

The to_float function returns a float option.

Example:

open Utils

let print_float_option =
  match x with
  | Some x -> Printf.printf "%f\n" x
  | None -> Printf.printf "error\n"

let () = print_float_option(to_float "420.69")
let () = print_float_option(to_float "69")

*)

let to_float (s:string) =
  try Some (float_of_string s)
  with Failure _ -> None

(*
   
SLICE COUNT

The slice_count function returns the number of slices in a string, as delmited by an arbitrary character.

Example:

open Utils

let test = slice_count "Mary,had,a,little,lamb."
let () = Printf.printf "%d\n" test

*)

let slice_count (s:string) (delim:char) =
  let rec count_words acc = function
    | [] -> acc
    | "" :: tail -> count_words acc tail
    | _ :: tail -> count_words (acc + 1) tail
  in
  s |> String.split_on_char delim |> count_words 0