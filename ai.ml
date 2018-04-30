open Pokemon
open Model
open Types
open Controller

(* [team_points pokes1 pokes2] evaluates the current combat situation to
 * a score for the team of [pokes1] vs [pokes2]. The score is based off of the
 * proportion of remaining hit points of the pokemon in [pokes2] with lower hp
 * amounting to more points. The score is also based off of the relative type
 * advantage of [pokes1] vs. [pokes2]. And finally, the score is also based on
 * how many pokemon have 0 remaining hit points in [pokes2] with more points
 * awarded for more pokemon with 0 hit points.*)
let team_points (pokes1 : poke list) (pokes2 : poke list) =
  let poke1 = (pokes1 |> List.split |> snd) in
  let poke2 = (pokes2 |> List.split |> snd) in
  let hp_points_fun acc poke =
    (1. -. float (hp poke) /. float (maxhp poke)) *. 100. +. acc in
  let type_points_fun tp_lst sum poketp =
    ((List.fold_left (fun acc tp_elt -> (type_compare poketp tp_elt) +. acc) 0.
        tp_lst) /. float (List.length tp_lst) -. 1.) *. 50. +. sum in
  let faint_points_fun acc poke = if hp poke == 0 then acc + 100 else acc in
  let hp_points = int_of_float (List.fold_left hp_points_fun 0. (poke2)) in
  let poke_types pokes =
    List.fold_left (fun acc poke -> (ptype poke)@acc) [] pokes in
  let type_points = int_of_float
      (poke1 |> poke_types |> List.fold_left
         (type_points_fun (poke2 |> poke_types)) 0.) in
  let faint_points = List.fold_left faint_points_fun 0 (poke2) in
  hp_points + type_points + faint_points

(* [update_combat state moves] produces a Model state after application of all
 * commands within the CombatAction list [moves].*)
