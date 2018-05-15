(* PUT YOUR TEST CASES HERE *)
open OUnit2
open Pokemon
open Controller

let pkc = build_poke "25"
let chr = build_poke "6"
let rand = random_poke ()
let effect1 = Nothing
let effect2 = Status(Other, 100, Poisoned)
let effect3 = Heal(Self, 100, 10)
let effect4 = Buff(Self, 100, ATKBuff 7)
let effect5 = Buff(Self, 100, ATKBuff (-7))
let effect6 = Special(Self, 100, HealStatus(Poisoned), Nothing)
let effect7 = Damage(Other, 100, 20, (1,1), Electric, SpecialA)
let effect8 = Status(Other, 100, Paralyze)
let effect9 = Status(Other, 100, Burn)
let effect10 = Buff(Self, 100, SPDBuff 7)
let effect11 = Buff(Self, 100, SPDBuff (-7))
let effect12 = Buff(Self, 100, DEFBuff 7)
let effect13 = Buff(Self, 100, DEFBuff (-7))
let effect14 = Buff(Self, 100, SpatkBuff 7)
let effect15 = Buff(Self, 100, SpatkBuff (-7))
let effect16 = Status(Other, 100, Focused)


let test000_name            = "Andrea 000"
let test000_expression      = name pkc
let test000_expected_result = "Pikachu"

let test001_name            = "Andrea 001"
let test001_expression      = status pkc
let test001_expected_result = [StatusNone]

let test002_name            = "Andrea 002"
let test002_expression      = hp pkc
let test002_expected_result = 118

let test003_name            = "Andrea 003"
let test003_expression      = maxhp pkc = hp pkc
let test003_expected_result = true

let test004_name            = "Andrea 004"
let test004_expression      = poke_effect pkc rand effect1
let test004_expected_result = pkc

let test005_name            = "Andrea 005"
let test005_expression      = status(poke_effect pkc rand effect2)
let test005_expected_result = [Poisoned]

let test006_name            = "Andrea 006"
let test006_expression      = hp(poke_effect pkc rand effect3)
let test006_expected_result = 118

let test007_name            = "Andrea 007"
let test007_expression      = snd(atk(poke_effect pkc rand effect4))
let test007_expected_result = 6

let test008_name            = "Andrea 008"
let test008_expression      = snd(atk(poke_effect pkc rand effect5))
let test008_expected_result = -6

let test009_name            = "Andrea 009"
let test009_expression      = status(poke_effect pkc rand effect6)
let test009_expected_result = [StatusNone]

let test010_name            = "Andrea 010"
let test010_expression      = turns pkc
let test010_expected_result = 0

let test011_name            = "Andrea 011"
let test011_expression      = set_count pkc 4 |> turns
let test011_expected_result = 4

let test012_name            = "Andrea 012"
let test012_expression      = (hp(poke_effect pkc rand effect7)) < hp pkc
let test012_expected_result = true

let test013_name            = "Andrea 013"
let test013_expression      = status(poke_effect (poke_effect pkc rand effect2) rand effect8)
let test013_expected_result = [Poisoned]

let test014_name            = "Andrea 014"
let test014_expression      = status(poke_effect chr pkc effect9)
let test014_expected_result = [StatusNone]

let test015_name            = "Andrea 015"
let test015_expression      = List.length(build_inventory ())
let test015_expected_result = 4

let test016_name            = "Andrea 016"
let test016_expression      = snd(spd(poke_effect pkc rand effect10))
let test016_expected_result = 6

let test017_name            = "Andrea 017"
let test017_expression      = snd(spd(poke_effect pkc rand effect11))
let test017_expected_result = -6

let test018_name            = "Andrea 018"
let test018_expression      = snd(def(poke_effect pkc rand effect12))
let test018_expected_result = 6

let test019_name            = "Andrea 019"
let test019_expression      = snd(def(poke_effect pkc rand effect13))
let test019_expected_result = -6

let test020_name            = "Andrea 020"
let test020_expression      = snd(spatk(poke_effect pkc rand effect14))
let test020_expected_result = 6

