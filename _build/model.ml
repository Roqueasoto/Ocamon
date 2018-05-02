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
  game_stats : (string * string list) list;
}

(* Module for common helper methods *)
module CommonHelp = struct
  (* If k in lst, updates binding of k to v in lst, else creates new binding
     k to v in lst. *)
  let update_assoc k v lst =
    let lst' = List.remove_assoc k lst in
    (k, v)::lst'
end

(* Blank types to be used by helper functions. *)
module Blanks = struct
  let blank_person_info =
    {
      id = "";
      name = "";
      poke_inv = [];
      item_inv = [];
      person_image = "";
      message = "";
    }

  let blank_state = {
    population = [];
    mode = failwith "uninitated game";
    milestones = [];
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

  let initial_enemy_0 = {blank_person_info with
                         id = enemy_id 0;
                        }

  let initial_enemy_1 = {blank_person_info with
                         id = enemy_id 1;
                        }

  let initial_enemy_2 = {blank_person_info with
                         id = enemy_id 2;
                        }

  let initial_enemy_3 = {blank_person_info with
                         id = enemy_id 3;
                        }

  let initial_enemy_4 = {blank_person_info with
                         id = enemy_id 4;
                        }

  let initial_enemy_5 = {blank_person_info with
                         id = enemy_id 5;
                         poke_inv = [(0, Pokemon.random_poke ())];
                        }

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

(* Helper functions to make ai_info from current state. *)
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
    enemy_item_inv = get_item_lst enemy_id t;
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
      item_inv = List.map (fun elt -> (elt, 1)) ai_info.enemy_item_inv;
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

(* Helper functions for Do *)
module DoRoundHelp = struct
  open CommonHelp
  open Controller

(*
  AF:
    Represents information from a state.

  RI:
   person_info_x.poke_inv = poke_inv_x
   List.assoc 0 poke_inv_x = poke_x
*)
  type state_info = {
    person_info_self : person_info;
    person_info_other : person_info;
    poke_inv_self : poke list;
    poke_inv_other : poke list;
    poke_self : Pokemon.t;
    poke_other : Pokemon.t;
  }

(* Returns state_info representation of st.*)
  let expand_state self_id other_id st =
    let person_info_self = List.assoc self_id st.population in
    let person_info_other = List.assoc other_id st.population in

    let poke_inv_self = person_info_self.poke_inv in
    let poke_inv_other = person_info_other.poke_inv in

    let poke_self = List.assoc 0 poke_inv_self in
    let poke_other = List.assoc 0 poke_inv_other in
    {
      person_info_self = person_info_self;
      person_info_other = person_info_other;
      poke_inv_self = poke_inv_self;
      poke_inv_other = poke_inv_other;
      poke_self = poke_self;
      poke_other = poke_other;
    }

(* Updates state_info given new poke_invs  *)
  let update_state_info_with_poke_invs state_info (poke_inv_self', poke_inv_other') =
    let person_info_self' = {state_info.person_info_self with poke_inv = poke_inv_self'} in
    let person_info_other' = {state_info.person_info_other with poke_inv = poke_inv_other'} in
    {state_info with
     person_info_self = person_info_self';
     person_info_other = person_info_other';
    }

(* Updates state_info given new pokes *)
  let update_state_info_with_pokes state_info (poke_self', poke_other') =
    let poke_inv_self' = update_assoc 0 poke_self' state_info.poke_inv_self in
    let poke_inv_other' = update_assoc 0 poke_other' state_info.poke_inv_other in
    update_state_info_with_poke_invs state_info (poke_inv_self', poke_inv_other')

  (* Returns state updated with state_info. *)
  let update_state_with_state_info st state_info =
    let self_id = state_info.person_info_self.id in
    let other_id = state_info.person_info_other.id in
    let population' = update_assoc self_id state_info.person_info_self st.population in
    let population'' = update_assoc other_id state_info.person_info_other population' in
    {st with population = population''}

(* Returns state updated with pokes, using state info.  *)
  let update_state_with_pokes_and_state_info st (state_info, poke_self', poke_other') =
    let state_info' = update_state_info_with_pokes state_info (poke_self', poke_other') in
    update_state_with_state_info st state_info'

