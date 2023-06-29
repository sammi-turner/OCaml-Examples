(* Define a record type with a mutable field *)
type bank_account = {
  name: string;
  mutable balance: float;
}

(* Function to create a new bank account *)
let create_account (name:string) (balance:float) : bank_account = {
  name; 
  balance;
}

(* Function to deposit into a bank account *)
let deposit (account:bank_account) (amount:float) : unit = 
  account.balance <- account.balance +. amount

(* Function to withdraw from a bank account *)
let withdraw (account:bank_account) (amount:float) : unit = 
  if amount > account.balance then 
    raise (Failure "Insufficient funds")
  else 
    account.balance <- account.balance -. amount

(* Function to print the current balance of a bank account *)
let print_balance (account:bank_account) : unit = 
  print_string ("Balance of " ^ account.name ^ ": " ^ string_of_float account.balance ^ "\n")

let account = create_account "John Doe" 1000.0;;
deposit account 500.0;
print_balance account;
withdraw account 200.0;
print_balance account
