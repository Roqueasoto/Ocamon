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

(*BATTLE-BATTLE-BATTLE-BATTLE-BATTLE-BATTLE-BATTLE-BATTLE-BATTLE-BATTLE *)
let make_action num comb_inf =
  List.assoc num (actions (List.assoc 0 (comb_inf.user_person_info.poke_inv)))

let make_switch num =
  CombatAction [Switch num]

let make_item num comb_inf =
  begin
  match item_use_combat (List.nth (comb_inf.user_person_info.item_inv) num) with
    | Some i -> i
    | None -> failwith "Unreachable : Items can't be made"
  end
  (*num is 0-5 for chosen item*)

let pokemon_or_items_six () =
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

let pokemon_or_items_five () =
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
        else keep_running := true;
    done; !num

let pokemon_or_items_four () =
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
        else keep_running := true;
    done; !num

let pokemon_or_items_three () =
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
        else keep_running := true;
    done; !num

let pokemon_or_items_two () =
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
        else keep_running := true;
    done; !num

let pokemon_or_items_one () =
  let num = ref 1 in
  let keep_running = ref true in
    while !keep_running do
      let s = Graphics.wait_next_event [Graphics.Key_pressed] in
      if s.Graphics.keypressed
      then
        if s.Graphics.key = '1'
        then (num := 0; keep_running := false)
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
        else if s.Graphics.key = '2'
        then (num := 2; keep_running := false)
        else if s.Graphics.key = '3'
        then (num := 3; keep_running := false)
        else keep_running := true;
    done; !num

let press_battle_two () =
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
        else keep_running := true;
    done; !num

let items_screen gui_inf =
  let comb_inf = begin match gui_inf.combat_info with
    | Some i -> i
    | None -> failwith "Unreachable : item_screen issue"
  end in

  set_color black;
  set_line_width 7;
  draw_rect 50 10 500 100;
  set_color white;
  fill_rect 50 10 500 100;
  set_color black;

  (* set_font "-misc-dejavu sans mono-bold-r-normal--14-0-0-0-m-0-iso8859-1";  *)

  let num_items = List.length (inv_names (comb_inf.user_person_info.item_inv))in
    match num_items with
    |6 ->
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
      pokemon_or_items_six ()
    |5 ->
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
      pokemon_or_items_five ()
    |4 ->
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
      pokemon_or_items_four ()
    |3 ->
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
      pokemon_or_items_three ()
    |2 ->
      moveto 80 50;
      draw_string ("2. " ^  (List.assoc 1 (inv_names
      (comb_inf.user_person_info.item_inv))));
      moveto 80 70;
      draw_string ("1. " ^  (List.assoc 0 (inv_names
        (comb_inf.user_person_info.item_inv))));
      moveto 80 90;
      draw_string "Press number key to use item.";
      pokemon_or_items_two ()
    |1 ->
      moveto 80 70;
      draw_string ("1. " ^  (List.assoc 0 (inv_names
        (comb_inf.user_person_info.item_inv))));
      moveto 80 90;
      draw_string "Press number key to use item.";
      pokemon_or_items_one ()
    |0 -> failwith "Can't have no items"
    |_ -> failwith "Shouldn't have more than 6 items"

let poke_screen gui_inf =
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

  (* set_font "-misc-dejavu sans mono-bold-r-normal--14-0-0-0-m-0-iso8859-1";  *)

  (*This finds out whether or not the *)
  let num_pokemon = List.length comb_inf.user_person_info.poke_inv in
    match num_pokemon with
    |6 ->
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
      pokemon_or_items_six ()
    |5 ->
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
      pokemon_or_items_five ()
    |4 ->
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
    pokemon_or_items_four ()
    |3 ->
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
      pokemon_or_items_three ()
    |2 ->
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
      pokemon_or_items_two ()
    |1 ->
      moveto 80 70;
      draw_string ("1. " ^ (name (List.assoc 0
      (comb_inf.user_person_info.poke_inv))) ^ "  " ^
      (string_of_int (hp (List.assoc 0 (comb_inf.user_person_info.poke_inv))))
      ^ "/" ^
      (string_of_int (maxhp (List.assoc 0
        (comb_inf.user_person_info.poke_inv)))));
      moveto 80 90;
      draw_string "Press number key to switch OCAMON.";
      pokemon_or_items_one ()
    |0 -> failwith "Can't have no pokemon or items"
    |_ -> failwith "Shouldn't have more than 6 pokemon."

  (*I NEED TO DISPLAY THE POKEMON IN THE LIST OF POKEMON*)

