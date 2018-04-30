open Types
open Controller

(* [take_turn combat] is the command that represents the ai input based on the
 * combat state of the game [combat] as defined in the module Model.
 * requires: [combat] is the current state of the combat in the game that the
 *   ai will use to issue a command. *)
val take_turn : Model.t -> command

(*
--------------------------------------------------------------------------------
  Below here we will glass-box test all the inner functions of Pokemon.ml by
  temporarily exposing.
*)

val team_points : poke list -> poke list -> int

val update_combat : Model.t -> command list -> Model.t

val evaluate : Model.t -> command list -> int

val valid_moves : poke list -> Pokemon.item list -> (char * command) list

val accuracy : effect -> float

val move_acy_set : int -> effect -> effect

val expand_move : effect list -> ((effect list) * float) list ->
  ((effect list) * float) list

val gamma : Model.t -> string -> int -> int -> (command * command) list ->
  float * float -> ((command * command) list) * int

val chance_layer : (char * command) list -> (command * command) list ->
  (command * command) list -> int -> string -> int -> int -> float * float ->
  Model.t -> ((command * command) list) * int

val chance_move : char * command -> float -> float -> int -> string -> int ->
  int -> (command * command) list -> float * float -> Model.t ->
  ((command * command) list) * int

val chance_br : ((effect list) * float) list -> float -> float -> string ->
  int -> int -> (command * command) list -> command -> float * float -> int ->
  int -> bool -> (command * command) list -> Model.t ->
  ((command * command) list) * int

(*
--------------------------------------------------------------------------------
end of exposed methods for glass-box testing.
*)
