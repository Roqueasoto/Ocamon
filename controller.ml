type status = StatusNone | Sleep | Paralyze | Burn | Frozen | Poison
            | Confused | Flinch | Substitute | Uncontrollable | Focused
            | LeechSeed | Missed | Toxic

type bufftype = HPBuff of int | ATKBuff of int | DEFBuff of int | SPDBuff of int

type choices = CStart of int | CMap | CWin | CLose | CQuit

type effect =
  | Switch of int
  | Heal of string    * int * int
  | Damage of string  * int * int * (int * int)
  | Status of string  * int * status
  | Buff of string    * int * bufftype
  | Special of string * int * string
  | Nothing

type command =
  | Move of string
  | Interact of choices
  | CombatAction of effect list
  | Round of (effect list) * (effect list)

let parse i = failwith"Unimplemented"
