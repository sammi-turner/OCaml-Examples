(*
   
Write an evaporator function that tests the life of an evaporator containing a gas.

The arguments of the function are content of the evaporator (in ml), the percentage of foam or gas lost every day (evap_per_day) and the threshold percentage beyond which the evaporator is no longer useful. 

All the numbers are strictly positive.

The function should return the nth day (as an integer) on which the evaporator will be out of use.

Example:

evaporator 10.0 10.0 5.0 => 29

*)

let evaporator (content:float) (evap_per_day:float) (threshold:float): int = 
  let rec helper curr_content day =
    if curr_content <= (threshold /. 100.0) *. content then
      day
    else
      let next_content = curr_content -. (evap_per_day /. 100.0) *. curr_content in
      helper next_content (day + 1)
  in
  helper content 0

let test = evaporator 10.0 10.0 5.0
let () = Printf.printf "%d\n" test