let test021_name            = "Andrea 021"
let test021_expression      = snd(spatk(poke_effect pkc rand effect15))
let test021_expected_result = -6

let test022_name            = "Andrea 022"
let test022_expression      = check_status pkc StatusNone
let test022_expected_result = true

let test023_name            = "Andrea 023"
let test023_expression      = check_status (poke_effect pkc rand effect2) StatusNone
let test023_expected_result = false

let test024_name            = "Andrea 024"
let test024_expression      = check_status (poke_effect pkc rand effect2) Poisoned
let test024_expected_result = true

let test025_name            = "Andrea 025"
let test025_expression      = ptype pkc
let test025_expected_result = [Electric]

let test026_name            = "Andrea 026"
let test026_expression      = ptype chr
let test026_expected_result = [Fire; Flying]

let test027_name            = "Andrea 027"
let test027_expression      = action_names pkc
let test027_expected_result = [(1, "Thunder"); (2, "Agility"); (3, "Swift"); (4, "Quick Attack")]

let test028_name            = "Andrea 028"
let test028_expression      = action_names chr
let test028_expected_result = [(1, "Flamethrower"); (2, "Slash"); (3, "Rage"); (4, "Leer")]

let test029_name            = "Andrea 029"
let test029_expression      = clear_stat (poke_effect pkc rand effect2) Poisoned |> status
let test029_expected_result = [StatusNone]

let test030_name            = "Andrea 030"
let test030_expression      = clear_stat (poke_effect (poke_effect pkc rand effect2) rand effect16) Poisoned|> status
let test030_expected_result = [Focused]



let tests = [
  test000_name >::
  (fun _ -> assert_equal test000_expected_result test000_expression);
  test001_name >::
  (fun _ -> assert_equal test001_expected_result test001_expression);
  test002_name >::
  (fun _ -> assert_equal test002_expected_result test002_expression);
  test003_name >::
  (fun _ -> assert_equal test003_expected_result test003_expression);
  test004_name >::
  (fun _ -> assert_equal test004_expected_result test004_expression);
  test005_name >::
  (fun _ -> assert_equal test005_expected_result test005_expression);
  test006_name >::
  (fun _ -> assert_equal test006_expected_result test006_expression);
  test007_name >::
  (fun _ -> assert_equal test007_expected_result test007_expression);
  test008_name >::
  (fun _ -> assert_equal test008_expected_result test008_expression);
  test009_name >::
  (fun _ -> assert_equal test009_expected_result test009_expression);
  test010_name >::
  (fun _ -> assert_equal test010_expected_result test010_expression);
  test011_name >::
  (fun _ -> assert_equal test011_expected_result test011_expression);
  test012_name >::
  (fun _ -> assert_equal test012_expected_result test012_expression);
  test013_name >::
  (fun _ -> assert_equal test013_expected_result test013_expression);
  test014_name >::
  (fun _ -> assert_equal test014_expected_result test014_expression);
  test015_name >::
  (fun _ -> assert_equal test015_expected_result test015_expression);
  test016_name >::
  (fun _ -> assert_equal test016_expected_result test016_expression);
  test017_name >::
  (fun _ -> assert_equal test017_expected_result test017_expression);
  test018_name >::
  (fun _ -> assert_equal test018_expected_result test018_expression);
  test019_name >::
  (fun _ -> assert_equal test019_expected_result test019_expression);
  test020_name >::
  (fun _ -> assert_equal test020_expected_result test020_expression);
  test021_name >::
  (fun _ -> assert_equal test021_expected_result test021_expression);
  test024_name >::
  (fun _ -> assert_equal test024_expected_result test024_expression);
  test025_name >::
  (fun _ -> assert_equal test025_expected_result test025_expression);
  test026_name >::
  (fun _ -> assert_equal test026_expected_result test026_expression);
  test027_name >::
  (fun _ -> assert_equal test027_expected_result test027_expression);
  test028_name >::
  (fun _ -> assert_equal test028_expected_result test028_expression);
  test029_name >::
  (fun _ -> assert_equal test029_expected_result test029_expression);
  test030_name >::
  (fun _ -> assert_equal test030_expected_result test030_expression);

]
