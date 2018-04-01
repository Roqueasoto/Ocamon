
(* [pokemon] is an abstract type representing an instance of a pokemon in the game *)
type pokemon

(* [ptype p] is the type of the pokemon p. *)
val ptype : pokemon -> ptype

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

(* [item_holding p] is the name of the item the pokemon p is holding.
 * Empty string if the pokemon isn't holding anything*)
val item_holding : pokemon -> string

(* [actions p] is the current list of actions the pokemon p can perform. *)
val actions : pokemon -> string list

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

