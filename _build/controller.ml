type effect_on = Self | Other

type status = StatusNone | Sleep | Paralyze | Burn | Frozen | Poison | Toxic
            | Confused | Flinch | Substitute | Uncontrollable | Focused
            | LeechSeed | Missed

type bufftype = ATKBuff of int | DEFBuff of int | SPDBuff of int

type choices = CStart of int | CMap | CBattleEnd | CWin | CLose of bool
             | CWinGame of bool | CQuit

type special =
  | XAtk (* MODEL *)
  | XDef (* MODEL *)
  | XSpd (* MODEL *)
  | XSpa (* MODEL *) (*Temporarily reaises stat in battle*)
  | GSPA (* MODEL *) (*Temporarily guards stat in battle*)
  | Absorb
  | Bide (* MODEL *)
  | Bind (* MODEL *)
  | Clamp (* MODEL *)
  | Conversion
  | Counter (* BOTH: I take counter special, and put fireblast into effect of special. *)
  | Dig (* MODEL *)
  | DoubleEdge
  | DragonRage
  | DreamEater
  | Explosion
  | FireSpin (* MODEL *)
  | Fissure
  | Fly (* MODEL *)
  | Guillotine
  | Haze
  | HornDrill
  | HyperBeam (* MODEL *)
  | LightScreen (* MODEL *)
  (* | Metronome  *)
  | Mimic
  | MirrorMove (* MODEL *)
  | NightShade
  | PetalDance (* MODEL *)
  | PsyWave
  | Rage (* MODEL *)
  | RazorWind (* MODEL *)
  | Recover
  | Reflect (* MODEL *)
  | Rest
  | SeismicToss
  | SelfDestruct
  | SkillBash (* MODEL *)
  | SkyAttack (* MODEL *)
  | SoftBoiled
  | SonicBoom
  | SolarBeam (* MODEL *)
  | Submission
  | Substitute
  | SuperFang
  | Swift (* MODEL *)
  | TakeDown
  | Thrash (* MODEL *)
  | Transform
  | Wrap (* MODEL *)

type effect =
  | Switch of int
  | Heal of effect_on    * int * int
  | Damage of effect_on  * int * int * (int * int)
  | Status of effect_on  * int * status
  | Buff of effect_on    * int * bufftype
  | Special of effect_on * int * special * effect
  | Nothing

type command =
  | Move of string
  | Interact of choices
  | CombatAction of effect list
  | Round of effect list * effect list
