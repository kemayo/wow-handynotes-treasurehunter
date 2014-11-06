---------------------------------------------------------
-- Addon declaration
HandyNotes_TreasureHunter = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_TreasureHunter", "AceEvent-3.0")
local HL = HandyNotes_TreasureHunter
local HandyNotes = LibStub("AceAddon-3.0"):GetAddon("HandyNotes")
-- local L = LibStub("AceLocale-3.0"):GetLocale("HandyNotes_TreasureHunter", true)

local debugf = tekDebug and tekDebug:GetFrame("TreasureHunter")
local function Debug(...) if debugf then debugf:AddMessage(string.join(", ", tostringall(...))) end end

---------------------------------------------------------
-- Our db upvalue and db defaults
local db
local defaults = {
    profile = {
        show_junk = true,
        found = false,
        icon_scale = 1.0,
        icon_alpha = 1.0,
        icon_item = true,
    },
}

---------------------------------------------------------
-- Localize some globals
local next = next
local GameTooltip = GameTooltip
local WorldMapTooltip = WorldMapTooltip
local HandyNotes = HandyNotes
local GetItemInfo = GetItemInfo
local GetAchievementInfo = GetAchievementInfo
local GetAchievementCriteriaInfo = GetAchievementCriteriaInfo
local GetCurrencyInfo = GetCurrencyInfo

---------------------------------------------------------
-- Constants

