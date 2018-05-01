compile:
	ocamlbuild -use-ocamlfind guitext.cmo ai.cmo controller.cmo model.cmo pokemon.cmo types.cmo GUI.cmo
<<<<<<< HEAD

=======
  
>>>>>>> f712209ea6db8e024bc5bbac608e9cca3c76f172
clean:
	ocamlbuild -clean

test:
	ocamlbuild -use-ocamlfind test.byte && ./test.byte
