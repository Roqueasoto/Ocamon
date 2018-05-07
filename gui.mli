open Graphics
open Camlimages
open Images
open Png
open Jpeg
open Pokemon
open Types
open Controller

(*
 * Each of the module types provides the visual standard of the Graphics window
 * that each of the following modules (Combat, Overworld, and Start)
 * all must adhere to.
 *)

(* [image] is an abstract type representing an image *)
type image

val array_of_image : Images.t -> Graphics.color array array

(* [background] gives the image in the background *)
val press_battle: int ref -> unit -> unit

(* [startGame] determines if the user pressed the button to start the game *)
val make_action : int ref -> Types.gui_combat_info -> Controller.command

(* [quitGame] determines if the user pressed the button to quit the game *)
val check : int ref -> Types.gui_combat_info -> int -> int -> Controller.command

(* [getCredits] determines if the user pressed the button to get the game maker credits *)
val draw_battle : Types.gui_info -> Controller.command

(* [getHelp] determines if the user pressed the button to get the instructions of the game *)
val press_map : unit -> unit

val draw_map : unit -> unit

val press_start : unit -> unit

val draw_start : unit -> unit

val start_game : unit -> unit

val press_win : unit -> unit

val win_game : unit -> unit


(*module type OverworldGUI = sig

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

end *)

(*  Since our game is a single player, there are three different modes that
 * the user can find themselves in: combat mode, overworld (walking around the town),
 * and the start menu mode. Each one of these modes has a separate module dedicated to
 * it since they all take different inputs and have different elements to their
 * individual GUIs. *)

(* The Combat GUI appears when a trainer happens to encounter another trainer
 * or another pokemon worth combatting or capturing, respectively.
module Combat : CombatGUI *)

(*(* The Overwold GUI occurs for the most part of the gameplay. In this mode,
 * the user has the chance to explore the area and find items, battle trainers,
 * or speak to other people. *)
module Overworld : OverworldGUI*)

(* The Start GUI appears before any of the other GUIs, it appears when
 * the user first loads up the game. In this GUI, the user has the chance to
 * read instructions, read game credits, quit, or begin playing.
module Start : StartGUI *)

(* The Inventory GUI appears when the user wants to see their inventory.
 * Any item that the user collects from winnings, AIs or from pokemon
 * appears here in the user's inventory.
module Inventory : InvGUI *)