let fight_screen gui_inf =
  let comb_inf = begin match gui_inf.combat_info with
    | Some i -> i
    | None -> failwith "Unreachable : fight_screen"
  end in

  set_color black;
  set_line_width 7;
  draw_rect 50 10 500 100;
  set_color white;
  fill_rect 50 10 500 100;
  set_color black; (*NEEDS TO BE HERE FOR THE TEXT*)

  let action_num = List.length (action_names (List.assoc 0
  (comb_inf.user_person_info.poke_inv))) in
    match action_num with
    |2 ->
      moveto 80 55;
      draw_string ("2. " ^ (List.assoc 2 (action_names (List.assoc 0
        (comb_inf.user_person_info.poke_inv)))));
      moveto 80 70;
      draw_string ("1. " ^ (List.assoc 1 (action_names (List.assoc 0
        (comb_inf.user_person_info.poke_inv)))));
      moveto 80 90;
      draw_string "Press number key for attack.";
      press_battle_two ()
    |3 ->
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
      press_battle_three ()
    |4 ->
      moveto 80 25;
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
      press_battle_four ()
    |_ -> failwith "Shouldn't have this many actions"

let no_more_press () =
  let keep_running = ref true in
    while !keep_running do
      let s = Graphics.wait_next_event [Graphics.Key_pressed] in
      if s.Graphics.keypressed
      then
        if s.Graphics.key = 'c'
        then keep_running := false
        else keep_running := true;
    done

let no_pokemon () =
  set_color black;
  set_line_width 7;
  draw_rect 50 10 500 100;
  set_color white;
  fill_rect 50 10 500 100;

  set_color black;
  moveto 80 90;
  draw_string "You don't have any other pokemon.";

  moveto 380 10;
  draw_string "Press 'c' to continue. >";

  no_more_press ()

let no_items () =
  set_color black;
  set_line_width 7;
  draw_rect 50 10 500 100;
  set_color white;
  fill_rect 50 10 500 100;

  set_color black;
  moveto 80 90;
  draw_string "You don't have any items.";

  moveto 380 10;
  draw_string "Press 'c' to continue. >";

  no_more_press ()

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

let rec fpi_screen gui_inf =
  let comb_inf = begin match gui_inf.combat_info with
    | Some i -> i
    | None -> failwith "Unreachable : fpi_screen"
  end in

  set_color black;
  set_line_width 7;
  draw_rect 50 10 500 100;
  set_color white;
  fill_rect 50 10 500 100;

  set_color black;
  (* set_font "-misc-dejavu sans mono-bold-r-normal--12-0-0-0-m-0-iso8859-1"; *)
  moveto 80 40;
  draw_string ("3. ITEMS");
  moveto 80 55;
  draw_string ("2. POKEMON");
  moveto 80 70;
  draw_string ("1. FIGHT");
  moveto 80 90;
  (* set_font "-misc-dejavu sans mono-bold-r-normal--14-0-0-0-m-0-iso8859-1"; *)
  draw_string "Press number key.";

  let choice = fpi_press () in
    match choice with
    |1 ->
      let num = fight_screen gui_inf in
      make_action num comb_inf
    |2 ->
      if (List.length (comb_inf.user_person_info.poke_inv) <= 1)
      then (no_pokemon (); fpi_screen gui_inf)
      else
        let num = poke_screen gui_inf in
        make_switch num
    |3 ->
      if (List.length (comb_inf.user_person_info.item_inv) = 0)
      then (no_items (); fpi_screen gui_inf)
      else
        let num = items_screen gui_inf in
        make_item num comb_inf
    |_ -> failwith "Number chosen shouldn't have gone this far"

let rec press_history () =
  let keep_running = ref true in
  while !keep_running do
    let s = Graphics.wait_next_event [Graphics.Key_pressed] in
    if s.Graphics.keypressed
    then
      if s.Graphics.key = 'c'
      then keep_running := false
      else keep_running := true;
  done 

