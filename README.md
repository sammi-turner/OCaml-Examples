<br>

# OCaml Examples

<br>

## Install Opam

To install opam, follow [these instructions](https://ocaml.org/docs/up-and-running).

<br>

## Building with Dune

To install, run

```sh
opam install dune
```

followed by

```sh
opam init
```

<br>

### Check version

Close the terminal. Then re-open it to determine the version of dune you are running with

```sh
dune --version
```

<br>

### Quiet output

To prevent build progress reports from being printed before your programs run, create a global dune config file.

On unix systems, this will be located at

```sh
~/.config/dune/config
```

Add the following code to the file, replacing 3.15 with the version number that you are running.

```
(lang dune 3.15)
(display quiet)
```

<br>

### Useful shell function

Dune New Project (dnp)

```sh
dnp() {
  dune init project $1 && cd $1 && dune build
}
```

<br>

### Useful shell aliases

Dune Compile and Run (dcr)

```sh
alias dcr='dune build && dune exec ./bin/main.exe'
```

Dune Compile (dc)

```sh
alias dc='dune build'
```

Dune Run (dr)

```sh
alias dr='dune exec ./bin/main.exe'
```

<br>

## Alternative build system

<br>

### Setting up ocamlbuild

1. install ocamlbuild with

```sh
opam install ocamlbuild
```

2. install ocamlfind with

```sh
opam install ocamlfind
```

3. use opam to install any dependencies required by the project.

4. in the project directory, create a _tags file with the following code

```
true: -traverse
```

5. Use the following functions and alias as shortcuts to compile and run your code.

The functions can be run with either zero parameters, or a list of dependencies.

OCaml build (ob)

```sh
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

```sh
obr() {
  if [ $# -eq 0 ]; then
    ocamlbuild -use-ocamlfind main.native && ./main.native
  else
    local pkgs="$*"
    ocamlbuild -use-ocamlfind -pkgs "$pkgs" main.native && ./main.native
  fi
}
```

Run OCaml binary (rob)

```sh
alias rob='./main.native'
```

<br>

### Bogus linting errors

The OCaml Platform extension for VSCode is configured to Dune rather than OCamlbuild, so using OCamlbuild projects with it will generate bogus linting errors.

I don't know if this problem also occurs in terminal-based editors where an OCaml LSP is set up, but I dare say that it might.

One workaround for this problem is to use VSCodium instead of vscode, and to install the OCaml Platform Syntax extension rather than the OCaml Platform extension, but of course, this will only give you OCaml syntax highlighting, not linting or autocompletion.

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

## Function Generation With LLMs

Although I am still wary of using an LLM to create an entire project, they can still be useful for small code snippets.

I have had good results with prompts using the following template

```
Write a [name] function in OCaml that takes
[name the parameters and their types] and returns
a [type] such that [describe what the function does].
```

Another strategy is to provide the LLM with a list of function signatures for a particular utility or feature and ask the LLM to implement the function bodies, one by one, asking for your feedback at each step.

<br>


Along the way, the LLM made errors, but when I pointed them out, it was able to self-correct and arrive at a solution.

<br>
