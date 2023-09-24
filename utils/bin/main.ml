open Utils

let () =
  start;
  let s = edit_prompt "What is your name? " "Lisa" 30 in
  let final = Printf.sprintf "\n\nYou're tearing me apart %s!\n\nPress any key to close. " s in
  finish final
