open Controller
open Types

(* [start_text ]*)
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


    (*
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
    hold_for_key ; *)

let get_cmd gui_inf gmode =
  match gmode with
  | MStart -> let pick = start_text () in Interact (CStart pick)
  | _ -> Interact (CQuit)
