
(* [command] represents a command input by a player. Parsed into one of the 7
 *  main "button" inputs.*)
type command =
  | Up
  | Down
  | Left
  | Right
  | Interact
  | Back
  | Start

(* [parse key] is the command that represents player input [key].
 * requires: [key] is a valid single keyboard input as described in the game's
 *  instructions. *)
val parse : int -> command
