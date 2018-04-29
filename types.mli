(* Public model types. *)

(* [index] represents the position of a particular pokemon in the party. *)
type index = int

(* [poke] represents a pokemon and their position in the party.*)
type poke = (index * Pokemon.pokemon)

(* [item] represents an item *)
type item = string

(* [itemQ] represents an item and quantity pair in the inventory. *)
type itemQ = (item * int)

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

(* [effect] represents a combat effect on the game state. For type Switch, the
 * int carried represents the position of the Pokemon in the party that will be
 * swapped to the front. For all other types, string indicates the Pokemon being
 * affected by the move as self or other. In these types, the second entry (int)
 * the tuple designates the accuracy or likelihood of this effect and if this
 * in effect is the first one in a CombatAction list, this is the accuracy of
 * the move overall. For Damage and Heal, the third tuple (int) indicated the
 * amount of damage or healing performed. For Damage, the fourth tuple (a pair
 * of ints) indicated how many times the move is repeated (min, max).
 * Example - Ember's Damage - "other" , 100 , 30 , (1 , 1). The Nothing type
 * is used for an action with no effect. *)
type effect =
  | Switch of int
  | Heal of string    * int * int
  | Damage of string  * int * int * (int * int)
  | Status of string  * int * string
  | Buff of string    * int * string
  | Special of string * int * string
  | Nothing


(* [command] represents a command input by a player. Parsed into one of the 7
 * main "button" inputs. CombatAction is implemented as an effect list because
 * a certain combat action may have multiple effects. The first effect of the
 * list must succeed for any following effects to occur. As such, the first
 * effect should be the main effect of the pokemon move.*)
type command =
  | Move of string
  | Interact
  | CombatAction of effect list
  | Round of (effect list) * (effect list)
