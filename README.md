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

## OCaml Syntax Primer

The OCaml entry on [Learn X in Y Minutes](https://learnxinyminutes.com/docs/ocaml/) is very good.

## Book Recommendation

The praise for [Real World OCaml](https://dev.realworldocaml.org/) is well-deserved.

## YouTube Tutorials

I recommend Michael Ryan Clarkson's extensive [OCaml Programming](https://youtube.com/playlist?list=PLre5AT9JnKShBOPeuiD9b-I4XROIJhkIU) playlist.

## AI Code Generation

Large Language Models (LLMs) are only effective for me because I don't trust their output.

I always test the code that they generate!

However, given that OCaml is an old language that is fairly popular in academia, there is a suprising amount of training data for them to work with.

## Function Generation With LLMs

I have had good results with prompts using the following Chat-GPT4 template

```
"Write a [name] function in OCaml that takes [name the parameters and their types] 
and returns a [type] such that [describe what the function does]."
```

## Example of Program Generation with Chat-GPT4

I wrote a lexer for parsing s-expressions and had the following [lengthy conversation with Chat-GPT](https://chat.openai.com/c/b0a5a938-156b-4017-ba73-2329da1a10a2) about how to turn the lexer into a parser, then an evaluator and finally a REPL.

Along the way, the LLM made errors, but when I pointed them out, it was able to self-correct and arrive at a solution.
