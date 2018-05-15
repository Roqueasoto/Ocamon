open Graphics
open Camlimages
open Images
open Png
open Jpeg
open Pokemon
open Shared_types
open Controller

(*
#require "graphics";;
open Graphics;;
#require "camlimages";;
open Camlimages;;
#require "camlimages.png";;
open Png;;
#require "camlimages.jpeg";;
open Jpeg;;
open Images;;
*)

type image

type status = {
  mouse_x : int;	(* X coordinate of the mouse *)
  mouse_y : int;	(* Y coordinate of the mouse *)
  button : bool;	(* true if a mouse button is pressed *)
  keypressed : bool;	(* true if a key has been pressed *)
  key : char;	(* the character for the key pressed *)
}

type event =
  |Button_down
  |Button_up
  |Key_pressed
  |Mouse_motion
  |Poll


(* let rec updateStatus (l: event list) (st: status) =
  match l with
  |[] -> draw_char ' '
  |h::t -> if st.keypressed = true
  then draw_char st.key else updateStatus t st *)

  (* Printf.printf "Key value pressed: %d\n%!" key;*)

(*[array_of_image img] transforms image to color color array*)
let array_of_image img =
  match img with
  | Images.Index8 bitmap ->
      let w = bitmap.Index8.width
      and h = bitmap.Index8.height
      and colormap = bitmap.Index8.colormap.map in
      let cmap = Array.map (fun {r = r; g = g; b = b} -> Graphics.rgb r g b)
        colormap in
      if bitmap.Index8.transparent <> -1 then
        cmap.(bitmap.Index8.transparent) <- transp;
      Array.init h (fun i ->
        Array.init w (fun j -> cmap.(Index8.unsafe_get bitmap j i)))
  | Index16 bitmap ->
      let w = bitmap.Index16.width
      and h = bitmap.Index16.height
      and colormap = bitmap.Index16.colormap.map in
      let cmap = Array.map (fun {r = r; g = g; b = b} -> rgb r g b) colormap in
      if bitmap.Index16.transparent <> -1 then
        cmap.(bitmap.Index16.transparent) <- transp;
      Array.init h (fun i ->
        Array.init w (fun j -> cmap.(Index16.unsafe_get bitmap j i)))
  | Rgb24 bitmap ->
      let w = bitmap.Rgb24.width
      and h = bitmap.Rgb24.height in
      Array.init h (fun i ->
        Array.init w (fun j ->
          let {r = r; g = g; b = b} = Rgb24.unsafe_get bitmap j i in
          rgb r g b))
  | Rgba32 _ | Cmyk32 _ -> failwith "RGBA and CMYK not supported"

<<<<<<< HEAD
(*[get_image f] reads an image from a .png file  *)

let rec press_battle num () =
  let keep_running = ref true in
    while !keep_running do
      let s = Graphics.wait_next_event [Graphics.Key_pressed] in
      if s.Graphics.keypressed
      then
        if s.Graphics.key = 'q'
        then close_graph ()
        else if s.Graphics.key = '1'
        then num := 1
=======
(*BATTLE-BATTLE-BATTLE-BATTLE-BATTLE-BATTLE-BATTLE-BATTLE-BATTLE-BATTLE *)
let fpi_press () =
  let num = ref 1 in
  let keep_running = ref true in
    while !keep_running do
      let s = Graphics.wait_next_event [Graphics.Key_pressed] in
      if s.Graphics.keypressed
      then
        if s.Graphics.key = '1'
        then (num := 1; keep_running := false)
        else if s.Graphics.key = '2'
        then (num := 2; keep_running := false)
        else if s.Graphics.key = '3'
        then (num := 3; keep_running := false)
        else keep_running := true;
    done; !num

let pokemon_or_items () =
  let num = ref 1 in
  let keep_running = ref true in
    while !keep_running do
      let s = Graphics.wait_next_event [Graphics.Key_pressed] in
      if s.Graphics.keypressed
      then
        if s.Graphics.key = '1'
        then (num := 0; keep_running := false)
        else if s.Graphics.key = '2'
        then (num := 1; keep_running := false)
        else if s.Graphics.key = '3'
        then (num := 2; keep_running := false)
        else if s.Graphics.key = '4'
        then (num := 3; keep_running := false)
        else if s.Graphics.key = '5'
        then (num := 4; keep_running := false)
        else if s.Graphics.key = '6'
        then (num := 5; keep_running := false)
        else keep_running := true;
    done; !num

