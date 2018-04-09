(* [take_turn combat] is the command that represents the ai input based on the
 * combat state of the game [combat] as defined in the module Model.
 * requires: [combat] is the current state of the combat in the game that the
 *   ai will use to issue a command. *)
val take_turn : Model.ai_info -> command
