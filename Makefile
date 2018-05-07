compile:
<<<<<<< HEAD
	ocamlbuild -use-ocamlfind guitext.cmo ai.cmo controller.cmo model.cmo pokemon.cmo types.cmo gui.cmo
  
=======
	ocamlbuild -use-ocamlfind guitext.cmo ai.cmo controller.cmo model.cmo pokemon.cmo types.cmo GUI.cmo

>>>>>>> b151a00f3e749a97ddf9df85259c16623b582d45
clean:
	ocamlbuild -clean

test:
	ocamlbuild -use-ocamlfind test.byte && ./test.byte
<<<<<<< HEAD
=======

play:
	ocamlbuild -use-ocamlfind main.byte && ./main.byte
>>>>>>> b151a00f3e749a97ddf9df85259c16623b582d45
