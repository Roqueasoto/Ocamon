type overworld_info = {
  mutable player_loc : int*int;
  map_id : int;
  mutable random_enc : bool;
  mutable infront : object_info option;
}

type combat_info = {
  turns : int;
  party1 : pokemon_info list;
  party2 : pokemon_info list;
  items1 : item_info list;
  items2 : item_info list;
}

type person_info = {
  id : string;
  dollars : int;
  location_id : string;

}

type game_info = {

}

type t