let press_battle_four () =
  let num = ref 1 in
  let keep_running = ref true in
    while !keep_running do
      let s = Graphics.wait_next_event [Graphics.Key_pressed] in
      if s.Graphics.keypressed
      then
        if s.Graphics.key = '1'
        then (num := 1; keep_running := false)
        else if s.Graphics.key = '2'
        then (num := 2; keep_running := false)
        else if s.Graphics.key = '3'
        then (num := 3; keep_running := false)
        else if s.Graphics.key = '4'
        then (num := 4; keep_running := false)
        else keep_running := true;
    done; !num

let press_battle_three () =
  let num = ref 1 in
  let keep_running = ref true in
    while !keep_running do
      let s = Graphics.wait_next_event [Graphics.Key_pressed] in
      if s.Graphics.keypressed
      then
        if s.Graphics.key = '1'
        then (num := 1; keep_running := false)
>>>>>>> 5dff971619973e1c912df79fcca2ee7554f140f5
        else if s.Graphics.key = '2'
        then num := 2
        else if s.Graphics.key = '3'
        then num := 3
        else if s.Graphics.key = '4'
        then num := 4
        else
          keep_running := true;
    done

let make_action num comb_inf =
  List.assoc !num (actions (snd (List.hd (comb_inf.user_person_info.poke_inv))))

let check num comb_inf user_health opp_health =
  if user_health <= 0 || opp_health <= 0
  then
    (*draw_string "Looks like the battle is over."; *)
    Interact CBattleEnd
  else
    make_action num comb_inf

(*val draw_battle: Types.gui_info -> Controller.command*)
let draw_battle gui_inf =
  Graphics.set_window_title "OCAMON!";
  Graphics.open_graph " 300x300";
  let start = Png.load "startScreen.png" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 0 0;

