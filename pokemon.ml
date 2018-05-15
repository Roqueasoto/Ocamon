open Controller

type item =
  {itemname: string; descript : string; itemeffect : effect list; quantity: int}

type action = {actname : string; descript : string; effect : effect list}

type t = {poketype : ptype list; name : string; status : status list;
                hp : int; atk : int*int; def : int*int;
                spd : int*int; spatk: int*int; maxhp : int; catch_rate : int;
                turn_counter : int; actions : action list;
                sprite_back : string; sprite_front : string}

module PokeMoves = struct
  let razor_leaf = {actname = "Razor Leaf";
                    descript = "Deals damage and increase critical hit";
                    effect = [Damage(Other, 95, 55, (1,1), Grass, Physical)]}

  let growth =
    {actname = "Growth";
     descript = "Raises the user's Attack and Special Attack by one stage each";
     effect = [Buff(Self, 100, ATKBuff 1); Buff(Self, 100, SpatkBuff 1)]}

  let sleep_powder = {actname = "Sleep Powder";
                      descript = "Puts target to sleep";
                      effect = [Status(Other, 75, Sleep)]}

  let solar_beam = {actname = "Solar Beam";
                    descript = "Deals damage of 120";
                    effect = [Damage(Other, 100, 120, (1,1), Grass, Special)]}

  let poison_powder = {actname = "Poison Powder";
                       descript = "Poisons the pokemon";
                       effect = [Status(Other, 75, Poisoned)]}

  let vine_whip = {actname = "Vine Whip";
                   descript = "deals damage";
                   effect = [Damage(Other, 100, 45, (1,1), Grass, Physical)]}

  let fire_spin = {actname = "Fire Spin";
                   descript = "Inflicts damage on the first turn
                   then traps the opponent, causing them to lose 1⁄16
                   of their maximum HP after each turn, for 4-5 turns";
                   effect = [Damage(Other, 85, 35, (1,1), Fire, Special)]}

  let flamethrower =
    {actname = "Flamethrower";
     descript = "Deals damage and has 10% chance of burning the target";
     effect = [Damage(Other, 100, 95, (1,1), Fire, Special);
               Status(Other, 10, Burn)]}

  let slash = {actname = "Slash";
               descript = "Deals damage and increase critical hit";
               effect = [Damage(Other, 100, 70, (1,1), Normal, Physical)]}

  let rage =
    {actname = "Rage";
     descript = "Deals damage, raises atk stage";
     effect = [Damage(Other, 100, 20, (1,1), Normal, Physical);
               Buff(Self, 100, ATKBuff 1)]}

  let leer = {actname = "Leer";
              descript = "lowers target defense by one stage";
              effect = [Buff(Other, 100, DEFBuff (-1))]}

  let hydropump = {actname = "hydropump";
              descript = "deals damage";
              effect = [Damage(Other, 80, 110, (1,1), Water, Special)]}

  let skullbash = {actname = "Skull Bash";
              descript = "deals damage";
              effect = [Damage(Other,100, 100, (1,1), Normal, Physical)]}

  let withdraw = {actname = "Withdraw";
              descript = "Raises def by 1 stage";
              effect = [Buff(Self, 100, DEFBuff 1)]}

  let bite = {actname = "Bite";
              descript = "Deals damage";
              effect = [Damage(Other, 100, 60, (1,1), Normal, Physical)]}

  let watergun = {actname = "Water Gun";
              descript = "Deals damage";
              effect = [Damage(Other, 100, 40, (1,1), Water, Special)]}

  let tackle = {actname = "Tackle";
              descript = "deals damage";
              effect = [Damage(Other, 95, 35, (1,1), Normal, Physical)]}

  let stringshot = {actname = "String Shot";
              descript = "slows target speed by one stage";
                    effect = [Buff(Other, 95, SPDBuff (-1))]}

  let harden = {actname = "harden";
              descript = "raise user def by 1";
                effect = [Buff(Other, 100, DEFBuff (-1))]}

  let psybeam =
    {actname = "Psybeam";
     descript = "deals damage and has a 10% chance of confusing the target";
     effect = [Damage(Other, 100, 65, (1,1), Psychic, Special);
               Status(Other, 10, Confused)]}

  let whirlwind = {actname = "Whirlwind";
                descript = "No effect on trainer battle";
                effect = [Nothing]}

  let supersonic = {actname = "Supersonic";
                descript = "Makes the target confused";
                effect = [Status(Other, 55, Confused)]}

  let poison_sting =
    {actname = "Poison Sting";
     descript = "deals damage and has a 30% chance of poisoning the target";
     effect = [Damage(Other, 100, 15, (1,1), Poison, Physical);
               Status(Other, 30, Poisoned)]}

  let agility = {actname = "Agility";
                descript = "Raise user speed by 2 stages";
                effect = [Buff(Self, 100, SPDBuff 2)]}

  let pin_missle = {actname = "Pin Missile";
                descript = "Damage, hits 2-5 times";
                effect = [Damage(Other, 95, 25, (2,5), Bug, Physical)]}

  let twineedle =
    {actname = "Twineedle";
     descript = "Deals damage twice, 20% chance of poisoning";
     effect = [Damage(Other, 100, 25, (2,2), Bug, Physical);
               Status(Other, 20, Poisoned)]}

  let wingattack = {actname = "Wing Attack";
                descript = "Deals damage w/ no additional effect";
                effect = [Damage(Other, 100, 60, (1,1), Flying, Physical)]}

  let quickattack = {actname = "Quick Attack";
                descript = "Deals damage";
                effect = [Damage(Other, 100, 40, (1,1), Normal, Physical)]}

  let hyper_fang =
    {actname = "Hyper Fang";
     descript = "Deals damage and has 10% chance of causing flinch";
     effect = [Damage(Other, 90, 80, (1,1), Normal, Physical);
               Status(Other, 10, Flinch)]}

  let tailwhip = {actname = "Tail Whip";
                descript = "Lowers defense by 1 stage";
                effect = [Buff(Other, 100, DEFBuff (-1))]}

  let drillpeck = {actname = "Drill Peck";
                descript = "deals damage";
                effect = [Damage(Other, 100, 80, (1,1), Flying, Physical)]}

  let furyattack = {actname = "Fury Attack";
                descript = "hits 2-5 times per turn used";
                effect = [Damage(Other, 85, 15, (2,5), Normal, Physical)]}

  let acid = {actname = "Acid";
              descript = "deals damage and has a 10% chance
              of lowering the target's Special Defense by one stage.";
              effect = [Damage(Other, 100, 40, (1,1), Poison, Special)]}

  let screech = {actname = "Screech";
              descript = "Lowers target def by 2 stages";
              effect = [Buff(Other, 85, DEFBuff (-2))]}

  let glare = {actname = "Glare";
              descript = "paralyzes target";
              effect = [Status(Other, 100, Paralyze)]}

  let bite =
    {actname = "Bite";
     descript = "Deals damage and has 30% chance of causing target to flinch";
     effect = [Damage(Other, 100, 60, (1,1), Normal, Physical);
               Status(Other, 30, Flinch)]}

  let thunder =
    {actname = "Thunder";
     descript = "deals damage and has a 30% chance of paralyzing the target";
     effect = [Damage(Other, 70, 110, (1,1), Electric, Special);
               Status(Other, 30, Paralyze)]}

  let swift = {actname = "Swift";
               descript = "deals damage";
               effect = [Damage(Other, 100, 60, (1,1), Normal, Special)]
  }

