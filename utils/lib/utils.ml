open Printf
open Curses

(*
   
WRAPPERS AROUND CURSES LIBRARY FUNCTIONS

- The start and finish functions open and close the virtual terminal.
- The add and show functions work together to display text to the virtual terminal.
- The vinput function takes input from the user in the virtual terminal up to a maximum length.
- The render_menu function is a helper for select_option.
- The select_option function allows the user to select an item from a menu. This returns a corresponding integer.

Example:

open Utils
open Printf

let () =
  start;
  keypress_off;
  let city = [|"CITIES";"London";"Paris";"Berlin";"Rome"|] in
  let num = select_option city in
  let s = sprintf "\nYou entered option %d. Press any key to close.\n" num in
  finish s

*)

let start : unit =
  let win = initscr () in
  ignore (keypad win true)

let vputs (s:string) : unit =
  ignore (addstr s);
  ignore (refresh())

let finish (s:string) : unit =
  vputs s;
  ignore (getch ());
  endwin ()

let vinput (n:int) : string =
  let buffer = String.make n ' ' in
  ignore (getnstr buffer 0 n);
  buffer

let cursor_off : unit =
  ignore (curs_set(0))

let keypress_off : unit =
  ignore (noecho())

let render_menu (menu:string array) (size:int) (count:int) : unit =
  clear ();
  let s = ref "\n    " in
  s := !s ^ menu.(0) ^ "\n\n";
  for i = 1 to size - 1 do
    if i = count then
      s := !s ^ "  > " ^ menu.(i) ^ "\n"
    else
      s := !s ^ "    " ^ menu.(i) ^ "\n"
  done;
  vputs !s

let select_option (menu:string array) : int =
  cursor_off;
  
  let size = ref (Array.length menu) in
  let value = ref 1 in
  let key_press = ref 0 in
  
  while !key_press <> int_of_char '\n' do
    render_menu menu !size !value;
    key_press := getch ();
    
    match !key_press with
    | k when k = Key.down ->
        incr value;
        if !value = !size then value := 1;
        render_menu menu !size !value
    | k when k = Key.up ->
        decr value;
        if !value = 0 then value := !size - 1;
        render_menu menu !size !value
    | _ -> ()
  done;
  !value
  
(* 

USER INPUT

The user_input function prompts the user with a string and returns the user input as another string.

Example:

open Utils

let s = user_input "Hello, what is your name? ";;
printf "Nice to meet you %s!\n" s

*)

let user_input (s:string) : string =
  printf "%s " s;
  flush stdout;
  read_line ()

(*
   
IS UNIX

The is_unix function returns true if the program is being run on a unix-like operating system, or false if it is not.

*)

let is_unix () : bool =
  let os_type = Sys.os_type in
  match os_type with
  | "Unix" | "Cygwin" | "MacOS" -> true
  | _ -> false

(*

CLEAR TERMINAL

The clear_terminal function wipes the terminal window.

*)

let clear_terminal () : unit =
  if Sys.os_type = "Win32" then
    ignore (Sys.command "cls")
  else
    ignore (Sys.command "clear")

(*
   
READ FILE

The read_file function returns a string option.

Example:

open Utils

let print_file_contents (x:string option) : unit =
  match x with
  | Some x -> printf "File contents : %s\n" x
  | None -> printf "That file does not exist in the working directory.\n"

let content = read_file "example.txt";;
print_file_contents content

*)

let read_file (name:string) : string option =
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

open Utils;;

write_file "example.txt" "Oh, hi Mark!"

*)

let write_file (name:string) (content:string) : unit =
  let oc = open_out name in
  output_string oc content;
  close_out oc

(*
   
APPEND TO FILE

The append_to_file function either appends a string to a file, or writes to the file if it does not already exist.

Example:

open Utils;;

append_to_file "example.txt" "Oh, hi Mark!"

*)

let append_to_file (name:string) (content:string) : unit =
  let channel = open_out_gen [Open_append; Open_creat] 0o666 name in
  output_string channel content;
  close_out channel

(*
   
DELETE FILE

The delete_file function attempts to delete a file from the working directory.

Example:

open Utils;;

let result = delete_file "example.txt";
printf "%b\n" result

*)

let delete_file (name:string) : unit = 
  try 
    Sys.remove name
  with
  | Sys_error _ -> ()

(*

PSEUDO

The pseudo function returns either 0 or an integer between 1 and n.

Example:

open Utils

let die0 = pseudo 6
let die1 = pseudo 6
let die2 = pseudo 6;;

printf "%d %d %d\n" die0 die1 die2

*)

let pseudo (n:int) : int =
  Random.self_init ();
  match n with
    _ when n > 0 -> Random.int(n) + 1
    | _ -> 0

(*
   
SLICES TO STRING

The slices_to_string function converts a list of strings into a string with an arbitrary character between each list element.

Example:

open Utils

let test = slices_to_string ["You're";"tearing";"me";"apart";"Lisa!"] ' ';;
print_endline test

*)

let slices_to_string (lst:string list) (ch:char) : string =
  let rec join acc = function
    | [] -> acc
    | [x] -> acc ^ x
    | x :: xs -> join (acc ^ x ^ String.make 1 ch) xs
  in
  join "" lst

(*
   
PRINT LIST

The print_list function prints out a list of strings with each string on a new line.

Example:

open Utils

let people = ["Mark";"Lisa";"Johnny"];;
print_list people

*)

let print_list (lst:string list) : unit = 
  List.iter (fun str -> printf "%s\n" str) lst

(*
   
REMOVE EMPTY STRINGS

The remove_empty_strings function returns the non-empty strings from a list. 

open Utils

let test = ["hello";"";"doggie";"";""]
let non_empty_strings = remove_empty_strings test;;
print_list non_empty_strings

*)

