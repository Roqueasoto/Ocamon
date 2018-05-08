open Controller
open Shared_types
open Pokemon

(* [start_text] Produces the text informaton and interface for the user to
 * interact with at the start of the game. Returns an int corresponding to the
 * chosen Pokemon at this stage.*)
let start_text () =
  let hold_for_key =  begin match read_line () with
    | exception End_of_file -> ()
    | command -> ()  end in
  let () = ANSITerminal.(print_string [red]
                           "An image of a man in a lab coat appears.\n");
    print_string "This symbol indicates press enter to proceed : > ";
    hold_for_key ;

    print_endline "Hello there! Welcome to the world of POKEMON!";
    print_endline "My name is Oak!\n";
    print_endline "People call me the POKEMON PROF!\n";
    print_string "> " ;
    hold_for_key ;

    ANSITerminal.(print_string [red] "An image of a Pikachu appears.\n");
    print_string "> " ;
    hold_for_key ;

    print_endline
      "This world is inhabited by creatures called POKEMON! For some\n";
    print_endline
      "people, POKEMON are pets. Others use them for fights. Myself...\n";
    print_endline "I study POKEMON as a profession.\n";
    print_string "> " ;
    hold_for_key ;

    ANSITerminal.(print_string [red]
                    "An image of a boy (the player characer) appears.\n");
    print_string "> " ;
    hold_for_key ;

    print_endline "First, what is your name?\n";
    print_endline "Right! So your name is Ash!\n";
    print_string "> " ;
    hold_for_key ;

    ANSITerminal.(print_string [red] "An image of another boy appears.\n");
    print_string "> " ;
    hold_for_key ;

    print_endline
      "This is my grandson. He's been your rival since you were a baby.\n";
    print_endline "...Erm, what was his name again?\n";
    print_endline "That's right! I remember now! His nsame is Gary!\n";
    print_string "> " ;
    hold_for_key ;

    ANSITerminal.(print_string [red] "Ash's image appears.\n");
    print_string "> " ;
    hold_for_key ;

    print_endline
      "Ash! Your very own POKEMON legend is about to unfold! A world of\n";
    print_endline "dreams and adventures with POKEMON awaits!\n";
    print_string "> " ;
    hold_for_key ;

    print_endline
      "But first, you need a partner to venture out into the world with.\n";
    print_endline
      "Come with me to my lab, and we can get you and Gary a POKEMON!\n";
    print_string "> " ;
    hold_for_key ;

    ANSITerminal.(print_string [red]
                    "Professor Oak brings you to his laboratory.\n");
    ANSITerminal.(print_string [red]
                    "It seems like Gary was already waiting for you both,\n");
    ANSITerminal.(print_string [red]
                    "and there is a large ball on the table next to him.\n");
    print_string "> " ;
    hold_for_key ;

    print_endline "Look, Ash! Do you see that ball on the table?\n";
    print_endline "That is a POKE BALL. It holds a POKEMON inside.\n";
    print_endline "You may have it! Go on, take it!\n";
    print_string "> " ;
    hold_for_key ;

    ANSITerminal.(print_string [red]
                    "You approached the table and were gazing at the POKE\n");
    ANSITerminal.(print_string [red]
                    "BALL, when just as you are about to pick it up, Gary\n");
    ANSITerminal.(print_string [red]
                    "dashes in and takes it from your hands!\n");
    print_string "> " ;
    hold_for_key ;

    print_endline "Well Ash, you snooze you lose, and youre behind me right\n";
    print_endline "from the start! This is my Pokemon now!\n";
    print_string "> " ;
    hold_for_key ;

    ANSITerminal.(print_string [red]
                    "Professor Oak approaches you looking frustrated and\n");
    ANSITerminal.(print_string [red]
                    "takes another POKE BALL out of his pocket and hands it\n");
    ANSITerminal.(print_string [red]
                    "to you.\n");
    print_string "> " ;
    hold_for_key ;

    print_endline "Gary haven't I told you to be more patient!? Sorry about\n";
    print_endline "that Ash but you can have this POKE BALL instead. I just\n";
    print_endline "caught it right outside the lab! Its a Pikachu!\n";
    print_string "> " ;
    hold_for_key ;

    ANSITerminal.(print_string [red]
                    "You release the POKE BALL to reveal a Pikachu looking\n");
    ANSITerminal.(print_string [red]
                    "around and then at you, exclaiming 'pika-pika'!\n");
    print_string "> " ;
    hold_for_key ; in 0


(* [map_text] Produces the text informaton and interface for the user to
 * interact with at the map stage (pre-battle). Returns unit. *)
let map_text () =
  let hold_for_key =  begin match read_line () with
    | exception End_of_file -> ()
    | command -> ()  end in

    ANSITerminal.(print_string [red]
                    "Gary also releases his POKEMON to reveal a Charizard.\n");
    ANSITerminal.(print_string [red]
                    "As you turn to leave, Gary rushes past you and your\n");
    ANSITerminal.(print_string [red]
                    "eyes meet as he turns to face you.\n");
    print_string "> " ;
    hold_for_key ;

    print_endline "Wait up Ash! Lets check out our POKEMON. Come on, I'll\n";
    print_endline "take you on!\n";
    print_string "> " ;
    hold_for_key ;

    ANSITerminal.(print_string [red]
                    "The battle begins!!!\n");
    print_string "> " ;
    hold_for_key

(* [ask_cmd cinf] Returns the user's parsed command while providing text info.
 * - requires : [cinf] combat_info from gui_info. *)
let rec ask_cmd cinf =
  (* let user_pokes = (cinf.user_person_info.poke_inv |> List.hd |> snd) in*)
  let () = print_endline ("Type Fight, Item, or Switch.\n") in
  failwith"Unimplemented"


(* [combat_text gui_inf] Produces the text informaton and interface for the user
 * to interact with at the combat stage. Returns the user's parsed command. *)
let combat_text ginf =
  let hold_for_key =  begin match read_line () with
    | exception End_of_file -> ()
    | command -> ()  end in
  let comb_inf = begin match ginf.combat_info with
    | Some i -> i
    | None -> failwith"Unreachable : combat_text"
  end in
  let ai_poke1 =
    (comb_inf.enemy_person_info.poke_inv |> List.hd |> snd |> name) in
  let u_poke1 =
    (comb_inf.user_person_info.poke_inv |> List.hd |> snd |> name) in
  let () =
    ANSITerminal.(print_string [red] "Gary wants to fight!\n");
    print_string "> " ;
    hold_for_key ;

    print_endline ("Gary sent out "^ai_poke1^"!\n");
    print_endline ("Go! "^u_poke1^"!\n");
    print_string "> " ;
    hold_for_key; in
  ask_cmd ginf


let get_cmd gui_inf gmode =
  match gmode with
  | MStart -> let pick = start_text () in Interact (CStart pick)
  | MMap -> map_text (); Interact CMap
  | MCombat s -> combat_text gui_inf
  | _ -> failwith"Unimplemented"
