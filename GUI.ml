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
