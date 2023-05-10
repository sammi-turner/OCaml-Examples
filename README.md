# OCaml Examples

## Installation

To install OCaml, follow [these instructions](https://ocaml.org/docs/up-and-running).

## YouTube Tutorials

I highly recommend Michael Ryan Clarkson's extensive [OCaml Programming](https://youtube.com/playlist?list=PLre5AT9JnKShBOPeuiD9b-I4XROIJhkIU) playlist.

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
