type effect_on = Self | Other

type status = StatusNone | Sleep | Paralyze | Burn | Frozen | Poison
            | Confused | Flinch | Substitute | Uncontrollable | Focused
            | LeechSeed | Missed | Toxic

type bufftype = HPBuff of int | ATKBuff of int | DEFBuff of int | SPDBuff of int

type choices = CStart of int | CMap | CWin | CLose | CQuit

type effect =
  | Switch of int
  | Heal of effect_on   * int * int
  | Damage of effect_on  * int * int * (int * int)
  | Status of effect_on  * int * status
  | Buff of effect_on   * int * bufftype
  | Special of effect_on * int * string
  | Nothing

type command =
  | Move of string
  | Interact of choices
  | CombatAction of effect list
  | Round of (effect list) * (effect list)

let parse i = failwith"Unimplemented"
