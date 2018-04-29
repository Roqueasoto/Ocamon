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


let tests_g =
  let user_party = [ build_poke "Pikachu" ] in
  let ai_party = [ random_poke ][
  (*Check insertion works well with empty set. *)
  "ins_empt_mem1" >:: (fun _ -> assert_equal true (rem_dict |> member 'c'));
  "ins_empt_mem2" >:: (fun _ -> assert_equal false (rem_dict |> member 'd'));
  "ins_empt_fd" >:: (fun _ -> assert_equal (Some 'd') (rem_dict |> find 'c'));
  "ins_empty" >:: (fun _ -> assert_equal ['c','d'] (rem_dict |> to_list));
]

let gb_tests = gb_tests @ tests_g


--------------------------------------------------------------------------------
  This section compiles all available tests.
*)

let suite = "Full AI test suite" >:::
  bb_tests @ gb_tests

(* The following line must be the one and only place
 * in your entire source code that calls [OUnit2.run_test_tt_main]. *)
let _ = run_test_tt_main suite
