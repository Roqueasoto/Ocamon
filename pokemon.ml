open Controller

type ptype = Normal | Fire | Water | Electric | Grass | Ice | Fighting
           | Poison | Ground | Flying | Psychic | Bug | Rock | Ghost | Dragon

type item = {name: string; descript : string; itemeffect : effect list; quantity: int}

type action = {actname : string; descript : string; effect : effect list}

type t = {poketype : ptype list; name : string; status : status list;
                hp : int; atk : int*int; def : int*int;
                spd : int*int; maxhp : int; catch_rate : int;
                actions : action list; sprite_back : string;
                sprite_front : string}

let ptype poke = poke.poketype

let name poke = poke.name

let hp poke = poke.hp

let atk poke = poke.atk

let def poke = poke.def

let spd poke = poke.spd

let maxhp poke = poke.maxhp

let catch_rate poke = poke.catch_rate

let sprite_front poke = poke.sprite_front

let sprite_back poke = poke.sprite_back

let status poke = poke.status

let check_sub poke =
  if poke.status = [Substitute] then true else false

let rec parse_actions lst ind acc =
  match lst with
  | [] -> acc
  | h::t -> parse_actions t (ind+1) (acc@[(ind, CombatAction h.effect)])

let actions poke =
  let actlst = poke.actions in
  parse_actions actlst 1 []

let rec parse_action_names lst ind acc =
  match lst with
  | [] -> acc
  | h::t -> parse_action_names t (ind+1) (acc@[(ind, h.actname)])

let action_names poke =
  let actlst = poke.actions in
  parse_action_names actlst 1 []

let rec clear_helper stats stat acc =
  match stats with
  | [] -> if acc == [] then [StatusNone] else acc
  | h::t -> if h = stat then acc@t else clear_helper stats stat (h::acc)

let clear_stat poke stat =
  {poketype = poke.poketype; name = poke.name; status = clear_helper poke.status stat [];
   hp = poke.hp; atk = poke.atk; def = poke.def;
   spd = poke.spd; maxhp = poke.maxhp;
   catch_rate = poke.catch_rate;
   actions = poke.actions; sprite_back = poke.sprite_back;
   sprite_front = poke.sprite_front}

let build_poke s =
let act =
  [{actname = "Slam";
    descript = "Slam deals damage of 80 with 75 accuracy";
    effect = [Damage(Other, 75, 80, (20, 32))]};
   {actname = "Tunderbolt";
    descript = "Thunderbolt deals damage of 70 with 100 accuracy and has a 10% chance of paralyzing the target";
    effect = [Damage(Other, 100, 70, (15, 24));Status(Other,10, Paralyze)]};
   {actname = "Agility";
    descript = "Agility raises the user's Speed by two stages";
    effect = [Buff(Self, 100, SPDBuff 2)]};
   {actname = "Wild Charge";
    descript = "Wild Charge deals damage, but the user receives 1⁄4 of the damage it inflicted in recoil";
    effect = [Damage(Self, 100, 90, (15, 24)); Damage (Self, 100, 22, (15, 24))]}]
in
{poketype = [Electric]; name = "Pikachu"; status = [StatusNone];
   hp = 118; atk = (83, 0); def = (58, 0);
   spd = (90, 0); maxhp = 118; catch_rate = 190; actions = act;
   sprite_back = "./PokeSpriteBack/25.png";
   sprite_front = "./PokeSpriteFront/Spr_1y_025.png"}

let random_poke () =
  let act =
    [{actname = "Fire Fang";
      descript = "Deals damage of 65 with 95 accuracy,
has a 10% chance of burning the target and
has a 10% chance of causing the target to flinch";
      effect = [Damage(Other, 95, 65, (15, 24)); Status(Other,10, Burn); Status(Other,10, Flinch)]};
     {actname = "Flame Burst";
      descript = "Deals damage of 70 with 100 accuracy";
      effect = [Damage(Other, 100, 70, (15, 24))]};
     {actname = "Slash";
      descript = "Slash deals damage of 70 with 100 accuracy";
      effect = [Damage(Other, 100, 70, (20, 32))]};
     {actname = "Flamethrower";
      descript = "Deals damage of 90 with 100 accuracy,
has a 10% chance of burning the target";
      effect = [Damage(Other, 100, 90, (15, 24)); Status(Other,10, Burn)]}]
in