let rec remove_empty_strings (lst:string list) : string list =
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
  | Some x -> printf "%c\n" x
  | None -> printf "error\n"

let test = nth_char "OCaml" 2;;
print_char_option test

*)

let nth_char (s:string) (n:int) : char option  =
  if n < 0 || n >= String.length s then None
  else Some s.[n]

(*
   
COUNT CHAR INSTANCES

The count_char_instances function returns the number of instances of a char in a string.

Example:

open Utils

let char_count = count_char_instances "What a story Mark" 'a';;
printf "%i\n" char_count

*)

let count_char_instances (s:string) (c:char) : int =
  let rec count_helper i count =
    if i < 0 then count
    else if s.[i] = c then count_helper (i - 1) (count + 1)
    else count_helper (i - 1) count
  in
  count_helper (String.length s - 1) 0

(*
   
NTH STRING

The nth_string function returns a string option.

Example:

open Utils

let print_string_option (x:string option) =
  match x with
  | Some x -> printf "%s\n" x
  | None -> printf "error\n"

let people = ["Mark";"Lisa";"Johnny"]

let person0 = nth_string people 0
let person1 = nth_string people 1
let person2 = nth_string people 2
let person3 = nth_string people 3;;

print_string_option person0;
print_string_option person1;
print_string_option person2;
print_string_option person3

*)

let rec nth_string (lst:string list) (n:int) : string option =
  match lst with
  | [] -> None
  | head :: tail ->
    if n = 0 then Some head
    else nth_string tail (n-1)

(*
   
COUNT STRING INSTANCES

The count_string_instances function returns the integer number of instances of a string in a list of strings.

Example:

open Utils

let lst = ["Oh";"Denny";"Denny";"Denny";"boy"]
let count = count_string_instances lst "Denny";;
printf "%d\n" count

*)

let rec count_string_instances (lst:string list) (s:string) : int =
  match lst with
  | [] -> 0
  | head::tail ->
    let count_rest = count_string_instances tail s in
    if head = s then
      1 + count_rest
    else
      count_rest

(*
   
NTH SLICE

The nth_slice function returns either an empty string or a slice from the argument string.

Example:

open Utils;;

print_endline (nth_slice 3 "This is a test" ' ')

*)

let nth_slice (n:int) (s:string) (c:char) : string =
  let words = String.split_on_char c s in
  if n < List.length words then
    List.nth words n
  else
    ""

(*
   
IS DIGIT

The is_digit function returns the boolean true if a char is a decimal digit, or false if it is not.

Example:

open Utils

let test0 = is_digit '0'
let test1 = is_digit '9'
let test2 = is_digit 'a';;

printf "%b %b %b\n" test0 test1 test2

*)

let is_digit (c:char) : bool =
  Char.code c >= 48 && Char.code c <= 57

(*

IS LOWER CASE

The is_lower_case function returns the boolean true if a char is a lower case ascii letter, or false if it is not.

Example:

open Utils

let test0 = is_lower_case 'a'
let test1 = is_lower_case 'A'
let test2 = is_lower_case ' ';;

printf "%b %b %b\n" test0 test1 test2

*)

let is_lower_case (c:char) : bool =
  Char.code c >= 97 && Char.code c <= 122

(*

IS UPPER CASE

The is_upper_case function returns the boolean true if a char is an upper case ascii letter, or false if it is not.

Example:

open Utils

let test0 = is_upper_case 'a'
let test1 = is_upper_case 'A'
let test2 = is_upper_case ' ';;

printf "%b %b %b\n" test0 test1 test2

*)

let is_upper_case (c:char) : bool =
  Char.code c >= 65 && Char.code c <= 90

(*

TO INT

The to_int function returns an int option.

Example:

open Utils

let print_int_option (x:int option) =
  match x with
  | Some x -> printf "%d\n" x
  | None -> printf "error\n";;

print_int_option(to_int "420.69");
print_int_option(to_int "69")

*)

let to_int (s:string) : int option =
  try Some (int_of_string s)
  with Failure _ -> None

(*

IS INT

The is_int function returns the boolean true if a string represents an integer, or false if it does not.

Example:

open Utils

let test0 = is_int "abc"
let test1 = is_int "42";;

printf "%b %b\n" test0 test1

*)

let is_int (s:string) : bool = 
  let x = to_int s in
  match x with
  | None -> false
  | _ -> true

(*

TO FLOAT

The to_float function returns a float option.

Example:

open Utils

let print_float_option (x:float option) =
  match x with
  | Some x -> printf "%f\n" x
  | None -> printf "error\n";;

print_float_option(to_float "420.69");
print_float_option(to_float "69")

*)

let to_float (s:string) : float option =
  try Some (float_of_string s)
  with Failure _ -> None

(*

IS FLOAT

The is_float function returns the boolean true if a string represents a float, or false if it does not.

Example:

open Utils

let test0 = is_float "abc"
let test1 = is_float "69.420";;

printf "%b %b\n" test0 test1

*)

let is_float (s:string) : bool = 
  let x = to_float s in
  match x with
  | None -> false
  | _ -> true

(*
   
SLICE COUNT

The slice_count function returns the number of slices in a string, as delmited by an arbitrary character.

Example:

open Utils;;

printf "%i\n" (slice_count "You're,tearing,me,apart,Lisa!" ',')

*)

let slice_count (s:string) (delim:char) : int =
  let rec count_words acc = function
    | [] -> acc
    | "" :: tail -> count_words acc tail
    | _ :: tail -> count_words (acc + 1) tail
  in
  s |> String.split_on_char delim |> count_words 0
