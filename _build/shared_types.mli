(* Public model types. *)

(* [index] represents the position of a particular pokemon in the party. *)
type index = int

(* [poke] represents a pokemon and their position in the party.*)
type poke = (index * Pokemon.t)

(* [ai_info] represents the information about combat the AI module requires. *)
type ai_info = {
  user_poke_inv : poke list;
  enemy_poke_inv : poke list;
  enemy_item_inv : Pokemon.item list;
  enemy_level : int
}

(* [person_id] represents the id of a trainer (enemer or user) in the game. *)
type person_id = string

(* [person_info] represents infromation about the enemy or user in the game. *)
type person_info = {
  id : person_id;
  name : string;
  poke_inv : poke list;
  item_inv : Pokemon.item list;
  person_image : string;
  message : string;
}

(* [gui_combat_info] represents the combat information for needed for the GUI.*)
type gui_combat_info = {
  user_person_info : person_info;
  enemy_person_info : person_info;
}

(* Represents current useful stats of game.
   next_battle is the integer representing the level that the
   player is allowed to play.
   battle_round_log represents the list of actions that took place
   during each round of combat (or empty list). *)
type game_stats =
  {
    next_battle : int;
    battle_round_log : string list;
  }

(* [gui_history_info] represents more information about the user play history.*)
type gui_history_info = {
  milestones : string list;
  game_stats : game_stats
}

(* [mode_of_info] is which mode we are in. *)
type mode =
  | MStart
  | MMap
  | MCombat of person_id
  | MWin (* win battle *)
  | MLose (* lost battle *)
  | MWinGame
  | MQuit

(* AF: [gui_info] represents the set of information about the game state the
 * GUI needs in order to produce the graphics.
   RI: combat_info must be None if mode is not MCombat. combat_info must be Some
   gui_combat_info is mode is MCombat. *)
type gui_info = {
  mode : mode;
  combat_info : gui_combat_info option;
  history_info : gui_history_info;
}
