(*
   
Write a "longest" function that has strings s1 and s2 as parameters.

s1 and s2 consist only of letters from a to z. 

The function should return the longest possible sorted string, containing only distinct letters from s1 and s2, with no repetition of letters.

Examples:

a = "xyaabbbccccdefww"
b = "xxxxyyyyabklmopq"

longest a b -> "abcdefklmopqwxy"

a = "abcde"
b = "defgh"

longest a b -> "abcdefgh"

*)

let longest (s1:string) (s2:string) =
  let chars = List.sort_uniq Char.compare (List.append (String.to_seq s1 |> List.of_seq) (String.to_seq s2 |> List.of_seq)) in
  String.of_seq (List.to_seq chars)

let test0 = longest "xyaabbbccccdefww" "xxxxyyyyabklmopq"
let test1 = longest "abcde" "defgh"
let () = Printf.printf "%s\n%s\n" test0 test1