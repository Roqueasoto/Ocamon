(* Public model types. *)

(* [index] represents the position of a particular pokemon in the party. *)
type index = int

(* [poke] represents a pokemon and their position in the party.*)
type poke = (index * Pokemon.t)

(* [itemQ] represents an item and quantity pair in the inventory. *)
type itemQ = (Pokemon.item * int)

(* [ai_info] represents the information about combat the AI module requires. *)
type ai_info = {
  user_poke_inv : poke list;
  enemy_poke_inv : poke list;
  enemy_item_lst : Pokemon.item list;
  enemy_level : int
}

(* [person_id] represents the id of a trainer (enemer or user) in the game. *)
type person_id = string

(* [person_info] represents infromation about the enemy or user in the game. *)
type person_info = {
  id : person_id;
  poke_inv : poke list;
  item_inv : itemQ list; (* RI: Keys in item_inv contain no duplicates. *)
  person_image : string;
  message : string;
}

(* [gui_combat_info] represents the combat information for needed for the GUI. *)
type gui_combat_info = {
  user_person_info : person_info;
  enemy_person_info : person_info;
}

(* [gui_history_info] represents additional information about the user play history. *)
type gui_history_info = {
  milestones : string list;
  poke_storage : poke list;
  game_stats : (string * string list) list
}

(* [mode_of_info] is which mode we are in. *)
type mode =
  | MStart
  | MMap
  | MCombat of person_id
  | MWin
  | MLose
  | MSimulation

(* [gui_info] represents the set of information about the game state that the
 * GUI needs in order to produce the graphics.*)
type gui_info = {
  mode : mode;
  combat_info : gui_combat_info option;
  history_info : gui_history_info;
}
