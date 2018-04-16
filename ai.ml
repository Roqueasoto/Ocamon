open Pokemon
open Model
open Command
open Controller

(* [team_points pokes1 pokes2] evaluates the current combat situation to
 * a score for the team of [pokes1] vs [pokes2]. The score is based off of the
 * proportion of remaining hit points of the pokemon in [pokes2] with lower hp
 * amounting to more points. The score is also based off of the relative type
 * advantage of [pokes1] vs. [pokes2]. And finally, the score is also based on
 * how many pokemon have 0 remaining hit points in [pokes2] with more points
 * awarded for more pokemon with 0 hit points.*)
let team_points pokes1 pokes2 =
  let hp_points_fun acc poke =
    (1. -. float (hp poke) /. float (maxhp poke)) *. 100. +. acc in
  let type_points_fun tp_lst sum poketp =
    ((List.fold_left (fun acc tp_elt -> (type_compare poketp tp_elt) +. acc) 0.
        tp_lst) /. float (List.length tp_lst) -. 1.) *. 50. +. sum in
  let faint_points_fun acc poke = if hp poke == 0 then acc + 100 else acc in
  let hp_points = int_of_float (List.fold_left hp_points_fun 0. (snd pokes2)) in
  let poke_types pokes =
    List.fold_left (fun acc poke -> ptype poke::acc) [] pokes in
  let type_points = int_of_float
      (pokes1 |> snd |> poke_types |> List.fold_left
         (type_points_fun (pokes2 |> snd |> poke_types)) 0.) in
  let faint_points = List.fold_left faint_points_fun 0 (snd pokes2) in
  hp_points + type_points + faint_points

(* [evaluate user_pokes enemy_pokes] evaluates the current combat to a score
 * where a positive score corresponds to a match that the enemy ai is winning
 * and where a negative score corresponds to one where the user is winning. The
 * more decisive the vicoty, the more points (either positive or negative) it
 * is worth. *)
let evaluate user_pokes enemy_pokes =
  team_points enemy_pokes user_pokes - team_points user_pokes enemy_pokes

(* [valid_moves pokes items] returns a list of valid commands for the player
 * with party [pokes] and inventory [items]. *)
let valid_moves pokes items =
  let item_moves_fun acc item = let cmd = item_use_combat item in if cmd == None
    then acc else ('i',cmd)::acc in
  let switch_move_fun acc asc_poke = if (asc_poke |> snd |> hp) = 0 then acc
    else ('s',(CombatAction(Switch(asc_poke|>fst))))::acc in
  let item_moves = List.fold_left item_moves_fun [] items in
  let action_moves =
    ('a',(pokes |> List.assoc 0 |> actions |> snd)::item_moves) in
  List.fold_left switch_move_fun action_moves (pokes |> List.remove_assoc 0)

(* [gamma_A state] *)
let rec gamma_A state =
  let score = min_int in
  let moves = valid_moves state.enemy_poke_lst state.enemy_item_lst in
  state

and chance_layer move_lst =
  match move_lst with
  |


(* [take_turn ai_inf]*)
let take_turn ai_inf = Controller.Move "up"
