open Types
open Model
open Ai
open Controller
open Guitext

(* [step st gmode] returns new game state when the GUI returns, indicating the
 * a command was given. If the mode is Quit, then no stepping takes place.
 * requires :
 * - [st] -> a valid game state.
 * - [gmode] -> a valid game mode of type mode.
 * raises : "unreachable : step" if the command given by ai or user is not of
 *  the CombatAction type. *)
let step st gmode =
  let g_inf = get_gui_info st in
  match gmode with
  | MQuit -> st
  | MStart | MMap | MWin | MLose | MWinGame -> do' (get_cmd g_inf gmode) st
  | MCombat _ -> let user_cmd = get_cmd g_inf gmode in
    begin match user_cmd with
      | (CombatAction u_eff) -> let ai_cmd = take_turn st in
        let ai_eff = begin match ai_cmd with
          | CombatAction a_eff -> a_eff
          | _ -> failwith "unreachable : step"
        end in
        do' (Round (u_eff,ai_eff)) st
      | (Interact cmd) -> do' (Interact cmd) st
      | _ -> failwith "unreachable : step"
    end

(* [play_game st] Begins the gameplay loop, recursively calling itself until the
 * game is over, at which time it returns a unit. Requies a valid game state. *)
let rec play_game st =
  let omode = get_mode st in
  let new_st = step st omode in
  let nmode = get_mode new_st in
  match nmode with
  | MQuit -> ()
  | MStart | MMap | MCombat _ | MWin | MLose | MWinGame -> play_game new_st

(* [main ()] starts the REPL, which initializes the game and starts the GUI. *)
let main () =
  let init_st = initiate_state () in
  play_game init_st

(*  Runs Main Function. *)
let () = main ()