end

(*Template:
  {poketype = []; name = ""; status = [StatusNone];
  hp = ; atk = (, 0); def = (, 0); spd = (, 0); spatk = (, 0);
  maxhp = ; catch_rate = ;
  actions = [];
  sprite_back = "./PokeSpriteBack/1.png";
  sprite_front = "./PokeSpriteFront/1.png"}
*)

module Pokedex = struct
  open PokeMoves

  let bulbasaur =
    {poketype = [Grass;Poison]; name = "Bulbasaur"; status = [StatusNone];
     hp = 128; atk = (77, 0); def = (77, 0); spd = (73, 0); spatk = (93, 0);
     maxhp = 128; catch_rate = 45; turn_counter = 0;
     actions = [razor_leaf; growth; sleep_powder; solar_beam];
     sprite_back = "./PokeSpriteBack/1.png";
     sprite_front = "./PokeSpriteFront/1.png"}

  let ivysaur =
    {poketype = [Grass;Poison]; name = "Ivysaur"; status = [StatusNone];
     hp = 143; atk = (90, 0); def = (91, 0); spd = (88, 0); spatk = (108, 0);
     maxhp = 143; catch_rate = 45; turn_counter = 0;
     actions = [sleep_powder; growth; razor_leaf; poison_powder];
     sprite_back = "./PokeSpriteBack/2.png";
     sprite_front = "./PokeSpriteFront/2.png"}

  let venusaur =
    {poketype = [Grass;Poison]; name="Venusaur"; status=[StatusNone];
     hp = 163; atk = (110, 0); def = (111, 0); spd = (108, 0); spatk = (128, 0);
     maxhp = 163; catch_rate = 45; turn_counter = 0;
     actions = [growth; razor_leaf; poison_powder; vine_whip];
     sprite_back = "./PokeSpriteBack/3.png";
     sprite_front = "./PokeSpriteBack/3.png"}

  let charmander =
    {poketype = [Fire]; name = "Charmander"; status = [StatusNone];
    hp = 122; atk = (80, 0); def = (71, 0); spd = (93, 0); spatk = (78, 0);
    maxhp = 122; catch_rate = 45; turn_counter = 0;
    actions = [fire_spin; flamethrower; slash; rage];
    sprite_back = "./PokeSpriteBack/4.png";
    sprite_front = "./PokeSpriteFront/4.png"}

  let charmeleon =
    {poketype = [Fire]; name = "Charmeleon"; status = [StatusNone];
    hp = 141; atk = (92, 0); def = (86, 0); spd = (108, 0); spatk = (93, 0);
    maxhp = 141; catch_rate = 45; turn_counter = 0;
    actions = [flamethrower; slash; rage; leer];
    sprite_back = "./PokeSpriteBack/5.png";
    sprite_front = "./PokeSpriteFront/5.png"}

  let charizard =
    {poketype = [Fire;Flying]; name = "Charizard"; status = [StatusNone];
     hp = 161; atk = (112, 0); def = (106, 0); spd = (100, 0); spatk = (113, 0);
     maxhp = 161; catch_rate = 45; turn_counter = 0;
     actions = [flamethrower; slash; rage; leer];
     sprite_back = "./PokeSpriteBack/6.png";
     sprite_front = "./PokeSpriteFront/6.png"}

  let squirtle =
    {poketype = [Water]; name = "Squirtle"; status = [StatusNone];
    hp = 77; atk = (76, 0); def = (93, 0); spd = (71, 0); spatk = (78, 0);
    maxhp = 77; catch_rate = 45; turn_counter = 0;
    actions = [hydropump; skullbash; withdraw; bite];
    sprite_back = "./PokeSpriteBack/7.png";
    sprite_front = "./PokeSpriteFront/7.png"}

  let wartortle =
    {poketype = [Water]; name = "Wartortle"; status = [StatusNone];
    hp = 142; atk = (91, 0); def = (108, 0); spd = (86, 0); spatk = (93, 0);
    maxhp = 142; catch_rate = 45; turn_counter = 0;
    actions = [hydropump; skullbash; withdraw; bite];
    sprite_back = "./PokeSpriteBack/8.png";
    sprite_front = "./PokeSpriteFront/8.png"}

  let blastoise =
    {poketype = [Water]; name = "Blastoise"; status = [StatusNone];
    hp = 162; atk = (111, 0); def = (128, 0); spd = (106, 0); spatk = (113, 0);
    maxhp = 162; catch_rate = 45; turn_counter = 0;
    actions = [skullbash; withdraw; bite; watergun];
    sprite_back = "./PokeSpriteBack/9.png";
    sprite_front = "./PokeSpriteFront/9.png"}

  let caterpie =
    {poketype = [Bug]; name = "Caterpie"; status = [StatusNone];
    hp = 128; atk = (58, 0); def = (63, 0); spd = (73, 0); spatk = (48, 0);
    maxhp = 128; catch_rate = 225; turn_counter = 0;
    actions = [tackle; stringshot];
    sprite_back = "./PokeSpriteBack/10.png";
    sprite_front = "./PokeSpriteFront/10.png"}

  let metapod =
    {poketype = [Bug]; name = "Caterpie"; status = [StatusNone];
    hp = 133; atk = (48, 0); def = (83, 0); spd = (58, 0); spatk = (53, 0);
    maxhp = 133; catch_rate = 120; turn_counter = 0;
    actions = [tackle; stringshot; harden];
    sprite_back = "./PokeSpriteBack/11.png";
    sprite_front = "./PokeSpriteFront/11.png"}

  let butterfree =
    {poketype = [Bug;Flying]; name = "Butterfree"; status = [StatusNone];
    hp = 143; atk = (146, 0); def = (78, 0); spd = (98, 0); spatk = (108, 0);
    maxhp = 143; catch_rate = 120; turn_counter = 0;
    actions = [psybeam;whirlwind;supersonic;sleep_powder];
    sprite_back = "./PokeSpriteBack/12.png";
    sprite_front = "./PokeSpriteFront/12.png"}

  let weedle =
    {poketype = [Bug;Poison]; name = "Weedle"; status = [StatusNone];
    hp = 123; atk = (63, 0); def = (58, 0); spd = (78, 0); spatk = (48, 0);
    maxhp = 123; catch_rate = 255; turn_counter = 0;
    actions = [stringshot; poison_sting];
    sprite_back = "./PokeSpriteBack/13.png";
    sprite_front = "./PokeSpriteFront/13.png"}

  let kakuna =
    {poketype = [Bug;Poison]; name = "Kakuna"; status = [StatusNone];
    hp = 128; atk = (53, 0); def = (78, 0); spd = (63, 0); spatk = (53, 0);
    maxhp = 128; catch_rate = 120; turn_counter = 0;
    actions = [stringshot; poison_sting; harden];
    sprite_back = "./PokeSpriteBack/14.png";
    sprite_front = "./PokeSpriteFront/14.png"}

  let beedrill =
    {poketype = [Bug;Poison]; name = "Beedrill"; status = [StatusNone];
    hp = 148; atk = (108, 0); def = (68, 0); spd = (103, 0); spatk = (73, 0);
    maxhp = 148; catch_rate = 45; turn_counter = 0;
    actions = [agility; pin_missle; rage; twineedle];
    sprite_back = "./PokeSpriteBack/15.png";
    sprite_front = "./PokeSpriteFront/15.png"}

  let pidgey =
    {poketype = [Normal; Flying]; name = "Pidgey"; status = [StatusNone];
    hp = 123; atk = (73, 0); def = (68, 0); spd = (84, 0); spatk = (63, 0);
    maxhp = 123; catch_rate = 255; turn_counter = 0;
    actions = [agility; whirlwind; quickattack; wingattack];
    sprite_back = "./PokeSpriteBack/16.png";
    sprite_front = "./PokeSpriteFront/16.png"}

  let pidgeotto =
    {poketype = [Normal; Flying]; name = "Pidgeotto"; status = [StatusNone];
    hp = 146; atk = (88, 0); def = (83, 0); spd = (99, 0); spatk = (78, 0);
    maxhp = 146; catch_rate = 255; turn_counter = 0;
    actions = [agility; wingattack; whirlwind; quickattack];
    sprite_back = "./PokeSpriteBack/17.png";
    sprite_front = "./PokeSpriteFront/17.png"}

  let pidgeot =
    {poketype = [Normal; Flying]; name = "Pidgeotto"; status = [StatusNone];
    hp = 166; atk = (108, 0); def = (103, 0); spd = (119, 0); spatk = (98, 0);
    maxhp = 166; catch_rate = 45; turn_counter = 0;
    actions = [agility; wingattack; whirlwind; quickattack];
    sprite_back = "./PokeSpriteBack/18.png";
    sprite_front = "./PokeSpriteFront/18.png"}

  let rattata =
    {poketype = [Normal]; name = "Rattata"; status = [StatusNone];
    hp = 113; atk = (84, 0); def = (63, 0); spd = (100, 0); spatk = (53, 0);
    maxhp = 113; catch_rate = 255; turn_counter = 0;
    actions = [hyper_fang; quickattack; tackle; tailwhip];
    sprite_back = "./PokeSpriteBack/19.png";
    sprite_front = "./PokeSpriteFront/19.png"}

  let raticate =
    {poketype = [Normal]; name = "Raticate"; status = [StatusNone];
    hp = 138; atk = (109, 0); def = (88, 0); spd = (125, 0); spatk = (78, 0);
    maxhp = 138; catch_rate = 127; turn_counter = 0;
    actions = [tackle; hyper_fang; quickattack; tailwhip];
    sprite_back = "./PokeSpriteBack/20.png";
    sprite_front = "./PokeSpriteFront/20.png"}

  let spearow =
    {poketype = [Normal; Flying]; name = "Spearow"; status = [StatusNone];
    hp = 123; atk = (88, 0); def = (58, 0); spd = (98, 0); spatk = (59, 0);
    maxhp = 123; catch_rate = 255; turn_counter = 0;
    actions = [agility; drillpeck; furyattack; leer];
    sprite_back = "./PokeSpriteBack/21.png";
    sprite_front = "./PokeSpriteFront/21.png"}

  let fearow =
    {poketype = [Normal; Flying]; name = "Fearow"; status = [StatusNone];
    hp = 148; atk = (118, 0); def = (93, 0); spd = (128, 0); spatk = (89, 0);
    maxhp = 148; catch_rate = 90; turn_counter = 0;
    actions = [agility; drillpeck; furyattack; leer];
    sprite_back = "./PokeSpriteBack/22.png";
    sprite_front = "./PokeSpriteFront/22.png"}

  let ekans =
    {poketype = [Poison]; name = "Ekans"; status = [StatusNone];
    hp = 118; atk = (88, 0); def = (72, 0); spd = (83, 0); spatk = (68, 0);
    maxhp = 118; catch_rate = 255; turn_counter = 0;
    actions = [acid; screech; glare; bite];
    sprite_back = "./PokeSpriteBack/23.png";
    sprite_front = "./PokeSpriteFront/23.png"}

  let arbok =
    {poketype = [Poison]; name = "Arbok"; status = [StatusNone];
    hp = 143; atk = (113, 0); def = (97, 0); spd = (108, 0); spatk = (93, 0);
    maxhp = 143; catch_rate = 90; turn_counter = 0;
    actions = [acid; screech; glare; bite];
    sprite_back = "./PokeSpriteBack/24.png";
    sprite_front = "./PokeSpriteFront/24.png"}

  let pikachu =
    {poketype = [Electric]; name = "Pikachu"; status = [StatusNone];
     hp = 118; atk = (83, 0); def = (58, 0); spd = (90, 0); spatk = (78, 0);
     maxhp = 118; catch_rate = 190;  turn_counter = 0;
     actions = [thunder; agility; swift; quickattack];
     sprite_back = "./PokeSpriteBack/25.png";
     sprite_front = "./PokeSpriteFront/25.png"}

  let raichu =
    {poketype = [Electric]; name = "Raichu"; status = [StatusNone];
     hp = 143; atk = (118, 0); def = (83, 0); spd = (118, 0); spatk = (130, 0);
     maxhp = 143; catch_rate = 190;  turn_counter = 0;
     actions = [thunder; agility; swift; quickattack];
     sprite_back = "./PokeSpriteBack/26.png";
     sprite_front = "./PokeSpriteFront/26.png"}


  let pokedex =
  [("1", bulbasaur); ("2", ivysaur); ("3", venusaur); ("4", charmander);
   ("5", charmeleon); ("6", charizard); ("7", squirtle); ("8", wartortle);
   ("9", blastoise); ("10", caterpie); ("11", metapod); ("12", butterfree);
   ("13", weedle); ("14", kakuna); ("15", beedrill); ("16", pidgey);
   ("17", pidgeotto); ("18", pidgeot); ("19", rattata); ("20", raticate);
   ("21", spearow); ("22", fearow);("23", ekans);("24", arbok);("25", pikachu);
   ("26", raichu)
  ]
