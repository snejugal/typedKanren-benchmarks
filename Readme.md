# typedKanren vs other miniKanren implementations

This repository contains benchmarks for [typedKanren], [faster-miniKanren],
[OCanren], and [klogic]. Benchmarks for the last three implementations are based
on the benchmarks from the paper “klogic: miniKanren in Kotlin” by Kamenev _et
al._ from [this repository][klogic-benchmarks]. Changes are described in
separate Readme files in each subdirectory.

[typedKanren]: https://github.com/SnejUgal/typedKanren
[faster-miniKanren]: https://github.com/michaelballantyne/faster-minikanren
[OCanren]: https://github.com/PLTools/OCanren
[klogic]: https://github.com/UnitTestBot/klogic
[klogic-benchmarks]: https://github.com/Kakadu/miniKanren_exec_order

This repository provides a Nix flake with a shell in which benchmarks can be
easily run. One exception is OCanren benchmarks because one of its transitive
dependencies fails to build on NixOS. For OCanren, we provide a Docker container
which runs the benchmarks.

## Running benchmarks

To run typedKanren benchmarks, `cd` into its subdirectory, start the shell with
`nix develop`, and run benchmarks with `stack bench`. Results will be printed to
the terminal.

To run benchmarks for other implementations, start this repository's shell with
`nix develop`, then `cd` into one of the corresponding subdirectories, and
follow the instructions in the Readme.