let make_item num comb_inf =
  begin
  match item_use_combat (List.nth (comb_inf.user_person_info.item_inv) num) with
    | Some i -> i
    | None -> failwith "Unreachable : combat_text"
  end
  (*num is 0-5 for chosen item*)

  let opp_poke = Jpeg.load "them.jpg" [] in
  let p = opp_poke|> array_of_image |> make_image in
  draw_image p 200 200;

  set_color white;
  fill_rect 70 20 200 100;
  set_color black;
  set_font "-misc-dejavu sans mono-bold-r-normal--14-0-0-0-m-0-iso8859-1";
  moveto 300 30;
  draw_string ("6. " ^  (List.assoc 5 (inv_names
    (comb_inf.user_person_info.item_inv))));
  moveto 300 50;
  draw_string ("5. " ^  (List.assoc 4 (inv_names
    (comb_inf.user_person_info.item_inv))));
  moveto 300 70;
  draw_string ("4. " ^  (List.assoc 3 (inv_names
    (comb_inf.user_person_info.item_inv))));
  moveto 80 30;
  draw_string ("3. " ^  (List.assoc 2 (inv_names
    (comb_inf.user_person_info.item_inv))));
  moveto 80 50;
  draw_string ("2. " ^  (List.assoc 1 (inv_names
    (comb_inf.user_person_info.item_inv))));
  moveto 80 70;
  draw_string ("1. " ^  (List.assoc 0 (inv_names
    (comb_inf.user_person_info.item_inv))));
  moveto 80 90;
  draw_string "Press number key to use item.";

  let num = ref 0 in

  let comb_inf = begin match gui_inf.combat_info with
    | Some i -> i
    | None -> failwith "Unreachable : combat_text"
  end in

  set_color black;
  set_line_width 7;
  draw_rect 50 10 500 100;
  set_color white;
  fill_rect 50 10 500 100;

  set_color black;
  set_font "-misc-dejavu sans mono-bold-r-normal--14-0-0-0-m-0-iso8859-1";
  moveto 300 30;
  draw_string ("6. " ^ (name (List.assoc 5
    (comb_inf.user_person_info.poke_inv))) ^ "  " ^
    (string_of_int (hp (List.assoc 5 (comb_inf.user_person_info.poke_inv))))
    ^ "/" ^
    (string_of_int (maxhp (List.assoc 5
      (comb_inf.user_person_info.poke_inv)))));

  moveto 300 50;
  draw_string ("5. " ^ (name (List.assoc 4
    (comb_inf.user_person_info.poke_inv))) ^ "  " ^
    (string_of_int (hp (List.assoc 4 (comb_inf.user_person_info.poke_inv))))
    ^ "/" ^
    (string_of_int (maxhp (List.assoc 4
      (comb_inf.user_person_info.poke_inv)))));

  moveto 300 70;
  draw_string ("4. " ^ (name (List.assoc 3
    (comb_inf.user_person_info.poke_inv))) ^ "  " ^
    (string_of_int (hp (List.assoc 3 (comb_inf.user_person_info.poke_inv))))
    ^ "/" ^
    (string_of_int (maxhp (List.assoc 3
      (comb_inf.user_person_info.poke_inv)))));

  moveto 80 30;
  draw_string ("3. " ^ (name (List.assoc 2
    (comb_inf.user_person_info.poke_inv))) ^ "  " ^
    (string_of_int (hp (List.assoc 2 (comb_inf.user_person_info.poke_inv))))
    ^ "/" ^
    (string_of_int (maxhp (List.assoc 2
      (comb_inf.user_person_info.poke_inv)))));

  moveto 80 50;
  draw_string ("2. " ^ (name (List.assoc 1
    (comb_inf.user_person_info.poke_inv))) ^ "  " ^
    (string_of_int (hp (List.assoc 1 (comb_inf.user_person_info.poke_inv))))
    ^ "/" ^
    (string_of_int (maxhp (List.assoc 1
    (comb_inf.user_person_info.poke_inv)))));

  moveto 80 70;
    draw_string ("1. " ^ (name (List.assoc 0
    (comb_inf.user_person_info.poke_inv))) ^ "  " ^
    (string_of_int (hp (List.assoc 0 (comb_inf.user_person_info.poke_inv))))
    ^ "/" ^
    (string_of_int (maxhp (List.assoc 0
      (comb_inf.user_person_info.poke_inv)))));

  moveto 80 90;
  draw_string "Press number key to switch OCAMON.";

  pokemon_or_items ()

  (*I NEED TO DISPLAY THE POKEMON IN THE LIST OF POKEMON*)

let fight_screen gui_inf =
  let comb_inf = begin match gui_inf.combat_info with
    | Some i -> i
    | None -> failwith "Unreachable : combat_text"
  end in

  set_color black;
  set_line_width 7;
  draw_rect 50 10 500 100;
  set_color white;
  fill_rect 50 10 500 100;

  set_color black;
  set_font "-misc-dejavu sans mono-bold-r-normal--12-0-0-0-m-0-iso8859-1";

  if (List.length (action_names (List.assoc 0
    (comb_inf.user_person_info.poke_inv))) = 2)
  then
    (moveto 80 55;
    draw_string ("2. " ^ (List.assoc 2 (action_names (List.assoc 0
      (comb_inf.user_person_info.poke_inv)))));
    moveto 80 70;
    draw_string ("1. " ^ (List.assoc 1 (action_names (List.assoc 0
      (comb_inf.user_person_info.poke_inv)))));
    moveto 80 90;
    draw_string "Press number key for attack.";
    press_battle_two ())

  else
    if (List.length (action_names (List.assoc 0
      (comb_inf.user_person_info.poke_inv))) = 3)
    then
      (moveto 80 40;
      draw_string ("3. " ^ (List.assoc 3 (action_names (List.assoc 0
        (comb_inf.user_person_info.poke_inv)))));
      moveto 80 55;
      draw_string ("2. " ^ (List.assoc 2 (action_names (List.assoc 0
        (comb_inf.user_person_info.poke_inv)))));
      moveto 80 70;
      draw_string ("1. " ^ (List.assoc 1 (action_names (List.assoc 0
        (comb_inf.user_person_info.poke_inv)))));
      moveto 80 90;
      draw_string "Press number key for attack.";

      press_battle_three ())
    else
      (moveto 80 25;
      draw_string ("4. " ^ (List.assoc 4 (action_names (List.assoc 0
        (comb_inf.user_person_info.poke_inv)))));
      moveto 80 40;
      draw_string ("3. " ^ (List.assoc 3 (action_names (List.assoc 0
        (comb_inf.user_person_info.poke_inv)))));
      moveto 80 55;
      draw_string ("2. " ^ (List.assoc 2 (action_names (List.assoc 0
        (comb_inf.user_person_info.poke_inv)))));
      moveto 80 70;
      draw_string ("1. " ^ (List.assoc 1 (action_names (List.assoc 0
        (comb_inf.user_person_info.poke_inv)))));
      moveto 80 90;
      draw_string "Press number key for attack.";

      press_battle_four ())

