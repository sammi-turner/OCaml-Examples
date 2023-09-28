open Curses
open Printf

(* Utility functions *)

let start : unit =
  let win = initscr () in
  ignore (keypad win true);
  scrollok win true;
  winch_handler_on ()

let vputs (s:string) : unit =
  ignore (addstr s);
  ignore (refresh())

let finish (s:string) : unit =
  vputs s;
  ignore (getch ());
  endwin ()

let cursor_off : unit =
  ignore (curs_set(0))

(* Game class *)

class game = object(self)
  val mutable dice = Array.make 7 0
  val mutable scores = Array.make 13 0
  
  method default_dice () : unit =
    dice.(0) <- 5;
    for i = 1 to 6 do
      dice.(i) <- 0
    done
  
  method default_scores () : unit =
    for i = 0 to 12 do
      scores.(i) <- -1
    done
  
  method numeric_input () : int =
    cursor_off;
    let num = getch () in
    (num - 48)
  
  method pseudo (n:int) : int =
    Random.self_init ();
    match n with
    | _ when n > 0 -> Random.int(n) + 1
    | _ -> 0
  
  method dice_count : unit =
    let rec loop () =
      if dice.(0) > 0 then (
        let roll = self#pseudo 6 in
        dice.(0) <- dice.(0) - 1;
        dice.(roll) <- dice.(roll) + 1;
        loop ()
      )
    in
    loop ()

  method player_rerolls : unit =
    for i = 1 to 6 do
      if dice.(i) > 0 then (
        let _ = self#score_card in
        let s = sprintf "How many %ds do you wish to re-roll? " i in
        vputs s;
        let x = self#numeric_input () in
        if x > 0 && x <= dice.(i) then (dice.(i) <- dice.(i) - x; dice.(0) <- dice.(0) + x)
      )
    done

  method score_card : unit =
    clear ();
    vputs "\n    SCORE CARD\n";

    let _ = 
    vputs "\n    Ones                     ";
    match scores.(0) with
      | -1 -> vputs "a"
      | _ -> vputs (string_of_int(scores.(0))) in

    let _ = 
    vputs "\n    Twos                     ";
    match scores.(1) with
      | -1 -> vputs "b"
      | _ -> vputs (string_of_int(scores.(1))) in

    let _ = 
    vputs "\n    Threes                   ";
    match scores.(2) with
      | -1 -> vputs "c"
      | _ -> vputs (string_of_int(scores.(2))) in

    let _ = 
    vputs "\n    Fours                    ";
    match scores.(3) with
      | -1 -> vputs "d"
      | _ -> vputs (string_of_int(scores.(3))) in

    let _ = 
    vputs "\n    Fives                    ";
    match scores.(4) with
      | -1 -> vputs "e"
      | _ -> vputs (string_of_int(scores.(4))) in

    let _ = 
    vputs "\n    Sixes                    ";
    match scores.(5) with
      | -1 -> vputs "f"
      | _ -> vputs (string_of_int(scores.(5))) in

    let _ = 
    vputs "\n    Three of a Kind          ";
    match scores.(6) with
      | -1 -> vputs "g"
      | _ -> vputs (string_of_int(scores.(6))) in

    let _ = 
    vputs "\n    Four of a Kind           ";
    match scores.(7) with
      | -1 -> vputs "h"
      | _ -> vputs (string_of_int(scores.(7))) in

    let _ = 
    vputs "\n    Full House               ";
    match scores.(8) with
      | -1 -> vputs "i"
      | _ -> vputs (string_of_int(scores.(8))) in

    let _ = 
    vputs "\n    Small Straight           ";
    match scores.(9) with
      | -1 -> vputs "j"
      | _ -> vputs (string_of_int(scores.(9))) in

    let _ = 
    vputs "\n    Large Straight           ";
    match scores.(10) with
      | -1 -> vputs "k"
      | _ -> vputs (string_of_int(scores.(10))) in

    let _ = 
    vputs "\n    Chance                   ";
    match scores.(11) with
      | -1 -> vputs "l"
      | _ -> vputs (string_of_int(scores.(11))) in

    let _ = 
    vputs "\n    Yahtzee                  ";
    match scores.(12) with
      | -1 -> vputs "m"
      | _ -> vputs (string_of_int(scores.(12))) in

    let s = sprintf "
         
    DICE HELD

    %d 1s, %d 2s, %d 3s, %d 4s, %d 5s and %d 6s.
    You have %d re-rolls.\n
    " dice.(1) dice.(2) dice.(3) dice.(4) dice.(5) dice.(6) dice.(0) in
    vputs s
    
  method scoring_selection : unit =
    let loop =
      self#score_card in
      vputs "Which scorebox? ";
      ignore (curs_set(0));
      let x = getch () in
      match x with
      | 97 -> if scores.(0) == -1 then scores.(0) <- dice.(1) else loop
      | 98 -> if scores.(1) == -1 then scores.(1) <- (dice.(2) * 2) else loop
      | 99 -> if scores.(2) == -1 then scores.(2) <- (dice.(3) * 3) else loop
      | 100 -> if scores.(3) == -1 then scores.(3) <- (dice.(4) * 4) else loop
      | 101 -> if scores.(4) == -1 then scores.(4) <- (dice.(5) * 5) else loop
      | 102 -> if scores.(5) == -1 then scores.(5) <- (dice.(6) * 6) else loop
      | 103 -> if scores.(6) == -1 then scores.(6) <- self#three_of_a_kind else loop
      | 104 -> if scores.(7) == -1 then scores.(7) <- self#four_of_a_kind else loop
      | 105 -> if scores.(8) == -1 then scores.(8) <- self#full_house else loop
      | 106 -> if scores.(9) == -1 then scores.(9) <- self#small_straight else loop
      | 107 -> if scores.(10) == -1 then scores.(10) <- self#large_straight else loop
      | 108 -> if scores.(11) == -1 then scores.(11) <- self#total_of_dice else loop
      | 109 -> if scores.(12) == -1 then scores.(12) <- self#yahtzee else loop
      | _ -> loop

  method total_of_dice : int =
    dice.(1) + (dice.(2) * 2) + (dice.(3) * 3) + (dice.(4) * 4) + (dice.(5) * 5) + (dice.(6) * 6)

  method three_of_a_kind : int =
    if (dice.(1) > 2) || (dice.(2) > 2) || (dice.(3) > 2) || (dice.(4) > 2) || (dice.(5) > 2) || (dice.(6) > 2) then
      self#total_of_dice
    else 0

  method four_of_a_kind : int =
    if (dice.(1) > 3) || (dice.(2) > 3) || (dice.(3) > 3) || (dice.(4) > 3) || (dice.(5) > 3) || (dice.(6) > 3) then
      self#total_of_dice
    else 0

  method yahtzee : int =
    if (dice.(1) == 5) || (dice.(2) == 5) || (dice.(3) == 5) || (dice.(4) == 5) || (dice.(5) == 5) || (dice.(6) == 5) then 50 else 0

  method full_house : int =
    let triple_test = (dice.(1) == 3) || (dice.(2) == 3) || (dice.(3) == 3) || (dice.(4) == 3) || (dice.(5) == 3) || (dice.(6) == 3) in
    let pair_test = (dice.(1) == 2) || (dice.(2) == 2) || (dice.(3) == 2) || (dice.(4) == 2) || (dice.(5) == 2) || (dice.(6) == 2) in
    if (triple_test && pair_test) || (self#yahtzee == 50) then 25 else 0

  method small_straight : int =
    let test1 = (dice.(1) > 0) || (dice.(2) > 0) || (dice.(3) > 0) || (dice.(4) > 0) in
    let test2 = (dice.(2) > 0) || (dice.(3) > 0) || (dice.(4) > 0) || (dice.(5) > 0) in
    let test3 = (dice.(3) > 0) || (dice.(4) > 0) || (dice.(5) > 0) || (dice.(6) > 0) in
    if (test1 || test2 || test3) then 30 else 0

  method large_straight : int =
    let test1 = (dice.(1) > 0) || (dice.(2) > 0) || (dice.(3) > 0) || (dice.(4) > 0) || (dice.(5) > 0) in
    let test2 = (dice.(2) > 0) || (dice.(3) > 0) || (dice.(4) > 0) || (dice.(5) > 0) || (dice.(6) > 0) in
    if (test1 || test2) then 40 else 0

  method upper_total : int =
    scores.(0) + scores.(1) + scores.(2) + scores.(3) + scores.(4) + scores.(5)

  method upper_bonus : int =
    if self#upper_total > 62 then 35 else 0
    
  method grand_total : int =
    self#upper_total + self#upper_bonus + scores.(6) + scores.(7) + scores.(8) + scores.(9) + scores.(10) + scores.(11) + scores.(12)

  method output_scores : unit =
    clear ();
    let output = sprintf "

        FINAL SCORE CARD

        Ones                     %d
        Twos                     %d
        Threes                   %d
        Fours                    %d
        Fives                    %d
        Sixes                    %d
        Upper Total              %d
        Upper Bonus              %d
        Three of a Kind          %d
        Four of a Kind           %d
        Full House               %d
        Small Straight           %d
        Large Straight           %d
        Chance                   %d
        Yahtzee                  %d
        
        GRAND TOTAL              %d\n
    "
    scores.(0) scores.(1) scores.(2) scores.(3) scores.(4) scores.(5) self#upper_total self#upper_bonus 
    scores.(6) scores.(7) scores.(8) scores.(9) scores.(10) scores.(11) scores.(12) self#grand_total in
    vputs output;
    let channel = open_out_gen [Open_append; Open_creat] 0o666 "scores.txt" in
    output_string channel output;
    close_out channel
  
  method main_loop : unit =
    self#default_scores ();
    for _ = 0 to 12 do
      self#default_dice ();
      self#dice_count;
      self#player_rerolls;
      if dice.(0) > 0 then
        begin
          self#dice_count;
          self#player_rerolls;
        end;
      begin
        self#dice_count;
        self#scoring_selection;
      end
    done;
    self#output_scores
end

(* Entry point *)

let () =
  start
  let instance = new game;;
  instance#main_loop;
  finish "    Good game! Press any key to close. "
