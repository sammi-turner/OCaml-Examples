open Utils

let sentence = "Mary,had,a,little,lamb"
let slices = sentence_to_slices sentence ','
let test = slices_to_sentence slices ' '
let () = Printf.printf "Sentence: %s.\n" test