(*[draw_battle gui_inf] *)
let draw_battle gui_inf =
  Graphics.set_window_title "OCAMON!";
  Graphics.open_graph " 600x400";
  let start = Jpeg.load "battleBackground.jpg" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 0 0;

  let comb_inf = begin match gui_inf.combat_info with
    | Some i -> i
    | None -> failwith "Unreachable : Something wrong at draw_battle"
  end in

  (*Displays pokemon images*)
  let user_poke = Png.load (sprite_back (List.assoc 0
    (comb_inf.user_person_info.poke_inv))) [] in
  let c = user_poke |> array_of_image |> make_image in
  draw_image c 150 115;

  let opp_poke = Png.load (sprite_front (List.assoc 0
    (comb_inf.enemy_person_info.poke_inv))) [] in
  let p = opp_poke|> array_of_image |> make_image in
  draw_image p 400 200;

  (*Displays pokemon names*)
  (* set_font "-misc-dejavu sans mono-bold-r-normal--12-0-0-0-m-0-iso8859-1"; *)
  set_color black;
  moveto 260 230;
  draw_string (name (List.assoc 0 (comb_inf.enemy_person_info.poke_inv)));
  moveto 230 135;
  draw_string (name (List.assoc 0 (comb_inf.user_person_info.poke_inv)));

  (*HP METER-HP METER-HP METER-HP METER-HP METER-HP METER-HP METER-HP METER*)
<<<<<<< HEAD
  let max_user = float (maxhp  
    (List.assoc 0 (comb_inf.user_person_info.poke_inv))) in 
  let max_opp = float (maxhp 
    (List.assoc 0 (comb_inf.enemy_person_info.poke_inv))) in 

  let user_hp_now = float (hp
    (List.assoc 0 (comb_inf.user_person_info.poke_inv))) in 
  let opp_hp_now = float (hp
    (List.assoc 0 (comb_inf.enemy_person_info.poke_inv))) in 
=======
  let max_user = float (maxhp (snd
    (List.hd (comb_inf.user_person_info.poke_inv)))) in
  let max_opp = float (maxhp (snd
    (List.hd (comb_inf.enemy_person_info.poke_inv)))) in

  let user_hp_now = float (hp (snd
    (List.hd (comb_inf.user_person_info.poke_inv)))) in
  let opp_hp_now = float (hp (snd
    (List.hd (comb_inf.enemy_person_info.poke_inv)))) in
