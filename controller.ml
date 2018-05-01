type effect_on = Self | Other

type status = StatusNone | Sleep | Paralyze | Burn | Frozen | Poison
            | Confused | Flinch | Substitute | Uncontrollable | Focused
            | LeechSeed | Missed | Toxic

type bufftype = HPBuff of int | ATKBuff of int | DEFBuff of int | SPDBuff of int

type effect =
  | Switch of int
  | Heal of effect_on    * int * int
  | Damage of effect_on  * int * int * (int * int)
  | Status of effect_on  * int * string
  | Buff of effect_on    * int * string
  | Special of effect_on * int * string
  | Nothing


type command =
  | Move of string
  | Interact
  | CombatAction of effect list
  | Round of effect list * effect list

(* [parse key] is the command that represents player input [key].
 * requires: [key] is a valid single keyboard input as described in the game's
 *  instructions. *)
let parse = failwith "unimplemented"
