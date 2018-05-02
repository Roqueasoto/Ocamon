open Graphics
open Camlimages
open Images
open Png  
open Jpeg

type image

module StartGUI = struct 

  type status = {
  	mouse_x : int;	(* X coordinate of the mouse *)
  	mouse_y : int;	(* Y coordinate of the mouse *)
  	button : bool;	(* true if a mouse button is pressed *)
  	keypressed : bool;	(* true if a key has been pressed *)
  	key : char;	(* the character for the key pressed *)
  }

  type t = 
    |Image of Image.t

  type event = 
    |Button_down 
    |Button_up
    |Key_pressed
    |Mouse_motion
    |Poll

  (*[img_to_arr] transforms image to color color array*)
  let img_to_arr img = 
    match img with 
    | Index8 bitmap -> 
      let w = bitmap.Index8.width 
      and h = bitamp.Index8.height in 
      and 
    | Rbg24 bitmap -> 
    | Index16 bitmap -> 
    | Rbga32 bitmap -> 
    | Cmyk32 bitmap -> 

  (*[get_image f] reads an image from a .png file  *)
  let get_image f = Image.read_image f 

  let updateStatus (l: event list) (st: status) = 
    match l with 
    |[] -> st 
    |h::t -> if h.keypressed = true then Graphics.draw_char(h.key) else  
  
  let couleur r b g = Graphics.rgb r b g 

  let dimensions x y =  
    let dim = " " ^ string_of_int x ^ "x" ^ string_of_int y in 
    Graphics.open_graph(dim); 
    Graphics.set_window_title "OCAMON!" 

  let background i = 
    let img = Graphics.dump_image i in 
    Graphics.make_image img

  let startGame e st = 
    if Graphics.
      
  let quitGame () = 
    if Graphics.read_key () = 'q' then close_graph ()
  
  let getCredits = ;;

  let getHelp = ;;
  

  


(*I need to get gui_info in types.mli and I need to get get_gui_info*)

end 

module OverworldGUI = struct 

  let dimensions x y =  
    let dim = " " ^ string_of_int x ^ "x" ^ string_of_int y in 
    Graphics.open_graph(dim) 
  
  let background (d: image) = Image.read_image "Charmander.bmp"

  let playerLocation = 
  
  let walking = 
    
  let standing = 
  
  let speaking = 
  

end 

module CombatGUI = struct
  let dimensions = 
  let background = 
  let pokemon = 
  let poisoned = 
  let asleep = 
  let frozen = 
  let useItem = 
  let attack = 
  let switchOut = 
  let finish = 

end 

module InvGUI = struct
  let dimensions = 
  let background = 
  let items = 
end 

