(*
   
Find the total sum of internal angles (in degrees) in an n-sided simple polygon.

n will be greater than 2.

Examples:

3 => 180
4 => 360
5 => 540

*)

let angle (n:int) = (n - 2) * 180

let test3 = angle 3
let test4 = angle 4
let test5 = angle 5

let () = Printf.printf "%d %d %d\n" test3 test4 test5