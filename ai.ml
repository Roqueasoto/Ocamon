open Pokemon

(* [team_points score pokes1 pokes2] evaluates the current combat situation to
 * a score for the team of [pokes1] vs [pokes2]. The score is based off of the
 * proportion of remaining hit points of the pokemon in [pokes2] with lower hp
 * amounting to more points. The score is also based off of the relative type
 * advantage of [pokes1] vs. [pokes2]. And finally, the score is also based on
 * how many pokemon have 0 remaining hit point in [pokes2] with more points
 * awarded for more pokemon with 0 hit points.*)
let rec team_points score pokes1 pokes2 =
  let hp_points poke = (float (hp poke) /. float (maxhp poke)) *. 100. in
  let type_matchup tp1 tp_lst =
    ((List.fold_left (fun acc tp_elt -> (type_compare tp1 tp_elt) +. acc) 0.
        tp_lst) /. float (List.length tp_lst) -. 1.) *. 50. in
  let

(* [evaluate user_pokes enemy_pokes] *)
let evaluate user_pokes enemy_pokes =


(* [take_turn ai_inf]*)
let take_turn ai_inf = Controller.Move "up"
