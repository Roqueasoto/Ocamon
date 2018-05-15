open Pokemon
open Model
open Shared_types
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
  let poke_types pokes = List.fold_left
      (fun acc pk -> if hp pk <> 0 then (ptype pk)@acc else acc) [] pokes in
  let type_points = int_of_float(poke1 |> poke_types |> List.fold_left
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
  | Heal (_,i1,_) | Damage (_,i1,_,_,_,_) | Status (_,i1,_) | Buff (_,i1,_)
  | Special (_,i1,_,_) -> float i1

(* [move_acy_set acy move] returns effect [move] with accuracy set to [acy] if
 * possible for the effect type of [move].*)
let move_acy_set acy move =
  match move with
  | Heal (poke,_,mag) -> Heal (poke,acy,mag)
  | Damage (poke,_,mag,freq,typ,ca) -> Damage (poke,acy,mag,freq,typ,ca)
  | Status (poke,_,sta) -> Status (poke,acy,sta)
  | Buff (poke,_,buf) -> Buff (poke,acy,buf)
  | Special (poke,_,spec,eff) -> Special (poke,acy,spec,eff)
  | Nothing | Switch _ -> move

(* [expand_move move acc] produces a list of effect list and probability values
 * that represent all possible outcomes from action [move], and their respective
 * probabilities of occuring.
 * requires -
 * - [move] a list of effect types representing a valid CombatAction. List size
 *   should be maximum 3 effects.
 * - [acc] an accumulator initiated as the empty list.
 * raises -
 * - failwith "Move too large: expand_move" -  if list of expanded effects is
 *   larger than anticipated.  *)
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
        if acy <> 100. then
          let new_acy_miss1 = (100. -. acy) *. acy1 /. 100. in
          let new_acy_hit1 = (acy *. acy1 /. 100.) in
          let new_acy_miss2 = (100. -. acy) *. acy2 /. 100. in
          let new_acy_hit2 = (acy *. acy2 /. 100.) in
          let new_hits = (new_h::eff1,new_acy_hit1)
                        ::(new_h::eff2,new_acy_hit2)::[] in
          let new_miss = (eff1,new_acy_miss1)::(eff2,new_acy_miss2)::[] in
          expand_move t (new_hits@new_miss)
        else let new_hits = (new_h::eff1,acy1)::(new_h::eff2,acy2)::[] in
          expand_move t new_hits
      | (eff1,acy1)::[] -> let acy = accuracy h in if acy <> 100. then
          let new_acy_miss = (100. -. acy) *. acy1 /. 100. in
          let new_acy_hit = (acy *. acy1 /. 100.) in
          expand_move t (((new_h::eff1),new_acy_hit)::(eff1,new_acy_miss)::[])
        else expand_move t (((new_h::eff1),acy1)::[])
      | _ -> failwith "Move too large: expand_move"
    end

(* [gamma state min_max depth_max depth path score_minmax]
 * returns the best choice CombatAction and corresponding score
 * using the gamma pruning technique, pioneered by Melko and Nagy 2007. The
 * gamma function has 3 branches: a minimizer, a maximizer, and an evaluation
 * stage when the desired depth is reached.
 * requires:
 *  - [state] - a valid game state that is either the initial state or
 *    one produced by multiple applications of do on the initial state.
 *  - [min_max] - either "min" or "max" designating which action to perform.
 *  - [depth_max] -  an integer designating the maximum desired depth.
 *  - [depth] - an integer indicating current depth. Initialized as -1.
 *  - [score_minmax] - a tuple of floats containg the largest possible points a
 *    single move could bring the minimizer respectively.  *)
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

(* [chance_layer lst rootp bestp score min_max dep_max dep sc_mnmx st]
 * returns the best choice CombatAction and corresponding score
 * using the gamma pruning technique, pioneered by Melko and Nagy 2007. This
 * function is built as a mutually recursive helper function to gamma.
 * requires:
 *  - [lst] - a list of valid char*combat action pairs.
 *  - [st] - a valid game state that is either the initial state or
 *    one produced by multiple applications of do on the initial state.
 *  - [rootp] the path of moves leading to valid moves [lst].
 *  - [bestp] the path of moves leading to the current best moves [lst].
 *  - [min_max] - either "min" or "max" designating which action to perform.
 *  - [dep_max] -  an integer designating the maximum desired depth.
 *  - [dep] - an integer indicating current depth. Initialized as -1.
 *  - [sc_mnmx] - a tuple of floats containg the largest possible points a
 *    single move could bring the minimizer respectively.  *)
and chance_layer lst rootp bestp score min_max dep_max dep sc_mnmx st =
  let s = 0. in let p = 0. in
  match lst with
    | [] -> bestp,score
    | h::t ->
      let n_path,n_score
        = chance_move h s p score min_max dep_max dep rootp sc_mnmx st in
      if min_max = "max" && score >= n_score
      then chance_layer t rootp bestp score min_max dep_max dep sc_mnmx st
      else if min_max = "max" && score < n_score then
        chance_layer t rootp n_path n_score min_max dep_max dep sc_mnmx st
      else if min_max = "min" && score <= n_score then
        chance_layer t rootp bestp score min_max dep_max dep sc_mnmx st
      else chance_layer t rootp n_path n_score min_max dep_max dep sc_mnmx st

(* [chance_move move s p score min_max dep_max dep path sc_mnmx st]
 * returns the score corresponding to CombatAction move and path of the move,
 * using the gamma pruning technique, pioneered by Melko and Nagy 2007. This
 * function is built as a mutually recursive helper function to gamma.
 * requires:
 *  - [move] - a valid char*CombatAction pair.
 *  - [s] - a float that represents the value of the current move.
 *  - [p] - a float that represents the probability of the current move.
 *  - [score] - an integer value representing the current best move.
 *  - [st] - a valid game state that is either the initial state or
 *    one produced by multiple applications of do on the initial state.
 *  - [min_max] - either "min" or "max" designating which action to perform.
 *  - [dep_max] -  an integer designating the maximum desired depth.
 *  - [dep] - an integer indicating current depth. Initialized as -1.
 *  - [sc_mnmx] - a tuple of floats containg the largest possible points a
 *    single move could bring the minimizer respectively.  *)
and chance_move move s p score min_max dep_max dep path sc_mnmx st =
  let eff = begin match move with
    | _,Interact _ | _,Move _ -> failwith "Combat moves should be CombatActions"
    | 'i',(CombatAction effs) -> expand_move effs []
    | 's',(CombatAction effs) -> expand_move effs []
    | 'a',(CombatAction effs) -> expand_move effs []
    | _,_ -> failwith "Something wrong with move list definition"
    end in
  chance_br eff s p min_max dep_max dep path
    (snd move) sc_mnmx score score false path st

(* [chance_br branch s p min_max dep_max dep path comb_act sc_mnmx score
 *   alphbet skip prev_path st]
 * returns the average score corresponding to [branch] and path of the move,
 * using the gamma pruning technique, pioneered by Melko and Nagy 2007. This
 * function is built as a mutually recursive helper function to gamma. This
 * is where pruning occurs if a move is partially evaluated to not be useful.
 * requires:
 *  - [branch] - a list of effect list * float (accuracy) pairs.
 *  - [s] - a float that represents the value of the current move.
 *  - [p] - a float that represents the probability of the current move.
 *  - [comb_act] - a valid Combat Action.
 *  - [score] - an integer value representing the current best move.
 *  - [alphbet] - a float corresponding to the value of the current move with
 *     the best possible scenario.
 *  - [skip] -  a boolean to designate if remaining of branch should be skipped.
 *  - [prev_path] - the path to the latest move in branch.
 *  - [st] - a valid game state that is either the initial state or
 *    one produced by multiple applications of do on the initial state.
 *  - [min_max] - either "min" or "max" designating which action to perform.
 *  - [dep_max] -  an integer designating the maximum desired depth.
 *  - [dep] - an integer indicating current depth. Initialized as -1.
 *  - [sc_mnmx] - a tuple of floats containg the largest possible points a
 *    single move could bring the minimizer respectively.  *)
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

(* [take_turn state] returns a CombatAction representing the choice taken by
 * the ai. Every time take_turn is called, the ai assesses what the best move
 * is through the gamma (gamma pruning function) and then depending on the level
 * of difficulty of the enemy, decides whether or not to dispose of it and
 * instead choose a random move from all valid moves it may make. *)
let take_turn state =
  (* make sc_mnmx more accurate*)
  let act_lst = gamma state "max" 1 (-1) [] (-1200.,1200.) in
  let choice = (act_lst |> fst |> List.rev |> List.hd |> fst) in
  let ai_inf = get_ai_info state in
  let moves = valid_moves ai_inf.enemy_poke_inv ai_inf.enemy_item_inv in
  let wrong = if Random.int 5 > ai_inf.enemy_level then true else false in
  if wrong then ((List.length moves - 1) |> Random.int |> List.nth moves |> snd)
  else choice
