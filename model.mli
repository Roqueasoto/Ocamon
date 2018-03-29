(* [coordinate] represents the player or object's current location in the
 * overworld as an int pair. Changes when the player moves in the overworld. *)
type coordinate = int * int

(* [direction] represents cardinal the direction the player or object is facing
 * in the overworld. *)
type direction = | North | South | East | West

(* [effect] represents the effect on the game UI that is intiated when
 * the user interacts with an object in the overworld.*)
type effect = | Combat | Pickup | Talk | PC | Store | PokeCenter | Special

(* [object_info] represents an object that is located in the overworld. An
 * Defined as an item in the overworld that the user can interact with. *)
type object_info = {
  obj_location : coordinate;
  facing : direction;
  interact : effect;
  map_id : string;
}

(* [overworld_info] represets the current overworld map that the player is
 * traversing.*)
type overworld_info = {
  user_location : coordinate;
  map_id : string;
  random_enc : bool;
  infront : object_info option;
  facing : direction;
  obj_list : object_info list;
}

(* [index] represents the position of a particular pokemon in the party. *)
type index = int

(* [poke] represents a pokemon and their position in the party.*)
type poke = (index * poke_info)

(* [ai_info] represents the information about combat the AI module requires. *)
type ai_info = {
  user_poke_inv : poke list;
  enemy_poke_inv : poke list;
  user_item_lst : int list;
}

(* [combat_info] represents the combat information for needed for the GUI. *)
type combat_info = {
  user_person_info : person_info;
  enemy_person_info : person_info;
}

(* [person_id] represents the id of a trainer (enemer or user) in the game. *)
type person_id = string

(* [person_info] represents infromation about the enemy or user in the game. *)
type person_info = {
  id : string;
  dollars : int;
  (* location_id : string; *)
  poke_inv : poke list;
  item_lst : int list;
  person_image : string;
  enemy_message : string;
}

(* [person] represents a person and id pair*)
type person = (person_id * person_info)

(* [user_info] represents additional information about the user play history. *)
type user_info ={
  milestones : string list;
  poke_storage : poke list;
}

(* [gui_info] represents the set of information about the game state that the
 * GUI needs in order to produce the graphics.*)
type gui_info = {
  overworld_info : overworld_info;
  combat_info : combat_info;
  in_combat : bool;
  user : user_info;
}

(* [game_info] represents the current information about the user and enemy
 * trainers in the game.*)
type game_info = {
  persons : person list;
  user : user_info;
}

(* [t] the abstract game state type*)
type t

(* [get_game_info game] takes in a game state [game] and produces a
 * game_info type that describes the users and enemy trainers in the game. *)
val get_game_info : t -> game_info

(* [get_ai_info game] takes in a game state [game] and produces an ai_info type
 * that describes the game information required for the ai to make a move. The
 * game state must be in combat and it must be the AI's turn. *)
val get_ai_info : t -> ai_info

(* [get_gui_info game] takes in a game state [game] and produces a gui_info
 * type that the GUI requires to update the graphics. *)
val get_gui_info : t -> gui_info

(* [do' cmd game] *)
val do' : Controller.command -> t -> t

(* [initialize_game] produces an initial game state of type t. *)
val initialize_game : t
