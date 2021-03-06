open Controller

(* [pokemon] an abstract type representing an instanced pokemon in the game *)
type t

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

(*[spatk p] is the current special attack value & stat stage of the pokemon p*)
val spatk : t -> int*int

(* [maxhp p] is the maxiumum hp value of the pokemon p. *)
val maxhp : t -> int

(* [catch_rate p] is the catch rate of the pokemon p. *)
val catch_rate : t -> int

(*[sprite_front p] returns the front sprite path of the pokemon p*)
val sprite_front : t -> string

(*[sprite_back p] returns the back sprite path of the pokemon p*)
val sprite_back : t -> string

(*[status p] returns the status list of pokemon p*)
val status : t -> status list

(*[turns p] returns the turn_counter of the pokemon p*)
val turns : t -> int

(*[decre_turn p] returns a pokemon with turn_counter decremented (not below 0)*)
val decre_turn : t -> t

(*[set_count p i] sets the turn_counter to i. i cannot be below 0*)
val set_count : t -> int -> t

(* [actions p] is the current list of CombatAction commands that the pokemon p
 * can perform. *)
val actions : t -> (int * command) list

(*[action_names] returns an assoc. list of (index, action_name), from 1*)
val action_names : t -> (int * string) list

(*[inv_names] returns a association list of (index, itemn name), from 1*)
val inv_names : item list -> (int * string) list

(*[check_status p s] returns true if the pokemon has status s*)
val check_status: t -> status -> bool

(*[clear_stat p s] returns a pokemon without the status s*)
val clear_stat: t -> status -> t

(* [build_poke s] returns a pokemon of the id s .
 * requires: s must be a valid id of a Gen I pokemon.*)
val build_poke : string -> t

(* [random_poke] builds a random pokemon from the json file j,
 * which contains info about all of the possible pokemons.
 *)
val random_poke : unit -> t

(* [build_inventory] gives a random list of 4  items*)
val build_inventory : unit -> item list

(* [pokemon_effect p1 p2 e] process effect e on the pokemon p1 and returns a new p1 *)
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

(* Gets the pokedex key corresponding to poke.
Requires poke to be in pokedex.*)
val get_pokedex_number : t -> string

(* Gets the keys to the pokedex *)
val get_pokedex_keys : string list 
