#lang racket
(require minikanren minikanren/numbers "./scheme.rkt")

(define (run^ op)
  (match op
    ["log243base3"
      (run 1 (p) (logo (build-num 243) (build-num 3) p (build-num 0)))]
    ["exp3x5"
      (run 1 (p) (expo (build-num 3) (build-num 5) p))]
    ["quines100"
      (run 100 (q)
        (eval-expo q '() `(val_ ,q)))]
    ["twines15"
      (run 15 (q r)
        (eval-expo q '() `(val_ ,r))
        (eval-expo r '() `(val_ ,q)))]
    ["thrines2"
      (run 2 (q r s)
        (eval-expo q '() `(val_ ,r))
        (eval-expo r '() `(val_ ,s))
        (eval-expo s '() `(val_ ,q)))]))

(struct gc-info (mode pre-amount pre-admin-amount code-amount
                      post-amount post-admin-amount
                      start-process-time end-process-time
                      start-time end-time)
  #:prefab)

(define gc-log-receiver (make-log-receiver (current-logger) 'debug 'GC))

(define (current-memory-use-from-logs fallback)
  (define gc-log (sync/timeout 0 gc-log-receiver))
  (cond
    [(eq? gc-log #f) fallback]
    [else (current-memory-use-from-logs (gc-info-post-amount (vector-ref gc-log 2)))]))

(define (max-memory-use-from-logs fallback)
  (define gc-log (sync/timeout 0 gc-log-receiver))
  (cond
    [(eq? gc-log #f) fallback]
    [else (max-memory-use-from-logs (max fallback (gc-info-pre-amount (vector-ref gc-log 2))))]))

(provide main)
(define (main op)
  (collect-garbage 'major)
  (define before (current-memory-use-from-logs 0))

  (run^ op)

  (collect-garbage 'major)
  (define after (max-memory-use-from-logs 0))

  (printf "Peak memory usage ~a: ~a B~n" op (- after before)))
