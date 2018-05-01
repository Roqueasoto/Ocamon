compile:
	ocamlbuild -use-ocamlfind guitext.cmo ai.cmo controller.cmo model.cmo pokemon.cmo types.cmo GUI.cmo

clean:
	ocamlbuild -clean
