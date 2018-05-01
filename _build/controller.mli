(* [status] are types for the Status effect. *)
type status = StatusNone | Sleep | Paralyze | Burn | Frozen | Poison
           | Confused | Flinch | Substitute | Uncontrollable | Focused
           | LeechSeed | Missed | Toxic

(* [BuffType] are types for the Buff effect. The int it carries indicate how much to
   increase/decrease the stages of certain stats. *)
type bufftype = HPBuff of int | ATKBuff of int | DEFBuff of int | SPDBuff of int

(* [choices] are types for the Interact command. These indicate what choices are
 * made and at what stage of the game they were made. CStart carries an int that
 * represents the choice of Pokemon at the outset of the game. *)
type choices = CStart of int | CMap | CWin | CLose | CQuit

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
  | Status of string  * int * status
  | Buff of string    * int * bufftype
  | Special of string * int * string
  | Nothing

(* [command] represents a command input by a player. Parsed into one of the 7
 * main "button" inputs. CombatAction is implemented as an effect list because
 * a certain combat action may have multiple effects. The first effect of the
 * list must succeed for any following effects to occur. As such, the first
 * effect should be the main effect of the pokemon move.*)
type command =
  | Move of string
  | Interact of choices
  | CombatAction of effect list
  | Round of (effect list) * (effect list)

(* [parse key] is the command that represents player input [key].
 * requires: [key] is a valid single keyboard input as described in the game's
 *  instructions. *)
val parse : int -> command
