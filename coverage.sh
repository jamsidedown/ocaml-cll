#/bin/sh

find _build/ -name '*.coverage' | xargs rm -f
dune test --instrument-with bisect_ppx --force
bisect-ppx-report html
bisect-ppx-report summary