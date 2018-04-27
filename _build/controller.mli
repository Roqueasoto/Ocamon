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
  | Round of command * command

(* [parse key] is the command that represents player input [key].
 * requires: [key] is a valid single keyboard input as described in the game's
 *  instructions. *)
val parse : int -> command
