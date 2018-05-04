open OUnit2
open Ai
open Types
open Controller
open Pokemon
open Model

(* This file will glass-box and black-box test the methods of ai.ml *)

let bb_tests = []

let gb_tests = []

(*
--------------------------------------------------------------------------------
  This is the black-box testing section of this module.
*)

let tests_b = [
  (*Check insertion works well with empty set. *)
]

let bb_tests = bb_tests @ tests_b

(*
--------------------------------------------------------------------------------
  This is the glass-box testing section of this module. Will be commenting out
  the section when not glass-box testing to not expose the methods in ai.
*)

let tests_g =

  (* Testing game state evaluation.*)
  let user_pty1 = [ (0,build_poke "25") ] in
  let ai_pty1 = (0,random_poke ())::[] in
  let ai_inf_1 = {
    user_poke_inv = user_pty1;
    enemy_poke_inv = ai_pty1;
    enemy_item_inv = [];
    enemy_level = 5; } in
  let st1 = make_hypothetical_state ai_inf_1 in
  let no_mv1 = (CombatAction [Nothing])::(CombatAction [Nothing])::[] in
  let dmg2 = Damage (Other,100,5,(1,1)) in
  let ai_poke2 = random_poke () in
  let user_poke2 = poke_effect ("25" |> build_poke) ai_poke2 dmg2 in
  let user_pty2 = [ (0,user_poke2) ] in
  let ai_pty2 = (0,ai_poke2)::[] in
  let ai_inf_2 = {
    user_poke_inv = user_pty2;
    enemy_poke_inv = ai_pty2;
    enemy_item_inv = [];
    enemy_level = 5; } in
  let st2 = make_hypothetical_state ai_inf_2 in
  let dmg3 = Damage (Other,100,300,(1,1)) in
  let ai_poke3 = random_poke () in
  let user_poke3 = poke_effect ("25" |> build_poke) ai_poke3 dmg3 in
  let user_pty3 = [ (0,build_poke "25");(1,user_poke3) ] in
  let ai_pty3 = (0,ai_poke3)::[] in
  let ai_inf_3 = {
    user_poke_inv = user_pty3;
    enemy_poke_inv = ai_pty3;
    enemy_item_inv = [];
    enemy_level = 5; } in
  let st3 = make_hypothetical_state ai_inf_3 in

  (* Testing getting and setting accuracy of effects. *)
  let effS = Switch 1 in
  let effH = Heal (Other,90,90) in
  let effSta = Status (Other,75,Paralyze) in
  let effBf = Buff (Other,100,ATKBuff 2) in
  let effN = Nothing in
  let n_effH = Heal (Other,35,90) in
  let n_effSta = Status (Other,95,Paralyze) in
  let n_effBf = Buff (Other,10,ATKBuff 2) in
  let n_effD = Damage (Other,85,300,(1,1)) in

  (* Testing expansion of moves*)
  let fl_mv1 = [Damage (Other,85,300,(1,1))] in
  let fl_mv2 = [Damage (Other,85,300,(1,1)) ; Switch 1 ] in
  let fl_mv3 = [Damage (Other,85,300,(1,1)) ; Heal (Other,35,90) ] in
  let fl_mv4 = [Damage (Other,85,90,(1,1)) ; Heal (Other,35,90) ; Switch 1] in
  let fl_mv5 = [Damage (Other,85,90,(1,1)) ; Heal (Other,35,90) ;
                Status (Other,30,Paralyze)] in
  let fl_mv6 = [Damage (Other,85,90,(1,1)) ; Heal (Other,35,90) ; Switch 1 ;
                Status (Other,30,Paralyze)] in
  let fl_mv7 = [Damage (Other,85,90,(1,1)) ; Heal (Other,35,90) ;
                Status (Other,30,Paralyze) ; Switch 1 ] in
  let ex_mv1 = [([Nothing],15.);([Damage (Other,85,300,(1,1))],85.)] in
  let ex_mv2 = [([Nothing],15.);([Switch 1;Damage (Other,85,300,(1,1))],85.)] in
  let ex_mv3 =
    [([Nothing],15.);([Heal (Other,35,90);Damage (Other,85,300,(1,1))],76.5);
     ([Damage (Other,85,300,(1,1))],8.5)] in
  let ex_mv4 =
    [([Nothing],15.);
     ([Switch 1;Heal (Other,35,90);Damage (Other,85,300,(1,1))],76.5);
     ([Switch 1;Damage (Other,85,300,(1,1))],8.5)] in
  let ex_mv5 =
    [([Nothing],15.);([Status (Other,30,Paralyze);Heal (Other,35,90);
                       Damage (Other,85,300,(1,1))],22.95);
     ([Status (Other,30,Paralyze);Damage (Other,85,300,(1,1))],2.55);
     ([Heal (Other,35,90);Damage (Other,85,300,(1,1))],53.55);
     ([Damage (Other,85,300,(1,1))],5.95)] in
  let ex_mv6 =
    [([Nothing],15.);([Status (Other,30,Paralyze);Switch 1;Heal (Other,35,90);
                       Damage (Other,85,300,(1,1))],22.95);
     ([Status (Other,30,Paralyze);Switch 1;Damage (Other,85,300,(1,1))],2.55);
     ([Switch 1;Heal (Other,35,90);Damage (Other,85,300,(1,1))],53.55);
     ([Switch 1;Damage (Other,85,300,(1,1))],5.95)] in
  let er_mv7 = try let _ = expand_move fl_mv7 [] in false
    with _ -> true in

  (* Testing valid_move generation. *)
  let mv_gen1 = [Damage (Other,85,300,(1,1))] in
  let fl_mv2 = [Damage (Other,85,300,(1,1)) ; Switch 1 ] in [
  (* Test the evaluation function with teams that only have a type difference.*)
  "tp_us1" >:: (fun _ -> assert_equal 25 (team_points user_pty1 ai_pty1));
  "tp_ai1" >:: (fun _ -> assert_equal (-25) (team_points ai_pty1 user_pty1));
  "up_cmbt1" >:: (fun _ -> assert_equal st1 (update_combat st1 no_mv1));
  "eval1" >:: (fun _ -> assert_equal (-50) (evaluate st1 no_mv1));

  (* Test the evaluation function with teams that have an hp difference.*)
  "tp_us2" >:: (fun _ -> assert_equal 25 (team_points user_pty2 ai_pty2));
  "tp_ai2" >:: (fun _ -> assert_equal true (team_points ai_pty1 user_pty1 <
                    team_points ai_pty2 user_pty2));
  "up_cmbt2" >:: (fun _ -> assert_equal st2 (update_combat st2 no_mv1));
  "eval2" >:: (fun _ -> assert_equal true
                  (evaluate st1 no_mv1 < evaluate st2 no_mv1));

  (* Test the evaluation function with teams that have fainted members.*)
  "tp_us3" >:: (fun _ -> assert_equal 25 (team_points user_pty3 ai_pty3));
  "tp_ai3" >:: (fun _ -> assert_equal (175) (team_points ai_pty3 user_pty3));
  "up_cmbt3" >:: (fun _ -> assert_equal st3 (update_combat st3 no_mv1));
  "eval3" >:: (fun _ -> assert_equal (150) (evaluate st3 no_mv1));

  (* Test the accuracy function with all effect types. *)
  "accS" >:: (fun _ -> assert_equal 100. (accuracy effS));
  "accH" >:: (fun _ -> assert_equal 90. (accuracy effH));
  "accD" >:: (fun _ -> assert_equal 100. (accuracy dmg3));
  "accSta" >:: (fun _ -> assert_equal 75. (accuracy effSta));
  "accBF" >:: (fun _ -> assert_equal 100. (accuracy effBf));
  "accN" >:: (fun _ -> assert_equal 100. (accuracy effN));

  (* Test the move_acy_set function with all effect types. *)
  "naccS" >:: (fun _ -> assert_equal (accuracy effS)
                  (effS |> move_acy_set 75 |> accuracy));
  "naccH" >:: (fun _ -> assert_equal (accuracy n_effH)
                  (effH |> move_acy_set 35 |> accuracy));
  "naccD" >:: (fun _ -> assert_equal (accuracy n_effD)
                  (dmg3 |> move_acy_set 85 |> accuracy));
  "naccSta" >:: (fun _ -> assert_equal (accuracy n_effSta)
                  (effSta |> move_acy_set 95 |> accuracy));
  "naccBF" >:: (fun _ -> assert_equal (accuracy n_effBf)
                  (effBf |> move_acy_set 10 |> accuracy));
  "naccN" >:: (fun _ -> assert_equal (accuracy effN)
                  (effN |> move_acy_set 35 |> accuracy));

  (* Test the expand_move function with various effects lists. *)
  "exp_1" >:: (fun _ -> assert_equal ex_mv1 (expand_move fl_mv1 []));
  "exp_2" >:: (fun _ -> assert_equal ex_mv2 (expand_move fl_mv2 []));
  "exp_3" >:: (fun _ -> assert_equal ex_mv3 (expand_move fl_mv3 []));
  "exp_4" >:: (fun _ -> assert_equal ex_mv4 (expand_move fl_mv4 []));
  "exp_5" >:: (fun _ -> assert_equal ex_mv5 (expand_move fl_mv5 []));
  "exp_6" >:: (fun _ -> assert_equal ex_mv6 (expand_move fl_mv6 []));
  "exp_7" >:: (fun _ -> assert_equal true er_mv7);

  (* Test the valid_moves function. *)
  "exp_1" >:: (fun _ -> assert_equal ex_mv1 (expand_move fl_mv1 []));
  "exp_2" >:: (fun _ -> assert_equal ex_mv2 (expand_move fl_mv2 []));
  "exp_3" >:: (fun _ -> assert_equal ex_mv3 (expand_move fl_mv3 []));
  "exp_4" >:: (fun _ -> assert_equal ex_mv4 (expand_move fl_mv4 []));
  "exp_5" >:: (fun _ -> assert_equal ex_mv5 (expand_move fl_mv5 []));
  "exp_6" >:: (fun _ -> assert_equal ex_mv6 (expand_move fl_mv6 []));
  "exp_7" >:: (fun _ -> assert_equal true er_mv7);
]

let gb_tests = gb_tests @ tests_g

(*
--------------------------------------------------------------------------------
  This section compiles all available tests.
*)

(* For use in main test file*)
let ai_tests = bb_tests @ gb_tests

(*
let suite = "Full AI test suite" >:::
  bb_tests @ gb_tests

  The following line must be the one and only place
 * in your entire source code that calls [OUnit2.run_test_tt_main].
                   let _ = run_test_tt_main suite *)
