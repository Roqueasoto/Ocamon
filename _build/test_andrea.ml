(* PUT YOUR TEST CASES HERE *)
open OUnit2
open Pokemon
open Controller

let pkc = build_poke "25"
let rand = random_poke ()
let effect1 = Nothing
let effect2 = Status(Other, 100, Poisoned)
let effect3 = Heal(Self, 100, 10)
let effect4 = Buff(Self, 100, ATKBuff 7)
let effect5 = Buff(Self, 100, ATKBuff (-7))
let effect6 = Special(Self, 100, HealStatus(Poisoned), Nothing)

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
let test010_expression      = 0
let test010_expected_result = 1

let test011_name            = "Andrea 011"
let test011_expression      = 0
let test011_expected_result = 1

let test012_name            = "Andrea 012"
let test012_expression      = 0
let test012_expected_result = 1

let test013_name            = "Andrea 013"
let test013_expression      = 0
let test013_expected_result = 1

let test014_name            = "Andrea 014"
let test014_expression      = 0
let test014_expected_result = 1

let test015_name            = "Andrea 015"
let test015_expression      = 0
let test015_expected_result = 1

let test016_name            = "Andrea 016"
let test016_expression      = 0
let test016_expected_result = 1

let test017_name            = "Andrea 017"
let test017_expression      = 0
let test017_expected_result = 1

let test018_name            = "Andrea 018"
let test018_expression      = 0
let test018_expected_result = 1

let test019_name            = "Andrea 019"
let test019_expression      = 0
let test019_expected_result = 1

let test020_name            = "Andrea 020"
let test020_expression      = 0
let test020_expected_result = 1

let test021_name            = "Andrea 021"
let test021_expression      = 0
let test021_expected_result = 1

let test022_name            = "Andrea 022"
let test022_expression      = 0
let test022_expected_result = 1

let test023_name            = "Andrea 023"
let test023_expression      = 0
let test023_expected_result = 1

let test024_name            = "Andrea 024"
let test024_expression      = 0
let test024_expected_result = 1

let test025_name            = "Andrea 025"
let test025_expression      = 0
let test025_expected_result = 1

let test026_name            = "Andrea 026"
let test026_expression      = 0
let test026_expected_result = 1

let test027_name            = "Andrea 027"
let test027_expression      = 0
let test027_expected_result = 1

let test028_name            = "Andrea 028"
let test028_expression      = 0
let test028_expected_result = 1

let test029_name            = "Andrea 029"
let test029_expression      = 0
let test029_expected_result = 1

let test030_name            = "Andrea 030"
let test030_expression      = 0
let test030_expected_result = 1

let test031_name            = "Andrea 031"
let test031_expression      = 0
let test031_expected_result = 1

let test032_name            = "Andrea 032"
let test032_expression      = 0
let test032_expected_result = 1

let test033_name            = "Andrea 033"
let test033_expression      = 0
let test033_expected_result = 1

let test034_name            = "Andrea 034"
let test034_expression      = 0
let test034_expected_result = 1

let test035_name            = "Andrea 035"
let test035_expression      = 0
let test035_expected_result = 1

let test036_name            = "Andrea 036"
let test036_expression      = 0
let test036_expected_result = 1

let test037_name            = "Andrea 037"
let test037_expression      = 0
let test037_expected_result = 1

let test038_name            = "Andrea 038"
let test038_expression      = 0
let test038_expected_result = 1

let test039_name            = "Andrea 039"
let test039_expression      = 0
let test039_expected_result = 1

let test040_name            = "Andrea 040"
let test040_expression      = 0
let test040_expected_result = 1

let test041_name            = "Andrea 041"
let test041_expression      = 0
let test041_expected_result = 1

let test042_name            = "Andrea 042"
let test042_expression      = 0
let test042_expected_result = 1

let test043_name            = "Andrea 043"
let test043_expression      = 0
let test043_expected_result = 1

let test044_name            = "Andrea 044"
let test044_expression      = 0
let test044_expected_result = 1

let test045_name            = "Andrea 045"
let test045_expression      = 0
let test045_expected_result = 1

let test046_name            = "Andrea 046"
let test046_expression      = 0
let test046_expected_result = 1

let test047_name            = "Andrea 047"
let test047_expression      = 0
let test047_expected_result = 1

let test048_name            = "Andrea 048"
let test048_expression      = 0
let test048_expected_result = 1

let test049_name            = "Andrea 049"
let test049_expression      = 0
let test049_expected_result = 1

let test050_name            = "Andrea 050"
let test050_expression      = 0
let test050_expected_result = 1

let test051_name            = "Andrea 051"
let test051_expression      = 0
let test051_expected_result = 1

let test052_name            = "Andrea 052"
let test052_expression      = 0
let test052_expected_result = 1