local points = {
    --[[ structure:
    [mapFile] = { -- "_terrain1" etc will be stripped from attempts to fetch this
        [coord] = {
            type=[type], -- item / plain
            id=[id/string], -- item: itemid, plain: text-description
            quest=[id], -- will be checked, for whether character already has it
            junk=[bool], -- doesn't count for achievement
            npc=[id], -- related npc id, which admittedly isn't used for anything
            note=[string], -- some text which might be helpful
        },
    },
    -- e.g.:
    ["KunLaiSummit"] = {
        [52907140] = { type="item", item=86394, note="in the cave", quest=31413, }, -- Hozen Warrior Spear
    }.
    --]]
    ["NagrandDraenor"] = {

    },
    ["ShadowmoonValleyDR"] = {
        -- garrison-y
        [27100260]={ type="currency", quest=35280, currency=824, label="Stolen Treasure", },
        [26500570]={ type="currency", quest=34174, currency=824, label="Fantastic Fish", },
        [28800710]={ type="currency", quest=35279, currency=824, label="Sunken Treasure", },
        [30301990]={ type="currency", quest=35530, currency=824, label="Lunarfall Egg", note="Moves to the garrison once built", },
        [45802460]={ type="currency", quest=33570, currency=824, label="Shadowmoon Exile Treasure", note="cave below Exile Rise", },
        [52902490]={ type="currency", quest=37254, currency=824, label="Mushroom-Covered Chest", },
        [57904530]={ type="currency", quest=33568, currency=824, label="Kaliri Egg", },
        [28303930]={ type="currency", quest=33571, currency=824, label="Shadowmoon Treasure", },
        [42106130]={ type="currency", quest=33041, currency=824, label="Iron Horde Cargo Shipment", },
        [84504470]={ type="currency", quest=33885, currency=824, label="Cargo of the Raven Queen", },
        -- treasures
        [20303060]={ type="item", quest=33575, item=108904, note="Demonic Cache", },
        [22803390]={ type="item", quest=33572, item=113373, note="Rotting Basket", },
        [30004530]={ type="item", quest=35919, item=113563, note="Shadowmoon Sacrificial Dagger" },
        [31303910]={ type="item", quest=33886, item=109081, note="Ronokk's Belongings", },
        [33503970]={ type="item", quest=33569, item=113545, note="Reusable mana potion", },
        [34204350]={ type="item", quest=33866, item=109124, note="Veema's Herb Bag", },
        [34404620]={ type="item", quest=33891, item=108901, note="Giant Moonwillow Cone", },
        [35904090]={ type="item", quest=33540, item=113546, note="Uzko's Knickknacks", },
        [36704450]={ type="item", quest=33573, item=113378, },
        [36804140]={ type="item", quest=33046, item=113547, note="Beloved's Offering, offhand decoration", },
        [37202310]={ type="item", quest=33613, item=108945, note="in cave, Bubbling Cauldron", },
        [37202610]={ type="item", quest=35677, item=110506, note="Sunken Fishing Boat, fishy fun items", },
        [37505930]={ type="item", quest=33567, item=108903, note="Iron Horde Tribute", },
        [37704430]={ type="item", quest=33584, item=113531, note="Consumable: Rested XP", },
        [38504300]={ type="item", quest=33614, item=113408, note="Greka's Urn", },
        [39208380]={ type="item", quest=33566, item=113372, note="Waterlogged Chest", },
        [41502790]={ type="item", quest=33869, item=108902, note="Armored Elekk Tusk", },
        [43806060]={ type="plain", quest=33611, label="Peaceful Offering 1", },
        [44505920]={ type="plain", quest=33612, label="Peaceful Offering 4", },
        [44506350]={ type="plain", quest=33384, label="Peaceful Offering 3", },
        [45206050]={ type="plain", quest=33610, label="Peaceful Offering 2", },
        [47104610]={ type="item", quest=33564, item=108900, note="Hanging Satchel", },
        [48704750]={ type="item", quest=35798, item=109130, note="Glowing Cave Mushroom", },
        [49303750]={ type="item", quest=33867, item=109739, note="Astrologer's Box", toy=true, },
        [51107910]={ type="item", quest=33574, item=113375, note="Vindicator's Cache", toy=true, },
        [51803550]={ type="plain", quest=33037, label="False-Bottomed Jar", note="Gold", },
        [55004500]={ type="item", quest=35581, item=109124, note="Alchemist's Satchel", },
        [55307480]={ type="item", quest=35580, item=117550, note="Swamplighter Hive", toy=true, },
        [55801990]={ type="item", quest=35600, item=118104, note="Strange Spore", pet=true, },
        [58902200]={ type="item", quest=35603, item=113215, note="Mikkal's Chest, a sick burn from the NPC", },
        [66903350]={ type="item", quest=36507, item=116875, note="Orc Skeleton", },
        [67108430]={ type="item", quest=33565, item=44722, note="Scaly Rylak Egg, ah the memories", },
        -- rares (do these count for the 'treasure hunter' achievement?)
        [21602100]={ type="item", quest=33640, item=108906, npc=75482, }, -- Veloss
        [27604360]={ type="item", quest=36880, item=118734, npc=86689, }, -- Sneevel
        [29600620]={ type="item", quest=35281, item=111666, npc=81406, }, -- Bahameye
        [29603380]={ type="item", quest=33664, item=113082, npc=76380, }, -- Gorum
        [29605080]={ type="item", quest=37357, item=119369, npc=85451, }, -- Malgosh Shadowkeeper
        [31905720]={ type="item", quest=37359, item=119392, npc=85078, }, -- Voidreaver Urnae
        [32203500]={ type="item", quest=33039, item=109061, npc=72362, }, -- Ku'targ the Voidseer
        [32604140]={ type="item", quest=35847, item=109074, npc=83385, }, -- Voidseer Kalurg
        [37203640]={ type="item", quest=33061, item=109060, npc=77140, }, -- Amaukwa
        [37404880]={ type="item", quest=35558, item=113631, toy=true, npc=79524, }, -- Hypnocroak
        [37601460]={ type="item", quest=33055, item=108907, npc=72537, }, -- Leaf-Reader Kurri
        [38607020]={ type="item", quest=35523, item=113559, npc=82362, }, -- Morva Soultwister
        [40804440]={ type="item", quest=33043, item=109078, npc=74206, }, -- Killmaw
        [41008300]={ type="item", quest=35448, item=113548, npc=82268, }, -- Darkmaster Go'vid
        [42804100]={ type="item", quest=33038, item=113553, npc=75434, }, -- Windfang Matriarch
        [43807740]={ type="item", quest=33383, item=117551, npc=81639, }, -- Brambleking Fili
        [44005760]={ type="item", quest=33642, item=119449, npc=75071, }, -- Mother Om'ra, hunter quest
        [44802080]={ type="item", quest=35906, item=113561, npc=77310, }, -- Mad King Sporeon 
        [46007160]={ type="npc", quest=37351, currency=823, npc=84911, }, -- Demidos
        [48007760]={ type="item", quest=37355, item=119360, npc=85121, }, -- Lady Temptessa
        [48208100]={ type="npc", quest=37354, currency=823, npc=85029, }, -- Shadowspeaker Niir
        [48602260]={ type="item", quest=35553, item=113542, npc=82374, }, -- Rai'vosh, reusable slow-fall Item
        [48604360]={ type="item", quest=33064, item=109075, npc=77085, }, -- Dark Emanation
        [48806640]={ type="item", quest=33389, item=113570, toy=true, npc=75435, }, -- Yggdrel
        [49604200]={ type="item", quest=35555, item=113541, npc=82411, }, -- Darktalon
        [50207240]={ type="npc", quest=37352, currency=823, npc=84925, }, -- Quartermaster Hershak
        [50807880]={ type="item", quest=37356, item=86213, npc=86213, }, -- Aqualir
        [51807920]={ type="item", quest=37353, item=85001, npc=85001, }, -- Master Sergeant Milgra
        [52801680]={ type="item", quest=35731, item=113540, npc=82326, }, -- Ba'ruun, reusable food (no buff)
        [53005060]={ type="item", quest=34068, item=109077, npc=72606, }, -- Rockhoof
        [54607060]={ type="item", quest=33643, item=108957, npc=75492, }, -- Venomshade
        [57404840]={ type="item", quest=35909, item=113571, npc=83553, }, -- Insha'tar
        [58408680]={ type="plain", quest=37409, label="Nagidna", npc=85555, note="in a cave @ 59,89", }, -- item not known yet...
        [61005520]={ type="item", quest=35732, item=113543, npc=82415, }, -- Shinri
        [61408880]={ type="item", quest=37411, item=119411, npc=85837, }, -- Slivermaw
        [61606180]={ type="item", quest=35725, item=113557, npc=82207, }, -- Faebright
        [67806380]={ type="item", quest=35688, item=113556, npc=82676, }, -- Enavra
        [68208480]={ type="npc", quest=37410, currency=823, npc=85568, }, -- Avalanche
    },
    ["FrostfireRidge"] = {
        -- garrison
        [16104980]={ type="currency", quest=33942, label="Supply Dump", currency=824, },
        [21605070]={ type="currency", quest=34931, label="Pale Loot Sack", currency=824, },
        [24001300]={ type="currency", quest=34647, label="Snow-Covered Strongbox", currency=824, },
        [34202350]={ type="currency", quest=32803, label="Thunderlord Cache", currency=824, },
        [37205920]={ type="currency", quest=34967, label="Raided Loot", currency=824, },
        [43705550]={ type="currency", quest=34841, label="Forgotten Supplies", currency=824, },
        [51002280]={ type="currency", quest=34521, label="Glowing Obsidian Shard", currency=824, },
        [56707180]={ type="currency", quest=36863, label="Iron Horde Munitions", currency=824, },
        [64702570]={ type="currency", quest=33946, label="Survivalist's Cache", currency=824, },
        [66702640]={ type="currency", quest=33948, label="Goren Leftovers", currency=824, },
        [68204580]={ type="currency", quest=33947, label="Grimfrost Treasure", currency=824, },
        [69006910]={ type="currency", quest=33017, label="Iron Horde Supplies", currency=824, },
        [74505620]={ type="currency", quest=34937, label="Lady Sena's Other Materials Stash", currency=824, },
        -- treasures
        [09804540]={ type="item", quest=34641, item=111407, note="Sealed Jug", },
        [19201200]={ type="item", quest=34642, item=111408, note="Lucky Coin", },
        [21900960]={ type="item", quest=33926, item=108739, note="Lagoon Pool", toy=true, },
        [23102500]={ type="item", quest=33916, item=108735, note="Arena Master's War Horn", toy=true, },
        [24202720]={ type="item", quest=33501, item=63293, note="Spectator's Chest, booze", },
        [24204860]={ type="item", quest=34507, item=110689, note="Frozen Frostwolf Axe", },
        [25502040]={ type="item", quest=34648, item=111415, note="Gnawed Bone", },
        [27604280]={ type="item", quest=33500, item=43696, note="Slave's Stash, booze", },
        [38403780]={ type="item", quest=33502, item=112087, note="Obsidian Petroglyph", },
        [40902010]={ type="item", quest=34473, item=110536, note="Envoy's Satchel", },
        [42401970]={ type="item", quest=34520, item=120341, note="Burning Pearl", },
        [42703170]={ type="item", quest=33940, item=112187, note="Crag-Leaper's Cache", },
        [57105210]={ type="item", quest=34476, item=111554, note="Frozen Orc Skeleton", },
        [63401480]={ type="npc", quest=33525, npc=75081, note=UNKNOWN, }, -- Young Orc Woman
        [64406580]={ type="item", quest=33505, item=117564, note="Wiggling Egg", pet=true, },
        -- rares
        [67407820]={ type="item", quest=34477, item=112086, npc=78621, }, -- Cyclonic Fury
        [41206820]={ type="item", quest=34843, item=111953, npc=80242, }, -- Chillfang
        [28206620]={ type="item", quest=34470, item=111666, npc=78606, }, -- Pale Fishmonger
        [38606300]={ type="item", quest=34865, item=112077, npc=80312, }, -- Grutush the Pillager
        [51806480]={ type="item", quest=34825, item=111948, npc=80190, }, -- Gruuk
        [76406340]={ type="item", quest=34132, item=112094, npc=77526, }, -- Scout Goreseeker
        [25405500]={ type="item", quest=34129, item=112066, npc=77513, }, -- Coldstomp the Griever
        [27405000]={ type="item", quest=34497, item=111476, npc=78867, toy=true, }, -- Breathless
        [40404700]={ type="item", quest=33014, item=111490, npc=72294, }, -- Cindermaw
        [66403140]={ type="item", quest=33843, item=111533, npc=74613, }, -- Broodmother Reeg'ak
        [36803400]={ type="item", quest=33938, item=111576, npc=76918, }, -- Primalist Mur'og
        [26803160]={ type="item", quest=34133, item=111475, npc=77527, }, -- The Beater
        [40402780]={ type="item", quest=34559, item=111477, npc=79145, }, -- Yaga the Scarred
        [61602640]={ type="item", quest=34708, item=112078, npc=79678, }, -- Jehil the Climber
        [34002320]={ type="npc", quest=32941, item=101436, npc=71721, currency=824, }, -- Canyon Icemother
        [54602220]={ type="item", quest=32918, item=111530, npc=71665, }, -- Giant-Slayer Kul
        [58603420]={ type="npc", quest=34130, npc=78151, currency=824, }, -- Huntmaster Kuang
        [54606940]={ type="item", quest=34131, item=111484, npc=76914, }, -- Coldtusk
        [71404680]={ type="item", quest=33504, item=107661, npc=74971, }, -- Firefury Giant
        [47005520]={ type="item", quest=34839, item=111955, npc=80235, }, -- Gurun
        [50201860]={ type="npc", quest=33531, npc=75120, note=UNKNOWN, }, -- Clumsy Cragmaul Brute
        [84404880]={ type="npc", quest=nil, npc=84384, note=UNKNOWN, }, -- Taskmaster Kullah
        [85005220]={ type="npc", quest=37556, npc=87600, currency=823, }, -- Jaluk the Pacifist
        [88605740]={ type="npc", quest=37525, npc=84378, currency=823, }, -- Ak'ox the Slaughterer
        [86604880]={ type="item", quest=37401, item=119359, npc=84392, }, -- Ragore Driftstalker
        [86605180]={ type="npc", quest=37403, npc=84376, currency=823, }, -- Earthshaker Holar
        [83604720]={ type="npc", quest=37402, npc=87622, currency=823, }, -- Ogom the Mangler
        [87004640]={ type="npc", quest=37404, npc=84374, currency=823, }, -- Kaga the Ironbender
        [70002700]={ type="npc", quest=37381, npc=87351, currency=823, }, -- Mother of Goren
        [72203300]={ type="item", quest=34361, item=111534, npc=78265, }, -- The Bone Crawler
        [68801940]={ type="npc", quest=37382, npc=87348, currency=823, }, -- Hoarfrost
        [72203000]={ type="npc", quest=nil, npc=87349, note=UNKNOWN }, -- Gomtar the Agile
        [72203600]={ type="npc", quest=37380, npc=87352, note="Flees" }, -- Gibblette the Cowardly
        [70003600]={ type="item", quest=33562, item=111545, npc=72364, currency=824, }, -- Gorg'ak the Lava Guzzler
        [70603900]={ type="npc", quest=37379, npc=87356, currency=823, }, -- Vrok the Ancient
        [72402420]={ type="npc", quest=37378, npc=87357, currency=823, }, -- Valkor
        [43600940]={ type="item", quest=37384, item=119379, npc=82618, }, -- Tor'goroth
        [38201600]={ type="item", quest=37383, item=119399, npc=82620, }, -- Son of Goramal
        [45001500]={ type="npc", quest=37385, npc=82617, currency=823, }, -- Slogtusk the Corpse-Eater
        [48202340]={ type="item", quest=37386, item=119390, npc=82616, }, -- Jabberjaw
        [43002100]={ type="item", quest=37387, item=119356, npc=82614, }, -- Moltnoma
        [40601240]={ type="npc", quest=34522, npc=79104, currency=823, }, -- Ug'lok the Frozen
    },
    ["Gorgrond"] = {
        -- treasures
        [39006810]={ type="item", quest=36631, label="Sasha's Secret Stash", note="Random green + gold", },
        [40007230]={ type="item", quest=36170, item=118715, note="Femur of Improbability", },
        [40407660]={ type="item", quest=36621, item=118710, note="Explorer Canister", currency=824, },
        [41705300]={ type="item", quest=36506, item=118702, note="Brokor's Sack", },
        [41807810]={ type="plain", quest=36658, label="Evermorn Supply Cache", },
        [42408340]={ type="plain", quest=36625, label="Discarded Pack", note="Gold", },
        [42604680]={ type="currency", quest=35056, label="Horned Skull", currency=824, },
        [43109290]={ type="item", quest=34241, item=118227, note="Ockbar's Pack", },
        [43606980]={ type="plain", quest=36118, label="Pile of Rubble", note="Random green + gold", },
        [43704240]={ type="currency", quest=36618, label="Iron Supply Chest", currency=824, },
        [44207420]={ type="currency", quest=35709, label="Laughing Skull Cache", currency=824, },
        [45004260]={ type="item", quest=36634, item=118713, note="Sniper's Crossbow", },
        [45704970]={ type="item", quest=36610, item=118708, note="Suntouched Spear", },
        [46105000]={ type="currency", quest=36651, label="Harvestable Precious Crystal", currency=824, },
        [46204290]={ type="item", quest=36521, item=118707, note="Petrified Rylak Egg", },
        [48109340]={ type="plain", quest=36604, label="Stashed Emergency Rucksack", },
        [48904730]={ type="item", quest=36203, item=118716, note="Warm Goren Egg", toy=true, },
        [49304360]={ type="item", quest=36596, item=107645, note="Weapons Cache", currency=824, },
        [52506690]={ type="item", quest=36509, item=118717, note="Odd Skull", },
        [53008000]={ type="item", quest=34940, item=118718, note="Strange Looking Dagger", },
        [53107440]={ type="item", quest=36654, item=118714, note="Remains of Balik Orecrusher", },
        [57805600]={ type="item", quest=36605, item=118703, note="Remains of Balldir Deeprock", },
        [59406370]={ type="item", quest=36628, item=118712, note="Vindicator's Hammer", },
        [71906660]={ type="currency", quest=nil, label="Sunken Treasure", currency=824, },
        -- rares
        [37608140]={ type="item", quest=36600, item=118231, npc=85970, }, -- Riptar
        [38206620]={ type="item", quest=35910, item=118224, npc=79629, }, -- Stomper Kreego
        [40007900]={ type="item", quest=35335, item=118222, npc=82085, toy=true, }, -- Bashiok
        [40205960]={ type="item", quest=36394, item=114227, npc=80725, toy=true, }, -- Sulfurious
        [41804540]={ type="item", quest=36391, item=118230, npc=81038, }, -- Gelgor of the Blue Flame
        [44609220]={ type="item", quest=36656, item=118223, npc=86137, }, -- Sunclaw
        [46003360]={ type="npc", quest=37368, npc=86579, achievement=9655,  }, -- Blademaster Ro'gor
        [46205080]={ type="item", quest=36204, item=118229, npc=80868, }, -- Glut
        [46804320]={ type="item", quest=36186, item=118210, npc=84431, }, -- Greldrok the Cunning
        [47002380]={ type="npc", quest=37365, npc=86577, achievement=9655, }, -- Horgg
        [47002580]={ type="npc", quest=37364, npc=86582, achievement=9655, }, -- Morgo Kain
        [47603060]={ type="npc", quest=37367, npc=86574, achievement=9655, }, -- Inventor Blammo
        [47804140]={ type="item", quest=36393, item=118211, npc=85264, }, -- Rolkor
        [48202100]={ type="npc", quest=37362, npc=86566, achievement=9655, }, -- Defector Dazgo
        [49003380]={ type="npc", quest=37363, npc=86562, achievement=9655, }, -- Maniacal Madgard
        [50002380]={ type="npc", quest=37366, npc=86571, achievement=9655, }, -- Durp the Hated
        [50605320]={ type="item", quest=36178, item=118709, npc=84406, pet=true, }, -- Mandrakor
        [52207020]={ type="item", quest=35908, item=118209, npc=83522, }, -- Hive Queen Skrikka
        [52805360]={ type="item", quest=37413, item=119397, npc=78269, currency=823, }, -- Gnarljaw
        [53404460]={ type="item", quest=35503, item=118212, npc=82311, }, -- Char the Burning
        [53407820]={ type="item", quest=34726, item=118208, npc=76473, }, -- Mother Araneae
        [54207240]={ type="item", quest=36837, item=118228, npc=86520, }, -- Stompalupagus
        [55004660]={ type="item", quest=37377, item=119412, npc=88672, currency=823, achievement=9678, }, -- Hunter Bal'ra
        [57406860]={ type="item", quest=36387, item=118221, npc=85250, toy=true, }, -- Fossilwood the Petrified
        [57603580]={ type="item", quest=37370, item=119406, npc=82058, currency=823, achievement=9678, }, -- Depthroot
        [58006360]={ type="item", quest=35153, item=113453, npc=80785, }, -- Fungal Praetorian
        [58604120]={ type="npc", quest=37371, npc=86268, currency=823, achievement=9678, }, -- Alkali
        [59604300]={ type="item", quest=37375, item=119414, npc=88583, currency=823, achievement=9678, }, -- Grove Warden Yal
        [61803930]={ type="item", quest=37376, item=119391, npc=88586, currency=823, achievement=9678, }, -- Mogamago
        [63803160]={ type="npc", quest=37372, npc=86266, achievement=9678, }, -- Venolasix
        [64006180]={ type="item", quest=36794, item=118213, npc=86410, }, -- Sylldross
        [69204460]={ type="item", quest=37369, item=119432, npc=86257, toy=true, achievement=9678, }, -- Basten
        [70803400]={ type="item", quest=37374, item=119367, npc=88582, currency=823, achievement=9678, }, -- Swift Onyx Flayer
        [72803580]={ type="npc", quest=37373, npc=88580, achievement=9678, }, -- Firestarter Grash
        [76004200]={ type="npc", quest=37405, npc=80371, currency=823, }, -- Typhon
    },
    ["Talador"] = {

    },
    ["SpiresOfArak"] = {

    },
    -- these might /all/ be junk? don't know yet
    ["garrisonsmvalliance_tier1"] = {
        [49604380]={ type="currency", quest=35530, currency=824, label="Lunarfall Egg", note="wagon", },
        [51800110]={ type="currency", quest=35289, currency=824, label="Spark's Stolen Supplies", note="cave by lake", },
        [42405436]={ type="currency", quest=35381, currency=824, label="Pippers' Buried Supplies 1", },
        [50704850]={ type="currency", quest=35382, currency=824, label="Pippers' Buried Supplies 2", },
        [30802830]={ type="currency", quest=35383, currency=824, label="Pippers' Buried Supplies 3", },
        [49197683]={ type="currency", quest=35384, currency=824, label="Pippers' Buried Supplies 4", },
    },
    ["garrisonsmvalliance_tier2"] = {
        [37306590]={ type="currency", quest=35530, currency=824, label="Lunarfall Egg, wagon", },
        [51800110]={ type="currency", quest=35289, currency=824, label="Spark's Stolen Supplies", note="cave by lake", },
        [41685803]={ type="currency", quest=35381, currency=824, label="Pippers' Buried Supplies 1", },
        [51874545]={ type="currency", quest=35382, currency=824, label="Pippers' Buried Supplies 2", },
        [34972345]={ type="currency", quest=35383, currency=824, label="Pippers' Buried Supplies 3", },
        [46637608]={ type="currency", quest=35384, currency=824, label="Pippers' Buried Supplies 4", },
    },
    ["garrisonsmvalliance_tier3"] = {
        [61277261]={ type="currency", quest=35530, currency=824, label="Lunarfall Egg, tent", },
        [51800110]={ type="currency", quest=35289, currency=824, label="Spark's Stolen Supplies", note="cave by lake", },
        [60575515]={ type="currency", quest=35381, currency=824, label="Pippers' Buried Supplies 1", },
        [37307491]={ type="currency", quest=35382, currency=824, label="Pippers' Buried Supplies 2", },
        [37864378]={ type="currency", quest=35383, currency=824, label="Pippers' Buried Supplies 3", },
        [61527154]={ type="currency", quest=35384, currency=824, label="Pippers' Buried Supplies 4", },
    },
}