end

module Inventory = struct
  let antidote =
    {itemname = "Antidote"; descript = "Heals pokemon from poisoning";
     itemeffect = [Special(Self, 100, HealStatus(Poisoned), Nothing)];
     quantity = 1}

  let awakening =
    {itemname = "Awakening"; descript = "Wakes pokemon from sleep";
     itemeffect = [Special(Self, 100, HealStatus(Sleep), Nothing)];
     quantity = 1}

  let burnheal =
    {itemname = "Burn Heal"; descript = "Heals a burned pokemon";
     itemeffect = [Special(Self, 100, HealStatus(Burn), Nothing)];
     quantity = 1}

  let freshwater =
    {itemname = "Fresh Water";
     descript = "Water with high mineral content, +50 HP";
     itemeffect = [Heal(Self, 100, 60)]; quantity = 1}

  let hyperpotion = {itemname = "Hyper Potion"; descript = "HP +200 pts";
                     itemeffect = [Heal(Self, 100, 200)]; quantity = 1}

  let iceheal =
    {itemname = "Ice Heal"; descript = "Heal a frozen pokemon";
     itemeffect = [Special(Self, 100, HealStatus(Frozen), Nothing)];
     quantity = 1}

  let lemonade = {itemname = "Lemonade"; descript = "HP +80 pts";
                  itemeffect = [Heal(Self, 100, 80)]; quantity = 1}

  let paralyzeheal =
    {itemname = "Paralyze Heal"; descript = "Heal a paralyzed pokemon";
     itemeffect = [Special(Self, 100, HealStatus(Paralyze), Nothing)];
     quantity = 1}

  let direhit = {itemname = "Dire Hit"; descript = "Makes a pokemon focused";
                 itemeffect = [Status(Self, 100, Focused)]; quantity = 1}

  let fullheal =
    {itemname = "Full Heal"; descript = "Heals all nonvolatile status";
     itemeffect = [Special(Self, 100, HealStatus(Poisoned), Nothing);
                   Special(Self, 100, HealStatus(Paralyze), Nothing);
                   Special(Self, 100, HealStatus(Sleep), Nothing);
                   Special(Self, 100, HealStatus(Burn), Nothing);
                   Special(Self, 100, HealStatus(Frozen), Nothing)];
     quantity = 1}

  let fullrestore =
    {itemname = "Full Restore";
     descript = "Heals all nonvolatile status and restore full hp";
     itemeffect = [Heal(Self, 100, 1000);
                   Special(Self, 100, HealStatus(Poisoned), Nothing);
                   Special(Self, 100, HealStatus(Paralyze), Nothing);
                   Special(Self, 100, HealStatus(Sleep), Nothing);
                   Special(Self, 100, HealStatus(Burn), Nothing);
                   Special(Self, 100, HealStatus(Frozen), Nothing)];
     quantity = 1}


  let maxpotion = {itemname = "Max Potion"; descript = "Restores full hp";
                   itemeffect = [Heal(Self, 100, 1000)]; quantity = 1}

  let pokeflute =
    {itemname = "Poke Flute"; descript = "Wake up sleeping pokemon";
     itemeffect = [Special(Self, 100, HealStatus(Sleep), Nothing)]; quantity =1}

  let potion = {itemname = "Potion"; descript = "Heal +20 hp";
                itemeffect = [Heal(Self, 100, 20)]; quantity =1}

  let revive =
    {itemname = "Revive";
     descript = "Revive a fainted pokemon and restore half of its hp";
     itemeffect = [Special(Self, 100, Revive, Nothing)]; quantity = 1}

  let sodapop = {itemname = "Soda Pop"; descript = "Heal +60 hp";
                 itemeffect = [Heal(Self, 100, 60)]; quantity =1}

  let superpotion = {itemname = "Super Potion"; descript = "Heal +50 hp";
                     itemeffect = [Heal(Self, 100, 50)]; quantity = 1}

  let xattack = {itemname = "X Attack"; descript = "Raises attack by 1 level";
                 itemeffect=[Buff(Self, 100, ATKBuff 1)]; quantity =1}

  let xdefense =
    {itemname = "X Defense"; descript = "Raises defense by 1 level";
     itemeffect=[Buff(Self, 100, DEFBuff 1)]; quantity = 1}

  let xspecial =
    {itemname = "X Special"; descript = "Raises special by 1 level";
     itemeffect = [Buff(Self, 100, SpatkBuff 1)]; quantity =1}

  let xspeed = {itemname = "X Speed"; descript = "Raises speed by 1 level";
                itemeffect = [Buff(Self, 100, SPDBuff 1)]; quantity =1}

  let inv = [(0,antidote);(1,awakening);(2,burnheal);(3,freshwater);
             (4,hyperpotion); (5,iceheal);(6, lemonade); (7, paralyzeheal);
             (8, direhit); (9, fullheal); (10, fullrestore); (11, xspeed);
             (12, maxpotion); (13, pokeflute); (14, potion); (15, revive);
             (16, sodapop); (17, superpotion); (18, xattack); (19, xdefense);
             (20, xspecial)]
