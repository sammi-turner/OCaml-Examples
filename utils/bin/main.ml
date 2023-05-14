open Utils

let test0 = ["had";"a";"little"]
let test1 = "Mary" :: test0
let test2 = test1 @ ["lamb."]
let () = print_list test2
