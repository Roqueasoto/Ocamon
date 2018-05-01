compile:
	ocamlbuild -use-ocamlfind ai.cmo controller.cmo GUI.cmo model.cmo types.cmo pokemon.cmo

clean:
	ocamlbuild -clean

test:
	ocamlbuild -use-ocamlfind test.byte && ./test.byte
