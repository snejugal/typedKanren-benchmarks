#!/usr/bin/env sh
for name in exp3x5 log243base3 quines100 twines15 thrines2; do
  racket -t mem.rkt --main "$name"
done
