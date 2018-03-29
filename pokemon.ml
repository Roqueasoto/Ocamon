type ptype = Normal | Fire | Water | Electric | Grass | Ice | Fighting | Poison | Ground | Flying | Psychic
                | Bug | Rock | Ghost | Dragon | Dark | Steel | Fairy

type status_effect = None | Sleep | Paralyze | Burn | Frozen | Poison

(*This is just an example, more items to include after we decide*)
type item = Apicot Berry | Babiri Berry

type pokemon = {poketype : ptype; name : string; 
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
