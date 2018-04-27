type ptype = Normal | Fire | Water | Electric | Grass | Ice | Fighting
           | Poison | Ground | Flying | Psychic | Bug | Rock | Ghost | Dragon

type status = None | Sleep | Paralyze | Burn | Frozen | Poison 
           | Confused | Flinch | Substitute | Uncontrollable | Focused 
           | LeechSeed | Missed | Toxic

type item = {name: string; descript : string; effect : Controller.command; quantity: int}

type action = {name : string; descript : string; 
               pp : int; effect : effect list}

type poke = {poketype : ptype list; name : string; status : status;
                hp : int; atk : int*int; def : int*int;
                spd : int*int; maxhp : int; catch_rate : int;
                actions : (int*Controller.command) list; sprite_back : string;
                sprite_front : string} 

let ptype poke = poke.poketype

let name poke = poke.name

let nature poke = poke.nature

let hp poke = poke.hp

let atk poke = poke.atk

let def poke = poke.def

let spd poke = poke.spd

let maxhp poke = poke.maxhp

let catch_rate poke = poke.catch_rate

let rate_occ poke = poke.rate_occ

let item_holding poke = poke.item_holding

let actions poke = poke.actions

let build_poke s = 
  let act = [
    (0, CombatAction[Damage("other", 75, 80, (20, 32))]; 
    (1, CombatAction[Damage("other", 100, 90, (15, 24))];
    (2, CombatAction[(Buff("self", 2, "speed")]; 
    (3, CombatAction[Damage("other", 100, 90, (15, 24)); Damage ("self", 45, 100, (15, 24))]
    ] in 

  {poketype = Electric ; name = "Pikachu"; status = None;
                hp = (35, 0); atk = (55, 0); def = (40, 0);
                spd = (90, 0); maxhp = 274; catch_rate = 0.248;
                rate_occ : 0; actions = act
                sprite_back = "PokeSpriteBack/pikachu.png";
                sprite_front = "PokeSpriteFront/pikachu.png"} 

let random_poke () = 
   let act = [
    (0, CombatAction[Damage("other", 75, 80, (20, 32))]; 
    (1, CombatAction[Damage("other", 90, 100, (15, 24))];
    (2, CombatAction[(Buff("self", 2, "speed")]; 
    (3, CombatAction[Damage("other", 90, 100, (15, 24)); Damage ("self", 45, 100, (15, 24))]
    ] in 

  {poketype = Electric ; name = "Pikachu"; status = None;
                hp = (35, 0); atk = (55, 0); def = (40, 0);
                spd = (90, 0); maxhp = 274; catch_rate = 0.248; actions = poke.actions
                sprite_back = "PokeSpriteBack/pikachu.png"
                sprite_front = "PokeSpriteFront/pikachu.png"} 


let build_inventory poke =
  []


let poke_spd_buff poke i= 
  if i < 0 then 
  {poketype = poke.poketype; name = poke.name; status = poke.status;
  hp = poke.hp; atk = poke.atk; def = poke.def;
  spd = (fst(poke.spd), min(-6, snd(poke.spd)+i); maxhp = poke.maxhp; 
  catch_rate = poke.catch_rate;
  actions = poke.actions; sprite_back = poke.sprite_back; 
  sprite_front = poke.sprite_front}
  else 
  {poketype = poke.poketype; name = poke.name; status = poke.status;
  hp = poke.hp; atk = poke.atk; def = (fst(poke.def), max(snd(poke.def)+i, 6);
  spd = (fst(poke.spd), min(-6, snd(poke.spd)+i); maxhp = poke.maxhp; 
  catch_rate = poke.catch_rate; actions = poke.actions; 
  sprite_back = poke.sprite_back; sprite_front = poke.sprite_front}

let poke_effect poke effect = 
  match effect with 
  | Switch _ -> failwith "should not reach"
  | Heal (s, i1, i2) -> {poketype = poke.poketype; name = poke.name; status = poke.status
                         hp = (max(fst(poke.hp)+i2, poke.maxhp), snd(poke.hp)); 
                         atk = poke.atk; def = poke.def;
                         spd = poke.spd; maxhp = poke.maxhp; 
                         catch_rate = poke.catch_rate;
                         actions = poke.actions}
  | Damage (s, i1, i2, (r1, r2)) -> {poketype = poke.poketype; name = poke.name; status = poke.status
                                     hp = (min(fst(poke.hp)-i2, 0), snd(poke.hp)); 
                                     atk = poke.atk; def = poke.def;
                                     spd = poke.spd; maxhp = poke.maxhp; 
                                     catch_rate = poke.catch_rate;
                                     actions = poke.actions}
  | Buff (s, i1, b) -> match b with
                       | HPBuff i -> begin 
                         if i < 0 then 
                         {poketype = poke.poketype; name = poke.name; status = poke.status
                         hp = (fst(poke.hp), min(-6, snd(poke.hp)+i); 
                         atk = poke.atk; def = poke.def;
                         spd = poke.spd; maxhp = poke.maxhp; c
                         atch_rate = poke.catch_rate;
                         actions = poke.actions; sprite_back = poke.sprite_back; sprite_front = poke.sprite_front}
                         else 
                         {poketype = poke.poketype; name = poke.name; status = poke.status
                         hp = (fst(poke.hp), max(snd(poke.hp)+i, 6); 
                         atk = poke.atk; def = poke.def;
                         spd = poke.spd; maxhp = poke.maxhp; c
                         atch_rate = poke.catch_rate;
                         actions = poke.actions; sprite_back = poke.sprite_back; 
                         sprite_front = poke.sprite_front}
                       end 
                        | ATKBuff i -> begin 
                         if i < 0 then 
                         {poketype = poke.poketype; name = poke.name; status = poke.status
                         hp = poke.hp; 
                         atk = (fst(poke.atk), min(-6, snd(poke.atk)+i); def = poke.def;
                         spd = poke.spd; maxhp = poke.maxhp; c
                         atch_rate = poke.catch_rate;
                         actions = poke.actions; sprite_back = poke.sprite_back; 
                         sprite_front = poke.sprite_front}
                         else 
                         {poketype = poke.poketype; name = poke.name; status = poke.status
                         hp = poke.hp; 
                         atk = (fst(poke.atk), max(snd(poke.atk)+i, 6); def = poke.def;
                         spd = poke.spd; maxhp = poke.maxhp; c
                         atch_rate = poke.catch_rate;
                         actions = poke.actions; sprite_back = poke.sprite_back; 
                         sprite_front = poke.sprite_front}
                       end 
                       | DEFBuff i -> begin 
                         if i < 0 then 
                         {poketype = poke.poketype; name = poke.name; status = poke.status
                         hp = poke.hp; 
                         atk = poke.atk; def = (fst(poke.def), min(-6, snd(poke.def)+i);
                         spd = poke.spd; maxhp = poke.maxhp; c
                         atch_rate = poke.catch_rate;
                         actions = poke.actions; sprite_back = poke.sprite_back; 
                         sprite_front = poke.sprite_front}
                         else 
                         {poketype = poke.poketype; name = poke.name; status = poke.status
                         hp = poke.hp; 
                         atk = poke.atk; def = (fst(poke.def), max(snd(poke.def)+i, 6);
                         spd = poke.spd; maxhp = poke.maxhp; c
                         atch_rate = poke.catch_rate;
                         actions = poke.actions; sprite_back = poke.sprite_back; 
                         sprite_front = poke.sprite_front}
                       | SPDBuff i -> poke_spd_buff poke i 
  | Special _ -> failwith "unimplemented"
  | Nothing -> poke

let clear_buff poke = 
  {poketype = poke.poketype; 
  name = poke.name; 
  status = poke.statusl
  hp = (fst(poke.hp), 0); 
  atk = (fst(poke.atk), 0); 
  def = (fst(poke.def), 0);
  spd = (fst(spd.hp), 0); 
  maxhp = poke.maxhp; 
  catch_rate = poke.catch_rate;
  rate_occ = poke.rate_occ; 
  actions = poke.actions}

let type_compare ptype1 ptype2 =
  match ptype1,ptype2 with
  | Normal,Ghost -> 0.
  | Normal,_ -> 1.
  | Fire,Bug | Fire,Grass | Fire,Ice -> 2.
  | Fire,Rock | Fire,Water | Fire,Fire | Fire,Dragon -> 0.5
  | Fire,_ -> 1.
  | Water,Fire | Water,Ground | Water,Rock -> 2.
  | Water,Grass | Water,Ice | Water,Water | Water,Dragon -> 0.5
  | Water,_ -> 1.
  | Electric,Flying | Electric,Water -> 2.
  | Electric,Dragon | Electric,Grass | Electric,Dragon -> 0.5
  | Electric,Ground -> 0.
  | Electric,_ -> 1.
  | Grass,Ground | Grass,Rock | Grass,Water -> 2.
  | Grass,Grass | Grass,Fire | Grass,Poison | Grass,Bug | Grass,Dragon -> 0.5
  | Grass,_ -> 1.
  | Ice,Grass | Ice,Ground | Ice,Flying | Ice,Dragon -> 2.
  | Ice,Water | Ice,Ice -> 0.5
  | Ice,_ -> 1
  | Fighting,Normal | Fighting,Rock | Fighting,Ice -> 2.
  | Fighting,Poison | Fighting,Flying | Fighting,Psychic | Fighting,Bug -> 0.5
  | Fighting,Ghost -> 0.
  | Fighing,_ -> 1.
  | Poison,Grass | Poison,Bug -> 2.
  | Poison,Poison | Poison,Rock | Posion,Ghost | Poison,Rock -> 0.5
  | Posion,_ -> 1.
  | Ground,Fire | Ground,Electic | Ground,Poison | Ground,Rock -> 2.
  | Ground,Grass | Ground,Bug -> 0.5
  | Ground,Flying -> 0.
  | Ground,_ -> 1.
  | Flying,Grass | Flying,Bug | Flying,Fighting -> 2.
  | Flying,Electric | Flying,Rock -> 0.5
  | Flying,_ -> 1.
  | Psychic,Poison | Psychic,Psychic -> 2.
  | Psychic,Psychic -> 0.5
  | Psychic,_ -> 1.
  | Bug,Grass | Bug,Poison | Bug,Psychic -> 2.
  | Bug,Fire | Bug,Fighting | Bug,Ghost | Bug,Flying -> 0.5
  | Bug,_ -> 1.
  | Rock,Bug | Rock,Flying | Rock,Fire | Rock,Ice -> 2.
  | Rock,Fighting | Rock,Ground -> 0.5
  | Rock,_ -> 1.
  | Ghost,Ghost -> 2.
  | Ghost,Normal | Ghost,Fighting -> 0.
  | Ghost,_ -> 1.
  | Dragon,Dragon -> 2.
  | Dragon,_ -> 1.

 let item_use_combat item = 
   match item with 
   | 


(*Graveyard*)
(* let level poke = poke.level
 *)
 (*let xp poke = poke.xp*)