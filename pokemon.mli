
(* [pokemon] is an abstract type representing an instance of a pokemon in the game *)
type pokemon

(* [ptype p] is the type of the pokemon p. *)
type ptype

(* [item] is the type representing items in the user's inventory. *)
type item

(* [ptype p] is the type of the pokemon p. *)
val ptype : pokemon -> ptype list

(* [name p] is the name of the pokemon p. *)
val name : pokemon -> string

(* [leve p] is the current level of the pokemon p. *)
val level : pokemon -> int

(* [hp p] is the current hp value of the pokemon p. *)
val hp : pokemon -> int

(* [xp p] is the current xp value of the pokemon p. *)
val xp : pokemon -> int

(* [atk p] is the current atk value of the pokemon p. *)
val atk : pokemon -> int

(* [def p] is the current def value of the pokemon p. *)
val def : pokemon -> int

(* [spd p] is the current spd value of the pokemon p. *)
val spd : pokemon -> int

(* [maxhp p] is the maxiumum hp value of the pokemon p. *)
val maxhp : pokemon -> int

(* [exp p] is the current maxiumum hp value of the pokemon p. *)
val exp : pokemon -> int

(* [catch_rate p] is the catch rate of the pokemon p. *)
val catch_rate : pokemon -> float

(* [rate_occ p] is the rate of occurance of the pokemon p in the wild. *)
val rate_occ : pokemon -> float

(* [item_holding p] is the item the pokemon p is holding. None if the pokemon
 * isn't holding anything*)
val item_holding : pokemon -> item option

(* [actions p] is the current list of CombatAction commands that the pokemon p
 * can perform. *)
val actions : pokemon -> (int*Types.command) list

(* [build_poke j s] builds a pokemon of the name s from the json file j,
 * which contains info about all of the possible pokemons.
 * requires: s must be a valid name of a pokemon.*)
val build_poke : Yojson.Basic.json -> string -> pokemon

(* [random_poke j] builds a random pokemon from the json file j,
 * which contains info about all of the possible pokemons.
 *)
val random_poke : Yojson.Basic.json -> pokemon

(* [level_up p] returns a leveled-up pokemon from pokemon p*)
val level_up : pokemon -> pokemon

(* [learn_move p m] returns a pokemon that has learned the move m
 * requires: m must be a valid move name that the pokemon p is allowed to learn
 *)
val learn_move : pokemon -> string -> pokemon

(* [type_compare ptype1 ptype2] returns a float that describes how effective an
 * attack of type [ptype1] is against a pokemon of [ptype2].
 * requires: [ptype1] and [ptype2] must be type ptype.*)
val type_compare : ptype -> ptype -> float

(* [item_use_combat item] returns a CombatAction command that a valid [item]
 * can perform if it has one, otherwise returns None.*)
val item_use_combat : item -> Types.command option
