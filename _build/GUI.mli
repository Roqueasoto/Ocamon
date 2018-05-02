(*
 * Each of the module types provides the visual standard of the Graphics window 
 * that each of the following modules (Combat, Overworld, and Start) 
 * all must adhere to. 
 *)

(* [image] is an abstract type representing an image *)
type image 

(* [animation] is an abstract type representing an animation *)
type animation

module type StartGUI = sig 
 
  (* this type is comprised of all of the other types that makes up toggling a button *)
  type toggle_button = [`base|`widget|`container|`button|`toggle]

  (* [dimensions] gives the dimensions of the Graphics window (unit is the type of Graphics window) *)
  val dimensions : int * int -> unit 

  (* [background] gives the image in the background *)
  val background: image 

  (* [startGame] determines if the user pressed the button to start the game *)
  val startGame : toggle_button -> unit 

  (* [quitGame] determines if the user pressed the button to quit the game *)
  val quitGame : toggle_button -> unit 

  (* [getCredits] determines if the user pressed the button to get the game maker credits *)
  val getCredits : toggle_button -> unit

  (* [getHelp] determines if the user pressed the button to get the instructions of the game *)
  val getHelp : toggle_button -> unit


end

module type OverworldGUI = sig 

  (* [dimensions] gives the dimensions of the Graphics window *)
  val dimensions : (int * int) -> unit 

  (* [background] gives the image in the background *)
  val background : image  
  
  (* [playerLocation] gives the current coordinates of the player so that the "camera view" changes and moves *)
  val playerLocation : (int * int) -> unit 
  
  (* [walking] determines if the user's trainer (character) is moving *)
  val walking : Controller.command -> animation 
  
  (* [standing] determines if the user's trainer is currently standing in place *)
  val standing : Controller.command -> image 
  
  (* [speaking] determines if the user's trainer is speaking to any other person in the game based on proximity*)
  val speaking : (int * int) -> Controller.command -> animation 

end 

module type CombatGUI = sig 
  
  (* [dimensions] gives the dimensions of the Graphics window *)
  val dimensions : (int * int) -> unit 
  
  (* [background] gives the image in the background *)
  val background: image 

  (* [pokemon] shows the image of the user's pokemon *)
  val pokemon : image 
  
  (* [poisoned] shows that the pokemon has been poisoned *)
  val poisoned : bool -> animation 
  
  (* [asleep] shows that the pokemon has been cast asleep *)
  val asleep : bool -> animation 

  (* [frozen] shows that the pokemon has been frozen *)
  val frozen : bool -> animation 

  (* [useItem] shows that the pokemon has used an item in its inventory*)
  val useItem: bool -> animation 
  
  (* [attack] shows the specific attack that the pokemon *)
  val attack : bool -> animation  
 
  (* [switchOut] shows the animation of changing pokemon (user or enemy) *)
  val switchOut : bool -> animation 
  
  (* [finish] displays if won or lost *)
  val finish : bool -> image 

end 

module type InvGUI = sig 

  (* [dimensions] gives the dimensions of the Graphics window *)
  val dimensions : (int * int) -> unit 
  
  (* [background] displays an image in the background *)
  val background : image 
  
  (* [items] displays all of the items collected*)
  val items : image list 

end 

(*  Since our game is a single player, there are three different modes that 
 * the user can find themselves in: combat mode, overworld (walking around the town), 
 * and the start menu mode. Each one of these modes has a separate module dedicated to 
 * it since they all take different inputs and have different elements to their 
 * individual GUIs. *)

(* The Combat GUI appears when a trainer happens to encounter another trainer
 * or another pokemon worth combatting or capturing, respectively. *)
module Combat : CombatGUI

(* The Overwold GUI occurs for the most part of the gameplay. In this mode,
 * the user has the chance to explore the area and find items, battle trainers, 
 * or speak to other people. *)
module Overworld : OverworldGUI

(* The Start GUI appears before any of the other GUIs, it appears when 
 * the user first loads up the game. In this GUI, the user has the chance to 
 * read instructions, read game credits, quit, or begin playing. *)
module Start : StartGUI

(* The Inventory GUI appears when the user wants to see their inventory. 
 * Any item that the user collects from winnings, AIs or from pokemon
 * appears here in the user's inventory. *)
module Inventory : InvGUI 
