package org.klogic.benchmarks

import org.klogic.core.*
import org.klogic.core.Term
import org.klogic.utils.terms.OlegLogicNumber
import org.klogic.utils.terms.OlegLogicNumber.Companion.toOlegLogicNumber
import org.klogic.utils.terms.expᴼ
import org.openjdk.jmh.annotations.Benchmark

open class ExponentBenchmark : AbstractKlogicBenchmark() {
    @Benchmark
    fun benchmarkExponent() {
        val base = 3u.toOlegLogicNumber()
        val power = 5u.toOlegLogicNumber()

        RelationalContext().useWith {
            run(1, { result: Term<OlegLogicNumber> -> expᴼ(base, power, result) })
        }
    }
}
