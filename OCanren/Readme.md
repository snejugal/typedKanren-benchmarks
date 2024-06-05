# OCanren benchmarks

The benchmarks are based on the ones from the [`miniKanren_exec_order`][src]
repository. However, we extracted only the relevant files and removed unused
code under `IFDEF`s. It also turned out that the original repository patched
OCanren in a submodule, so we pushed these patches to a fork for easier
reproducibility.

[src]: https://github.com/Kakadu/miniKanren_exec_order/tree/miniKanren2023/ocaml/bench

## Running

One transitive dependency of OCanren fails to compile under NixOS. Because of
this, we had to resort to Docker containers.

```
…/typedKanren-bechmarks/OCanren $ docker build -t ocanren-benchmarks .
…/typedKanren-bechmarks/OCanren $ docker run ocanren-benchmarks
```

The results will be printed to the terminal.
