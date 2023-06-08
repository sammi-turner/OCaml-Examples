# OCaml Examples

## Install Opam

To install opam, follow [these instructions](https://ocaml.org/docs/up-and-running).

## Install Dune

When opam has been installed properly, run

```
opam install dune
```

## Check Dune Version

Determine the version of dune you are running with the command

```
dune --version
```

## Quiet output

To prevent build progress reports from being printed before your programs run, create a global dune config file.

On unix systems, this will be located at

```
~/.config/dune/config
```

Add the following code to the file, replacing 3.7 with the version number that you are running.

```
(lang dune 3.7)
(display quiet)
```

## Useful shell function

Dune New Project (dnp)

```
dnp() {
  dune init project $1 && cd $1 && dune build
}
```

## Useful shell aliases

Dune Compile and Run (dcr)

```
alias dcr='dune build && dune exec ./bin/main.exe'
```

Dune Compile (dc)

```
alias dc='dune build'
```

Dune Run (dr)

```
alias dr='dune exec ./bin/main.exe'
```

## YouTube Tutorials

I highly recommend Michael Ryan Clarkson's extensive [OCaml Programming](https://youtube.com/playlist?list=PLre5AT9JnKShBOPeuiD9b-I4XROIJhkIU) playlist.

## Chat-GPT Code Generation

Given that OCaml is a mature language which is popular in academia, with a fairly terse syntax and lots of training data available online, the quality of Chat-GPT generated code on small problems is surprisingly good.

I have had the best results with prompts using the following template

```
"Write a [name] function in OCaml that takes [name the parameters and their types] 
and returns a [type] such that [describe what the function does]."
```

However, it is very important to test the functions generated by the LLM.

If attempting to compile the code generates syntax errors, copy the first reported error and feed it back to Chat-GPT as part of the conversation in this format

```
That code gives me the following error : [paste error message here]
```

Repeat this process until either the code compiles, or the LLM keeps repeating the same mistake.

In the event of repetitive mistakes from Chat-GPT, press the "regenerate response" button.

If the generated code compiles, but the generated function does not behave as expected, try the following steps in order.

```
1. Check the wording of the problem statement. Should it be reworded?
2. Are there any subtle errors in the code, which you can correct manually?
3. Press the "regenerate response" button.
```
