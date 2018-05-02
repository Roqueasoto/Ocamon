<<<<<<< HEAD
open Graphics
open Camlimages
open Images
open Png       
open Jpeg 
open Pokemon

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
    draw_string "Press 'q' to quit game."

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
    draw_string "Press 'c' to continue." 


  let draw_battle gui_inf : command = 
    Graphics.set_window_title "OCAMON!";
    Graphics.open_graph " 300x300";
    let start = Png.load "startScreen.png" [] in 
    let s = start |> array_of_image |> make_image in 
    draw_image s 0 0;
    
    let user_poke = Png.load "us.png" [] in 
    let c = user_poke |> array_of_image |> make_image in 
    draw_image c 0 0; 

    set_color white; 
    fill_rect 70 20 200 100;
    set_color black;
    moveto 80 25;
    draw_string "4. " ^ List.tl action_names (gui_inf.combat_info.user_person_info.(List.hd poke_inv)); 
    moveto 80 40;
    draw_string "3. " ^ List.nth action_names (gui_inf.combat_info.user_person_info.(List.hd poke_inv)) 3;  
    moveto 80 55;
    draw_string "2. " ^ List.nth action_names (gui_inf.combat_info.user_person_info.(List.hd poke_inv)) 2;
    moveto 80 70;
    draw_string "1. " ^ List.hd action_names (gui_inf.combat_info.user_person_info.(List.hd poke_inv));
    moveto 80 100;
    draw_string "Press number key for attack.";

    (*This is the health meter*)
    let user_health = 30 in 
      (*(hp (gui_inf.combat_info.user_person_info.(List.hd poke_inv)))/
      (maxhp (gui_inf.combat_info.user_person_info.(List.hd poke_inv))) * 100 *)
    let opp_health = 60 in 
      (*(hp (gui_inf.combat_info.enemy_person_info.(List.hd poke_inv)))/
      (maxhp (gui_inf.combat_info.enemy_person_info.(List.hd poke_inv))) * 100*)

    if user_health <= 0 || opp_health <= 0 
    then 
      draw_string "Looks like the battle is over."; 
      Interact CBattleEnd

    else
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

      let opp_poke = Jpeg.load "them.jpg" [] in 
      let p = opp_poke|> array_of_image |> make_image in 
      draw_image p 200 200 
    
  
  let rec press () = 
    let keep_running = ref true in 
    while !keep_running do 
      let s = Graphics.wait_next_event [Graphics.Key_pressed] in 
      if s.Graphics.keypressed 
      then  
        draw_start (); 
        if s.Graphics.key = '1'
        then 
        else if s.Graphics.key = '2'
        then
        else if s.Graphics.key = '3'
        then 
        else if s.Graphics.key = '4'
        then 
        else if s.Graphics.key = 'q' 
        then close_graph () 
        else if s.Graphics.key = 'c'
        then draw_battle ()(*gui_inf*)
        else if s.Graphics.key = 's' 
        then 
          draw_map (); 
          keep_running := false; 
    done;
    press ()
  
  let start_game () = 
    draw_start (); 
    press ()  


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


  (*let rec updateStatus (l: event list) (st: status) = 
    match l with 
    |[] -> st 
    |h::t -> if h.keypressed = true then Graphics.draw_char(h.key) else updateStatus t st
  
  let dimensions x y =  
    Graphics.resize_window x y 
      
  let quitGame () = close_graph ()*)



  (* [get_cmd gui_inf gmode] is the command that represents the user input based
 * on the current mode [gmode] and relevant information about the state
 * [gui_inf] as defined in the Types module.
 * requires:
 * - [gui_inf] are the state details for gui to use as defined in Types.
 * - [gmode] is the current mode of the game corresponding to the state. *)
let get_cmd gui_inf gmode =
  match gmode with
  | MStart ->  start_game (); 
    let pick = 0
    in Interact (CStart pick)
  | MMap -> draw_map (); 
    Interact CMap
  | MCombat s -> draw_battle gui_inf 
  | MWinGame -> let b = win_game () in  (*b is a boolean for play again or quit*)
    Interact CWinGame b; 
  | MWin -> let b = win_game () in 
    Interact CWinGame b; 
  | MLose -> let b = lose_game () in 
    Interact CLose b; 
  | MQuit -> close_graph ();

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
=======
(*This is the GUI module*)

type image = ()

type animation = ()

module type StartGUI = sig
  type toggle_button = [`base|`widget|`container|`button|`toggle]
  val dimensions : int * int -> unit
  val background: image
  val startGame : toggle_button -> unit
  val quitGame : toggle_button -> unit
  val getCredits : toggle_button -> unit
  val getHelp : toggle_button -> unit
end

module type OverworldGUI = sig
  val dimensions : (int * int) -> unit
  val background : image
  val playerLocation : (int * int) -> unit
  val walking : Controller.command -> animation
  val standing : Controller.command -> image
  val speaking : (int * int) -> Controller.command -> animation
end

module type CombatGUI = sig
  val dimensions : (int * int) -> unit
  val background: image
  val pokemon : image
  val poisoned : bool -> animation
  val asleep : bool -> animation
  val frozen : bool -> animation
  val useItem: bool -> animation
  val attack : bool -> animation
  val switchOut : bool -> animation
  val finish : bool -> image
end

module type InvGUI = sig
  val dimensions : (int * int) -> unit
  val background : image
  val items : image list
end


module Combat : CombatGUI = struct
  let dimensions = failwith "unimplemented"
  let background = failwith "unimplemented"
  let pokemon = failwith "unimplemented"
  let poisoned = failwith "unimplemented"
  let asleep = failwith "unimplemented"
  let frozen = failwith "unimplemented"
  let useItem = failwith "unimplemented"
  let attack = failwith "unimplemented"
  let switchOut = failwith "unimplemented"
  let finish = failwith "unimplemented"
end

module Overworld : OverworldGUI = struct
  let dimensions = failwith "unimplemented"
  let background = failwith "unimplemented"
  let playerLocation = failwith "unimplemented"
  let walking = failwith "unimplemented"
  let standing = failwith "unimplemented"
  let speaking = failwith "unimplemented"
end

module Start : StartGUI = struct
  type toggle_button = [`base|`widget|`container|`button|`toggle]
  let dimensions = failwith "unimplemented"
  let background = failwith "unimplemented"
  let startGame = failwith "unimplemented"
  let quitGame = failwith "unimplemented"
  let getCredits = failwith "unimplemented"
  let getHelp = failwith "unimplemented"
end

module Inventory : InvGUI = struct
  let dimensions = failwith "unimplemented"
  let background = failwith "unimplemented"
  let items = failwith "unimplemented"
end
>>>>>>> 0b8444906c496e065bc79ee954db03c290402628