end



let ptype poke = poke.poketype

let name poke = poke.name

let hp poke = poke.hp

let atk poke = poke.atk

let def poke = poke.def

let spd poke = poke.spd

let spatk poke = poke.spatk

let maxhp poke = poke.maxhp

let catch_rate poke = poke.catch_rate

let sprite_front poke = poke.sprite_front

let sprite_back poke = poke.sprite_back

let status poke = poke.status

let turns poke = poke.turn_counter

let decre_turn poke =
  {poketype = poke.poketype; name = poke.name; status = poke.status;
   hp = poke.hp; atk = poke.atk; def = poke.def;
   spd = poke.spd; spatk = poke.spatk; maxhp = poke.maxhp;
   catch_rate = poke.catch_rate; turn_counter = max 0 (poke.turn_counter -1);
   actions = poke.actions; sprite_back = poke.sprite_back;
   sprite_front = poke.sprite_front}

let set_count poke i =
  {poketype = poke.poketype; name = poke.name; status = poke.status;
   hp = poke.hp; atk = poke.atk; def = poke.def;
   spd = poke.spd; spatk = poke.spatk; maxhp = poke.maxhp;
   catch_rate = poke.catch_rate; turn_counter = i;
   actions = poke.actions; sprite_back = poke.sprite_back;
   sprite_front = poke.sprite_front}

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

