compile:
	ocamlbuild -use-ocamlfind ai.cmo controller.cmo GUI.cmo model.cmo pokemon.cmo gui_text.cmo types.cmo

clean:
	ocamlbuild -clean
