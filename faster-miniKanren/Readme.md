# `faster-miniKanren` benchmarks

The benchmarks are based on the ones from the [`miniKanren_exec_order`][src]
repository. However,

- we use `faster-miniKanren` from the Racket package catalog;
- we use regular `run` instead of custom `myrun` for benchmarking quine
  generation.

The implementation of the Scheme interpreter is taken from that repository, for
it's closer with implementations in other languages.

[src]: https://github.com/Kakadu/miniKanren_exec_order/tree/miniKanren2023/racket/bench

## Running

When in the Nix shell, run

```
…/typedKanren-bechmarks/faster-miniKanren $ raco pkg install faster-minikanren benchmark
…/typedKanren-bechmarks/faster-miniKanren $ racket benchmarks.rkt
```

(It seems that installing racket packages declaratively in Nix is not possible.)

The results of benchmarks will be printed to the terminal.
