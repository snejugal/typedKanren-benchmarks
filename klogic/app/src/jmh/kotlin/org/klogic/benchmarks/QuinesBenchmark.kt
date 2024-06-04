package org.klogic.benchmarks

import org.klogic.core.*
import org.klogic.utils.computing.findQuines
import org.openjdk.jmh.annotations.Benchmark

open class QuinesBenchmark : AbstractKlogicBenchmark() {
    @Benchmark
    fun benchmarkQuines() {
        RelationalContext().useWith {
            findQuines(100)
        }
    }
}
