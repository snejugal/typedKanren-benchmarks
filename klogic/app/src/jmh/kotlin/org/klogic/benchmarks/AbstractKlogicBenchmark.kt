package org.klogic.benchmarks

import org.openjdk.jmh.annotations.*
import java.util.concurrent.TimeUnit
import javax.management.NotificationListener
import javax.management.NotificationEmitter
import javax.management.Notification
import com.sun.management.GarbageCollectionNotificationInfo
import javax.management.openmbean.CompositeData
import java.lang.management.ManagementFactory

// Code for collecting memory consumption metrics is based on
// https://cruftex.net/2017/03/28/The-6-Memory-Metrics-You-Should-Track-in-Your-Java-Benchmarks.html
// and
// https://github.com/cache2k/cache2k-benchmark/blob/e4cd7a8c491bf275545b3003932c2eebb69606e9/jmh-suite/src/main/java/org/cache2k/benchmark/jmh/GcProfiler.java
@BenchmarkMode(Mode.AverageTime)
@Warmup(iterations = 1)
@Fork(1)
@Measurement(iterations = 1, timeUnit = TimeUnit.MILLISECONDS)
@OutputTimeUnit(TimeUnit.MILLISECONDS)
@State(Scope.Thread)
abstract class AbstractKlogicBenchmark {
    val listener: NotificationListener = object : NotificationListener {
        override fun handleNotification(notification: Notification, obj: Any?) {
            if (!notification.getType().equals(GarbageCollectionNotificationInfo.GARBAGE_COLLECTION_NOTIFICATION)) {
                println(notification.getType())
                return
            }
            val notificationInfo = GarbageCollectionNotificationInfo.from(notification.getUserData() as CompositeData)
            val memoryUsage =
                if (before == null)
                    notificationInfo.getGcInfo().getMemoryUsageAfterGc()
                else
                    notificationInfo.getGcInfo().getMemoryUsageBeforeGc()
            var used: Long = 0
            for ((_, stats) in memoryUsage) {
                used += stats.getUsed()
            }
            if (before == null) {
                before = used
            } else if (used > maxUsed) {
                maxUsed = used
            }
        }
    }
    var maxUsed: Long = 0
    var before: Long? = null

    @Setup
    fun setup() {
        for (bean in ManagementFactory.getGarbageCollectorMXBeans()) {
            (bean as NotificationEmitter).addNotificationListener(listener, null, null)
        }
    }

    @TearDown
    fun teardown() {
        println("\nPeak memory used: ${maxUsed} - ${before} = ${maxUsed - before!!} bytes")
        for (bean in ManagementFactory.getGarbageCollectorMXBeans()) {
            (bean as NotificationEmitter).removeNotificationListener(listener)
        }
    }
}