let fpi_screen gui_inf =
  let comb_inf = begin match gui_inf.combat_info with
    | Some i -> i
    | None -> failwith "Unreachable : combat_text"
  end in

  set_color black;
  set_line_width 7;
  draw_rect 50 10 500 100;
  set_color white;
  fill_rect 50 10 500 100;

  set_color black;
  set_font "-misc-dejavu sans mono-bold-r-normal--12-0-0-0-m-0-iso8859-1";
  moveto 80 40;
  draw_string ("3. " ^ (List.assoc 3 (action_names (snd (List.hd (comb_inf.user_person_info.poke_inv))))));
  moveto 80 55;
  draw_string ("2. " ^ (List.assoc 2 (action_names (snd (List.hd (comb_inf.user_person_info.poke_inv))))));
  moveto 80 70;
  draw_string ("2. " ^ (List.assoc 2 (action_names (snd (List.hd (comb_inf.user_person_info.poke_inv))))));
  moveto 80 100;
  draw_string "Press number key for attack.";

  press_battle num ();

  let user_poke = Png.load (sprite_back (List.assoc 0
    (comb_inf.user_person_info.poke_inv))) [] in
  let c = user_poke |> array_of_image |> make_image in
  draw_image c 150 115;

  let opp_poke = Png.load (sprite_front (List.assoc 0
    (comb_inf.enemy_person_info.poke_inv))) [] in
  let p = opp_poke|> array_of_image |> make_image in
  draw_image p 400 200;

  (* POKEMON NAMES!!!!
  set_color black;
  moveto 260 230;
  draw_string "CHARIZARD"; (* Index '0' is always true.*)
  moveto 230 135;
  draw_string "PIKACHU";
  *)

  set_font "-misc-dejavu sans mono-bold-r-normal--12-0-0-0-m-0-iso8859-1";
  set_color black;
  moveto 260 230;
  draw_string (name (List.assoc 0 (comb_inf.enemy_person_info.poke_inv)));
  moveto 230 135;
  draw_string (name (List.assoc 0 (comb_inf.user_person_info.poke_inv)));

  (*
  set_font "-misc-dejavu sans mono-bold-r-normal--12-0-0-0-m-0-iso8859-1";
  draw_string ("4. " ^ "ATTACK");
  moveto 80 40;
  draw_string ("3. " ^ "DEFEND");
  moveto 80 55;
  draw_string ("2. " ^ "BLOCK");
  moveto 80 70;
  draw_string ("1. " ^ "KILL");
  moveto 80 90;
  set_font "-misc-dejavu sans mono-bold-r-normal--14-0-0-0-m-0-iso8859-1";
  draw_string "Press number key for attack.";
  *)

  (*TEXT BOX-TEXT BOX-TEXT BOX-TEXT BOX-TEXT BOX-TEXT BOX-TEXT BOX-TEXT BOX*)


  (*
  set_color black;
  set_line_width 5;
  draw_rect 50 10 500 100;
  set_color white;
  draw_rect 50 10 500 100;

  set_color black;
  moveto 80 25;
  set_font "-misc-dejavu sans mono-bold-r-normal--12-0-0-0-m-0-iso8859-1";
  draw_string ("4. " ^ (List.assoc 4 (action_names (List.assoc 0
    (comb_inf.user_person_info.poke_inv)))));
  moveto 80 40;
  draw_string ("3. " ^ (List.assoc 3 (action_names (List.assoc 0
    (comb_inf.user_person_info.poke_inv)))));
  moveto 80 55;
  draw_string ("2. " ^ (List.assoc 2 (action_names (List.assoc 0
    (comb_inf.user_person_info.poke_inv)))));
  moveto 80 70;
  draw_string ("1. " ^ (List.assoc 2 (action_names (List.assoc 0
    (comb_inf.user_person_info.poke_inv)))));
  moveto 80 90;
  draw_string "Press number key for attack.";
  *)

  (*****************************************************************)
  (*This handles the log_history*)
  (*****************************************************************)

  let rec history l =
    match l with
    |[] -> ()
    |h::t -> begin
      set_color black;
      set_line_width 7;
      draw_rect 50 10 500 100;
      set_color white;
      fill_rect 50 10 500 100;
      set_color black;
      set_font "-misc-dejavu sans mono-bold-r-normal--14-0-0-0-m-0-iso8859-1";
      moveto 80 90;
      h;
      moveto 380 10;
      set_font "-misc-dejavu sans mono-bold-r-normal--12-0-0-0-m-0-iso8859-1";
      draw_string "Press 'c' to continue. >";
      press_history ();
      history t
    end
  in history
    (List.map draw_string gui_inf.history_info.game_stats.battle_round_log);

  (*****************************************************************)
  (*****************************************************************)

  (*HP METER-HP METER-HP METER-HP METER-HP METER-HP METER-HP METER-HP METER*)
  let max_user = maxhp (snd (List.hd (comb_inf.user_person_info.poke_inv))) in
  let max_opp = maxhp (snd (List.hd (comb_inf.enemy_person_info.poke_inv))) in

  let user_hp_now = hp (snd (List.hd (comb_inf.user_person_info.poke_inv))) in
  let opp_hp_now = hp (snd (List.hd (comb_inf.enemy_person_info.poke_inv))) in

  let user_health = (user_hp_now/ max_user) * 100 in
  let opp_health = (opp_hp_now/ max_opp) * 100 in

  (*
  set_color red;
  fill_rect 230 115 100 10;
  set_color green;
  fill_rect 230 115 50 10;

  set_color red;
  fill_rect 260 210 100 10;
  set_color green;
  fill_rect 260 210 50 10;
  *)

  (*USER*)
  set_color red;
  fill_rect 70 0 100 10;
  set_color green;
  fill_rect 70 0 user_health 10;  (*full health is 100*)

  (*OPPONENT*)
  set_color red;
  fill_rect 260 210 100 10;
  set_color green;
  fill_rect 260 210 opp_health 10; (*full health is 100*)
  set_color black;
  set_font "-misc-dejavu sans mono-bold-r-normal--12-0-0-0-m-0-iso8859-1";
  moveto 260 190;
  draw_string (string_of_int opp_hp_now ^ "/" ^ string_of_int max_opp);

  (*****************************************************************)
  (*****************************************************************)

  (*make sure that no hp is 0*)
  if user_health <= 0 || opp_health <= 0
  then Interact CBattleEnd
  else fpi_screen gui_inf

