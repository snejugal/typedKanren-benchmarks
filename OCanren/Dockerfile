FROM ubuntu@sha256:e3f92abc0967a6c19d0dfa2d55838833e947b9d74edbcb0113e48535ad4be12a

WORKDIR /app
RUN apt update \
 && apt install opam ocaml-dune xdot -y \
 && opam init -y

COPY OCanren OCanren
COPY OCanren_benchmarks.opam .
RUN opam install . ./OCanren --deps-only -y
COPY dune-project .
COPY bin bin
RUN eval $(opam env) && dune build --profile=release \
    ./bin/all_benchmarks.exe \
    ./bin/mem_exp3.exe \
    ./bin/mem_log3.exe \
    ./bin/mem_quines.exe \
    ./bin/mem_twines.exe \
    ./bin/mem_thrines.exe

WORKDIR _build/default/bin
RUN cat > ./mem.sh <<EOF
#!/bin/sh
set -x
./mem_exp3.exe
./mem_log3.exe
./mem_quines.exe
./mem_twines.exe
./mem_thrines.exe
EOF
RUN chmod +x mem.sh
CMD ["./all_benchmarks.exe"]
