open Types

(* [person] represents a person and id pair*)
type person = (person_id * person_info)

type t = {
  population : person list;
  mode : mode;
  milestones : string list;
  poke_storage : poke list;
  game_stats : (string * string list) list;
}

module Initiate_Population = struct
  let blank_person_info =
    {
      id = "";
      poke_inv = [];
      item_lst = [];
      person_image = "";
      message = "";
    }

  let initial_user = {blank_person_info with id = "user"}

  let enemy_id_list = ["enemy_0";
                       "enemy_1";
                       "enemy_2";
                       "enemy_3";
                       "enemy_4";
                       "enemy_5";]

  let enemy_id n = List.nth enemy_id_list n

  let initial_enemy_0 = {blank_person_info with id = enemy_id 0}
  let initial_enemy_1 = {blank_person_info with id = enemy_id 1}
  let initial_enemy_2 = {blank_person_info with id = enemy_id 2}
  let initial_enemy_3 = {blank_person_info with id = enemy_id 3}
  let initial_enemy_4 = {blank_person_info with id = enemy_id 4}
  let initial_enemy_5 = {blank_person_info with id = enemy_id 5}

  let initial_population =
    [("user", initial_user);
     (enemy_id 0, initial_enemy_0);
     (enemy_id 1, initial_enemy_1);
     (enemy_id 2, initial_enemy_2);
     (enemy_id 3, initial_enemy_3);
     (enemy_id 4, initial_enemy_4);
     (enemy_id 5, initial_enemy_5);]

end

module MakeGuiInfo = struct

  let make_combat_info enemy_id t =
    {
      user_person_info = List.assoc "user" t.population;
      enemy_person_info = List.assoc enemy_id t.population;
    }

  let make_combat_info_opt t =
    match t.mode with
    | MCombat enemy_id -> Some (make_combat_info enemy_id t)
    | _ -> None

  let make_gui_info t =
    {
      mode = t.mode;
      combat_info = make_combat_info_opt t;
      history_info = failwith "";
    }
end

let initiate_state = fun () ->
  {
    population = Initiate_Population.initial_population;
    mode = MStart;
    milestones = [];
    poke_storage = [];
    game_stats = [];
  }

let get_gui_info t =
  MakeGuiInfo.make_gui_info t
