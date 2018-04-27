open Types

(* AF: [person] represents a person and id pair.
RI: person_id must equal person_info.id *)
type person = (person_id * person_info)

(* [t] represents the abstract state of the game.
   AF:
    t.population represents every person in the game, where
    the person with key "user" is the user, and each remaining person
    represents the enemy.
    t.mode represents which mode of the game we are in.
    t.milestones/poke_storage/game_stats represents additional information about
    the game.
   RI:
    t.population must have a person with key "user" and six enemies, with any
    valid id. A valid enemy id is a string whose only digit characters represent
    a unique level number between 0 and 5.
  *)
type t = {
  population : person list;
  mode : mode;
  milestones : string list;
  poke_storage : poke list;
  game_stats : (string * string list) list;
}

(* Blank types to be used by helper functions. *)
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

(* Helper functions to create initla population. *)
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

(* Helper functions to make a gui_info type from
the current state. *)
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

  let keys_of_inv inv =
    inv |> List.split |> fst

  let get_item_lst id t =
    let inv = (get_item_inv) id t in
    keys_of_inv inv

  (* Helper of ints_of_id, which converts a string to a char list. *)
  let rec char_lst s =
    match s with
    | "" -> []
    | _ -> s.[0]::(char_lst (String.sub s 1 (String.length s - 1)))

  (* Helper of ints_of_id, which returns wither c is a digit. *)
  let is_digit c =
    let code_0 = Char.code '0' in
    let code_9 = Char.code '9' in
    let code_c = Char.code 'c' in
    (code_c <= code_9) && (code_c >= code_0)

(* Gets a string of all of the digits in id.
   Example: [ints_of_id "enemy_5"] returns 5.*)
  let ints_of_id id =
    let lst = char_lst id in
    let dig_char_lst = List.filter is_digit lst in
    let dig_str_lst = List.map (String.make 1) dig_char_lst in
    let dig_str = List.fold_left (^) "" dig_str_lst in
    int_of_string dig_str

  let make_ai_info_h enemy_id t = {
    user_poke_inv = get_poke_inv "user" t;
    enemy_poke_inv = get_poke_inv enemy_id t;
    enemy_item_lst = get_item_lst enemy_id t;
    enemy_level = ints_of_id enemy_id;
  }

  (* requires mode be combat.*)
  let make_ai_info t =
    match t.mode with
    | MCombat enemy_id -> make_ai_info_h enemy_id t
    | _ -> failwith "unreachable make_ai_info"
end

(* Helper methods to make make_hypothetical_state *)
module MakeHypotheticalState = struct
  open Blanks

  let user_simulated_name = "user_simulated"
  let enemy_simulated_name = "enemy_simulated"

  let make_user_person_info ai_info =
    {
      blank_person_info with
      id = user_simulated_name;
      poke_inv = ai_info.user_poke_inv;
      item_inv = [];
    }

  let make_enemy_person_info ai_info =
    {
      blank_person_info with
      id = enemy_simulated_name;
      poke_inv = ai_info.enemy_poke_inv;
      item_inv = List.map (fun elt -> (elt, 1)) ai_info.enemy_item_lst;
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
