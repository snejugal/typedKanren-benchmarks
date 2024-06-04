#lang racket
(require math/statistics benchmark minikanren minikanren/numbers "./scheme.rkt")

(define results
  (run-benchmarks
    '(log243base3 exp3x5 quines100 twines15 thrines2)
    '()
    (lambda (op)
      (match op
        ['log243base3
          (run 1 (p) (logo (build-num 243) (build-num 3) p (build-num 0)))]
        ['exp3x5
          (run 1 (p) (expo (build-num 3) (build-num 5) p))]
        ['quines100
          (run 100 (q)
            (eval-expo q '() `(val_ ,q)))]
        ['twines15
          (run 15 (q r)
            (eval-expo q '() `(val_ ,r))
            (eval-expo r '() `(val_ ,q)))]
        ['thrines2
          (run 2 (q r s)
            (eval-expo q '() `(val_ ,r))
            (eval-expo r '() `(val_ ,s))
            (eval-expo s '() `(val_ ,q)))]))
    #:extract-time 'delta-time
    #:num-trials 40))

(for ([i results])
  (printf "~a: ~a ms\n"
    (benchmark-result-name i)
    (mean (benchmark-result-trial-times i))))
