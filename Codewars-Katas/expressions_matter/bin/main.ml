(*

Given three integers (a, b and c), return the largest number obtained after inserting the following operators and brackets: +, *, ()

Example:

When the numbers are 1, 2 and 3, here are some ways of placing signs and brackets:

1 * (2 + 3) = 5
1 * 2 * 3 = 6
1 + 2 * 3 = 7
(1 + 2) * 3 = 9

The maximum value that you can obtain is 9.

Notes:

The numbers are always positive.
The numbers range from 1 to 10 (inlcusive).
You can use the same operation more than once.
It is not necessary to place all the signs and brackets.
Repetition in numbers may occur.
You cannot cannot change the order in which the operands appear.

*)

let expression_matter (a:int) (b:int) (c:int) =
  let max_pair x y = 
    max (x * y) (x + y)
  in
  max (max_pair (max_pair a b) c)
    (max_pair a (max_pair b c))

let test0 = expression_matter 2 3 5
let test1 = expression_matter 1 2 4
let test2 = expression_matter 3 6 8

let () = Printf.printf "%d\n%d\n%d\n" test0 test1 test2
