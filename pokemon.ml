type ptype = Normal | Fire | Water | Electric | Grass | Ice | Fighting | Poison | Ground | Flying | Psychic
                | Bug | Rock | Ghost | Dragon | Dark | Steel | Fairy

type nature = Hardy | Lonely | Brave | Adamant | Naughty | Bold | Docile | Relaxed | Impish | Lax | Timid 
                | Hasty | Serious | Jolly | Naive | Modest | Mild | Quiet | Bashful | Rash | Calm | Gentle
                | Sassy | Careful | Quirky

type status_effect = None | Sleep | Paralyze | Burn | Frozen | Poison

(*This is just an example, more items to include after we decide*)
type item = Apicot Berry | Babiri Berry

type pokemon = {poketype : ptype; name : string; Nature: nature; 
                level : int; HP : int; XP : int; ATK : int; DEF : int;
                SPATK : int; SPD : int; SPDEF : int; MAXHP : int; IV : int, 
                EV: int; EXP : int; catch_rate : float; rate_occ : float; 
                item_holding : item; actions : list}

let type poke = poke.poketype

let name poke = poke.name

let nature poke = poke.nature

let level poke = poke.level

let hp poke = poke.hp

let xp poke = poke.xp

let atk poke = poke.atk

let def poke = poke.def

let spatk poke = poke.spatk

let spd poke = poke.spd

let spdef poke = poke.spdef

let maxhp poke = poke.maxhp

let iv poke = poke.iv

let ev poke = poke.ev

let catch_rate poke = poke.catch_rate

let rate_occ poke = poke.rate_occ

let item_holding poke = poke.item_holding

let actions poke = poke.actions
