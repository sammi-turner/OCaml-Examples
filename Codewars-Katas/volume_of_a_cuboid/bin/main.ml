(*

Write a function to calculate the volume of a cuboid with three values: the length, width and height.

*)

let get_volume_of_cuboid (length: int) (width: int) (height: int): int =
  length * width * height

let r0 = get_volume_of_cuboid 3 5 7
let r1 = get_volume_of_cuboid 2 4 1
let r2 = get_volume_of_cuboid 3 4 6

let () = Printf.printf "%d\n" r0
let () = Printf.printf "%d\n" r1
let () = Printf.printf "%d\n" r2