(* Returns state updated with pokes, using state info *)
  let update_state_with_poke_invs_and_state_info st (state_info, poke_inv_self', poke_inv_other') =
    let state_info' = update_state_info_with_poke_invs state_info (poke_inv_self', poke_inv_other') in
    update_state_with_state_info st state_info'

(* [do_eff_try (self_id, other_id) eff] returns (st', is_success) which is a tuple
   whose first element is the updated state and the second element is whether
   the effect was successful or not. *)
  let do_eff_try (self_id, other_id, st) eff =
    (* Based on accuracy, return a boolean that represents whether this effect is
       successful or not. *)
    let get_is_success accuracy =
      let random = Random.int 100 in
      random < accuracy in

    (* Swap poke_0 with poke_i *)
    let do_switch i =
      let state_info = expand_state self_id other_id st in
      let poke_inv_other_new = state_info.poke_inv_other in
      let poke_inv_self_new =
        let poke_inv_self = state_info.poke_inv_self in
        let poke_0 = List.assoc 0 poke_inv_self in
        let poke_i = List.assoc i poke_inv_self in
        let poke_inv_self' = update_assoc 0 poke_i poke_inv_self in
        let poke_inv_self'' = update_assoc i poke_0 poke_inv_self' in
        poke_inv_self'' in
      let st' = update_state_with_poke_invs_and_state_info st (state_info, poke_inv_self_new, poke_inv_other_new) in
      (st', true) in

    (* For Heal, Damage, Status, Buff, and Special *)
    let do_stuff effect_on accuracy =
      let is_success = get_is_success accuracy in
      let state_info = expand_state self_id other_id st in

      if not is_success then (st, false)

      else begin
        let (poke_self', poke_other') =
          match effect_on with
          | Self -> begin
              let poke_other' = state_info.poke_other in
              let poke_self' = Pokemon.poke_effect state_info.poke_self eff in
              (poke_self', poke_other')
            end
          | Other -> begin
              let poke_self' = state_info.poke_self in
              let poke_other' = Pokemon.poke_effect state_info.poke_self eff in
              (poke_self', poke_other')
            end in
        let st' = update_state_with_pokes_and_state_info st (state_info, poke_self', poke_other') in
        (st', true)
      end in

    match eff with
    | Switch i -> do_switch i
    | Heal (effect_on, accuracy, _) -> do_stuff effect_on accuracy
    | Damage (effect_on, accuracy, _, _) -> do_stuff effect_on accuracy
    | Status (effect_on, accuracy, _) -> do_stuff effect_on accuracy
    | Buff (effect_on, accuracy, _) ->  do_stuff effect_on accuracy
    | Special (effect_on, accuracy, _) ->  do_stuff effect_on accuracy
    | Nothing -> (st, true)

(* Requires that elist be expanded.
   First try the first effect. If it succeeds, proceed with resolving the rest of
   the effect list. Otherwise, no other effects are resolved.  *)
  let do_eff_lst (self_id, other_id, st) elist =
    match elist with
    | [] -> failwith "unreachable, empty eff list"
    | head::tail -> begin
        let (st', is_success) = do_eff_try (self_id, other_id, st) head in
        if is_success then
          let op st eff = fst (do_eff_try (self_id, other_id, st) eff) in
          List.fold_left op st' tail
        else
          st'
      end

  (* Requires to be in battle mode *)
  let get_enemy_id st =
    match st.mode with
    | MCombat enemy_id -> enemy_id
    | _ -> failwith "unreachable get_enemy_id"

  (* Elist is expanded to reflect damage multiplier.
     Example: elist is (damage (min 3, max 5), effect 2, efect 3) an
     random number between 3 and 5 is 4, expanded elist is:
     (dam1, dam2, dam3, dam4, effect2, effect3). *)
  let expand_effect_lst elst =
    (* Returns a random number between mini and maxi (inclusive) *)
    let get_random_in_range mini maxi =
      let bound = maxi - mini + 1 in
      let random = Random.int bound in
      random + mini in

    (* Example: multipley elt 3 evaluates to [elt; elt; elt] *)
    let rec multiply elt n =
      if n = 0 then []
      else elt::(multiply elt (n - 1)) in

    match elst with
    | [] -> failwith "unreachable empty elist"
    | h::t -> begin
        match h with
        | Damage (effect_on, accuracy, amount, (mini, maxi)) -> begin
            let damage = Damage (effect_on, accuracy, amount, (1, 1)) in
            let n = get_random_in_range mini maxi in
            (multiply damage n)@t
          end
        | _ -> elst
      end

  (* Returns whether the user effect list should be resolved first or not,
   based on pokemon rules.  *)
  let is_user_first user_elist enemy_elist st =
    let get_speed poke = poke |> Pokemon.spd |> fst in
    let enemy_id = get_enemy_id st in
    let state_info = expand_state "user" enemy_id st in
    let poke_user = state_info.poke_self in
    let poke_enemy = state_info.poke_other in
    let poke_user_speed = get_speed poke_user in
    let poke_enemy_speed = get_speed poke_enemy in
    poke_user_speed >= poke_enemy_speed (* TODO incorporate other facors.*)

  (* AF: Represents the order in which the two players moves occcur. *)
  type order_info = {
    first_id : person_id;
    second_id : person_id;
    first_elist : effect list;
    second_elist : effect list;
  }

  (* Generates correct order_info. *)
  let get_order_info user_elist enemy_elist enemy_id st =
    let is_user_first = is_user_first user_elist enemy_elist st in
    {
      first_id = if is_user_first then "user" else enemy_id;
      second_id = if is_user_first then enemy_id else "user";
      first_elist = if is_user_first then user_elist else enemy_elist;
      second_elist = if is_user_first then enemy_elist else user_elist;
    }

  (* Performs do on Round command.  *)
  let do_round user_elist enemy_elist st =
    let enemy_id = get_enemy_id st in
    let user_elist_x = expand_effect_lst user_elist in
    let enemy_elist_x = expand_effect_lst enemy_elist in
    let order = get_order_info user_elist_x enemy_elist_x enemy_id st in
    let first_id = order.first_id in
    let second_id = order.second_id in
    let st' = do_eff_lst (first_id, second_id, st) order.first_elist in
    let st'' = do_eff_lst (second_id, first_id, st') order.second_elist in
    st''
end

module DoInteractHelp = struct
  open CommonHelp
  open Controller

(* Normally, i represents which pokemon the user wants to start with.
   For protoype, we default to pikachu. TODO failwith "alpha set" *)
  let do_csart i st =
    let user_poke_new = Pokemon.build_poke ":)" in (*TODO failwith "implement pokemon picking" alpha set *)
    let user_info = List.assoc "user" st.population in
    let user_info' = {user_info with poke_inv = [0, user_poke_new]} in
    let population' = update_assoc "user" user_info' st.population in
    {st with population = population'}

(* Normally, go to next available level. In prototype, we go to level 6. *)
  let do_cmap st =
    {st with mode = MCombat "enemy_05"}

(* Go back to map. TODO inform state that next level is one higher. *)
  let do_cwin st =
    {st with mode = MMap}

  (* Go back to map. TODO inform state that next level is same.  *)
  let do_close st =
    {st with mode = MMap}

(* Let mode be MQuit, so that main knows that we have quit.*)
  let do_cquit st =
    {st with mode = MQuit}

  let do_interact choices st =
    match choices with
    | CStart i -> do_csart i st
    | CMap -> do_cmap st
    | CWin -> do_cwin st
    | CLose -> do_close st
    | CQuit -> do_cquit st
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

let get_mode st =
  st.mode

let do' cmd st =
  let open Controller in
  match cmd with
  | Move s -> failwith "unreachable: handled by gui"
  | Interact choices -> DoInteractHelp.do_interact choices st
  | CombatAction eff_lst -> failwith "unreachable: main will never ask model to do this"
  | Round (user_elist, enemy_elist) -> DoRoundHelp.do_round user_elist enemy_elist st