local cache_tooltip = CreateFrame("GameTooltip", "HNTreasureHunterTooltip")
cache_tooltip:AddFontStrings(
    cache_tooltip:CreateFontString("$parentTextLeft1", nil, "GameTooltipText"),
    cache_tooltip:CreateFontString("$parentTextRight1", nil, "GameTooltipText")
)
local name_cache = {}
local function mob_name(id)
    if not name_cache[id] then
        -- this doesn't work with just clearlines and the setowner outside of this, and I'm not sure why
        cache_tooltip:SetOwner(WorldFrame, "ANCHOR_NONE")
        cache_tooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(id))
        if cache_tooltip:IsShown() then
            name_cache[id] = HNTreasureHunterTooltipTextLeft1:GetText()
        end
    end
    return name_cache[id]
end

local default_texture
local icon_cache = {}
local trimmed_icon = function(texture)
    if not icon_cache[texture] then
        icon_cache[texture] = {
            icon = texture,
            tCoordLeft = 0.1,
            tCoordRight = 0.9,
            tCoordTop = 0.1,
            tCoordBottom = 0.9,
        }
    end
    return icon_cache[texture]
end
local function work_out_label(point)
    local fallback
    if point.label then
        return point.label
    end
    if point.item then
        local _, link, _, _, _, _, _, _, _, texture = GetItemInfo(point.item)
        if link then
            return link
        end
        fallback = 'item:'..point.item
    end
    if point.npc then
        local name = mob_name(point.npc)
        if name then
            return name
        end
        fallback = 'npc:'..point.npc
    end
    if point.currency then
        local name, _, texture = GetCurrencyInfo(point.currency)
        if name then
            return name
        end
    end
    return UNKNOWN