let rec update_combat state = function
  | (CombatAction h1)::(CombatAction h2)::t ->
    update_combat (do' (Round (h1,h2)) state) t
  | _ -> state

(* [evaluate state user_pokes enemy_pokes moves] evaluates the current combat to
 * a score, positive score corresponds to a match that the enemy ai is winning
 * and a negative score corresponds to one where the user is winning. The
 * more decisive the victory, the more points (either positive or negative) it
 * is worth. [moves] must be a valid CombatAction list representing the ai's
 * moves and user's predicted moves (in twos). [state] must be a valid game
 * state of either the initial game state or one produced by any number of calls
 * on do'.*)
let evaluate state moves =
  let new_state = update_combat state moves in
  let ai_inf = get_ai_info new_state in
  let user_pokes = ai_inf.user_poke_inv in
  let enemy_pokes = ai_inf.enemy_poke_inv in
  (team_points enemy_pokes user_pokes) - (team_points user_pokes enemy_pokes)

(* [valid_moves pokes items] returns a list of valid commands for the player
 * with party [pokes] and inventory [items]. *)
let valid_moves (pokes : poke list) (items : Pokemon.item list) =
  let append_char ch lst = List.rev_map (fun m -> (ch,m)) lst in
  let item_moves_fun acc item =
    let cmd = item_use_combat item in
    begin match cmd with
      | None -> acc
      | Some mv -> ('i',mv)::acc
    end in
  let switch_move_fun acc asc_poke = if (asc_poke |> snd |> hp) = 0 then acc
    else ('s',(CombatAction([Switch(asc_poke|>fst)])))::acc in
  let item_moves = List.fold_left item_moves_fun [] items in
  let action_moves =
    let move_list = (pokes |> List.assoc 0 |> actions |> List.split |> snd) in
    (append_char 'a' move_list)@item_moves in
  List.fold_left switch_move_fun action_moves (pokes |> List.remove_assoc 0)

(* [accuracy move] returns the accuracy of a given effect [move].*)
let accuracy = function
  | Switch _ | Nothing -> 100.
  | Heal (_,i1,_) | Damage (_,i1,_,_) | Status (_,i1,_) | Buff (_,i1,_)
  | Special (_,i1,_) -> float i1

(* [move_acy_set acy move] returns effect [move] with accuracy set to [acy] if
 * possible for the effect type of [move].*)
let move_acy_set acy move =
  match move with
  | Heal (poke,_,mag) -> Heal (poke,acy,mag)
  | Damage (poke,_,mag,freq) -> Damage (poke,acy,mag,freq)
  | Status (poke,_,sta) -> Status (poke,acy,sta)
  | Buff (poke,_,buf) -> Buff (poke,acy,buf)
  | Special (poke,_,spec) -> Special (poke,acy,spec)
  | Nothing | Switch _ -> move

(* [expand_move move acc] produces a list of effect list and probability values
 * that represent all possible outcomes from action [move], and their respective
 * probabilities of occuring.
 * requires -
 * - [move] a list of effect types representing a valid CombatAction. List size
 *   should be maximum 3 effects.
 * - [acc] an accumulator initiated as the empty list.*)
let rec expand_move move acc =
  let miss_chance rem_acc hit =  rem_acc -. (snd hit) in
  match move with
  | [] when acc<>[] -> let miss = (acc |> List.fold_left miss_chance 100.) in
    if miss = 0. then acc else ([Nothing],miss)::acc
  | [] -> acc
  | h::t when acc = [] -> let new_h = move_acy_set 100 h in
    expand_move t [[new_h],(accuracy h)]
  | h::t -> let new_h = move_acy_set 100 h in
    begin match acc with
      | (eff1,acy1)::(eff2,acy2)::[] -> let acy = accuracy h in
        let new_acy_miss1 = (100. -. acy) *. acy1 /. 100. in
        let new_acy_hit1 = (acy *. acy1 /. 100.) in
        let new_acy_miss2 = (100. -. acy) *. acy2 /. 100. in
        let new_acy_hit2 = (acy *. acy2 /. 100.) in
        let new_hits = (new_h::(eff2@eff1),new_acy_hit2)
                       ::(new_h::eff1,new_acy_hit1)::[] in
        let new_miss = ((eff2@eff1),new_acy_miss2)
                       ::(eff1,new_acy_miss1)::[] in
        expand_move t (new_hits@new_miss)
      | (eff1,acy1)::[] -> let acy = accuracy h in
        let new_acy_miss = (100. -. acy) *. acy1 /. 100. in
        let new_acy_hit = (acy *. acy1 /. 100.) in
        expand_move t (((new_h::eff1),new_acy_hit)::(eff1,new_acy_miss)::[])
      | _ -> failwith "Can't happen: expand_move"
    end

(* [gamma_A state] *)
let rec gamma state min_max depth_max depth path score_minmax =
  let depth = if min_max = "max" then depth + 1 else depth in
  let ai_inf = get_ai_info state in
  if min_max = "max" && depth < depth_max then let score_A = min_int in
    let moves = valid_moves ai_inf.enemy_poke_inv ai_inf.enemy_item_inv in
    chance_layer moves path path score_A
      "max" depth_max depth score_minmax state
  else if min_max = "min" && depth < depth_max then let score_B = max_int in
    let moves = valid_moves ai_inf.user_poke_inv [] in
    chance_layer moves path path score_B
      "min" depth_max depth score_minmax state
  else let _,moves_up = List.split path in
         path,(evaluate state moves_up)

and chance_layer lst rootp bestp score min_max dep_max dep sc_mnmx st =
  let s = 0. in let p = 0. in
  match lst with
    | [] -> bestp,score
    | h::t ->
      let n_path,n_score
        = chance_move h s p score min_max dep_max dep rootp sc_mnmx st in
      if min_max = "max" && score >= n_score
      then chance_layer t rootp rootp score min_max dep_max dep sc_mnmx st
      else if min_max = "max" && score < n_score then
        chance_layer t rootp n_path n_score min_max dep_max dep sc_mnmx st
      else if min_max = "min" && score <= n_score then
        chance_layer t rootp rootp score min_max dep_max dep sc_mnmx st
      else chance_layer t rootp n_path n_score min_max dep_max dep sc_mnmx st

and chance_move move s p score min_max dep_max dep path sc_mnmx st =
  let eff = begin match move with
    | _,Interact | _,Move _ -> failwith "Combat moves should be CombatActions"
    | 'i',(CombatAction effs) -> expand_move effs []
    | 's',(CombatAction effs) -> expand_move effs []
    | 'a',(CombatAction effs) -> expand_move effs []
    | _,_ -> failwith "Something wrong with move list definition"
    end in
  chance_br eff s p min_max dep_max dep path
    (snd move) sc_mnmx score score false path st

and chance_br branch s p min_max dep_max dep path
    comb_act sc_mnmx score alphbet skip prev_path st =
  match branch with
  | x when skip -> prev_path,alphbet
  | [] -> prev_path,alphbet
  | (moves,acy)::t -> let n_mnmx = if min_max = "max" then "min" else "max" in
    let sc_min_or_max = if min_max = "max" then snd sc_mnmx else fst sc_mnmx in
    let new_path = (comb_act,(CombatAction moves))::path in
    let res_path,res_score = gamma st n_mnmx dep_max dep new_path sc_mnmx in
    let s = s +. (float res_score) *. (acy /. 100.) in
    let p = p +. (acy /. 100.) in
    let n_alphbet = s +. (1. -. p) *. sc_min_or_max in
    if min_max = "max" && n_alphbet <= float score then
      chance_br t s p min_max dep_max dep path
        comb_act sc_mnmx score (truncate n_alphbet) true res_path st
    else if min_max = "max" && n_alphbet > float score then
      chance_br t s p min_max dep_max dep path
        comb_act sc_mnmx score (truncate n_alphbet) false res_path st
    else if min_max = "min" && n_alphbet >= float score then
      chance_br t s p min_max dep_max dep path
        comb_act sc_mnmx score (truncate n_alphbet) true res_path st
    else chance_br t s p min_max dep_max dep path
        comb_act sc_mnmx score (truncate n_alphbet) false res_path st

(* [take_turn state]*)
let take_turn state =
  let act_lst = gamma state "max" 1 (-1) [] (-1200.,1200.) in
  let choice = (act_lst |> fst |> List.rev |> List.hd |> fst) in
  let ai_inf = get_ai_info state in
  let moves = valid_moves ai_inf.enemy_poke_inv ai_inf.enemy_item_inv in
  let wrong = if Random.int 5 > ai_inf.enemy_level then true else false in
  if wrong then ((List.length moves - 1) |> Random.int |> List.nth moves |> snd)
  else choice
