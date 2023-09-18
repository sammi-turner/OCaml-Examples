open Utils
open Curses

let () =
  start;
  cursor_off;
  keypress_off;
  vputs ("Press an arrow key...\n");
  let quit_loop = ref false in
  while not !quit_loop do
    let ch = getch () in
    if ch == Key.up then vputs "up\n"
    else if ch == Key.down then vputs "down\n"
    else if ch == Key.left then vputs "left\n"
    else if ch == Key.right then vputs "right\n"
    else quit_loop := true
  done