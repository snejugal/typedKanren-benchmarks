package org.klogic.benchmarks

import org.klogic.core.*
import org.klogic.utils.computing.findThrines
import org.openjdk.jmh.annotations.Benchmark

open class ThrinesBenchmark : AbstractKlogicBenchmark() {
    @Benchmark
    fun benchmarkThrines() {
        RelationalContext().useWith {
            findThrines(3)
        }
    }
}
