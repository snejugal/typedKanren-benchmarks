open Benchmark
open Scheme_interpret

let () = Gc.compact();;
let { Gc.heap_words ; _ } = Gc.stat ();;
let () =
    OCanren.(run q) quineso (fun rr -> rr#reify OCanren.Reifier.id)
      |> OCanren.Stream.take ~n:100
      |> ignore;;
let new_stat = Gc.stat ();;
let peak_allocated = new_stat.Gc.top_heap_words - heap_words;;
let () = Printf.printf "Peak allocated in major heap: %d B\n" (peak_allocated * 8);;
