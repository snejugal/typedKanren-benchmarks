package org.klogic.benchmarks

import org.klogic.core.*
import org.klogic.utils.computing.findTwines
import org.openjdk.jmh.annotations.Benchmark

open class TwinesBenchmark : AbstractKlogicBenchmark() {
    @Benchmark
    fun benchmarkTwines() {
        RelationalContext().useWith {
            findTwines(15)
        }
    }
}