(*MAP-MAP-MAP-MAP-MAP-MAP-MAP-MAP-MAP-MAP-MAP-MAP-MAP-MAP-MAP-MAP-MAP-MAP-MAP*)
let rec press_before () =
  let keep_running = ref true in
    while !keep_running do
      let s = Graphics.wait_next_event [Graphics.Key_pressed] in
      if s.Graphics.keypressed
      then
        if s.Graphics.key = 'c'
        then keep_running := false
        else keep_running := true;
    done

(*[before_battle gui_inf] displays the enemy's image
and name before the actual battle*)
let before_battle gui_inf =
  Graphics.set_window_title "OCAMON!";
  Graphics.open_graph " 600x400";
  let start = Jpeg.load "battleBackground.jpg" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 0 0;

  let comb_inf = begin match gui_inf.combat_info with
    | Some i -> i
    | None -> failwith "Unreachable : combat_text"
  end in

  let enemy = Jpeg.load comb_inf.enemy_person_info.person_image [] in
  let e = enemy |> array_of_image |> make_image in
  draw_image e 250 50;

  set_color black;
  set_text_size 20;
  moveto 210 210;
  draw_string ("You are about to battle " ^ comb_inf.enemy_person_info.name
    ^ ".");
  moveto 210 180;
  draw_string "Press 'c' to continue.";

  press_before ()

