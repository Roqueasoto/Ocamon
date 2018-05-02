open Controller

(* [pokemon] is an abstract type representing an instance of a pokemon in the game *)
type t

(* [ptype p] is the type of the pokemon p. *)
type ptype

(* [item] is the type representing items in the user's inventory. *)
type item

(* [ptype p] is the type of the pokemon p. *)
val ptype : t -> ptype list

(* [name p] is the name of the pokemon p. *)
val name : t -> string

(* [hp p] is the current hp value of the pokemon p. *)
val hp : t -> int

(* [atk p] is the current atk value and stat stage of the pokemon p. *)
val atk : t -> int * int

(* [def p] is the current def value and stat stage of the pokemon p. *)
val def : t -> int * int

(* [spd p] is the current spd value and stat stage of the pokemon p. *)
val spd : t -> int * int

(* [maxhp p] is the maxiumum hp value of the pokemon p. *)
val maxhp : t -> int

(* [catch_rate p] is the catch rate of the pokemon p. *)
val catch_rate : t -> int

(*[sprite_front p] returns the front sprite path of the pokemon p*)
val sprite_front : t -> string

(*[sprite_back p] returns the back sprite path of the pokemon p*)
val sprite_back : t -> string

(* [actions p] is the current list of CombatAction commands that the pokemon p
 * can perform. *)
val actions : t -> (int * command) list

(*[action_names] returns an association list of (index, action_name)*)
val action_names : t -> (int * string) list

(*[status p] returns the status list of pokemon p*)
val status : t -> status list

(*[check_sub p] returns true if the pokemon's current status is Substitute*)
val check_sub : t -> bool

(*[clear_stat p s] returns a pokemon without the status s*)
val clear_stat: t -> status -> t

(* [build_poke s] builds a pokemon of the name s from the json file j,
 * which contains info about all of the possible pokemons.
 * requires: s must be a valid name of a pokemon.*)
val build_poke : string -> t

(* [random_poke] builds a random pokemon from the json file j,
 * which contains info about all of the possible pokemons.
 *)
val random_poke : unit -> t

(* [build_inventory] gives a random list of items*)
val build_inventory : unit -> item list

(* [pokemon_damage p e] process effect e on the pokemon p and returns a new pokemon *)
val poke_effect : t -> t -> effect -> t

(* Set all stat stages to zero*)
val clear_buff : t -> t

(* [type_compare ptype1 ptype2] returns a float that describes how effective an
 * attack of type [ptype1] is against a pokemon of [ptype2].
 * requires: [ptype1] and [ptype2] must be type ptype.*)
val type_compare : ptype -> ptype -> float

(* [item_use_combat item] returns a CombatAction command that a valid [item]
 * can perform if it has one, otherwise returns None.*)
val item_use_combat : item -> command option
