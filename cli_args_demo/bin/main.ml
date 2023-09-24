let () =
  let argc = Array.length Sys.argv in
  for i = 1 to argc - 1 do
    Printf.printf " %d. %s |" i Sys.argv.(i)
  done
