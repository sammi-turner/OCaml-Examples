open Utils

let () =
  start;
  add "What is your name? ";
  show;
  let name = vinput 20 in
  add "Hello, ";
  add name;
  add "! ";
  show;
  finish "\n\nPress any key to close the virtual terminal. "