let rec press_map () =
  let keep_running = ref true in
  while !keep_running do
    let s = Graphics.wait_next_event [Graphics.Key_pressed] in
    if s.Graphics.keypressed
    then
      if s.Graphics.key = 'c'
      then keep_running := false
      else keep_running := true
  done

(*HOW TO GET THE GUI_INF FOR "draw_battle gui_inf" *)
(*HOW TO GET THE GUI_INF FOR "draw_battle gui_inf" *)
(*HOW TO GET THE GUI_INF FOR "draw_battle gui_inf" *)

let draw_map () =
  Graphics.set_window_title "OCAMON!";
  Graphics.open_graph " 300x300";
  let start = Png.load "startScreen.png" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 0 0;
  set_color yellow;
  draw_rect 50 100 200 100;
  fill_rect 50 100 200 100;

  set_color black;
  set_line_width 3;
  draw_ellipse 500 50 50 20;
  set_color yellow;
  fill_ellipse 500 50 50 20;

  set_color black;
  set_line_width 3;
  draw_ellipse 500 200 50 20;
  set_color yellow;
  fill_ellipse 500 200 50 20;

  let user = Jpeg.load "ash_front.jpg" [] in
  let s = user |> array_of_image |> make_image in

  if gui_inf.history_info.game_stats.next_battle = 0
  then draw_image s 70 200
  else
    if gui_inf.history_info.game_stats.next_battle = 1
    then draw_image s 70 50
    else
      if gui_inf.history_info.game_stats.next_battle = 2
      then draw_image s 270 50
      else
        if gui_inf.history_info.game_stats.next_battle = 3
        then draw_image s 270 200
        else
          if gui_inf.history_info.game_stats.next_battle = 4
          then draw_image s 470 50
          else
            draw_image s 470 200;

  press_map ()

let map_game gui_inf =
  draw_map gui_inf;
  before_battle gui_inf

(*START-START-START-START-START-START-START-START-START-START-START-START*)

let press_poke () =
  let poke_num = ref 0 in
  let keep_running = ref true in
  while !keep_running do
    let s = Graphics.wait_next_event [Graphics.Key_pressed] in
    if s.Graphics.keypressed
    then
      if s.Graphics.key = '1'
      then (poke_num := 25; keep_running := false) (*CHANGE 25 TO 26*)
      else
        if s.Graphics.key = '2'
        then (poke_num := 3; keep_running := false)
        else
            if s.Graphics.key = '3'
            then (poke_num := 6; keep_running := false)
            else
              if s.Graphics.key = '4'
              then (poke_num := 9; keep_running := false)
              else keep_running := true
    else keep_running := true;
    done; !poke_num

let start_three () =
  Graphics.set_window_title "OCAMON!";
  Graphics.open_graph " 600x400";
  let start = Png.load "startScreen.png" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 0 0;

  set_color black;
  set_font "-misc-dejavu sans mono-bold-r-normal--20-0-0-0-m-0-iso8859-1";
  moveto 120 190;
  draw_string "1";

  moveto 240 190;
  draw_string "2";

  moveto 360 190;
  draw_string "3";

  moveto 470 190;
  draw_string "4";

  let start = Png.load "poke_26.png" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 95 130;

  let start = Png.load "poke_3.png" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 215 130;

  let start = Png.load "poke_6.png" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 335 130;

