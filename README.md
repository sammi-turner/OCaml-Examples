<br>

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

If you don't need all that, then you can use OCamlbuild instead.

<br>

## Bogus linting errors

The OCaml Platform extension for VSCode is configured to Dune rather than OCaml, so using OCamlbuild projects with it will generate bogus linting errors.

I don't know if this problem also occurs in terminal-based editors where an OCaml LSP is set up, but I dare say that it might.

One workaround for this problem is to use VSCodium instead of vscode, and to install the OCaml Platform Syntax extension rather than the OCaml Platform extension, but of course, this will only give you OCaml syntax highlighting, not linting or autocompletion.

<br>

### Useful shell functions

These functions can be run with either zero parameters, or a list of dependencies.

OCaml build (ob)

```
ob() {
  if [ $# -eq 0 ]; then
    ocamlbuild -use-ocamlfind main.native
  else
    local pkgs="$*"
    ocamlbuild -use-ocamlfind -pkgs "$pkgs" main.native
  fi
}
```

OCaml build and run (obr)

```
obr() {
  if [ $# -eq 0 ]; then
    ocamlbuild -use-ocamlfind main.native && ./main.native
  else
    local pkgs="$*"
    ocamlbuild -use-ocamlfind -pkgs "$pkgs" main.native && ./main.native
  fi
}
```

<br>

### Useful shell alias

Run OCaml binary (rob)

```
alias rob='./main.native'
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

## Hacking the context window limit

Although feeding errors back to Chat-GPT4 can yield good results, sometimes a conversation will drag on so long that the LLM "forgets" what you are talking about and the chatbots answers rapidly become useless.

This is because of a fundamental limit built into the LLM. Namely the maximum size of its context window. The size of the context grows as the conversation progresses.

To avoid running up against this limit when you are working on a code generation task, simply delete the chat you are using, start a new one, attach the source code that needs fixing to the chat (the "Advanced Data Analytics" plugin should be enabled), tell the chatbot that there are syntax errors or unexpected behaviour and ask for its help.

This process can be repeated as often as necessary!

<br>
