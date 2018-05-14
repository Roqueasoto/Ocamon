type effect_on = Self | Other

type status = StatusNone | Sleep | Paralyze | Burn | Frozen | Poisoned | Toxic
            | Confused | Flinch | Substitute | Uncontrollable | Focused
            | LeechSeed | Missed

type ptype = Normal | Fire | Water | Electric | Grass | Ice | Fighting
           | Poison | Ground | Flying | Psychic | Bug | Rock | Ghost | Dragon

type category = Special | Physical

type bufftype = ATKBuff of int | DEFBuff of int | SPDBuff of int | SpatkBuff of int

type choices = CStart of int | CMap | CBattleEnd | CWin | CLose of bool
             | CWinGame of bool | CQuit

type special =
  | GSPA (* MODEL *) (*Temporarily guards stat in battle*)
  | Clamp (* MODEL *)
  | Dig (* MODEL *)
  | DoubleEdge
  | DragonRage
  | DreamEater
  | Explosion
  | FireSpin (* MODEL *)
  | Fissure
  | Guillotine
  | Haze
  | HornDrill
  | HyperBeam (* MODEL *)
  | LightScreen (* MODEL *)
  | Mimic
  | MirrorMove (* MODEL *)
  | NightShade
  | PetalDance (* MODEL *)
  | PsyWave
  | Rage (* MODEL *)
  | Recover
  | Reflect (* MODEL *)
  | Rest
  | SeismicToss
  | SelfDestruct
  | SoftBoiled
  | SonicBoom
  | SolarBeam (* MODEL *)
  | Submission
  | SpeSubstitute
  | SuperFang
  | Swift (* MODEL *)
  | TakeDown
  | Thrash (* MODEL *)
  | Transform
  | HealStatus of status(*item*)
  | Revive (*item*)
  | FocusEnergy (*critical hit, possibly delete*)

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