{poketype = [Fire;Flying]; name = "Charizard"; status = [StatusNone];
   hp = 161; atk = (112, 0); def = (106, 0);
   spd = (100, 0); maxhp = 161; catch_rate = 45; actions = act;
   sprite_back = "./PokeSpriteBack/6.png";
   sprite_front = "./PokeSpriteFront/Spr_1y_006.png"}


let build_inventory poke =
  (* [{name = "Antidote";descript = "heals pokemon from poisoning";
    effect = [SwapStatus(Self, Poison, StatusNone)]; quantity = 1};
   {name = }

     ]
  *)
  []


let poke_spd_buff poke i=
  if i < 0 then
    {poketype = poke.poketype; name = poke.name; status = poke.status;
     hp = poke.hp; atk = poke.atk; def = poke.def;
     spd = (fst(poke.spd), (min (-6) (snd poke.spd)+i)); maxhp = poke.maxhp;
     catch_rate = poke.catch_rate;
     actions = poke.actions; sprite_back = poke.sprite_back;
     sprite_front = poke.sprite_front}
  else
    {poketype = poke.poketype; name = poke.name; status = poke.status;
     hp = poke.hp; atk = poke.atk; def = poke.def;
     spd = (fst(poke.spd), (max (6) (snd poke.spd)+i)); maxhp = poke.maxhp;
     catch_rate = poke.catch_rate; actions = poke.actions;
     sprite_back = poke.sprite_back; sprite_front = poke.sprite_front}

let poke_atk_buff poke i =
    if i < 0 then {poketype = poke.poketype; name = poke.name; status = poke.status;
                   hp = poke.hp; atk = (fst(poke.atk), (min (-6) (snd poke.atk)+i)); def = poke.def;
                   spd = poke.spd; maxhp = poke.maxhp; catch_rate = poke.catch_rate;
                   actions = poke.actions; sprite_back = poke.sprite_back;
                   sprite_front = poke.sprite_front}
    else
      {poketype = poke.poketype; name = poke.name; status = poke.status; hp = poke.hp;
       atk = (fst(poke.atk), (max (6) (snd poke.atk)+i)); def = poke.def;
      spd = poke.spd; maxhp = poke.maxhp; catch_rate = poke.catch_rate;
      actions = poke.actions; sprite_back = poke.sprite_back;
      sprite_front = poke.sprite_front}

let poke_def_buff poke i =
    if i < 0 then
      {poketype = poke.poketype; name = poke.name; status = poke.status; hp = poke.hp;
       atk = poke.atk; def = (fst(poke.def), (min (-6) (snd poke.def)+i));
      spd = poke.spd; maxhp = poke.maxhp; catch_rate = poke.catch_rate;
      actions = poke.actions; sprite_back = poke.sprite_back;
      sprite_front = poke.sprite_front}
    else
      {poketype = poke.poketype; name = poke.name; status = poke.status; hp = poke.hp;
       atk = poke.atk; def = (fst(poke.def),(max (6) (snd poke.def)+i));
       spd = poke.spd; maxhp = poke.maxhp; catch_rate = poke.catch_rate;
       actions = poke.actions; sprite_back = poke.sprite_back;
       sprite_front = poke.sprite_front}

let poke_heal poke pts =
  {poketype = poke.poketype; name = poke.name; status = poke.status;
   hp = (min (poke.hp+pts) poke.maxhp);
   atk = poke.atk; def = poke.def;
   spd = poke.spd; maxhp = poke.maxhp;
   catch_rate = poke.catch_rate;
   actions = poke.actions;
   sprite_back = poke.sprite_back;
   sprite_front = poke.sprite_front}

let poke_damage poke1 poke2 pts =
  let astage = float_of_int (snd poke2.atk) in
  let amul = max (2.0) (2.0 +. astage) /. max (2.0) (2.0 -. astage) in
  let dstage = float_of_int (snd poke1.def) in
  let dmul = max (2.0) (2.0 +. dstage) /. max (2.0) (2.0 -. dstage) in
  let def = float_of_int (fst(poke1.def)) *. dmul in
  let atk = float_of_int (fst(poke2.atk)) *. amul in
  let damage = int_of_float (((2.0 *. 50.0 /. 5.0) +. 2.0) *. atk *. (float_of_int pts) /. def /. 50.0) in
  {poketype = poke1.poketype; name = poke1.name; status = poke1.status;
   hp = (max (poke1.hp-damage) 0);
   atk = poke1.atk; def = poke1.def;
   spd = poke1.spd; maxhp = poke1.maxhp;
   catch_rate = poke1.catch_rate;
   actions = poke1.actions;
   sprite_back = poke1.sprite_back;
   sprite_front = poke1.sprite_front}