>>>>>>> master

  let user_health = (user_hp_now /. max_user) *. 100. in
  let opp_health = (opp_hp_now /. max_opp) *. 100. in

  set_color red; (*USER'S BAR*)
  fill_rect 230 115 100 10;
  set_color green;
  fill_rect 230 115 (truncate user_health) 10;  (*full health is 100*)

  set_color red; (*OPPONENT'S BAR*)
  fill_rect 260 210 100 10;
  set_color green;
  fill_rect 260 210 (truncate opp_health) 10; (*full health is 100*)

  (*USER*)
  set_color black;
  (* set_font "-misc-dejavu sans mono-bold-r-normal--12-0-0-0-m-0-iso8859-1"; *)
  moveto 350 115;
  draw_string (string_of_int (truncate user_hp_now) ^ "/" ^
    string_of_int (truncate max_user));

  (*OPPONENT*)
  set_color black;
  (* set_font "-misc-dejavu sans mono-bold-r-normal--12-0-0-0-m-0-iso8859-1"; *)
  moveto 260 190;
  draw_string (string_of_int (truncate opp_hp_now) ^ "/" ^
    string_of_int (truncate max_opp));

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
      (* set_font "-misc-dejavu sans mono-bold-r-normal--14-0-0-0-m-0-iso8859-1"; *)
      moveto 80 90;
      draw_string h;
      moveto 380 10;
      (* set_font "-misc-dejavu sans mono-bold-r-normal--12-0-0-0-m-0-iso8859-1"; *)
      draw_string "Press 'c' to continue. >";
      press_history ();
      history t
    end
  in history (gui_inf.history_info.game_stats.battle_round_log);

  (*make sure that no hp is 0*)
  (* add the hp's of the inventory and see if they are all at 0*)
  let user_hp_sum = List.fold_left (+) 0 (List.map hp (snd (List.split
    (comb_inf.user_person_info.poke_inv)))) in
  let opp_hp_sum = List.fold_left (+) 0 (List.map hp (snd (List.split
    (comb_inf.enemy_person_info.poke_inv)))) in

  if user_hp_sum <= 0 || opp_hp_sum <= 0
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
let before_battle () =
  Graphics.set_window_title "OCAMON!";
  Graphics.open_graph " 600x400";
  let start = Jpeg.load "battleBackground.jpg" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 0 0;

  (*let enemy = Jpeg.load comb_inf.enemy_person_info.person_image [] in
  let e = enemy |> array_of_image |> make_image in
  draw_image e 250 50;*)

  set_color black;
  set_text_size 20;
  moveto 210 210;
  draw_string "You are about to go into battle!";
  (*draw_string ("You are about to battle " ^ comb_inf.enemy_person_info.name
    ^ ".");*)
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

let draw_map gui_inf =
  Graphics.set_window_title "OCAMON!";
  Graphics.open_graph " 600x400";
  let start = Png.load "startScreen.png" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 0 0;

  set_color black;
  set_line_width 5;
  draw_rect 300 270 250 100;
  set_color white;
  fill_rect 300 270 250 100;

  set_color black;
  (* set_font "-misc-dejavu sans mono-bold-r-normal--14-0-0-0-m-0-iso8859-1"; *)
  moveto 310 350;
  draw_string "Press 'c' to continue. >";

  (*LINES*)
  set_color black;
  set_line_width 5;
  draw_rect 100 50 1 150;

  set_color black;
  set_line_width 5;
  draw_rect 100 50 200 1;

  set_color black;
  set_line_width 5;
  draw_rect 300 50 1 150;

  set_color black;
  set_line_width 5;
  draw_rect 300 200 200 1;

  set_color black;
  set_line_width 5;
  draw_rect 500 50 1 150;

  (*CIRCLES*)
  set_color black;
  set_line_width 3;
  draw_ellipse 100 200 50 20;
  set_color yellow;
  fill_ellipse 100 200 50 20;

  set_color black;
  set_line_width 3;
  draw_ellipse 100 50 50 20;
  set_color yellow;
  fill_ellipse 100 50 50 20;

  set_color black;
  set_line_width 3;
  draw_ellipse 300 50 50 20;
  set_color yellow;
  fill_ellipse 300 50 50 20;

  set_color black;
  set_line_width 3;
  draw_ellipse 300 200 50 20;
  set_color yellow;
  fill_ellipse 300 200 50 20;

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
<<<<<<< HEAD
          then draw_image s 470 200
          else 
            draw_image s 470 50;
=======
          then draw_image s 470 50
          else
            draw_image s 470 200;
>>>>>>> master

  press_map ()

let map_game gui_inf =
  draw_map gui_inf;
  before_battle () (*unit because gui_info doesn't have enemy name yet*)

(*START-START-START-START-START-START-START-START-START-START-START-START*)

let press_poke () =
  let poke_num = ref 0 in
  let keep_running = ref true in
  while !keep_running do
    let s = Graphics.wait_next_event [Graphics.Key_pressed] in
    if s.Graphics.keypressed
    then
      if s.Graphics.key = '1'
      then (poke_num := 26; keep_running := false)
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
  (* set_font "-misc-dejavu sans mono-bold-r-normal--20-0-0-0-m-0-iso8859-1"; *)
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

  let start = Png.load "poke_9.png" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 445 130;

  set_color black;
  set_line_width 5;
  draw_rect 100 20 400 100;
  set_color white;
  fill_rect 100 20 400 100;

  set_color black;
  (* set_font "-misc-dejavu sans mono-bold-r-normal--16-0-0-0-m-0-iso8859-1"; *)
  moveto 110 100;
  draw_string "Here are some OCAMON I caught earlier.";
  moveto 110 80;
  draw_string "You can pick only one.";
  moveto 110 60;
  draw_string "Press 1, 2, 3, or 4";
  moveto 110 40;
  draw_string "to choose your first OCAMON!";
  (* set_font "-misc-dejavu sans mono-bold-r-normal--12-0-0-0-m-0-iso8859-1"; *)
  moveto 260 20;
  draw_string "Press 1, 2, 3, or 4 to continue. > ";

  press_poke ()

let rec press_start () =
  let keep_running = ref true in
  while !keep_running do
    let s = Graphics.wait_next_event [Graphics.Key_pressed] in
    if s.Graphics.keypressed
    then
      if s.Graphics.key = 'c'
      then keep_running := false
      else keep_running := true;
  done

let start_two () =
  (*Graphics.set_window_title "OCAMON!";
  Graphics.open_graph " 600x400";
  let start = Png.load "startScreen.png" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 0 0;

  let start = Jpeg.load "foster.jpg" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 250 130; *)

  set_color black;
  set_line_width 5;
  draw_rect 100 20 400 100;
  set_color white;
  fill_rect 100 20 400 100;

  set_color black;
  (* set_font "-misc-dejavu sans mono-bold-r-normal--14-0-0-0-m-0-iso8859-1"; *)
  moveto 110 100;
  draw_string "This world is inhabited by OCAMON!";
  moveto 110 80;
  draw_string "For some people, OCAMON are pets.";
  moveto 110 60;
  draw_string "Others use them for fights.";
  moveto 110 40;
  draw_string "Myself. . . I study OCAMON as a profession. ";
  (* set_font "-misc-dejavu sans mono-bold-r-normal--12-0-0-0-m-0-iso8859-1"; *)
  moveto 310 20;
  draw_string "Press 'c' to continue. > ";

  press_start ()

(*[press_poke ()] takes an input unit () and outputs the pokemon choice int*)

let start_one () =
  Graphics.set_window_title "OCAMON!";
  Graphics.open_graph " 600x400";
  let start = Png.load "startScreen.png" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 0 0;

  let start = Jpeg.load "foster.jpg" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 250 130;

  set_color black;
  set_line_width 5;
  draw_rect 100 20 400 100;
  set_color white;
  fill_rect 100 20 400 100;

  set_color black;
  (* set_font "-misc-dejavu sans mono-bold-r-normal--16-0-0-0-m-0-iso8859-1"; *)
  moveto 110 100;
  draw_string "Hello there!";
  moveto 110 80;
  draw_string "Welcome to the world of OCAMON!";
  moveto 110 60;
  draw_string "My name is Nate Foster.";
  moveto 110 40;
  draw_string "People call me the OCAMON PROF.";
  (* set_font "-misc-dejavu sans mono-bold-r-normal--12-0-0-0-m-0-iso8859-1"; *)
  moveto 310 20;
  draw_string "Press 'c' to continue. > ";

  press_start ()

let start_game () =
  start_one ();
  start_two ();
  start_three ()

(*WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN-WIN*)
(*press_win () gives a bool,
true if player wants to play again or
false if player wants to quit*)
let press_win_match () =
  let return_bool = ref false in
  let keep_running = ref true in
  while !keep_running do
    let s = Graphics.wait_next_event [Graphics.Key_pressed] in
    if s.Graphics.keypressed
    then
      if s.Graphics.key = 'c'
      then (return_bool := true; keep_running := false)
      else keep_running := true;
  done; !return_bool

let rec win_match () =
  Graphics.set_window_title "OCAMON!";
  Graphics.open_graph " 600x400";
  let start = Png.load "startScreen.png" [] in
  let s = start |> array_of_image |> make_image in
  draw_image s 0 0;

  set_color black;
  set_line_width 5;
  draw_rect 150 100 300 100;
  set_color green;
  fill_rect 150 100 300 100;

  set_color black;
  set_text_size 20;
  moveto 160 180;
  draw_string "Congrats! You won the match!";
  moveto 160 150;
  draw_string "Press 'c' to continue. >";

  let maybe = press_win_match () in
    match maybe with
    |true -> Interact CWin
    |false ->  win_match ()

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
  set_line_width 5;
  draw_rect 150 100 300 100;
  set_color green;
  fill_rect 150 100 300 100;

  set_color black;
  set_text_size 20;
  moveto 160 180;
  draw_string "Congrats! You won! :)";
  moveto 160 150;
  draw_string "Press 'c' to continue playing.";
  moveto 160 120;
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

  press_lose ()

(* [get_cmd gui_inf gmode] is the command that represents the user input based
* on the current mode [gmode] and relevant information about the state
* [gui_inf] as defined in the Types module.
* requires:
* - [gui_inf] are the state details for gui to use as defined in Types.
* - [gmode] is the current mode of the game corresponding to the state. *)
let get_cmd gui_inf gmode =
  match gmode with
  | MStart ->
    let pick = start_game () in
    Interact (CStart pick)
  | MMap -> map_game gui_inf;
    Interact CMap
  | MCombat s ->
    draw_battle gui_inf
  | MWinGame ->  (*WHOLE GAME*)
    let choose = win_game () in
    Interact (CWinGame choose)
  | MWin ->  (*match*)
      win_match ()
  | MLose ->
    let choose = lose_game () in
    Interact (CLose choose);
  | MQuit -> failwith "MQuit should never be called"
