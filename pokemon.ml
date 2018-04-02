type ptype = Normal | Fire | Water | Electric | Grass | Ice | Fighting | Poison | Ground | Flying | Psychic
                | Bug | Rock | Ghost | Dragon | Dark | Steel | Fairy

type status_effect = None | Sleep | Paralyze | Burn | Frozen | Poison

(*This is just an example, more items to include after we decide*)
type item = Apicot Berry | Babiri Berry

type pokemon = {poketype : ptype list; name : string;
                level : int; HP : int; XP : int; ATK : int; DEF : int;
                SPD : int; MAXHP : int; EXP : int; catch_rate : float; rate_occ : float;
                item_holding : item; actions : list}

let ptype poke = poke.poketype

let name poke = poke.name

let nature poke = poke.nature

let level poke = poke.level

let hp poke = poke.hp

let xp poke = poke.xp

let atk poke = poke.atk

let def poke = poke.def

let spd poke = poke.spd

let maxhp poke = poke.maxhp

let catch_rate poke = poke.catch_rate

let rate_occ poke = poke.rate_occ

let item_holding poke = poke.item_holding

let actions poke = poke.actions

let type_compare ptype1 ptype2 =
  match ptype1,ptype2 with
  | Normal,Ghost -> 0.
  | Normal,_ -> 1.
  | Fire,Bug | Fire,Grass | Fire,Ice -> 2.
  | Fire,Rock | Fire,Water | Fire,Fire | Fire,Dragon -> 0.5
  | Fire,_ -> 1.
  | Water,Fire | Water,Ground | Water,Rock -> 2.
  | Water,Grass | Water,Ice | Water,Water | Water,Dragon -> 0.5
  | Water,_ -> 1.
  | Electric,Flying | Electric,Water -> 2.
  | Electric,Dragon | Electric,Grass | Electric,Dragon -> 0.5
  | Electric,Ground -> 0.
  | Electric,_ -> 1.
  | Grass,Ground | Grass,Rock | Grass,Water -> 2.
  | Grass,Grass | Grass,Fire | Grass,Poison | Grass,Bug | Grass,Dragon -> 0.5
  | Grass,_ -> 1.
  | Ice,Grass | Ice,Ground | Ice,Flying | Ice,Dragon -> 2.
  | Ice,Water | Ice,Ice -> 0.5
  | Ice,_ -> 1
  | Fighting,Normal | Fighting,Rock | Fighting,Ice -> 2.
  | Fighting,Poison | Fighting,Flying | Fighting,Psychic | Fighting,Bug -> 0.5
  | Fighting,Ghost -> 0.
  | Fighing,_ -> 1.
  | Poison,Grass | Poison,Bug -> 2.
  | Poison,Poison | Poison,Rock | Posion,Ghost | Poison,Rock -> 0.5
  | Posion,_ -> 1.
  | Ground,Fire | Ground,Electic | Ground,Poison | Ground,Rock -> 2.
  | Ground,Grass | Ground,Bug -> 0.5
  | Ground,Flying -> 0.
  | Ground,_ -> 1.
  | Flying,Grass | Flying,Bug | Flying,Fighting -> 2.
  | Flying,Electric | Flying,Rock -> 0.5
  | Flying,_ -> 1.
  | Psychic,Poison | Psychic,Psychic -> 2.
  | Psychic,Psychic -> 0.5
  | Psychic,_ -> 1.
  | Bug,Grass | Bug,Poison | Bug,Psychic -> 2.
  | Bug,Fire | Bug,Fighting | Bug,Ghost | Bug,Flying -> 0.5
  | Bug,_ -> 1.
  | Rock,Bug | Rock,Flying | Rock,Fire | Rock,Ice -> 2.
  | Rock,Fighting | Rock,Ground -> 0.5
  | Rock,_ -> 1.
  | Ghost,Ghost -> 2.
  | Ghost,Normal | Ghost,Fighting -> 0.
  | Ghost,_ -> 1.
  | Dragon,Dragon -> 2.
  | Dragon,_ -> 1.
