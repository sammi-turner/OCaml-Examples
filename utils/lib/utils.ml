open Curses

(*
   
IS UNIX

The is_unix function returns true if the program is being run on a unix-like operating system, or false if it is not.

Example :

open Utils

let v = is_unix ()
let () =
  match v with
  | true -> print_string "Its Unix."
  | false -> print_string "Its not Unix."

*)

let is_unix () : bool =
  let os_type = Sys.os_type in
  match os_type with
  | "Unix" | "Cygwin" | "MacOS" -> true
  | _ -> false

(*
   
READ FILE

The read_file function returns a string option.

Example:

open Utils

let print_file_contents (x:string option) : unit =
  match x with
  | Some x -> print_string x
  | None -> print_string "That file does not exist in the working directory."

let () = print_file_contents (read_file "example.txt")

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

open Utils

let () = write_file "example.txt" "Oh, hi Mark!"

*)

let write_file (name:string) (content:string) : unit =
  let oc = open_out name in
  output_string oc content;
  close_out oc

(*
   
APPEND TO FILE

The append_to_file function either appends a string to a file, or writes to the file if it does not already exist.

Example:

open Utils

let () = append_to_file "example.txt" "Oh, hi Mark!"

*)

let append_to_file (name:string) (content:string) : unit =
  let channel = open_out_gen [Open_append; Open_creat] 0o666 name in
  output_string channel content;
  close_out channel

(*
   
DELETE FILE

The delete_file function attempts to delete a file from the working directory.

Example:

open Utils

let () = delete_file "example.txt"

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
let die2 = pseudo 6

let () = Printf.printf "%d %d %d" die0 die1 die2

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

let test = slices_to_string ["You're";"tearing";"me";"apart";"Lisa!"] ' '
let () = print_string test

*)

let slices_to_string (lst:string list) (ch:char) : string =
  let rec join acc = function
    | [] -> acc
    | [x] -> acc ^ x
    | x :: xs -> join (acc ^ x ^ String.make 1 ch) xs
  in
  join "" lst

(*
   
COUNT CHAR INSTANCES

The count_char_instances function returns the number of instances of a char in a string.

Example:

open Utils

let char_count = count_char_instances "What a story Mark" 'a'
let () = print_int char_count

*)

let count_char_instances (s:string) (c:char) : int =
  let rec count_helper i count =
    if i < 0 then count
    else if s.[i] = c then count_helper (i - 1) (count + 1)
    else count_helper (i - 1) count
  in
  count_helper (String.length s - 1) 0

(*
   
COUNT STRING INSTANCES

The count_string_instances function returns the integer number of instances of a string in a list of strings.

Example:

open Utils

let lst = ["Oh";"Denny";"Denny";"Denny";"boy"]
let count = count_string_instances lst "Denny"
let () = print_int count

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

open Utils

let () = print_string (nth_slice 3 "This is a test" ' ')

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
let test2 = is_digit 'a'

let () = Printf.printf "%b %b %b" test0 test1 test2

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

let () = Printf.printf "%b %b %b" test0 test1 test2

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
let test2 = is_upper_case ' '

let () = Printf.printf "%b %b %b" test0 test1 test2

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
  | Some x -> print_int x
  | None -> print_string "error"

let () = print_int_option(to_int "420.69")
let () = print_string(" ")
let () = print_int_option(to_int "69")

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
let test1 = is_int "42"

let () = Printf.printf "%b %b" test0 test1

*)

let is_int (s:string) : bool = 
  let x = to_int s in
  match x with
  | None -> false
  | _ -> true

(*
   
SLICE COUNT

The slice_count function returns the number of slices in a string, as delmited by an arbitrary character.

Example:

open Utils

let () = print_int (slice_count "You're,tearing,me,apart,Lisa!" ',')

*)

let slice_count (s:string) (delim:char) : int =
  let rec count_words acc = function
    | [] -> acc
    | "" :: tail -> count_words acc tail
    | _ :: tail -> count_words (acc + 1) tail
  in
  s |> String.split_on_char delim |> count_words 0

(*
   
VIRTUAL TERMINAL FUNCTIONS

- The start function opens the virtual terminal.
- The finish function alerts the user with a string, then closes the virtual terminal on the next keypress.
- The vputs function prints text to the virtual terminal.
- The vinput function takes input from the user in the virtual terminal up to a maximum length.
- The cursor_on and cursor_off functions control the visibility of the cursor in the virtual terminal.
- The keypress_on and keypress_off functions control the visibility of key presses in the virtual terminal.
- The render_menu function is a helper for select_option.
- The select_option function allows the user to select an item from a menu.
- The render_prompt function is a helper for edit_prompt.
- The edit_prompt function prompts the user to edit an existing buffer.

Example:

open Utils

let () =
  start;
  keypress_off;
  let city = [|"CITIES";"London";"Paris";"Berlin";"Rome"|] in
  let num = select_option city in
  let s = Printf.sprintf "\nYou entered option %d. Press any key to close.\n" num in
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
  let zero = Char.chr 0 in
  nth_slice 0 buffer zero

let cursor_on : unit =
  ignore (curs_set(1))

let cursor_off : unit =
  ignore (curs_set(0))

let keypress_on : unit =
  ignore (echo())

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

let renderPrompt (prompt:string) (buffer:string) (pos:int) : unit =
  clear ();
  let s = ref prompt in
  for i = 0 to pos - 1 do
    s := !s ^ (String.make 1 buffer.[i])
  done;
  vputs !s
  
let edit_prompt (prompt:string) (buffer:string) (max:int) : string =
  let ch = ref 0 in
  let exit = ref false in
  let result = ref buffer in
  let pos = ref (String.length buffer) in
  let res = ref !pos in
  renderPrompt prompt !result !pos;

  while not !exit && !pos < max do
    ch := getch ();

    if !ch = Key.left && !pos > 0 then
      pos := !pos - 1;

    if !ch = Key.right && !res > !pos then
      pos := !pos + 1;

    if (!ch = Key.backspace || !ch = 127 || !ch = Char.code '\b') && !pos > 0 then (
      pos := !pos - 1;
      res := !res - 1;
      let new_result = String.sub !result 0 !pos ^ String.sub !result (!pos + 1) (!res - !pos) in
      result := new_result
    )
    else if !ch > 31 && !ch < 127 then (
      if !pos < !res then (
        let new_result = String.sub !result 0 !pos ^ String.make 1 (Char.chr !ch) ^ String.sub !result !pos (!res - !pos) in
        result := new_result;
        pos := !pos + 1
      ) else (
        result := !result ^ String.make 1 (Char.chr !ch);
        pos := !pos + 1;
        res := !res + 1
      )
    )
    else if !ch = Char.code '\n' then
      exit := true;

    renderPrompt prompt !result !pos
  done;
  !result
