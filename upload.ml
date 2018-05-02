open Graphics;;

Graphics.open_graph " 600x600";;

let show img = 
let pic = Graphics.dump_image img in 
Graphics.make_image pic;;
