open Utils
open Printf

let () =
  start;
  keypress_off;
  let city = [|"CITIES";"London";"Paris";"Berlin";"Rome"|] in
  let num = select_option city in
  let s = sprintf "\nYou entered option %d. Press any key to close.\n" num in
  finish s