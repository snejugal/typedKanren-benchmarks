open Benchmark
open Scheme_interpret

let { Gc.top_heap_words ; _ } = Gc.stat ();;
let () =
    OCanren.(run qrs) thrineso (fun rr _ _ -> rr#reify OCanren.Reifier.id)
      |> OCanren.Stream.take ~n:2
      |> ignore;;
let new_stat = Gc.stat ();;
let heap_words = new_stat.Gc.top_heap_words - top_heap_words;;
let () = Printf.printf "Peak allocated in major heap: %d B\n" (heap_words * 8);;
