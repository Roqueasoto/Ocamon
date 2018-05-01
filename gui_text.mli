open Controller
open Types

(* [get_cmd gui_inf gmode] is the command that represents the user input based
 * on the current mode [gmode] and relevant information about the state
 * [gui_inf] as defined in the Types module.
 * requires:
 * - [gui_inf] are the state details for gui to use as defined in Types.
 * - [gmode] is the current mode of the game corresponding to the state. *)
val get_cmd : gui_info -> mode -> command
