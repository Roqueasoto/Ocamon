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
type poke = (index * Pokemon.pokemon)

(* [enemy] represents the enemy trainer or wild pokemon and their difficulty. *)
type enemy = | WildPoke of int| Trainer of int

(* [ai_info] represents the information about combat the AI module requires. *)
type ai_info = {
  user_poke_inv : poke list;
  enemy_poke_inv : poke list;
  user_item_lst : int list;
  enemy_type : enemy;
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

(* [combat_info] represents the combat information for needed for the GUI. *)
type combat_info = {
  user_person_info : person_info;
  enemy_person_info : person_info;
}

(* [person] represents a person and id pair*)
type person = (person_id * person_info)

(* [user_info] represents additional information about the user play history. *)
type user_info = {
  milestones : string list;
  poke_storage : poke list;
  game_stats : (string * string list)
}

(* [gui_info] represents the set of information about the game state that the
 * GUI needs in order to produce the graphics.*)
type gui_info = {
  overworld_info : overworld_info;
  combat_info : combat_info;
  in_combat : bool;
  user : user_info;
}

(* [t] the abstract game state type*)
type t


(* [get_ai_info game] takes in a game state [game] and produces an ai_info type
 * that describes the game information required for the ai to make a move. The
 * game state must be in combat and it must be the AI's turn. *)
val get_ai_info : t -> ai_info

(* [get_gui_info game] takes in a game state [game] and produces a gui_info
 * type that the GUI requires to update the graphics. *)
val get_gui_info : t -> gui_info


(* [do' cmd game] is [game'] if doing command [cmd] in state [game] results in a
 * new state [game'] the function name [do'] is used, similarly to A2, as [do]
 * is a reserved keyword.
 *   - The "Move" command's moves the player in the direction indicated by
 *      the user in the overworld. When provided this will produce a new state
 *      with the player at this location. If the user is in a menu or in combat,
 *      this command should be handled by the GUI of the system and should not
 *      be passed to do'. The state will only change if the move is a valid
 *      move. A valid move is a move from a the user's location to another
 *      location to which movement is not blocked by either walls or an object.
 *   - The "Interact" command results in an appropriately updated [game'] if the
 *      user is facing an object and that object is facing the player, and its
 *      interact field has any effect type with the exception of Talk. If the
 *      user is not facing an object that is facing them, that object has an
 *      interact field of talk, or if the player is currently within a menu
 *      within the overworld or combat, then the GUI will handle the command
 *      and this will not be passed to do'.
 *   - The "CombatAction" command will perform the command as indicated. This
 *      command is only produceable by the GUI, which will interpret an
 *      interact command within the combat menu to mean a certain "CombatAction"
 *      type command that is then passed to the model. The command will result
 *      in an updated state [game'].
 *   - The "Back" command is purely a commmand for the GUI and as such should
 *      not be passed to [do'] as it will not ever affect the game state.
 *   - The "Start" command is another command entirely for the GUI which will
 *      not be passed to the game state as it should not affect it.
 *   - The behavior for commands that should not be passed to due is
 *      unspecified, however since they should not change the game state, if
 *      they are passed to [do'] then it will return state [game].
 * effects: None. All printing is done in the View (GUI) in keeping with the
 *   Model-View-Controller Schema.
 * require: the input state was produced by [initialize_game] or by repeated
 *   applications of [do'] to such a state.*)
val do' : Controller.command -> t -> t

(* [initialize_game] produces an initial game state of type t. *)
val initialize_game : t
