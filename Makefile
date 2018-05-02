compile:
<<<<<<< HEAD
	ocamlbuild -use-ocamlfind ai.cmo controller.cmo GUI.cmo model.cmo pokemon.cmo
clean: 
	ocamlbuild -clean

=======
	ocamlbuild -use-ocamlfind guitext.cmo ai.cmo controller.cmo model.cmo pokemon.cmo types.cmo GUI.cmo
  
clean:
	ocamlbuild -clean

test:
	ocamlbuild -use-ocamlfind test.byte && ./test.byte
>>>>>>> 0b8444906c496e065bc79ee954db03c290402628
