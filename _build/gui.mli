open Graphics
open Camlimages
open Images
open Png       
open Jpeg 
open Pokemon
open Shared_types 
open Controller   

type image 

type status = {
  mouse_x : int;	(* X coordinate of the mouse *)
  mouse_y : int;	(* Y coordinate of the mouse *)
  button : bool;	(* true if a mouse button is pressed *)
  keypressed : bool;	(* true if a key has been pressed *)
  key : char;	(* the character for the key pressed *)
}

type event = 
  |Button_down 
  |Button_up
  |Key_pressed
  |Mouse_motion
  |Poll

val array_of_image : Images.t -> Graphics.color array array 

val press_battle : int ref -> unit -> unit 

val make_action : int ref -> gui_combat_info -> Controller.command

val check : int ref -> gui_combat_info -> int -> int -> Controller.command

val draw_battle : gui_info -> Controller.command

val press_map : unit -> unit 

val draw_map : unit -> unit 

val press_start : unit -> int 

val draw_start : unit -> int 

val press_win : unit -> unit 

val win_game : unit -> unit 

val get_cmd : gui_info -> mode -> Controller.command