let non_overlap_stat s =
  match s with
  | StatusNone-> true
  | Sleep -> true
  | Burn -> true
  | Paralyze -> true
  | Frozen -> true
  | Poison -> true
  | Toxic -> true
  | _ -> false

let poke_change_status poke s =
  match poke.status, s with
  | [], s -> failwith "status should not be empty"
  | h::t, newstat -> if (h = StatusNone || newstat == StatusNone) then
                                             {poketype = poke.poketype; name = poke.name; status = [newstat];
                                             hp = poke.hp; atk = poke.atk; def = poke.def;
                                             spd = poke.spd; maxhp = poke.maxhp;
                                             catch_rate = poke.catch_rate;
                                             actions = poke.actions;
                                             sprite_back = poke.sprite_back;
                                             sprite_front = poke.sprite_front}
    else if non_overlap_stat h && non_overlap_stat h then poke
    else {poketype = poke.poketype; name = poke.name; status = newstat::poke.status;
          hp = poke.hp; atk = poke.atk; def = poke.def;
          spd = poke.spd; maxhp = poke.maxhp;
          catch_rate = poke.catch_rate;
          actions = poke.actions;
          sprite_back = poke.sprite_back;
          sprite_front = poke.sprite_front}


let poke_effect poke1 poke2 effect =
  match effect with
  | Switch _ -> failwith "should not reach"
  | Heal (s, i1, i2) ->  poke_heal poke1 i2
  | Damage (s, i1, i2, (r1, r2)) -> poke_damage poke1 poke2 i2
  | Buff (s, i1, b) -> begin
      match b with
      | ATKBuff i -> poke_atk_buff poke1 i
      | DEFBuff i -> poke_def_buff poke1 i
      | SPDBuff i -> poke_spd_buff poke1 i
    end
  | Special (_,_,_) -> failwith "unimplemented"
  | Status (_,_,s) -> poke_change_status poke1 s
  | Nothing -> poke1

let clear_buff poke =
  {poketype = poke.poketype;
  name = poke.name;
  status = poke.status;
  hp = poke.hp;
  atk = (fst(poke.atk), 0);
  def = (fst(poke.def), 0);
  spd = (fst(poke.spd), 0);
  maxhp = poke.maxhp;
  catch_rate = poke.catch_rate;
  actions = poke.actions;
  sprite_back = poke.sprite_back;
  sprite_front = poke.sprite_front}

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
  | Electric,Dragon | Electric,Grass | Electric, Electric-> 0.5
  | Electric,Ground -> 0.
  | Electric,_ -> 1.
  | Grass,Ground | Grass,Rock | Grass,Water -> 2.
  | Grass,Grass | Grass,Fire | Grass,Poison | Grass,Bug | Grass,Dragon -> 0.5
  | Grass,_ -> 1.
  | Ice,Grass | Ice,Ground | Ice,Flying | Ice,Dragon -> 2.
  | Ice,Water | Ice,Ice -> 0.5
  | Ice,_ -> 1.
  | Fighting,Normal | Fighting,Rock | Fighting,Ice -> 2.
  | Fighting,Poison | Fighting,Flying | Fighting,Psychic | Fighting,Bug -> 0.5
  | Fighting,Ghost -> 0.
  | Fighting,_ -> 1.
  | Poison,Grass | Poison,Bug -> 2.
  | Poison,Poison | Poison,Rock | Poison,Ghost | Poison,Ground -> 0.5
  | Poison,_ -> 1.
  | Ground,Fire | Ground,Electric | Ground,Poison | Ground,Rock -> 2.
  | Ground,Grass | Ground,Bug -> 0.5
  | Ground,Flying -> 0.
  | Ground,_ -> 1.
  | Flying,Grass | Flying,Bug | Flying,Fighting -> 2.
  | Flying,Electric | Flying,Rock -> 0.5
  | Flying,_ -> 1.
  | Psychic,Poison | Psychic,Fighting -> 2.
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
  if item.itemeffect = [] then None
  else Some (CombatAction item.itemeffect)
