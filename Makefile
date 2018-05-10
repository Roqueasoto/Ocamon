compile:

	ocamlbuild -use-ocamlfind ai.cmo controller.cmo model.cmo pokemon.cmo shared_types.cmo gui.cmo main.cmo

clean:
	ocamlbuild -clean

test:
	ocamlbuild -use-ocamlfind test.byte && ./test.byte

play:
	ocamlbuild -use-ocamlfind main.byte && ./main.byte

compile_roque:
	ocamlbuild -use-ocamlfind ai.cmo main.cmo

compile_cynthia:
	ocamlbuild -use-ocamlfind gui.cmo controller.cmo

compile_andrea:
	ocamlbuild -use-ocamlfind pokemon.cmo

compile_tim:
	ocamlbuild -use-ocamlfind model.cmo shared_types.cmo
