(*
   
Write a function that checks if a given string (case insensitive) is a palindrome. 

A palindrome is a word, number, phrase, or other sequence of symbols that reads the same backwards as forwards, 
such as madam or racecar, the date and time 12/21/33 12:21, and the sentence: "A man, a plan, a canal – Panama".

Examples:

is_palindrome "Abba" => true
is_palindrome "Hello" => false
is_palindrome "wow" => true

*)

let is_palindrome (s:string) =
  let len = String.length s in
  let lower = String.lowercase_ascii s in
  let rec loop i =
    if i >= len / 2 then true
    else if lower.[i] <> lower.[len - i - 1] then false
    else loop (i + 1)
  in
  loop 0

let test0 = is_palindrome "Abba"
let test1 = is_palindrome "Hello"
let test2 = is_palindrome "wow"

let () = Printf.printf "%b\n%b\n%b\n" test0 test1 test2
