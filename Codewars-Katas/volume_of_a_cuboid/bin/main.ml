(*

Write a function to calculate the volume of a cuboid with three values: the length, width and height.

*)

let get_volume_of_cuboid (length:int) (width:int) (height:int) : int =
  length * width * height

let test0 = get_volume_of_cuboid 3 5 7
let test1 = get_volume_of_cuboid 2 4 1
let test2 = get_volume_of_cuboid 3 4 6;;

Printf.printf "%d\n%d\n%d\n" test0 test1 test2
