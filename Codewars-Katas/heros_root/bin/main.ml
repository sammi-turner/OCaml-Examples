(*

Hero's Method approximates the square root of a number n by taking an initial guess x, an error e and repeatedly calculating a new approximate integer value x using (x + n / x) / 2. 

The algorithm terminates when the previous x and the new x have an absolute difference less than e.

Write an "int_rac" function that takes positive integer parameters "n" and "guess". Guess will be our initial value of x. Set the parameter "e" to 1.

int_rac will return the count of the progression of integer approximations that Hero's Method makes.

Examples:

int_rac 25 1 has a progression of 1, 13, 7, 5 so our function should return 4.

int_rac 125348 300 has a progression of 300, 358, 354 so our function should return 3.

*)

let int_rac (n : int) (guess : int) =
  let rec aux n x c = 
    let e = 1 in 
    let new_x = (x + n / x) / 2 in 
    if abs (new_x - x) < e then
      c
    else
      aux n new_x (c + 1)
  in
  aux n guess 1

let test0 = int_rac 25 1
let test1 = int_rac 125348 300

let () = Printf.printf "%d %d\n" test0 test1
