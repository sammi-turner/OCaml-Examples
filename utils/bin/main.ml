open Utils

let () =
  start;
  vputs ("What is your name? ");
  let name = vinput 20 in
  vputs ("Hello, " ^ name);
  vputs ("!\n\n");
  finish "Press any key to close the virtual terminal. "