end
local function work_out_texture(point)
    if point.item and db.icon_item then
        local texture = select(10, GetItemInfo(point.item))
        if texture then
            return trimmed_icon(texture)
        end
    end
    if point.currency then
        local texture = select(3, GetCurrencyInfo(point.currency))
        if texture then
            return trimmed_icon(texture)
        end
    end
    if point.achievement then
        local texture = select(10, GetAchievementInfo(point.achievement))
        if texture then
            return trimmed_icon(texture)
        end
    end
    -- if point.npc then

    -- end
    return trimmed_icon(default_texture)
end
local get_point_info = function(point)
    if not default_texture then
        default_texture = select(10, GetAchievementInfo(9726))
    end
    if point then
        local label = work_out_label(point)
        local icon = work_out_texture(point)
        local category = point.junk and "junk" or "treasure"
        return label, icon, category, point.quest
    end
end
local get_point_info_by_coord = function(mapFile, coord)
    mapFile = string.gsub(mapFile, "_terrain%d+$", "")
    return get_point_info(points[mapFile] and points[mapFile][coord])
end

local function handle_tooltip(tooltip, point)
    if point then
        -- major:
        if point.label then
            tooltip:AddLine(point.label)
        elseif point.item then
            tooltip:SetHyperlink(("item:%d"):format(point.item))
        elseif point.npc then
            tooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(point.npc))
        end

        if point.item and point.npc then
            tooltip:AddDoubleLine(CREATURE, mob_name(point.npc) or point.npc)
        end
        if point.currency then
            local name = GetCurrencyInfo(point.currency)
            tooltip:AddDoubleLine(CURRENCY, name or point.currency)
        end
        if point.achievement then
            local _, name = GetAchievementInfo(point.achievement)
            tooltip:AddDoubleLine(BATTLE_PET_SOURCE_6, name or point.achievement)
        end
        if point.note then
            tooltip:AddLine(point.note)
        end
    else
        tooltip:SetText(UNKNOWN)
    end
    tooltip:Show()
