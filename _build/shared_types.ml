type index = int

type poke = (index * Pokemon.t)

type itemQ = (Pokemon.item * int)

type ai_info = {
  user_poke_inv : poke list;
  enemy_poke_inv : poke list;
  enemy_item_inv : Pokemon.item list;
  enemy_level : int
}

type person_id = string

type person_info = {
  id : person_id;
  name : string;
  poke_inv : poke list;
  item_inv : itemQ list; (* RI: Keys in item_inv contain no duplicates. *)
  person_image : string;
  message : string;
}

type gui_combat_info = {
  user_person_info : person_info;
  enemy_person_info : person_info;
}

type game_stats =
  {
    next_battle : int;
  }

type gui_history_info = {
  milestones : string list;
  game_stats : game_stats
}

type mode =
  | MStart
  | MMap
  | MCombat of person_id
  | MWin
  | MLose
  | MWinGame
  | MQuit

type gui_info = {
  mode : mode;
  combat_info : gui_combat_info option;
  history_info : gui_history_info;
}
