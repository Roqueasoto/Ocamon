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

val fpi_press : unit -> int

val pokemon_or_items : unit -> int

val press_battle_four : unit -> int

val press_battle_three : unit -> int

val press_battle_two : unit -> int

val make_action : int -> gui_combat_info -> Controller.command

val make_switch : int -> Controller.command

val make_item : int -> gui_combat_info -> Controller.command

val items_screen : gui_info -> int

val poke_screen : gui_info -> int

val fight_screen : gui_info -> int 

val fpi_screen : gui_info -> Controller.command

val press_history : unit -> unit 

val draw_battle : gui_info -> Controller.command

val press_before : unit -> unit

val before_battle : unit -> unit

val press_map : unit -> unit 

val draw_map : gui_info -> unit 

val map_game : gui_info -> unit

val press_poke : unit -> int

val start_three : unit -> int

val press_start : unit -> unit 

val start_two : unit -> unit 

val start_one : unit -> unit

val start_game : unit -> int

val press_win : unit -> bool

val win_game : unit -> bool

val press_lose : unit -> bool

val lose_game : unit -> bool

val get_cmd : gui_info -> mode -> Controller.command
