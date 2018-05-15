compile:
	ocamlbuild -use-ocamlfind ai.cmo controller.cmo gui.cmo model.cmo pokemon.cmo shared_types.cmo main.cmo

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

compile_test:
	ocamlbuild -use-ocamlfind test.cmo test_andrea.cmo test_cynthia.cmo test_roque.cmo test_timothy.cmo ai_test.cmo
