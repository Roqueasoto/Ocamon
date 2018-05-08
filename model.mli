open Shared_types

(* [t] is the (abstract) state of the game. *)
type t

(* [initiate_state ()] returns the initial state of the game. *)
val initiate_state : unit -> t

(* [get_gui_info game] takes in a game state [game] and produces a gui_info
 * type that the GUI requires to update the graphics. *)
val get_gui_info : t -> gui_info

(* [get_ai_info game] takes in a game state [game] and produces an ai_info type
 * that describes the game information required for the ai to make a move. The
 * game state must be in combat and it must be the AI's turn. *)
val get_ai_info : t -> ai_info

(* [make_hypothetical_state ai_info] creates a hypothetical
   state from ai_info which AI module may use to run do' simulations. *)
val make_hypothetical_state : ai_info -> t

(* [get_mode st] returns which mode the state of the game is in. *)
val get_mode : t -> mode

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
 *      command is only produceable by the GUI or AI, which will interpret an
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