let rec parse_item_names lst ind acc =
  match lst with
  | [] -> acc
  | h::t -> parse_item_names t (ind+1) (acc@[ind, h.itemname])

let inv_names inv =
  parse_item_names inv 1 []

let rec clear_helper stats stat acc =
  match stats with
  | [] -> if acc == [] then [StatusNone] else acc
  | h::t -> if h = stat then acc@t else clear_helper stats stat (h::acc)

let clear_stat poke stat =
  {poketype = poke.poketype; name = poke.name;
   status = clear_helper poke.status stat [];
   hp = poke.hp; atk = poke.atk; def = poke.def;
   spd = poke.spd; spatk = poke.spatk; maxhp = poke.maxhp;
   catch_rate = poke.catch_rate; turn_counter = poke.turn_counter;
   actions = poke.actions; sprite_back = poke.sprite_back;
   sprite_front = poke.sprite_front}

let build_poke s =
  match List.assoc_opt s Pokedex.pokedex with
  | Some p -> p
  | None -> failwith "A pokemon with this index does not exist"

let random_poke () =
  let len = List.length Pokedex.pokedex in
  let rand = (Random.int len) in
  let index = fst (List.nth Pokedex.pokedex rand) in
  build_poke index

let build_inventory poke =
  let r1 = Random.int 21 in
  let r2 = Random.int 21 in
  let r3 = Random.int 21 in
  let r4 = Random.int 21 in
  let i1 = List.assoc r1 Inventory.inv in
  let i2 = List.assoc r2 Inventory.inv in
  let i3 = List.assoc r3 Inventory.inv in
  let i4 = List.assoc r4 Inventory.inv in
  [i1; i2; i3; i4]

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


