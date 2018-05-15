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
  |	Button_down	(* A mouse button is pressed *)
  |	Button_up	(* A mouse button is released *)
  |	Key_pressed	(* A key is pressed *)
  |	Mouse_motion	(* The mouse is moved *)
  |	Poll	(* Don't wait; return immediately *)
  

(* [array_of_image t] takes an image type and returns a 2-D color array *)
val array_of_image : Images.t -> Graphics.color array array 

(* [make_action i g] takes int and gui_inf to List.assoc the proper action*)
val make_action : int -> gui_combat_info -> Controller.command

(* [make_switch i] takes int and returns the command for a pokemon switch*)
val make_switch : int -> Controller.command

(* [make_item i g] takes int and gui_inf to create item needed*)
val make_item : int -> gui_combat_info -> Controller.command

val pokemon_or_items_six : unit -> int 

val pokemon_or_items_five : unit -> int 

val pokemon_or_items_four : unit -> int 

val pokemon_or_items_three : unit -> int 

val pokemon_or_items_two : unit -> int 

val pokemon_or_items_one : unit -> int 

val press_battle_four : unit -> int

val press_battle_three : unit -> int

val press_battle_two : unit -> int

val items_screen : gui_info -> int

val poke_screen : gui_info -> int

val fight_screen : gui_info -> int 

val fpi_screen : gui_info -> Controller.command

val no_more_press : unit -> unit

val no_pokemon : unit -> unit 

val no_items : unit -> unit 

val fpi_press : unit -> int 

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

val press_win_match : unit -> bool

val win_match : unit -> Controller.command

val press_win : unit -> bool

val win_game : unit -> bool

val press_lose : unit -> bool

val lose_game : unit -> bool

val get_cmd : gui_info -> mode -> Controller.command