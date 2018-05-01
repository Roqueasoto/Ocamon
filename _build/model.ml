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

module Blanks = struct
  let blank_person_info =
    {
      id = "";
      poke_inv = [];
      item_inv = [];
      person_image = "";
      message = "";
    }

  let blank_state = {
    population = [];
    mode = failwith "uninitated game";
    milestones = [];
    poke_storage = [];
    game_stats = [];
  }

end

module Initiate_Population = struct
  open Blanks

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

module MakeAIInfo = struct
  let get_person_info id t = List.assoc id t.population

  let get_poke_inv id t =
    (get_person_info id t).poke_inv

  let get_item_inv id t =
    (get_person_info id t).item_inv

  let make_ai_info_h enemy_id t = {
    user_poke_inv = get_poke_inv "user" t;
    user_item_inv = get_item_inv "user" t;
    enemy_poke_inv = get_poke_inv enemy_id t;
    enemy_item_inv = get_item_inv enemy_id t;
  }

  (* requires mode be combat.*)
  let make_ai_info t =
    match t.mode with
    | MCombat enemy_id -> make_ai_info_h enemy_id t
    | _ -> failwith "unreachable make_ai_info"

end

module MakeHypotheticalState = struct
  open Blanks

  let user_simulated_name = "user_simulated"
  let enemy_simulated_name = "enemy_simulated"

  let make_user_person_info ai_info =
    {
      blank_person_info with
      id = user_simulated_name;
      poke_inv = ai_info.user_poke_inv;
      item_inv = ai_info.user_item_inv;
    }

  let make_enemy_person_info ai_info =
    {
      blank_person_info with
      id = enemy_simulated_name;
      poke_inv = ai_info.enemy_poke_inv;
      item_inv = ai_info.enemy_item_inv;
    }

  let make_hypothetical_state ai_info =
    let user_person_info = make_user_person_info ai_info in
    let enemy_person_info = make_enemy_person_info ai_info in
    {
      blank_state with
      population = [(user_simulated_name, user_person_info); (enemy_simulated_name, enemy_person_info)];
      mode = MCombat (enemy_simulated_name)
    }
end

let initiate_state = fun () ->
  {
    Blanks.blank_state with
    population = Initiate_Population.initial_population;
    mode = MStart;
  }

let get_gui_info t =
  MakeGuiInfo.make_gui_info t

(* Requires mode be combat mode. *)
let get_ai_info t =
  MakeAIInfo.make_ai_info t

let make_hypothetical_state ai_info =
  MakeHypotheticalState.make_hypothetical_state ai_info
