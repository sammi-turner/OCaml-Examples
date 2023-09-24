(*
   
Find the total sum of internal angles (in degrees) in an n-sided simple polygon.

n will be greater than 2.

Examples:

3 => 180
4 => 360
5 => 540

*)

let angle (n:int) : int = 
  (n - 2) * 180

let () = Printf.printf "%d %d %d\n" (angle 3) (angle 4) (angle 5)
