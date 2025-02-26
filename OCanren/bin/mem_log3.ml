open Benchmark
open Numero_decls

let wrap_test ?(n = 1) ~reifier goal () =
  OCanren.(run q) goal (fun rr -> rr#reify reifier) |> OCanren.Stream.take ~n |> ignore
;;

let { Gc.top_heap_words ; _ } = Gc.stat ();;
let () =
    wrap_test ~reifier:OCanren.Reifier.id (fun q ->
      logo (build_num 243) (build_num 3) q zero) ();;
let new_stat = Gc.stat ();;
let heap_words = new_stat.Gc.top_heap_words - top_heap_words;;
let () = Printf.printf "Peak allocated in major heap: %d B\n" (heap_words * 8);;
