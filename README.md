# OCaml Examples

## Installation

To install OCaml, follow [these instructions](https://ocaml.org/docs/up-and-running).

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
