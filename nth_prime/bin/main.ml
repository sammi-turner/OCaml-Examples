let is_prime (n:int) : bool =
  let rec is_not_divisible_from_2_to divisor =
    divisor * divisor > n || (n mod divisor <> 0 && is_not_divisible_from_2_to (divisor + 1)) in
  n = 2 || (n > 2 && is_not_divisible_from_2_to 2)

let nth_prime (n:int) : int =
  let rec find_prime candidate counter =
    if is_prime candidate then
      if counter = n then candidate
      else find_prime (candidate + 1) (counter + 1)
    else
      find_prime (candidate + 1) counter in
  find_prime 2 0

let () = Printf.printf "%d %d %d %d\n"  (nth_prime 0) (nth_prime 1) (nth_prime 2) (nth_prime 3)
