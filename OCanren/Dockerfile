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
RUN eval $(opam env) && dune build ./bin/all_benchmarks.exe --profile=release

CMD ["_build/default/bin/all_benchmarks.exe"]
