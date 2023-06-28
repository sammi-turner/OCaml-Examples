(*

Given the following definition of "shape"

type shape =
  | Rectangle of float * float
  | Circle of float

write a "sort_by_area" function that takes a list of shapes as its argument and returns a list of shapes that are sorted by ascending area.

The rectangles will have width and length dimensions.

The circles will have a radius dimension.

For example:

shapes = [ Rectangle (4.23, 6.43); Circle 1.23; Circle 3.444; Rectangle (1.342, 3.212) ]
sort_by_area shapes -> [ Rectangle (1.342, 3.212); Circle 1.23; Rectangle (4.23, 6.43); Circle 3.444 ]

*)

type shape =
  | Rectangle of float * float
  | Circle of float

let sort_by_area (shapes:shape list) : shape list =
  let area = function 
  | Circle r -> Float.pi *. r *. r 
  | Rectangle (a, b) -> a *. b in
  List.sort (fun a b -> compare (area a) (area b)) shapes

let rec print_shapes = function
  | [] -> ()
  | Rectangle(w, h) :: shapes ->
      Printf.printf "Rectangle (%f, %f)\n" w h;
      print_shapes shapes
  | Circle(r) :: shapes ->
      Printf.printf "Circle %f\n" r;
      print_shapes shapes

let test = sort_by_area [Rectangle (4.23, 6.43); Circle 1.23; Circle 3.444; Rectangle (1.342, 3.212)];;
print_shapes test
