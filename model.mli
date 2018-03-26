
type object_info = unit (*implement*)

type coordinate = int * int

type overworld_info = {
  user_location : coordinate;
  map_id : string;
  random_enc : bool;
  infront : object_info option;
}

type index = int

type poke = (index * poke_info)

type ai_info = {
  user_poke_inv : poke list;
  enemy_poke_inv : poke list;
  user_item_lst : int list;
}

type combat_info = {
  user_person_info : person_info;
  enemy_person_info : person_info;
}

type person_id = string

type person_info = {
  id : string;
  dollars : int;
  (* location_id : string; *)
  poke_inv : poke list;
  item_lst : int list;
  person_image : string;
  enemy_message : string;
}

type person = (person_id * person_info)

type user_info ={
  milestones : string list;

}

type gui_info = {
  overworld_info : overworld_info;
  combat_info : combat_info;
}

type game_info = {
  persons : person list;
}

type t

val get_game_info : t -> game_info
