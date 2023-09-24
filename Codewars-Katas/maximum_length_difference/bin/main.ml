(*
   
Write a function that takes two arrays of strings. Each string is composed of letters from a to z. 

Return the largest length difference between a string in the first array and a string in the second array as an int option.

If either array is empty, return None.

Example:

a1 = [|"hoqq";"bbllkw";"oox";"ejjuyyy";"plmiis";"xxxzgpsssa";"xxwwkktt";"znnnnfqknaz";"qqquuhii";"dvvvwz"|]
a2 = [|"cccooommaaqqoxii";"gggqaffhhh";"tttoowwwmmww"|]

The maximum difference between a1 and a2 is 13.

*)

let mxdiflg (a : string array) (b : string array) : int option =
  let max_length_a = Array.fold_left (fun acc s -> max acc (String.length s)) 0 a in
  let min_length_a = Array.fold_left (fun acc s -> min acc (String.length s)) max_int a in
  let max_length_b = Array.fold_left (fun acc s -> max acc (String.length s)) 0 b in
  let min_length_b = Array.fold_left (fun acc s -> min acc (String.length s)) max_int b in
  if Array.length a = 0 || Array.length b = 0 then
    None
  else
    Some (max (max_length_a - min_length_b) (max_length_b - min_length_a))

let a1 = [|"hoqq";"bbllkw";"oox";"ejjuyyy";"plmiis";"xxxzgpsssa";"xxwwkktt";"znnnnfqknaz";"qqquuhii";"dvvvwz"|]
let a2 = [|"cccooommaaqqoxii";"gggqaffhhh";"tttoowwwmmww"|]

let num = mxdiflg a1 a2

let ans =
  match num with
  | None -> "There wasn't a max value!"
  | Some num -> string_of_int num

let () = Printf.printf "%s\n" ans
