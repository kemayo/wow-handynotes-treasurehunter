local myname, ns = ...

ns.map_questids = {
    [525] = 34557, -- FrostfireRidge
    [534] = 39463, -- TanaanJungle
    [535] = 36466, -- Talador
    [539] = 36464, -- ShadowmoonValleyDR
    [542] = 36467, -- SpiresOfArak
    [543] = 36465, -- Gorgrond
    [550] = 36468, -- NagrandDraenor
}

ns.RegisterPoints(572, {}) -- continent
ns.RegisterPoints(550, { -- NagrandDraenor
    -- steamwheedle supplies
    [50108220]={ quest=35577, label="Steamwheedle Supplies", note="Use a glider", currency=824, },
    [52708010]={ quest=35583, label="Steamwheedle Supplies", note="Use a glider", currency=824, },
    [64601760]={ quest=35648, label="Steamwheedle Supplies", note="Use a glider", currency=824, },
    [70601860]={ quest=35646, label="Steamwheedle Supplies", note="Use a glider", currency=824, },
    [77805190]={ quest=35591, label="Steamwheedle Supplies", note="Use a glider", currency=824, },
    [87602030]={ quest=35662, label="Steamwheedle Supplies", note="Use a glider", currency=824, },
    [88204260]={ quest=35616, label="Steamwheedle Supplies", note="Use a glider", currency=824, },
    -- abu'gar
    [38404940]={ quest=36711, loot={114245}, label="Abu'Gar's Favorite Lure, won't show complete until you get Abu'Gar", }, -- 36072
    [65906120]={ quest=36711, loot={114242}, label="Abu'gar's Vitality, won't show complete until you get Abu'Gar", }, -- 35711
    [85403870]={ quest=36711, loot={114243}, label="Abu'gar's Missing Reel, won't show complete until you get Abu'Gar", }, -- 36089
    -- glider-required
    [70501390]={ quest=35643, label="Mountain Climber's Pack", note="Use a glider", currency=824, },
    [73007040]={ quest=35678, label="Warsong Lockbox", note="Use a glider", currency=824, },
    [76107000]={ quest=35682, loot={118678}, label="Warsong Spear, use a glider", },
    [80606060]={ quest=35593, label="Warsong Spoils", note="Use a glider", currency=824, },
    [81103720]={ quest=35661, loot={118262}, label="Brilliant Dreampetal, use a glider", },
    [87504500]={ quest=35622, label="Hidden Stash", currency=824, note="Use a glider", },
    [88901820]={ quest=35660, label="Fungus-Covered Chest", note="Use a glider", currency=824, },
    -- generic garrison supplies
    [37707060]={ quest=34760, label="Treasure of Kull'krosh", currency=824, },
    [40406860]={ quest=37435, label="Spirit Coffer", currency=824, junk=true, },
    [43305750]={ quest=35987, label="Genedar Debris", currency=824, },
    [44606750]={ quest=36002, label="Genedar Debris", currency=824, },
    [47207430]={ quest=35576, label="Goblin Pack", currency=824, },
    [48006010]={ quest=35999, label="Genedar Debris", currency=824, },
    [48607270]={ quest=36008, label="Genedar Debris", currency=824, },
    [51706030]={ quest=35695, label="Warsong Cache", currency=824, },
    [55306820]={ quest=36011, label="Genedar Debris", currency=824, },
    [56607290]={ quest=36050, label="Adventurer's Pouch", currency=824, },
    [73001090]={ quest=35951, label="A Pile of Dirt", note="Jump down", currency=824, },
    [73006220]={ quest=35590, label="Goblin Pack", currency=824, },
    [73107550]={ quest=35673, label="Appropriated Warsong Supplies", currency=824, },
    [77101660]={ quest=36174, label="Bounty of the Elements", currency=824, note="Cave, use the Elemental Stones for access", },
    [89103310]={ quest=36857, label="Smuggler's Cache", note="In a cave, dodge the tripwires", currency=824, },
    [89406580]={ quest=35976, label="Warsong Supplies", currency=824, },
    -- treasures
    [38305880]={ quest=36109, label="Goldtoe's Plunder", npc=84068, loot={114054}, note="Gold, parrot has the key", },
    [45605200]={ quest=35969, label="Adventurer's Pack", note="Gold, random green", },
    [45806630]={ quest=36020, loot={117981}, label="Fragment of Oshu'gun", },
    [50006650]={ quest=35579, loot={118264}, label="Void-Infused Crystal", },
    [52404440]={ quest=36073, loot={118250}, label="Warsong Helm", },
    [53406430]={ quest=36088, label="Adventurer's Pouch", note="Random green, in the cave", }, -- todo: confirm location
    [57806220]={ quest=36115, loot={118278}, label="Pale Elixir", },
    [58205260]={ quest=35694, loot={118266}, label="Golden Kaliri Egg", },
    [58305940]={ quest=36021, loot={116688}, label="Pokkar's Thirteenth Axe", },
    [61805740]={ quest=36082, label="Lost Pendant", note="Green amulet", },
    [62506710]={ quest=36116, label="Bag of Herbs", note="Assorted herbs", },
    [64703580]={ quest=36071, loot={118235}, label="Watertight Bag", },
    [64706580]={ quest=36046, loot={118253}, label="Telaar Defender Shield", },
    [66901950]={ quest=35954, loot={118234}, label="Elemental Offering, jump down", },
    [67404900]={ quest=36039, loot={118252}, label="Highmaul Sledge", },
    [67605980]={ quest=35759, label="Abandoned Cargo", note="Gold, random green", },
    [69905240]={ quest=35597, label="Adventurer's Pack", note="Gold, random green", },
    [72706100]={ quest=36035, loot={118254}, note="Polished Saberon Skull", label="Circuitous path up the cliff from in Sabermaw, past the Adventuer's Mace", },
    [73102160]={ quest=35692, loot={118233}, label="Freshwater Clam", },
    [73901410]={ quest=35955, label="Adventurer's Sack", note="Gold", },
    [75206500]={ quest=36102, label="Saberon Stash", note="Gold, jump down", },
    [75306570]={ quest=36099, loot={61986}, label="Important Exploration Supplies", },
    [75404710]={ quest=36074, loot={118236}, label="Gambler's Purse", },
    [75806200]={ quest=36077, label="Adventurer's Mace", note="Gold, green mace; circuitous path up the cliff from in Sabermaw", },
    [77302820]={ quest=35986, loot={116760}, label="Bone-Carved Dagger", },
    [78901550]={ quest=36036, loot={118251}, label="Elemental Shackles", },
    [81007980]={ quest=36049, loot={118255}, label="Ogre Beads", },
    [81501300]={ quest=35953, loot={116640}, label="Adventurer's Staff", },
    [82305660]={ quest=35765, label="Adventurer's Pack", note="Gold, random green", },
    [85405340]={ quest=35696, label="Burning Blade Cache", note="In tower, jump from cliff", },
    [87107290]={ quest=36051, loot={118054}, label="Grizzlemaw's Bonepile", },
    -- followers
    [40307610]={ quest=35596, follower=170, label="Kill Bolkar nearby to get the key", }, -- Goldmane
    [46401600]={ quest=34466, follower=190, label="Mysterious Staff; collect all the Mysterious items across Draenor", }, -- Archmage Vargoth
    [67205600]={ quest=36711, npc=82746, follower=209, label="Rebuild his fishing rod by gathering the pieces @ 38.4,49.3, 65.8,61.1, 85.4,38.7", }, -- Abu'gar
    -- pepe!
    [80105040]={ quest=39265, loot={127865}, achievement=10053, }, -- Viking Pepe
    -- Voidtalon
    [57302670]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
    [45903140]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
    [40504750]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
})
--[[
-- TODO: need the name
["ACaveInNagrand"] = {
    [66305730]={ quest=36088, label="Adventurer's Pouch", note="Random green", },
}
-- "Vault of the Titan"
["StonecragGorge"] = {
}
--]]
ns.RegisterPoints(539, { -- ShadowmoonValleyDR
    -- garrison-y
    [27100260]={ quest=35280, currency=824, label="Stolen Treasure", },
    [26500570]={ quest=34174, currency=824, label="Fantastic Fish", },
    -- [28800710]={ quest=35279, currency=824, label="Sunken Treasure", }, -- bugged for years
    [30301990]={ quest=35530, currency=824, label="Lunarfall Egg", note="Moves to the garrison once built", faction="Alliance", },
    [45802460]={ quest=33570, currency=824, label="Shadowmoon Exile Treasure", note="cave below Exile Rise", },
    [52902490]={ quest=37254, currency=824, label="Mushroom-Covered Chest", },
    [57904530]={ quest=33568, currency=824, label="Kaliri Egg", },
    [28303930]={ quest=33883, currency=824, label="Shadowmoon Treasure", },
    [42106130]={ quest=33041, currency=824, label="Iron Horde Cargo Shipment", },
    [84504470]={ quest=33885, currency=824, label="Cargo of the Raven Queen", },
    -- treasures
    [20303060]={ quest=33575, loot={108904}, label="Demonic Cache", },
    [22803390]={ quest=33572, loot={113373}, label="Rotting Basket", },
    [29803750]={ quest=36879, label="Dusty Lockbox", note="On top of the standing stones; some random greens", },
    [30004530]={ quest=35919, loot={113563}, label="Shadowmoon Sacrificial Dagger", },
    [31303910]={ quest=33886, loot={109081}, label="Ronokk's Belongings", },
    [33503970]={ quest=33569, loot={113545}, label="Reusable mana potion", },
    [34204350]={ quest=33866, loot={109124}, label="Veema's Herb Bag, underground", },
    [34404620]={ quest=33891, loot={108901}, label="Giant Moonwillow Cone", },
    [35904090]={ quest=33540, loot={113546}, label="Uzko's Knickknacks", },
    [36704450]={ quest=33573, loot={113378}, },
    [36804140]={ quest=33046, loot={113547}, label="Beloved's Offering, offhand decoration", },
    [37202310]={ quest=33613, loot={108945}, label="in cave, Bubbling Cauldron", },
    [37202610]={ quest=35677, loot={110506}, label="Sunken Fishing Boat, fishy fun items", },
    [37505930]={ quest=33567, loot={108903}, label="Iron Horde Tribute", },
    [37704430]={ quest=33584, loot={113531}, label="Consumable: Rested XP", },
    [38504300]={ quest=33614, loot={113408}, label="Greka's Urn", },
    [39208380]={ quest=33566, loot={113372}, label="Waterlogged Chest", },
    [41502790]={ quest=33869, loot={108902}, label="Armored Elekk Tusk", },
    [43806060]={ quest=33611, loot={107650}, label="Peaceful Offering", },
    [44505920]={ quest=33612, loot={107650}, label="Peaceful Offering", },
    [44506350]={ quest=33384, loot={107650}, label="Peaceful Offering", },
    [45206050]={ quest=33610, loot={107650}, label="Peaceful Offering", },
    [47104610]={ quest=33564, loot={108900}, label="Hanging Satchel", },
    [48704750]={ quest=35798, loot={109130}, label="Glowing Cave Mushroom", },
    [49303750]={ quest=33867, loot={109739}, label="Astrologer's Box", toy=true, },
    [51107910]={ quest=33574, loot={113375}, label="Vindicator's Cache", toy=true, },
    [51803550]={ quest=33037, label="False-Bottomed Jar", note="Gold", junk=true, },
    [52804840]={ quest=35584, loot={113560}, label="Ancestral Greataxe, against the grave", },
    [55004500]={ quest=35581, loot={109124}, label="Alchemist's Satchel", },
    [55307480]={ quest=35580, loot={117550}, label="Swamplighter Hive", toy=true, },
    [55801990]={ quest=35600, loot={118104}, label="Strange Spore, on top of the mushroom, go over the mountain", pet=true, },
    [58902200]={ quest=35603, loot={113215}, label="Mikkal's Chest, a sick burn from the NPC", },
    [66903350]={ quest=36507, loot={116875}, label="Orc Skeleton", },
    [67108430]={ quest=33565, loot={44722}, label="Scaly Rylak Egg, ah the memories", },
    -- followers
    [42804040]={ quest=35614, follower=179, npc=74741, faction="Alliance", label="Do the crystal defense event here to get him", }, -- Artificer Romuul
    -- Voidtalon
    [49607160]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
    [43207100]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
    [50907250]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
    [41907570]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
    [48706990]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
    [46607000]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
})
ns.RegisterPoints(540, { -- BloodthornCave
    [55544974]={ quest=33572, loot={113373}, label="Rotting Basket", },
})
ns.RegisterPoints(525, { -- FrostfireRidge
    -- garrison
    [16104980]={ quest=33942, label="Supply Dump", currency=824, },
    [21605070]={ quest=34931, label="Pale Loot Sack", currency=824, },
    [24001300]={ quest=34647, label="Snow-Covered Strongbox", currency=824, },
    [34202350]={ quest=32803, label="Thunderlord Cache", currency=824, },
    [37205920]={ quest=34967, label="Raided Loot", currency=824, },
    [43705550]={ quest=34841, label="Forgotten Supplies", currency=824, },
    [51002280]={ quest=34521, label="Glowing Obsidian Shard", currency=824, note="May be missing?", },
    [56707180]={ quest=36863, label="Iron Horde Munitions", currency=824, },
    [64702570]={ quest=33946, label="Survivalist's Cache", currency=824, },
    [66702640]={ quest=33948, label="Goren Leftovers", currency=824, },
    [68204580]={ quest=33947, label="Grimfrost Treasure", currency=824, },
    [69006910]={ quest=33017, label="Iron Horde Supplies", currency=824, },
    [74505620]={ quest=34937, label="Lady Sena's Other Materials Stash", currency=824, faction="Horde", },
    -- treasures
    [09804540]={ quest=34641, loot={111407}, label="Sealed Jug", },
    [19201200]={ quest=34642, loot={111408}, label="Lucky Coin", },
    [21900960]={ quest=33926, loot={108739}, label="Lagoon Pool", toy=true, },
    [23102500]={ quest=33916, loot={108735}, label="Arena Master's War Horn", toy=true, },
    [24202720]={ quest=33501, loot={63293}, label="Spectator's Chest; booze, jump from the tower, entrance @ 25,30", },
    [24204860]={ quest=34507, loot={110689}, label="Frozen Frostwolf Axe; cave at 25,51", },
    [25502040]={ quest=34648, loot={111415}, label="Gnawed Bone", },
    [27604280]={ quest=33500, loot={43696}, label="Slave's Stash, booze", },
    [30305120]={ quest=33438, loot={107662}, note="Time-Warped Tower; loot all the frozen ogres", }, -- note: other ogres are 33497, 33439, and 33440
    [38403780]={ quest=33502, loot={112087}, label="Obsidian Petroglyph", },
    [39701710]={ quest=33532, loot={120945}, currency=823, label="In the tower, behind some rocks", }, -- Cragmaul Cache
    [40902010]={ quest=34473, loot={110536}, label="Envoy's Satchel", },
    [42401970]={ quest=34520, loot={120341}, label="Burning Pearl", },
    [42703170]={ quest=33940, loot={112187}, label="Crag-Leaper's Cache", },
    [54803540]={ quest=33525, loot={107273}, label="Combine with Frostwolf First-Fang @ 63,48", }, -- Young Orc Traveler
    [57105210]={ quest=34476, loot={111554}, label="Frozen Orc Skeleton", },
    [61804250]={ quest=33511, npc=72156, loot={112110}, label="Interrupt the ritual, then feed him ogres", },
    [63401480]={ quest=33525, loot={107272}, npc=75081, label="Combine with Snow Hare's Foot @ 54,35", }, -- Young Orc Woman
    [64406580]={ quest=33505, loot={117564}, label="Wiggling Egg; rylak nests on the roof", pet=true, },
    -- bladespire...
    [26503640]={ quest=35367, label="Gorr'thogg's Personal Reserve", currency=824, },
    [26703940]={ quest=35370, loot={113189}, label="Doorog's Secret Stash", },
    [26603520]={ quest=35347, currency=824, label="Ogre Booty", },
    [27173763]={ quest=35373, label="Ogre Booty", note="Gold", },
    [27283876]={ quest=35570, label="Ogre Booty", note="Gold", },
    [27603382]={ quest=35371, label="Ogre Booty", note="Gold", },
    [28093409]={ quest=35567, currency=824, label="Ogre Booty", },
    [28093409]={ quest=35568, currency=824, label="Ogre Booty", },
    [28093409]={ quest=35569, currency=824, label="Ogre Booty", },
    [28293440]={ quest=35368, label="Ogre Booty", note="Gold", },
    [28293440]={ quest=35369, label="Ogre Booty", note="Gold", },
    -- followers
    [39602800]={ quest=34733, follower=32, label="Rescue Dagg from the other cage first, then find him outside your garrison", }, -- Dagg
    [68001900]={ quest=34464, follower=190, label="Mysterious Boots; collect all the Mysterious items across Draenor", }, -- Archmage Vargoth
    [65906080]={ quest=34733, follower=32, label="Rescue Dagg from the cage, then go to his other location", }, -- Dagg
    -- Voidtalon
    [51001990]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
    [52301830]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
    [53841721]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
    [47702750]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
})
-- All these Bladespire ones are available for Alliance, but Horde have to complete Moving In (33657) first
ns.RegisterPoints(526, { -- Turgall's Den: Bladespire Citadel
    [44806480]={ quest=35570, label="Ogre Booty", note="Gold", },
    [48506720]={ quest=35369, label="Ogre Booty", note="Gold; up some crates", },
    [53702880]={ quest=35368, label="Ogre Booty", note="Gold; up some crates", },
})
ns.RegisterPoints(527, { -- Turgall's Den: Bladespite Courtyard
    [36502900]={ quest=35347, currency=824, label="Ogre Booty", },
    [37806900]={ quest=35370, loot={113189}, label="Doorog's Secret Stash; second floor, outside", },
    [46401640]={ quest=35371, label="Ogre Booty", note="Gold; up some crates; may hit an invisible ceiling, it's reachable if you work at it", },
    [51101770]={ quest=35567, currency=824, label="Ogre Booty", },
    [52605300]={ quest=35373, label="Ogre Booty", note="Gold; up some crates", },
    [70806800]={ quest=35569, currency=824, label="Ogre Booty", note="In the vault", },
    [76606330]={ quest=35568, currency=824, label="Ogre Booty", note="In the vault", },
})
ns.RegisterPoints(528, { -- Turgall's Den: Bladespite Throne
    [31706640]={ quest=35367, loot={113108}, label="Gorr'thogg's Personal Reserve", },
})
ns.RegisterPoints(543, { -- Gorgrond
    -- treasures
    [39006810]={ quest=36631, label="Sasha's Secret Stash", note="Random green + gold; top of the tower on a broken beam outside, you have to jump down", },
    [40007230]={ quest=36170, loot={118715}, label="Femur of Improbability", },
    [40407660]={ quest=36621, loot={118710}, label="Explorer Canister", currency=824, },
    [41705300]={ quest=36506, loot={118702}, label="Brokor's Sack", },
    [41807810]={ quest=36658, label="Evermorn Supply Cache", note="Green and gold; behind a hut", },
    [42408340]={ quest=36625, label="Discarded Pack", note="Gold; under the roots", },
    [42604680]={ quest=35056, label="Horned Skull", currency=824, },
    [43109290]={ quest=34241, loot={118227}, label="Ockbar's Pack", },
    [43907050]={ quest=36118, label="Pile of Rubble", note="Random green + gold; behind the ruined ogre statue head", },
    [43704240]={ quest=36618, label="Iron Supply Chest", currency=824, },
    [44207420]={ quest=35709, label="Laughing Skull Cache", currency=824, note="Up a tree", },
    [45004260]={ quest=36634, loot={118713}, label="Sniper's Crossbow", },
    [45704970]={ quest=36610, loot={118708}, label="Suntouched Spear", },
    [46105000]={ quest=36651, label="Harvestable Precious Crystal", currency=824, },
    [46204290]={ quest=36521, loot={118707}, label="Petrified Rylak Egg", },
    [48109340]={ quest=36604, label="Stashed Emergency Rucksack", },
    [48904730]={ quest=36203, loot={118716}, label="Warm Goren Egg", toy=true, },
    [49304360]={ quest=36596, loot={107645}, label="Weapons Cache", currency=824, },
    [52506690]={ quest=36509, loot={118717}, label="Odd Skull", },
    [53008000]={ quest=34940, loot={118718}, label="Strange Looking Dagger; cave entrance at 51.3,77.6", },
    [53107440]={ quest=36654, loot={118714}, label="Remains of Balik Orecrusher", },
    [57006530]={ quest=37249, loot={118106}, label="Strange Spore; on mushrooms on the cliff", pet=true, junk=true, },
    [57805600]={ quest=36605, loot={118703}, label="Remains of Balldir Deeprock", },
    [59406370]={ quest=36628, loot={118712}, label="Vindicator's Hammer; on a mushroom, climb up into Wildwood from 59.8,53.5 (yes, it's a long way), jump to the mushrooms at 61.9,60.0, and carry on across to the one with a nest on top", },
    [71906660]={ quest=nil, label="Sunken Treasure", currency=824, },
    -- followers
    [39703990]={ quest=34463, follower=190, label="Mysterious Ring; collect all the Mysterious items across Draenor", }, -- Archmage Vargoth
    [44908690]={ quest=36037, npc=83820, follower=193, label="He'll look hostile; fight the things that are attacking him", }, -- Tormmok
    [42809090]={ quest=34279, npc=78030, follower=189, label="Follow the path up and fight him", }, -- Blook
    -- pepe!
    [47504130]={ quest=39267, loot={127867}, achievement=10053, }, -- Ninja Pepe
    -- Voidtalon
    [51603880]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
    [54004500]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
    [56004000]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
    [43203420]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
})
ns.RegisterPoints(535, { -- Talador
    -- treasures
    [33307670]={ quest=34259, label="Bonechewer Remnants", currency=824, },
    [35509660]={ quest=34249, label="Farmer's Bounty", currency=824, },
    [36509610]={ quest=34182, loot={117567}, label="Aarko's Family Treasure", },
    [37607490]={ quest=34148, loot={112371}, label="Bonechewer Spear; sticking out of Viperlash, cave entrance @ 36,75", },
    [38201250]={ quest=34258, label="Light of the Sea", currency=824, },
    [38408450]={ quest=34257, loot={116119}, label="Treasure of Ango'rosh", },
    [39307770]={ quest=35162, loot={112699}, label="Teroclaw Nest", pet=true, },
    [39505520]={ quest=34254, loot={117570}, label="Soulbinder's Reliquary", },
    [39807670]={ quest=35162, loot={112699}, label="Teroclaw Nest", pet=true, },
    [40608950]={ quest=34140, label="Yuuri's Gift", note="You have to complete Nightmare in the Tomb first", currency=824, faction="Alliance", },
    [47009170]={ quest=34256, loot={116128}, label="Relic of Telmor", },
    [52502950]={ quest=34235, loot={116132}, label="Luminous Shell", },
    [54002760]={ quest=34290, loot={116402}, label="Ketya's Stash", pet=true, },
    [54105630]={ quest=35162, loot={112699}, label="Teroclaw Nest", pet=true, },
    [55206680]={ quest=34253, loot={116118}, label="Draenei Weapons", currency=824, },
    [57207540]={ quest=34134, loot={117563}, label="Rescue 4 draenei trapped in spider webs, then Isaari's Cache will spawn here", faction="Alliance", junk=true, },
    [57402870]={ quest=34238, loot={116120}, label="Foreman's Lunchbox", toy=true, },
    [58901200]={ quest=33933, loot={108743}, label="Deceptia's Smoldering Boots", toy=true, },
    [61107170]={ quest=34116, loot={117563}, label="Rescue 4 adventurers trapped in spider webs, then Norana's Cache will spawn here", faction="Horde", },
    [62003240]={ quest=34236, loot={116131}, label="Amethyl Crystal", currency=824, },
    [62404800]={ quest=34252, loot={110506}, label="Barrel of Fish", },
    [64607920]={ quest=34251, loot={117571}, label="Iron Box", },
    [64901330]={ quest=34232, loot={116117}, label="Rook's Tacklebox", },
    [65501130]={ quest=34233, loot={117568}, label="Jug of Aged Ironwine, cave entrance to the north", },
    [65508860]={ quest=34255, loot={116129}, label="Webbed Sac", },
    [65908520]={ quest=34276, label="Rusted Lockbox", note="Random green", },
    [66608690]={ quest=34239, loot={117569}, label="Curious Deathweb Egg", toy=true, },
    [68785621]={ quest=34101, loot={109192}, label="Lightbearer", },
    [70100700]={ quest=36937, label="Burning Blade Cache", currency=823, },
    [70803200]={ quest=35162, loot={112699}, label="Teroclaw Nest", pet=true, },
    [70903550]={ quest=35162, loot={112699}, label="Teroclaw Nest", pet=true, },
    [72403700]={ quest=35162, loot={112699}, label="Teroclaw Nest", pet=true, },
    [72803560]={ quest=35162, loot={112699}, label="Teroclaw Nest", pet=true, },
    [73503070]={ quest=35162, loot={112699}, label="Teroclaw Nest", pet=true, },
    [73505140]={ quest=34471, loot={116127}, label="Bright Coin", },
    [74303400]={ quest=35162, loot={112699}, label="Teroclaw Nest", pet=true, },
    [74602930]={ quest=35162, loot={112699}, label="Teroclaw Nest", pet=true, },
    [75003600]={ quest=33649, npc=75644, }, -- Iron Scout (not sure what's on this... wowhead is silent...)
    [75704140]={ quest=34261, label="Keluu's Belongings", note="Gold", },
    [75804480]={ quest=34250, loot={116128}, label="Relic of Aruuna", },
    [77005000]={ quest=34248, loot={116116}, label="Charred Sword", },
    [78201480]={ quest=34263, loot={117572}, label="Pure Crystal Dust; upper level of the mine", },
    [81803500]={ quest=34260, loot={109118}, label="Aruuna Mining Cart", },
    -- followers
    [45303700]={ quest=34465, follower=190, label="Mysterious Hat; collect all the Mysterious items across Draenor", }, -- Archmage Vargoth
    [62755038]={ quest=nil, follower=171, label="Complete the quests starting with Clear!", }, -- Pleasure-Bot 8000 (actually a different quest for alliance and horde)
    [57405120]={ quest=36519, follower=207, label="Complete her quest", faction="Alliance", }, -- Defender Illona
    [58005300]={ quest=36518, follower=207, label="Complete her quest", faction="Horde", }, -- Aeda Brightdawn
    [56802600]={ quest=36522, follower=208, label="Complete his quest. Find him again outside your garrison.", }, -- Ahm
    -- pepe!
    [51006330]={ quest=39266, loot={127869}, achievement=10053, }, -- Knight Pepe
    -- Voidtalon
    [47004800]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
    [39705540]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
    [51904120]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
    [46205260]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
})
ns.RegisterPoints(537, { -- TombofSouls
    [67602320]={ quest=34671, npc=79543, loot={112370}, }, -- Shirzir
})
ns.RegisterPoints(542, { -- SpiresOfArak
    -- archeology
    [33302730]={ quest=36422, label="Sun-Touched Cache", currency=829, note="Needs archeology", },
    [42701830]={ quest=36244, label="Misplaced Scrolls", note="Needs archeology", currency=829, },
    [43001640]={ quest=36245, label="Relics of the Outcasts", currency=829, note="Needs archeology; on top of the walls", },
    [43202720]={ quest=36355, label="Relics of the Outcasts", currency=829, note="Needs archeology; climb the ropes", },
    [46004410]={ quest=36354, label="Relics of the Outcasts", currency=829, note="Needs archeology; climb the tree, jump to the rope", },
    [51904890]={ quest=36360, label="Relics of the Outcasts", currency=829, note="Needs archeology", },
    [52404280]={ quest=36416, label="Misplaced Scroll", currency=829, note="Needs archeology; start climbing the mountain at 53.6, 47.7", },
    [56304530]={ quest=36433, label="Smuggled Apexis Artifacts", currency=829, note="Needs archeology; climb  the mushrooms up the tree", },
    [60205390]={ quest=36359, label="Relics of the Outcasts", currency=829, note="Needs archeology", },
    [67403980]={ quest=36356, label="Relics of the Outcasts", currency=829, note="Needs archeology", },
    -- shrines
    [43802470]={ quest=36397, loot={115463}, label="Take to a Shrine of Terrok", repeatable=true, },
    [43901500]={ quest=36395, loot={115463}, label="Take to a Shrine of Terrok", repeatable=true, },
    [48906250]={ quest=36399, loot={115463}, label="Take to a Shrine of Terrok", repeatable=true, },
    [53108450]={ quest=nil, loot={115463}, label="Take to a Shrine of Terrok", repeatable=true, },
    [55602200]={ quest=36400, loot={115463}, label="Take to a Shrine of Terrok", repeatable=true, },
    [69204330]={ quest=36398, loot={115463}, label="Take to a Shrine of Terrok", repeatable=true, },
    [42402670]={ quest=36388, loot={118242}, note="Gift of Anzu", label="Drink Elixir of Shadow Sight", },
    [46904050]={ quest=36389, loot={118238}, note="Gift of Anzu", label="Drink Elixir of Shadow Sight", },
    [48604450]={ quest=36386, loot={118237}, note="Gift of Anzu", label="Drink Elixir of Shadow Sight", },
    [52001960]={ quest=36392, loot={118239}, note="Gift of Anzu", label="Drink Elixir of Shadow Sight", },
    [57007900]={ quest=36390, loot={118241}, note="Gift of Anzu", label="Drink Elixir of Shadow Sight", },
    [61105550]={ quest=36381, loot={118240}, note="Gift of Anzu", label="Drink Elixir of Shadow Sight", },
    [48305260]={ quest=36405, loot={118267}, label="Offering to the Raven Mother", },
    [48905470]={ quest=36406, loot={118267}, label="Offering to the Raven Mother", },
    [51906460]={ quest=36407, loot={118267}, label="Offering to the Raven Mother", },
    [53305560]={ quest=36403, loot={118267}, label="Offering to the Raven Mother", },
    [61006380]={ quest=36410, loot={118267}, label="Offering to the Raven Mother", },
    -- treasures
    [29504170]={ quest=35334, loot={118207}, pet=true, label="Egg of Varasha", note="In the cave", },
    [36801720]={ quest=36243, label="Outcast's Belongings", note="Random green", },
    [50402580]={ quest=36444, loot={118691}, label="Iron Horde Explosives", },
    [50702880]={ quest=36247, label="Lost Herb Satchel", note="Assorted herbs", },
    [36303940]={ quest=36402, loot={120337}, label="Orcish Signaling Horn", },
    [37204740]={ quest=36420, label="Garrison Supplies", currency=824, },
    [36505790]={ quest=36418, loot={116914}, label="Ephial's Dark Grimoire", },
    [47803610]={ quest=36411, loot={116911}, label="Lost Ring", },
    [49203730]={ quest=36445, loot={116835}, label="Assassin's Spear", },
    [46903400]={ quest=36446, label="Outcast's Pouch", note="Random green", },
    [47903070]={ quest=36361, loot={116920}, label="Shattered Hand Lockbox", },
    [42102170]={ quest=36447, label="Outcast's Belongings", note="Random green", },
    [34102750]={ quest=36421, label="Sun-Touched Cache", currency=824, },
    [68203880]={ quest=36375, npc=85190, loot={118692}, }, -- Sethekk Idol
    [71604850]={ quest=36450, loot={109223}, label="Sethekk Ritual Brew", },
    [41805050]={ quest=36451, loot={116918}, label="Garrison Workman's Hammer", },
    [56202880]={ quest=36362, label="Shattered Hand Cache", currency=824, },
    [68408900]={ quest=36453, label="Coinbender's Payment", note="Gold", },
    [63606740]={ quest=36454, label="Mysterious Mushrooms", note="Herbs", },
    [66505650]={ quest=36455, label="Waterlogged Satchel", note="Random green", },
    [54403240]={ quest=36364, loot={118695}, label="Toxicfang Venom", currency=824, },
    [59708130]={ quest=36365, label="Spray-O-Matic 5000 XT", currency=824, },
    [60908460]={ quest=36456, label="Shredder Parts", currency=824, },
    [55509080]={ quest=36366, label="Campaign Contributions", note="Gold", },
    [50502210]={ quest=36246, loot={116919}, label="Hidden in the water", }, -- Fractured Sunstone
    [44401200]={ quest=36377, npc=85206, loot={118693}, }, -- Rukhmar's Image
    [40605500]={ quest=36458, loot={116913}, label="Abandoned Mining Pick", },
    [58706030]={ quest=36340, loot={116922}, label="Ogron Plunder (Hobbit reference!)", },
    [37305070]={ quest=36657, loot={116887}, label="Feed the dog 3x[Rooby Reat] from the chef downstairs", },
    [37705640]={ quest=36462, loot={116020}, label="Unlocks a chest in Admiral Taylor's Garrison Town Hall @ 36.2,54.4", },
    [59109060]={ quest=36366, loot={116917}, label="In the control room", }, -- Sailor Zazzuk's 180-Proof Rum
    -- followers
    [55306850]={ quest=37168, follower=219, label="Follow the trail up the hill to 54.9,65.4, find him in the cave", }, -- Leorajh
    -- pepe!
    [54108360]={ quest=39268, loot={127870}, achievement=10053, }, -- Pirate Pepe
    -- Voidtalon
    [47002010]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
    [50400610]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
    [60801120]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
    [36501820]={ quest=37864, loot={121815}, label="Occasionally spawning portal", },
})
-- Garrisons!
ns.RegisterPoints(582, { -- Lunarfall
    -- garrisonsmvalliance_tier1
    [49604380]={ art=601, quest=35530, currency=824, label="Lunarfall Egg", note="wagon", faction="Alliance", junk=true, },
    [51800110]={ art=601, quest=35289, currency=824, label="Spark's Stolen Supplies", note="cave by lake", junk=true, },
    [42405436]={ art=601, quest=35381, currency=824, label="Pippers' Buried Supplies", junk=true, },
    [50704850]={ art=601, quest=35382, currency=824, label="Pippers' Buried Supplies", junk=true, },
    [30802830]={ art=601, quest=35383, currency=824, label="Pippers' Buried Supplies", junk=true, },
    [49197683]={ art=601, quest=35384, currency=824, label="Pippers' Buried Supplies", junk=true, },
    -- garrisonsmvalliance_tier2
    [37006590]={ art=602, quest=35530, currency=824, label="Lunarfall Egg, wagon", },
    [51800110]={ art=602, quest=35289, currency=824, label="Spark's Stolen Supplies", note="cave by lake", junk=true, },
    [41685803]={ art=602, quest=35381, currency=824, label="Pippers' Buried Supplies", junk=true, },
    [51874545]={ art=602, quest=35382, currency=824, label="Pippers' Buried Supplies", junk=true, },
    [34972345]={ art=602, quest=35383, currency=824, label="Pippers' Buried Supplies", junk=true, },
    [46637608]={ art=602, quest=35384, currency=824, label="Pippers' Buried Supplies", junk=true, },
    -- garrisonsmvalliance_tier3
    [61277261]={ art=603, quest=35530, currency=824, label="Lunarfall Egg, tent", },
    [51800110]={ art=603, quest=35289, currency=824, label="Spark's Stolen Supplies", note="cave by lake", junk=true, },
    [60575515]={ art=603, quest=35381, currency=824, label="Pippers' Buried Supplies", junk=true, },
    [37307491]={ art=603, quest=35382, currency=824, label="Pippers' Buried Supplies", junk=true, },
    [37864378]={ art=603, quest=35383, currency=824, label="Pippers' Buried Supplies", junk=true, },
    [61527154]={ art=603, quest=35384, currency=824, label="Pippers' Buried Supplies", junk=true, },
})
ns.RegisterPoints(590, { -- Frostwall (garrisonffhorde_tier)
    [72505620]={ quest=34937, label="Lady Sena's Other Materials Stash", currency=824, faction="Horde", },
})
ns.RegisterPoints(597, { -- FoundryRaid
    [59305720] = { quest=34405, loot={109118}, label="Iron Horde Chest", junk=true, },
})
-- ["TanaanJungleIntro"] = {},
ns.RegisterPoints(534, { -- TanaanJungle
    -- [42903490] = { quest=nil, currency=824, loot={128346}, label="Suspiciously Glowing Chest. Second floor", repeatable=true, },
    -- [35604620] = { quest=nil, currency=824, loot={128346}, label="Suspiciously Glowing Chest, in the cave", repeatable=true, },
    -- [49104660] = { quest=nil, currency=824, loot={128346}, label="Suspiciously Glowing Chest, on the pile", repeatable=true, },
    -- [22104980] = { quest=nil, currency=824, loot={128346}, label="Suspiciously Glowing Chest, on the ridge", repeatable=true, },
    -- [27506940] = { quest=nil, loot={128346}, currency=824, repeatable=true, }, -- draenic chest
    -- [21403570] = { quest=nil, loot={128346}, currency=824, repeatable=true, },
    [14905440] = { quest=38754, loot={127325}, achievement=10262, label="In the tower, on an orc hanging from a chain" }, -- weeping wolf axe
    [15904970] = { quest=38208, loot={127324}, achievement=10262, label="Back of cave", }, -- weathered axe
    [16005940] = { quest=38757, loot={128220}, achievement=10262, label="Second floor of the tower", }, -- grannok's eye
    [17005300] = { quest=38283, loot={128346}, achievement=10262, npc=91382, label="Small chest next to the body", }, -- deserter
    [17405700] = { quest=38755, loot={128346}, achievement=10262, currency=824, label="In the hut", }, -- spoils
    [19304100] = { quest=38320, loot={127338}, achievement=10262, label="Bottom of the lake", }, -- blade of Kra'nak
    [22004780] = { quest=38678, loot={128346}, achievement=10262, currency=824, label="In the hut", }, -- warchest
    [25305030] = { quest=38735, loot={128222}, achievement=10262, label="Top of tower, use rope to get up", }, -- enchanted spyglass
    [26506290] = { quest=38741, currency=823, achievement=10262, label="Top of tower, use rope to get up", }, -- bleeding hollow chest
    [26804410] = { quest=38683, loot={127709}, achievement=10262, }, -- Looted Bleeding Hollow Treasure
    [28702330] = { quest=38334, loot={127668}, achievement=10262, }, -- Jewel of Hellfire
    [28803460] = { quest=38863, currency=823, achievement=10262, }, -- Partially Mined Apexis Crystal
    [30307190] = { quest=38629, loot={127389}, achievement=10262, }, -- polished crystal
    [31403110] = { quest=38732, loot={127413}, achievement=10262, }, -- Jeweled Arakkoa Effigy
    [32407040] = { quest=38426, loot={127670}, achievement=10262, toy=true, }, -- sargerei tome
    [33907810] = { quest=38760, loot={128346}, achievement=10262, }, -- captain booty 1
    [34407830] = { quest=38762, loot={128346}, achievement=10262, }, -- captain booty 3
    [34703464] = { quest=38742, loot={127669}, achievement=10262, label="Bottom of the cave. Watch out for fall damage.", }, -- Mad Chief
    [34707710] = { quest=38761, loot={128346}, achievement=10262, }, -- captain booty 2
    [35907860] = { quest=38758, currency=824, achievement=10262, }, -- Ironbeard's Treasure
    [36304350] = { quest=37956, loot={127397}, achievement=10262, }, -- Strange Sapphire
    [37004620] = { quest=38640, currency=824, achievement=10262, }, -- Pale Removal Equipment
    [37808070] = { quest=38788, loot={127770}, achievement=10262, }, -- brazier
    [40607980] = { quest=38638, loot={127333}, achievement=10262, }, -- snake flute
    [40807550] = { quest=38639, loot={127766}, achievement=10262, toy=true, }, -- perfect blossom
    [41607330] = { quest=38657, loot={127339}, achievement=10262, }, -- forgotten champion sword
    [42803530] = { quest=38822, loot={127859}, achievement=10262, label="Top floor", toy=true, },
    [43203830] = { quest=38821, loot={127348}, achievement=10262, label="In the building" },
    [46207280] = { quest=38739, loot={128320}, achievement=10262, }, -- Mysterious Corrupted Obelisk
    [46804220] = { quest=38776, loot={127328}, achievement=10262, }, -- blade
    [46903660] = { quest=38771, loot={127347}, achievement=10262, }, -- book
    [46904440] = { quest=38773, loot={128218}, achievement=10262, }, -- fel satchel
    [47907040] = { quest=38705, loot={127329}, achievement=10262, }, -- Crystalized Essence of Elements
    [48507520] = { quest=38814, loot={127337}, achievement=10262, }, -- Looted Mystical Staff
    [49907680] = { quest=38809, loot={128223}, achievement=10262, }, -- Bleeding Hollow Mushroom Stash
    [49907960] = { quest=38703, loot={127354}, achievement=10262, }, -- Scouts Belongings
    [49908120] = { quest=38702, loot={127312}, achievement=10262, }, -- Discarded Helm
    [50806490] = { quest=38731, loot={127412}, achievement=10262, }, -- overgrown relic
    [51603270] = { quest=39075, currency=823, achievement=10262, }, -- Fel-Tainted Apexis Formation
    [51702430] = { quest=38686, loot={127341}, achievement=10262, }, -- Rune Etched Femur
    [54806930] = { quest=38593, loot={127334}, achievement=10262, label="Climb the vine bridge, spear in the side", }, -- spear
    [54909070] = { quest=39470, currency=824, achievement=10262, }, -- Dead Mans Chest
    [56906510] = { quest=38591, loot={127408}, achievement=10262, }, -- broken selfie sack
    [58502500] = { quest=38679, loot={115804}, achievement=10262, }, -- Jewel of the Fallen Star
    [61207580] = { quest=38601, currency=824, achievement=10262, }, -- Blackfang Isle Cache
    [62107070] = { quest=38602, loot={128217}, achievement=10262, }, -- Crystalized Fel Spike
    [62602050] = { quest=38682, loot={127401}, achievement=10262, }, -- Censer of Torment
    [63402810] = { quest=38740, loot={128309}, achievement=10262, }, -- Forgotten Shard of the Cipher
    [64704280] = { quest=38701, loot={127396}, achievement=10262, toy=true, }, -- Loose Soil
    [65908500] = { quest=39469, loot={128386}, achievement=10262, }, -- Bejeweled Egg
    [69705600] = { quest=38704, currency=824, achievement=10262, }, -- Forgotten Iron Horde Supplies
    [73604320] = { quest=38779, label="First floor of north-east tower", achievement=10262, }, -- Stashed Bleeding Hollow Loot
})
ns.RegisterPoints(622, { -- AshranAllianceFactionHub
    [45307020] = { follower=467, faction="Alliance", label="Outside the town hall", }, -- Fen Tao
})
ns.RegisterPoints(624, { -- AshranHordeFactionHub
    [47004500] = { follower=467, faction="Horde", label="Outside the inn", }, -- Fen Tao
})