end
local handle_tooltip_by_coord = function(tooltip, mapFile, coord)
    mapFile = string.gsub(mapFile, "_terrain%d+$", "")
    return handle_tooltip(tooltip, points[mapFile] and points[mapFile][coord])
end

---------------------------------------------------------
-- Plugin Handlers to HandyNotes
local HLHandler = {}
local info = {}

function HLHandler:OnEnter(mapFile, coord)
    local tooltip = self:GetParent() == WorldMapButton and WorldMapTooltip or GameTooltip
    if ( self:GetCenter() > UIParent:GetCenter() ) then -- compare X coordinate
        tooltip:SetOwner(self, "ANCHOR_LEFT")
    else
        tooltip:SetOwner(self, "ANCHOR_RIGHT")
    end
    handle_tooltip_by_coord(tooltip, mapFile, coord)
end

local function createWaypoint(button, mapFile, coord)
    local c, z = HandyNotes:GetCZ(mapFile)
    local x, y = HandyNotes:getXY(coord)
    local label = get_point_info_by_coord(mapFile, coord)
    if TomTom then
        local persistent, minimap, world
        if temporary then
            persistent = true
            minimap = false
            world = false
        end
        TomTom:AddZWaypoint(c, z, x*100, y*100, label, persistent, minimap, world)
    elseif Cartographer_Waypoints then
        Cartographer_Waypoints:AddWaypoint(NotePoint:new(HandyNotes:GetCZToZone(c, z), x, y, label))
    end