let poke_spd_buff poke i=
  if i < 0 then
    {poketype = poke.poketype; name = poke.name; status = poke.status;
     hp = poke.hp; atk = poke.atk; def = poke.def;
     spd = (fst(poke.spd), (max (-6) (snd poke.spd)+i));
     spatk = poke.spatk; maxhp = poke.maxhp;
     catch_rate = poke.catch_rate; turn_counter = poke.turn_counter;
     actions = poke.actions; sprite_back = poke.sprite_back;
     sprite_front = poke.sprite_front}
  else
    {poketype = poke.poketype; name = poke.name; status = poke.status;
     hp = poke.hp; atk = poke.atk; def = poke.def;
     spd = (fst(poke.spd), (min (6) (snd poke.spd)+i));
     spatk = poke.spatk; maxhp = poke.maxhp;
     catch_rate = poke.catch_rate; turn_counter = poke.turn_counter;
     actions = poke.actions;
     sprite_back = poke.sprite_back; sprite_front = poke.sprite_front}

let poke_atk_buff poke i =
  if i < 0 then
    {poketype = poke.poketype; name = poke.name; status = poke.status;
     hp = poke.hp;
     atk = (fst(poke.atk), (max (-6) (snd poke.atk)+i)); def = poke.def;
     spd = poke.spd; spatk = poke.spatk;
     maxhp = poke.maxhp; catch_rate = poke.catch_rate;
     turn_counter = poke.turn_counter;
     actions = poke.actions; sprite_back = poke.sprite_back;
     sprite_front = poke.sprite_front}
  else
    {poketype = poke.poketype; name = poke.name;
     status = poke.status; hp = poke.hp;
     atk = (fst(poke.atk), (min (6) (snd poke.atk)+i)); def = poke.def;
     spd = poke.spd; spatk = poke.spatk;
     maxhp = poke.maxhp; catch_rate = poke.catch_rate;
     turn_counter = poke.turn_counter;
     actions = poke.actions; sprite_back = poke.sprite_back;
     sprite_front = poke.sprite_front}

