type coordinate = int * int

type direction = | North | South | East | West

type effect = | Combat | Pickup | Talk | PC | Store | PokeCenter | Special

type object_info = {
  obj_location : coordinate;
  facing : direction;
  interact : effect;
}

type overworld_info = {
  user_location : coordinate;
  map_id : string;
  random_enc : bool;
  infront : object_info option;
  facing : direction;
  obj_list : object_info list;
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
  poke_storage : poke list;
}

type gui_info = {
  overworld_info : overworld_info;
  combat_info : combat_info;
  in_combat : bool;
  user : user_info;
}

type game_info = {
  persons : person list;
  user : user_info;
}

type t

val get_game_info : t -> game_info

val get_ai_info : t -> ai_info

val get_gui_info : t -> gui_info

val do' : t -> t
