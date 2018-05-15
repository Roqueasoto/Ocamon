type effect_on = Self | Other

type status = StatusNone | Sleep | Paralyze | Burn | Frozen | Poisoned | Toxic
            | Confused | Flinch | Substitute | Uncontrollable | Focused
            | LeechSeed | Mist

type ptype = Normal | Fire | Water | Electric | Grass | Ice | Fighting
           | Poison | Ground | Flying | Psychic | Bug | Rock | Ghost | Dragon
<<<<<<< HEAD

type category = SpecialA | Physical
=======
type category = Special | Physical
>>>>>>> 48493085429fa4fe36fe84451f2bc6a31b22f925

type bufftype =
    ATKBuff of int | DEFBuff of int | SPDBuff of int | SpatkBuff of int

type choices = CStart of int | CMap | CBattleEnd | CWin | CLose of bool
             | CWinGame of bool | CQuit

type special =
  | HealStatus of status
  | Revive

type effect =
  | Switch of int
  | Heal of effect_on    * int * int
  | Damage of effect_on  * int * int * (int * int) * ptype * category
  | Status of effect_on  * int * status
  | Buff of effect_on    * int * bufftype
  | Special of effect_on * int * special * effect
  | Nothing

type command =
  | Move of string
  | Interact of choices
  | CombatAction of effect list
  | Round of effect list * effect list
