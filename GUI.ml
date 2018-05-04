open Graphics
open Camlimages
open Images
open Png       
open Jpeg 
open Pokemon
open Types
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

module StartGUI = struct 

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
        let cmap = Array.map (fun {r = r; g = g; b = b} -> Graphics.rgb r g b) colormap in
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

  let check (num: int ref) comb_inf user_health opp_health : Controller.command = 
    if user_health <= 0 || opp_health <= 0 
    then 
      (*draw_string "Looks like the battle is over."; *)
      Interact CBattleEnd
    else 
      make_action num comb_inf 

  (*val draw_battle: Types.gui_info -> Controller.command*)
  let draw_battle gui_inf : command = 
    Graphics.set_window_title "OCAMON!";
    Graphics.open_graph " 300x300";
    let start = Png.load "startScreen.png" [] in 
    let s = start |> array_of_image |> make_image in 
    draw_image s 0 0;
    
    let user_poke = Png.load "us.png" [] in 
    let c = user_poke |> array_of_image |> make_image in 
    draw_image c 0 0; 

    let opp_poke = Jpeg.load "them.jpg" [] in 
    let p = opp_poke|> array_of_image |> make_image in 
    draw_image p 200 200; 

    set_color white; 
    fill_rect 70 20 200 100;
    set_color black;
    moveto 80 25;

    let num = ref 0 in 

    let comb_inf = begin match gui_inf.combat_info with
      | Some i -> i
      | None -> failwith "Unreachable : combat_text"
    end in 
    
    draw_string ("4. " ^ (List.assoc 4 (action_names (snd (List.hd (comb_inf.user_person_info.poke_inv)))))); 
    moveto 80 40;
    draw_string ("3. " ^ (List.assoc 3 (action_names (snd (List.hd (comb_inf.user_person_info.poke_inv))))));
    moveto 80 55;
    draw_string ("2. " ^ (List.assoc 2 (action_names (snd (List.hd (comb_inf.user_person_info.poke_inv))))));
    moveto 80 70;
    draw_string ("2. " ^ (List.assoc 2 (action_names (snd (List.hd (comb_inf.user_person_info.poke_inv))))));
    moveto 80 100;
    draw_string "Press number key for attack."; 

    press_battle num ();

    (*This is the health meter*)
    let user_health =
      (hp (snd (List.hd (comb_inf.user_person_info.poke_inv))))/
      (maxhp (snd (List.hd (comb_inf.user_person_info.poke_inv)))) * 100 in 

    let opp_health =
      (hp (snd (List.hd (comb_inf.enemy_person_info.poke_inv))))/
      (maxhp (snd (List.hd (comb_inf.enemy_person_info.poke_inv)))) * 100 in 

    (*USER*)
    set_color red; 
    fill_rect 70 0 100 10;
    set_color green; 
    fill_rect 70 0 user_health 10;  (*full health is 100*)

    (*OPPONENT*)
    set_color red; 
    fill_rect 90 200 100 10;
    set_color green; 
    fill_rect 90 200 opp_health 10; (*full health is 100*)

    check num comb_inf user_health opp_health 

  let rec press_map () = 
    let keep_running = ref true in 
    while !keep_running do 
      let s = Graphics.wait_next_event [Graphics.Key_pressed] in 
      if s.Graphics.keypressed 
      then  
        if s.Graphics.key = 'q' 
        then close_graph () 
        else if s.Graphics.key = 'c' 
        then 
          close_graph (); 
          keep_running := false
    done

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
    set_text_size 20; 
    moveto 60 150;
    draw_string "You are about to battle GARY.";
    moveto 60 130;
    draw_string "Press 'c' to continue." ;

    press_map ()

  let rec press_start () = (**)
    let keep_running = ref true in 
    while !keep_running do 
      let s = Graphics.wait_next_event [Graphics.Key_pressed] in 
      if s.Graphics.keypressed 
      then  
        if s.Graphics.key = 'q' 
        then close_graph () 
        else if s.Graphics.key = 's' 
        then 
          draw_map (); 
          keep_running := false; 
    done 

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
  
  let start_game () = 
    draw_start ()

  let win_game () = 
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
    draw_string "Congrats! You won!"; 
    moveto 80 150;
    draw_string "Press 's' to play again."; 
    moveto 80 120;
    draw_string "Press 'q' to quit game."

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
  | MCombat s -> draw_battle gui_inf 
  | MWinGame ->  (*b is a boolean for play again or quit*)
    Interact (CWinGame true);
  | MWin ->  
    Interact (CWinGame true);
  | MLose -> 
    Interact (CLose true);
  | MQuit -> Interact (CLose true);
end 

module OverworldGUI = struct 
  failwith "Unimplemented"
end 

module CombatGUI = struct
  failwith "Unimplemented"
end 

module InvGUI = struct
  let dimensions = failwith "Unimplemented" 
  let background = failwith "Unimplemented"
  let items = failwith "Unimplemented"
end 