end

do
    local currentZone, currentCoord
    local function generateMenu(button, level)
        if (not level) then return end
        for k in pairs(info) do info[k] = nil end
        if (level == 1) then
            -- Create the title of the menu
            info.isTitle      = 1
            info.text         = "HandyNotes - TreasureHunter"
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)

            if TomTom or Cartographer_Waypoints then
                -- Waypoint menu item
                info.disabled     = nil
                info.isTitle      = nil
                info.notCheckable = nil
                info.text = "Create waypoint"
                info.icon = nil
                info.func = createWaypoint
                info.arg1 = currentZone
                info.arg2 = currentCoord
                UIDropDownMenu_AddButton(info, level);
            end

            -- Close menu item
            info.text         = "Close"
            info.icon         = nil
            info.func         = function() CloseDropDownMenus() end
            info.arg1         = nil
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level);
        end
    end
    local HL_Dropdown = CreateFrame("Frame", "HandyNotes_TreasureHunterDropdownMenu")
    HL_Dropdown.displayMode = "MENU"
    HL_Dropdown.initialize = generateMenu

    function HLHandler:OnClick(button, down, mapFile, coord)
        if button == "RightButton" and not down then
            currentZone = string.gsub(mapFile, "_terrain%d+$", "")
            currentCoord = coord
            ToggleDropDownMenu(1, nil, HL_Dropdown, self, 0, 0)
        end
    end
