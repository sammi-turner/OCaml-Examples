open Utils;;

print_endline "The files in the working directory are:";
let s = shell "ls -1" in
print_endline s