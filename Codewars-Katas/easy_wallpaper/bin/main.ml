(*
   
John wants to decorate the walls of a room with wallpaper. He wants a fool-proof method for getting it right.

John knows that the rectangular room has a length of l meters, a width of w meters, a height of h meters. 

The standard width of the rolls he wants to buy is 0.52 meters. The length of a roll is 10 meters. 

He bears in mind however, that it’s best to have an extra length of wallpaper handy in case of mistakes, so he wants to buy a length 15% greater than the one he needs.

The last time he did these calculations he got a headache, so could you help John?

The wallpaper function should return an English word in lower case corresponding to the number of rolls he must buy.

Examples:

wallpaper 4.0 3.5 3.0 => "ten"

wallpaper 0.0 3.5 3.0 => "zero"

Notes:

*)

let wallPaper (l: float) (w: float) (h: float) =
  let t = [|"zero"; "one"; "two"; "three"; "four";
       "five"; "six"; "seven"; "eight"; "nine"; "ten";
       "eleven"; "twelve"; "thirteen"; "fourteen"; "fifteen";
       "sixteen"; "seventeen"; "eighteen"; "nineteen"; "twenty"|]
      in if (l = 0.0 || w = 0.0 || h = 0.0) then
          t.(0)
      else
          t.(truncate(ceil(( ((l +. w) *. 2.0 *. h) /. 5.2) *. 1.15)))

let test0 = wallPaper 4.0 3.5 3.0
let test1 = wallPaper 0.0 3.5 3.0

let () = Printf.printf "%s\n" test0
let () = Printf.printf "%s\n" test1