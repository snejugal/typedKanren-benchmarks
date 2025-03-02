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
…/typedKanren-bechmarks/OCanren $ docker run --rm ocanren-benchmarks
```

The results will be printed to the terminal.

To run memory benchmarks, change the entrypoint to `./mem.sh`:

```
…/typedKanren-bechmarks/OCanren $ docker run --rm --entrypoint ./mem.sh ocanren-benchmarks
+ ./mem_exp3.exe
Peak allocated in major heap: 1474560 B
+ ./mem_log3.exe
Peak allocated in major heap: 983040 B
+ ./mem_quines.exe
Peak allocated in major heap: 173547520 B
+ ./mem_twines.exe
Peak allocated in major heap: 113758208 B
+ ./mem_thrines.exe
Peak allocated in major heap: 150777856 B
```