let poke_def_buff poke i =
    if i < 0 then
      {poketype = poke.poketype; name = poke.name;
       status = poke.status; hp = poke.hp;
       atk = poke.atk; def = (fst(poke.def), (max (-6) (snd poke.def)+i));
       spd = poke.spd; spatk = poke.spatk;
       maxhp = poke.maxhp; catch_rate = poke.catch_rate;
       turn_counter = poke.turn_counter;
      actions = poke.actions; sprite_back = poke.sprite_back;
      sprite_front = poke.sprite_front}
    else
      {poketype = poke.poketype; name = poke.name;
       status = poke.status; hp = poke.hp;
       atk = poke.atk; def = (fst(poke.def),(min (6) (snd poke.def)+i));
       spd = poke.spd; spatk = poke.spatk;
       maxhp = poke.maxhp; catch_rate = poke.catch_rate;
       turn_counter = poke.turn_counter;
       actions = poke.actions; sprite_back = poke.sprite_back;
       sprite_front = poke.sprite_front}

let poke_spatk_buff poke i =
  if i < 0 then
    {poketype = poke.poketype; name = poke.name;
     status = poke.status; hp = poke.hp;
     atk = poke.atk; def = poke.def;
     spd = poke.spd; spatk = (fst(poke.spatk), (max (-6) (snd poke.spatk)+i));
     maxhp = poke.maxhp; catch_rate = poke.catch_rate;
     turn_counter = poke.turn_counter;
     actions = poke.actions; sprite_back = poke.sprite_back;
     sprite_front = poke.sprite_front}
  else
    {poketype = poke.poketype; name = poke.name;
     status = poke.status; hp = poke.hp;
     atk = poke.atk; def = (fst(poke.spatk),(min (6) (snd poke.spatk)+i));
     spd = poke.spd; spatk = poke.spatk;
     maxhp = poke.maxhp; catch_rate = poke.catch_rate;
     turn_counter = poke.turn_counter;
     actions = poke.actions; sprite_back = poke.sprite_back;
     sprite_front = poke.sprite_front}

let poke_heal poke pts =
  {poketype = poke.poketype; name = poke.name; status = poke.status;
   hp = (min (poke.hp+pts) poke.maxhp);
   atk = poke.atk; def = poke.def;
   spd = poke.spd; spatk = poke.spatk;
   maxhp = poke.maxhp; catch_rate = poke.catch_rate;
   turn_counter = poke.turn_counter;
   actions = poke.actions;
   sprite_back = poke.sprite_back;
   sprite_front = poke.sprite_front}

(*Calculate the largest possible effectiveness*)
let rec type_eff mtype lst acc =
  match lst with
  | [] -> acc
  | h::t -> let nspat = type_compare mtype h in
            if nspat >= acc then type_eff mtype t nspat
            else type_eff mtype t acc


let poke_damage poke1 poke2 pts mtype cat =
  let astage = begin
              match cat with
              | Physical -> float_of_int (snd poke2.atk)
              | Special -> float_of_int (snd poke2.spatk)
            end in
  let apower = begin
              match cat with
              | Physical -> float_of_int (fst poke2.atk)
              | Special -> float_of_int (fst poke2.spatk)
            end in
  let amul = max (2.0) (2.0 +. astage) /. max (2.0) (2.0 -. astage) in
  let atk = apower *. amul in
  let dstage = float_of_int (snd poke1.def) in
  let dmul = max (2.0) (2.0 +. dstage) /. max (2.0) (2.0 -. dstage) in
  let def = float_of_int (fst(poke1.def)) *. dmul in
  let eff = type_eff mtype poke1.poketype 0. in
  let damage = int_of_float (((2.0 *. 50.0 /. 5.0) +. 2.0) *. atk *.
                             (float_of_int pts) /. def /. 50.0 *. eff) in

  {poketype = poke1.poketype; name = poke1.name;
   status = poke1.status;
   hp = (max (poke1.hp-damage) 0);
   atk = poke1.atk; def = poke1.def;
   spd = poke1.spd; spatk = poke1.spatk;
   maxhp = poke1.maxhp;
   catch_rate = poke1.catch_rate;
   turn_counter = poke1.turn_counter;
   actions = poke1.actions;
   sprite_back = poke1.sprite_back;
   sprite_front = poke1.sprite_front}

let overlap_stats s =
  match s with
  | Sleep -> true
  | Paralyze -> true
  | Burn -> true
  | Frozen -> true
  | Poisoned -> true
  | Toxic -> true
  | Substitute -> true
  | _ -> false

let rec check_overlaps lst s =
  if not (overlap_stats s) then false else
  match lst with
  | [] -> false
  | h::t -> if overlap_stats h then true
            else check_overlaps t s

(*let get_turns s =
  match s with
  | Confused -> 4
  | Sleep -> Random.int 8*)

