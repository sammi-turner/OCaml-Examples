open Utils

let sentence = "Mary   had   a   little   lamb"
let words = sentence_to_words sentence
let test = words_to_sentence words
let () = Printf.printf "Sentence: %s.\n" test