let draw_start () =
  Graphics.set_window_title "OCAMON!";
  Graphics.open_graph " 300x300";
  let start = Png.load "startScreen.png" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 0 0;

  set_color black;
  draw_rect 50 100 205 105;
  fill_rect 50 100 205 105;

  set_color cyan;
  draw_rect 50 100 200 100;
  fill_rect 50 100 200 100;

  set_color black;
  set_text_size 20;
  moveto 80 180;
  draw_string "Welcome to OCAMON!";
  moveto 80 150;
  draw_string "Press 's' to start game.";
  moveto 80 120;
  draw_string "Press 'q' to quit game.";

  press_start ()

(*[press_poke ()] takes an input unit () and outputs the pokemon choice int*)

let win_game () =
  Graphics.set_window_title "OCAMON!";
  Graphics.open_graph " 300x300";
  let start = Png.load "startScreen.png" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 0 0;

  set_color black;
  draw_rect 50 100 205 105;
  fill_rect 50 100 205 105;

let start_game () =
  start_one ();
  start_two ();
  start_three ()

(*WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN*)
(*press_win () gives a bool,
true if player wants to play again or
false if player wants to quit*)
let rec press_win () =
  let continue = ref true in
  let keep_running = ref true in
  while !keep_running do
    let s = Graphics.wait_next_event [Graphics.Key_pressed] in
    if s.Graphics.keypressed
    then
      if s.Graphics.key = 'q'
      then (continue := false; keep_running := false)
      else if s.Graphics.key = 'c'
      then (continue := true; keep_running := false)
      else keep_running := true;
  done; !continue

let win_game () =
  Graphics.set_window_title "OCAMON!";
  Graphics.open_graph " 600x400";
  let start = Png.load "startScreen.png" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 0 0;

  set_color black;
  set_text_size 20;
  moveto 80 180;
  draw_string "Congrats! You won!";
  moveto 80 150;
  draw_string "Press 's' to play again.";
  moveto 80 120;
  draw_string "Press 'q' to quit game.";

  press_win ()
(*LOSE-LOSE-LOSE-LOSE-LOSE-LOSE-LOSE-LOSE-LOSE-LOSE-LOSE-LOSE-LOSE-LOSE-LOSE*)
let rec press_lose () =
  let continue = ref true in
  let keep_running = ref true in
  while !keep_running do
    let s = Graphics.wait_next_event [Graphics.Key_pressed] in
    if s.Graphics.keypressed
    then
      if s.Graphics.key = 'q'
      then (continue := false; keep_running := false)
      else if s.Graphics.key = 'c'
      then (continue := true; keep_running := false)
      else keep_running := true;
  done; !continue

let lose_game () =
  Graphics.set_window_title "OCAMON!";
  Graphics.open_graph " 600x400";
  let start = Png.load "startScreen.png" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 0 0;

  set_color black;
  set_line_width 5;
  draw_rect 150 100 300 100;
  set_color red;
  fill_rect 150 100 300 100;

  set_color black;
  set_text_size 20;
  moveto 160 180;
  draw_string "Oh no! You lost! :(";
  moveto 160 150;
  draw_string "Press 'c' to continue playing.";
  moveto 160 120;
  draw_string "Press 'q' to quit game.";


(* [get_cmd gui_inf gmode] is the command that represents the user input based
* on the current mode [gmode] and relevant information about the state
* [gui_inf] as defined in the Types module.
* requires:
* - [gui_inf] are the state details for gui to use as defined in Types.
* - [gmode] is the current mode of the game corresponding to the state. *)
let get_cmd gui_inf gmode =
  match gmode with
  | MStart -> start_game ();
    let pick = 0
    in Interact (CStart pick)
  | MMap -> draw_map ();
    Interact CMap
  | MCombat s ->
    draw_battle gui_inf
  | MWinGame ->  (*continue is a boolean for play again or quit*)
    Interact (CWinGame !continue);
  | MWin ->
    Interact (CWinGame !continue);
  | MLose ->
    Interact (CLose true);
  | MQuit -> Interact (CLose true);


(*
module OverworldGUI = struct
failwith "Unimplemented"
end

module InvGUI = struct
let dimensions = failwith "Unimplemented"
let background = failwith "Unimplemented"
let items = failwith "Unimplemented"
end *)
