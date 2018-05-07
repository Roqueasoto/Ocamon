compile:

	ocamlbuild -use-ocamlfind guitext.cmo ai.cmo controller.cmo model.cmo pokemon.cmo types.cmo gui.cmo

clean:
	ocamlbuild -clean

test:
	ocamlbuild -use-ocamlfind test.byte && ./test.byte

play:
	ocamlbuild -use-ocamlfind main.byte && ./main.byte
