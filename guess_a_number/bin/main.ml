let rec guess_number (num:int) : unit =
  print_string "Guess a number: ";
  let guess = read_int () in
  if guess < num then (
    print_string "Too low! Try again.\n";
    guess_number num
  ) else if guess > num then (
    print_string "Too high! Try again.\n";
    guess_number num
  ) else (
    print_string "You got it!\n"
  )

let () =
  Random.self_init ();
  let actual_number = Random.int 100 in
  print_string "I'm thinking of a number between 0 and 99.\n";
  guess_number actual_number
