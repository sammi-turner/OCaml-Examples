# OCaml Examples

Small example programs in OCaml.

## Useful shell function

Dune New Project (dnp)

```
dnp() {
  dune init project $1 && cd $1
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