end

function HLHandler:OnLeave(mapFile, coord)
    if self:GetParent() == WorldMapButton then
        WorldMapTooltip:Hide()
    else
        GameTooltip:Hide()
    end
end

do
    -- This is a custom iterator we use to iterate over every node in a given zone
    local currentLevel
    local function iter(t, prestate)
        if not t then return nil end
        local state, value = next(t, prestate)
        while state do -- Have we reached the end of this zone?
            if value then
                if not value.level or value.level == currentLevel then
                    local label, icon, category, quest = get_point_info(value)
                    -- Debug("iter step", state, icon, db.icon_scale, db.icon_alpha, category, quest)
                    if (
                        (category ~= "junk" or db.show_junk)
                        and (db.found or not (quest and IsQuestFlaggedCompleted(quest)))
                    ) then
                        return state, nil, icon, db.icon_scale, db.icon_alpha
                    end
                end
            end
            state, value = next(t, state) -- Get next data
        end
        return nil, nil, nil, nil
    end
    function HLHandler:GetNodes(mapFile, minimap, level)
        currentLevel = level
        mapFile = string.gsub(mapFile, "_terrain%d+$", "")
        return iter, points[mapFile], nil
    end
end

---------------------------------------------------------
-- Options table
local options = {
    type = "group",
    name = "TreasureHunter",
    desc = "TreasureHunter",
    get = function(info) return db[info[#info]] end,
    set = function(info, v)
        db[info[#info]] = v
        HL:SendMessage("HandyNotes_NotifyUpdate", "TreasureHunter")
    end,
    args = {
        desc = {
            name = "These settings control the look and feel of the icon.",
            type = "description",
            order = 0,
        },
        icon_scale = {
            type = "range",
            name = "Icon Scale",
            desc = "The scale of the icons",
            min = 0.25, max = 2, step = 0.01,
            order = 20,
        },
        icon_alpha = {
            type = "range",
            name = "Icon Alpha",
            desc = "The alpha transparency of the icons",
            min = 0, max = 1, step = 0.01,
            order = 30,
        },
        icon_item = {
            type = "toggle",
            name = "Item icons",
            desc = "Show the icons for items, if known; otherwise, the achievement icon will be used",
        },
        show_junk = {
            type = "toggle",
            name = "Junk",
            desc = "Show items which don't count for any achievement",
        },
        found = {
            type = "toggle",
            name = "Show found",
            desc = "Show waypoints for items you've already found?",
        },
    },
}


---------------------------------------------------------
-- Addon initialization, enabling and disabling

function HL:OnInitialize()
    -- Set up our database
    self.db = LibStub("AceDB-3.0"):New("HandyNotes_TreasureHunterDB", defaults)
    db = self.db.profile
    -- Initialize our database with HandyNotes
    HandyNotes:RegisterPluginDB("TreasureHunter", HLHandler, options)
end

function HL:Refresh()
    self:SendMessage("HandyNotes_NotifyUpdate", "TreasureHunter")
end
