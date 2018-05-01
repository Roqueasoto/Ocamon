open OUnit2

(* INSTRUCTIONS:
   1. Use the following 4 boolean flags to enable or disable your tests.
   2. Write your tests in test_<your_name>.ml. DO NOT MODIFY test mli files.
   3. Run "make test"

   WARNING:
   Please make sure that the boolean flags below are correct. If you disable one,
   don't forget to re-enable it if you wish to run it again.
*)

let enable_andrea = true
let enable_cynthia = true
let enable_roque = true
let enable_timothy = true

(* DO NOT MODIFY BELOW THIS LINE *)

let active_tests_andrea   = if enable_andrea  then Test_andrea.tests  else []
let active_tests_cynthia  = if enable_cynthia then Test_cynthia.tests else []
let active_tests_roque    = if enable_roque   then Test_roque.tests   else []
let active_tests_timothy  = if enable_timothy then Test_timothy.tests else []

let tests = "TESTING SUITE FOR OCAMON BY TEAM AWESOME" >:::
            active_tests_andrea @
            active_tests_cynthia @
            active_tests_roque @
            active_tests_timothy

let _ = run_test_tt_main tests