let test053_name            = "Andrea 053"
let test053_expression      = 0
let test053_expected_result = 1

let test054_name            = "Andrea 054"
let test054_expression      = 0
let test054_expected_result = 1

let test055_name            = "Andrea 055"
let test055_expression      = 0
let test055_expected_result = 1

let test056_name            = "Andrea 056"
let test056_expression      = 0
let test056_expected_result = 1

let test057_name            = "Andrea 057"
let test057_expression      = 0
let test057_expected_result = 1

let test058_name            = "Andrea 058"
let test058_expression      = 0
let test058_expected_result = 1

let test059_name            = "Andrea 059"
let test059_expression      = 0
let test059_expected_result = 1

let test060_name            = "Andrea 060"
let test060_expression      = 0
let test060_expected_result = 1

let test061_name            = "Andrea 061"
let test061_expression      = 0
let test061_expected_result = 1

let test062_name            = "Andrea 062"
let test062_expression      = 0
let test062_expected_result = 1

let test063_name            = "Andrea 063"
let test063_expression      = 0
let test063_expected_result = 1

let test064_name            = "Andrea 064"
let test064_expression      = 0
let test064_expected_result = 1

let test065_name            = "Andrea 065"
let test065_expression      = 0
let test065_expected_result = 1

let test066_name            = "Andrea 066"
let test066_expression      = 0
let test066_expected_result = 1

let test067_name            = "Andrea 067"
let test067_expression      = 0
let test067_expected_result = 1

let test068_name            = "Andrea 068"
let test068_expression      = 0
let test068_expected_result = 1

let test069_name            = "Andrea 069"
let test069_expression      = 0
let test069_expected_result = 1

let test070_name            = "Andrea 070"
let test070_expression      = 0
let test070_expected_result = 1

let test071_name            = "Andrea 071"
let test071_expression      = 0
let test071_expected_result = 1

let test072_name            = "Andrea 072"
let test072_expression      = 0
let test072_expected_result = 1

let test073_name            = "Andrea 073"
let test073_expression      = 0
let test073_expected_result = 1

let test074_name            = "Andrea 074"
let test074_expression      = 0
let test074_expected_result = 1

let test075_name            = "Andrea 075"
let test075_expression      = 0
let test075_expected_result = 1

let test076_name            = "Andrea 076"
let test076_expression      = 0
let test076_expected_result = 1

let test077_name            = "Andrea 077"
let test077_expression      = 0
let test077_expected_result = 1

let test078_name            = "Andrea 078"
let test078_expression      = 0
let test078_expected_result = 1

let test079_name            = "Andrea 079"
let test079_expression      = 0
let test079_expected_result = 1

let test080_name            = "Andrea 080"
let test080_expression      = 0
let test080_expected_result = 1

let test081_name            = "Andrea 081"
let test081_expression      = 0
let test081_expected_result = 1

let test082_name            = "Andrea 082"
let test082_expression      = 0
let test082_expected_result = 1

let test083_name            = "Andrea 083"
let test083_expression      = 0
let test083_expected_result = 1

let test084_name            = "Andrea 084"
let test084_expression      = 0
let test084_expected_result = 1

let test085_name            = "Andrea 085"
let test085_expression      = 0
let test085_expected_result = 1

let test086_name            = "Andrea 086"
let test086_expression      = 0
let test086_expected_result = 1

let test087_name            = "Andrea 087"
let test087_expression      = 0
let test087_expected_result = 1

let test088_name            = "Andrea 088"
let test088_expression      = 0
let test088_expected_result = 1

let test089_name            = "Andrea 089"
let test089_expression      = 0
let test089_expected_result = 1

let test090_name            = "Andrea 090"
let test090_expression      = 0
let test090_expected_result = 1

let test091_name            = "Andrea 091"
let test091_expression      = 0
let test091_expected_result = 1

let test092_name            = "Andrea 092"
let test092_expression      = 0
let test092_expected_result = 1

let test093_name            = "Andrea 093"
let test093_expression      = 0
let test093_expected_result = 1

let test094_name            = "Andrea 094"
let test094_expression      = 0
let test094_expected_result = 1

let test095_name            = "Andrea 095"
let test095_expression      = 0
let test095_expected_result = 1

let test096_name            = "Andrea 096"
let test096_expression      = 0
let test096_expected_result = 1

let test097_name            = "Andrea 097"
let test097_expression      = 0
let test097_expected_result = 1

let test098_name            = "Andrea 098"
let test098_expression      = 0
let test098_expected_result = 1

let test099_name            = "Andrea 099"
let test099_expression      = 0
let test099_expected_result = 1

let test100_name            = "Andrea 100"
let test100_expression      = 0
let test100_expected_result = 1




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

]