let poke_change_status poke s =
  match poke.status, s with
  | [], _ -> failwith "status should not be empty"
  | h::t, _ -> begin
             match h, s with
          | _, Substitute ->
            {poketype = poke.poketype; name = poke.name; status = s::poke.status;
             hp = poke.hp/4*3; atk = poke.atk; def = poke.def;
             spd = poke.spd; spatk = poke.spatk; maxhp = poke.maxhp;
             catch_rate = poke.catch_rate; turn_counter = poke.turn_counter;
             actions = poke.actions; sprite_back = poke.sprite_back;
             sprite_front = poke.sprite_front}
          | StatusNone, _ ->
            {poketype = poke.poketype; name = poke.name; status = [s];
             hp = poke.hp; atk = poke.atk; def = poke.def;
             spd = poke.spd; spatk = poke.spatk; maxhp = poke.maxhp;
             catch_rate = poke.catch_rate; turn_counter = poke.turn_counter;
             actions = poke.actions; sprite_back = poke.sprite_back;
             sprite_front = poke.sprite_front}
          | _, StatusNone ->
            {poketype = poke.poketype; name = poke.name; status = [s];
             hp = poke.hp; atk = poke.atk; def = poke.def;
             spd = poke.spd; spatk = poke.spatk; maxhp = poke.maxhp;
             catch_rate = poke.catch_rate; turn_counter = poke.turn_counter;
             actions = poke.actions; sprite_back = poke.sprite_back;
             sprite_front = poke.sprite_front}
          | _, _ ->
            if check_overlaps poke.status s then poke
            else
              {poketype = poke.poketype; name = poke.name;
               status = s::poke.status;
               hp = poke.hp; atk = poke.atk; def = poke.def;
               spd = poke.spd; spatk = poke.spatk; maxhp = poke.maxhp;
               catch_rate = poke.catch_rate; turn_counter = poke.turn_counter;
               actions = poke.actions; sprite_back = poke.sprite_back;
               sprite_front = poke.sprite_front}
            end


let revive_poke poke =
  let newhp = poke.maxhp/2 in
  {poketype = poke.poketype; name = poke.name; status = poke.status;
   hp = newhp; atk = poke.atk; def = poke.def;
   spd = poke.spd; spatk = poke.spatk; maxhp = poke.maxhp;
   catch_rate = poke.catch_rate; turn_counter = poke.turn_counter;
   actions = poke.actions;
   sprite_back = poke.sprite_back;
   sprite_front = poke.sprite_front}

let rec match_type lst s =
  match lst with
  | [] -> false
  | h::t -> match h, s with
           | Fire, Burn -> true
           | Poison, Poisoned -> true
           | Ice, Frozen -> true
           | Grass, LeechSeed -> true
           | _, Substitute -> true
           | _, _ -> false

let rec check_status_help lst s =
  match lst with
  | [] -> false
  | h::t -> if h = s then true else check_status_help t s

let check_status poke s =
  check_status_help poke.status s

let poke_effect poke1 poke2 effect =
  match effect with
  | Switch _ -> failwith "should not reach"
  | Heal (s, i1, i2) ->  poke_heal poke1 i2
  | Damage (s, i1, i2, (r1, r2), t, c) ->
    if check_status poke1 Substitute then poke1
    else poke_damage poke1 poke2 i2 t c
  | Buff (s, i1, b) -> begin
      match b with
      | ATKBuff i -> poke_atk_buff poke1 i
      | DEFBuff i -> poke_def_buff poke1 i
      | SPDBuff i -> poke_spd_buff poke1 i
      | SpatkBuff i -> poke_spatk_buff poke1 i
    end
  | Special (s,i,p,e) -> begin
      match p with
      | HealStatus stat -> clear_stat poke1 stat
      | Revive -> revive_poke poke1
    end
  | Status (_,_,s) -> if match_type poke1.poketype s then poke1 else
                         poke_change_status poke1 s
  | Nothing -> poke1

let clear_buff poke =
  {poketype = poke.poketype;
  name = poke.name;
  status = poke.status;
  hp = poke.hp;
  atk = (fst(poke.atk), 0);
  def = (fst(poke.def), 0);
  spd = (fst(poke.spd), 0);
  spatk = (fst(poke.spatk),0);
  maxhp = poke.maxhp;
  catch_rate = poke.catch_rate;
  turn_counter = poke.turn_counter;
  actions = poke.actions;
  sprite_back = poke.sprite_back;
  sprite_front = poke.sprite_front}

let item_use_combat item =
  if item.itemeffect = [] then None
  else Some (CombatAction item.itemeffect)

(* Gets the pokedex key corresponding to poke.
Requires poke to be in pokedex.*)
let get_pokedex_number poke =
  let open Pokedex in
  let op (elt_key, elt_poke) =
    (name poke) = (name elt_poke) in
  let filtered = List.filter op pokedex in
  match filtered with
  | [] -> failwith "unreachable: precondition failrure"
  | (key, _)::_ -> key

(* Gets the keys of pokedex *)
let get_pokedex_keys = List.map fst Pokedex.pokedex
