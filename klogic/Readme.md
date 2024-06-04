# KLogic benchmarks

The benchmarks are taken from the [KLogic repository][src]. However, we made
some changes:

- removed `SortingBenchmark`;
- changed `LogarithmBenchmark` to calculate $\log_3 243$, in line with
  benchmarks for other languages;
- removed dependency on test fixtures by inlining `withEmptyContext`.

[src]: https://github.com/UnitTestBot/klogic/tree/main/klogic-benchmarks/src/jmh/kotlin/org/klogic/benchmarks

## Running

When in the Nix shell, run

```bash
…/typedKanren-benchmarks/klogic $ gradle jmh
```

Results will be printed to the terminal as well as saved in
`./app/build/results/jmh/results.txt`.
