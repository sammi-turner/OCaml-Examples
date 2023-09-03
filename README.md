# OCaml Examples

<br>

## Install Opam

To install opam, follow [these instructions](https://ocaml.org/docs/up-and-running).

<br>

## Building with Dune

To install, run

```
opam install dune
```

<br>

### Check version

Determine the version of dune you are running with

```
dune --version
```

<br>

### Quiet output

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

<br>

### Useful shell function

Dune New Project (dnp)

```
dnp() {
  dune init project $1 && cd $1 && dune build
}
```

<br>

### Useful shell aliases

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

<br>

## Building with OCamlbuild

Dune creates a file structure with lots of config files. 

If you don't need all that, then you can use OCamlbuild instead, but be warned that you may have to disable your current linting tool, or you will get bogus linting errors!

<br>

### To compile a native binary

```
ocamlbuild -use-ocamlfind main.native
```

<br>

### To run the binary

```
./main.native
```

<br>

### To compile and run the binary

```
ocamlbuild -use-ocamlfind main.native && ./main.native
```

<br>

### Linking dependencies

Replace "your_opam_packages" with the correct dependency names.

```
ocamlbuild -use-ocamlfind -pkgs your_opam_packages main.native
```

<br>

### Can I delete the build folder?

You can delete the build folder, but keeping it will make re-compilation faster.

<br>

## OCaml Syntax Primer

The OCaml entry on [Learn X in Y Minutes](https://learnxinyminutes.com/docs/ocaml/) is very good.

<br>

## Language Overview

The Read World OCaml site has a great [Guided Tour](https://dev.realworldocaml.org/guided-tour.html).

<br>

## YouTube Tutorials

For video tutorials, I recommend Michael Ryan Clarkson's extensive [OCaml Programming](https://youtube.com/playlist?list=PLre5AT9JnKShBOPeuiD9b-I4XROIJhkIU) playlist.

<br>

## AI Code Generation

Large Language Models (LLMs) are only effective for me because I don't trust their output.

I always test the code that they generate!

However, given that OCaml is an old language that is fairly popular in academia, there is a suprising amount of training data for them to work with.

<br>

## Function Generation With LLMs

I have had good results with prompts using the following template

```
"Write a [name] function in OCaml that takes [name the parameters and their types] 
and returns a [type] such that [describe what the function does]."
```

<br>

## Example of Program Generation with Chat-GPT4

I wrote a lexer for parsing s-expressions and had the following [lengthy conversation with Chat-GPT](https://chat.openai.com/share/a11e1f50-dce6-4e11-b351-9b4c02d52443) about how to turn the lexer into a parser, then an evaluator and finally a REPL.

Along the way, the LLM made errors, but when I pointed them out, it was able to self-correct and arrive at a solution.

<br>

## My current Chat-GPT4 custom instructions

Enable the "advanced data analysis" features and plug-ins.

```
Do not remind me that you are an AI language model. 

Avoid "friendly assistant" boilerplate. 

Be straight to the point, direct and concrete.

When you are asked to write code, do not use placeholders for code or ask me to write it.

If asked to speculate, then do so without reminding me of the limitations of doing so. 

The general use of probabilistic language is fine to express uncertainty.

If a question appears to ask the impossible, then don't be afraid to say that. 

Don't bend over backwards to provide an impossible answer. 

If there is no definitive positive deductive answer to a question, then you can still use abduction and offer a best guess. 

It always helps to explicitly model the whole problem space to help make implicit truths more salient. 

Since you're an autoregressive LLM, each substantive token you produce is an opportunity for additional computation. 

If you try to leap to conclusions, then you will likely get it wrong.
```

<br>
