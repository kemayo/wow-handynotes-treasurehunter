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
        [52907140] = { type="item", id=86394, note="in the cave", quest=31413, }, -- Hozen Warrior Spear
    }.
    --]]
    ["NagrandDraenor"] = {

    },
    ["ShadowmoonValleyDR"] = {
        -- garrison-y
        [27100260]={ type="currency", quest=35280, id=824, note="Stolen Treasure", },
        [26500570]={ type="currency", quest=34174, id=824, note="Fantastic Fish", },
        [28800710]={ type="currency", quest=35279, id=824, note="Sunken Treasure", },
        [30301990]={ type="currency", quest=35530, id=824, note="Lunarfall Egg", note="Moves to the garrison once built", },
        [45802460]={ type="currency", quest=33570, id=824, note="Shadowmoon Exile Treasure", note="cave below Exile Rise", },
        [52902490]={ type="currency", quest=37254, id=824, note="Mushroom-Covered Chest", },
        [57904530]={ type="currency", quest=33568, id=824, note="Kaliri Egg", },
        [28303930]={ type="currency", quest=33571, id=824, note="Shadowmoon Treasure", },
        [42106130]={ type="currency", quest=33041, id=824, note="Iron Horde Cargo Shipment", },
        [84504470]={ type="currency", quest=33885, id=824, note="Cargo of the Raven Queen", },
        -- treasures
        [20303060]={ type="item", quest=33575, id=108904, note="Demonic Cache", },
        [22803390]={ type="item", quest=33572, id=113373, note="Rotting Basket", },
        [30004530]={ type="item", quest=35919, id=113563, note="Shadowmoon Sacrificial Dagger" },
        [31303910]={ type="item", quest=33886, id=109081, note="Ronokk's Belongings", },
        [33503970]={ type="item", quest=33569, id=113545, note="Reusable mana potion", },
        [34204350]={ type="item", quest=33866, id=109124, note="Veema's Herb Bag", },
        [34404620]={ type="item", quest=33891, id=108901, note="Giant Moonwillow Cone", },
        [35904090]={ type="item", quest=33540, id=113546, note="Uzko's Knickknacks", },
        [36704450]={ type="item", quest=33573, id=113378, },
        [36804140]={ type="item", quest=33046, id=113547, note="Beloved's Offering, offhand decoration", },
        [37202310]={ type="item", quest=33613, id=108945, note="in cave, Bubbling Cauldron", },
        [37202610]={ type="item", quest=35677, id=110506, note="Sunken Fishing Boat, fishy fun items", },
        [37505930]={ type="item", quest=33567, id=108903, note="Iron Horde Tribute", },
        [37704430]={ type="item", quest=33584, id=113531, note="Consumable: Rested XP", },
        [38504300]={ type="item", quest=33614, id=113408, note="Greka's Urn", },
        [39208380]={ type="item", quest=33566, id=113372, note="Waterlogged Chest", },
        [41502790]={ type="item", quest=33869, id=108902, note="Armored Elekk Tusk", },
        [43806060]={ type="plain", quest=33611, id="Peaceful Offering 1", },
        [44505920]={ type="plain", quest=33612, id="Peaceful Offering 4", },
        [44506350]={ type="plain", quest=33384, id="Peaceful Offering 3", },
        [45206050]={ type="plain", quest=33610, id="Peaceful Offering 2", },
        [47104610]={ type="item", quest=33564, id=108900, note="Hanging Satchel", },
        [48704750]={ type="item", quest=35798, id=109130, note="Glowing Cave Mushroom", },
        [49303750]={ type="item", quest=33867, id=109739, note="Astrologer's Box", toy=true, },
        [51107910]={ type="item", quest=33574, id=113375, note="Vindicator's Cache", toy=true, },
        [51803550]={ type="plain", quest=33037, id="False-Bottomed Jar", note="Gold", },
        [55004500]={ type="item", quest=35581, id=109124, note="Alchemist's Satchel", },
        [55307480]={ type="item", quest=35580, id=117550, note="Swamplighter Hive", toy=true, },
        [55801990]={ type="item", quest=35600, id=118104, note="Strange Spore", pet=true, },
        [58902200]={ type="item", quest=35603, id=113215, note="Mikkal's Chest, a sick burn from the NPC", },
        [66903350]={ type="item", quest=36507, id=116875, note="Orc Skeleton", },
        [67108430]={ type="item", quest=33565, id=44722, note="Scaly Rylak Egg, ah the memories", },
        -- rares (do these count for the 'treasure hunter' achievement?)
        [37203640]={ type="item", quest=33061, id=109060, note="Amaukwa", npc=77140, },
        [52801680]={ type="item", quest=35731, id=113540, note="Ba'ruun, reusable food (no buff)", npc=82326, },
        [29600620]={ type="item", quest=35281, id=111666, note="Bahameye", npc=81406, },
        [48604360]={ type="item", quest=33064, id=109075, note="Dark Emanation", npc=77085, },
        [41008300]={ type="item", quest=35448, id=113548, note="Darkmaster Go'vid", npc=82268, },
        [49604200]={ type="item", quest=35555, id=113541, note="Darktalon", npc=82411, },
        [29603380]={ type="item", quest=33664, id=113082, note="Gorum", npc=76380, },
        [61606180]={ type="item", quest=35725, id=113557, note="Faebright", npc=82207, },
        [67806380]={ type="item", quest=35688, id=113556, note="Enavra", npc=82676, },
        [37404880]={ type="item", quest=35558, id=113631, note="Hypnocroak", toy=true, npc=79524, },
        [57404840]={ type="item", quest=35909, id=113571, note="Insha'tar", npc=83553, },
        [40804440]={ type="item", quest=33043, id=109078, note="Killmaw", npc=74206, },
        [32203500]={ type="item", quest=33039, id=109061, note="Ku'targ the Voidseer", npc=72362, },
        [37601460]={ type="item", quest=33055, id=108907, note="Leaf-Reader Kurri", npc=72537, },
        [44802080]={ type="item", quest=35906, id=113561, note="Mad King Sporeon ", npc=77310, },
        [38607020]={ type="item", quest=35523, id=113559, note="Morva Soultwister", npc=82362, },
        [44005760]={ type="item", quest=33642, id=119449, note="Mother Om'ra, hunter quest", npc=75071, },
        [48602260]={ type="item", quest=35553, id=113542, note="Rai'vosh, reusable slow-fall Item", npc=82374, },
        [53005060]={ type="item", quest=34068, id=109077, note="Rockhoof", npc=72606, },
        [61005520]={ type="item", quest=35732, id=113543, note="Shinri, 400% Ground Mount with Cooldown", npc=82415, },
        [27604360]={ type="item", quest=36880, id=118734, note="Sneevel", npc=86689, },
        [21602100]={ type="item", quest=33640, id=108906, note="Veloss", npc=75482, },
        [54607060]={ type="item", quest=33643, id=108957, note="Venomshade", npc=75492, },
        [32604140]={ type="item", quest=35847, id=109074, note="Voidseer Kalurg", npc=83385, },
        [48806640]={ type="item", quest=33389, id=113570, note="Yggdrel", toy=true, npc=75435, },
        [42804100]={ type="item", quest=33038, id=113553, note="Windfang Matriarch", npc=75434, },
        [43807740]={ type="item", quest=33383, id=117551, note="Brambleking Fili", npc=81639, },
        [31905720]={ type="item", quest=37359, id=119392, note="Voidreaver Urnae", npc=85078, },
        [29605080]={ type="item", quest=37357, id=119369, note="Malgosh Shadowkeeper", npc=85451, },
        [46007160]={ type="currency", quest=37351, id=823, note="Demidos", npc=84911, },
        [48007760]={ type="item", quest=37355, id=119360, note="Lady Temptessa", npc=85121, },
        [50207240]={ type="currency", quest=37352, id=823, note="Quartermaster Hershak", npc=84925, },
        [48208100]={ type="currency", quest=37354, id=823, note="Shadowspeaker Niir", npc=85029, },
        [50807880]={ type="item", quest=37356, id=86213, note="Aqualir", npc=86213, },
        [51807920]={ type="item", quest=37353, id=85001, note="Master Sergeant Milgra", npc=85001, },
        [61408880]={ type="item", quest=37411, id=119411, note="Slivermaw", npc=85837, },
        [58408680]={ type="plain", quest=37409, id="Nagidna,", note="in a cave @ 59,89", npc=85555, }, -- item not known yet...
        [68208480]={ type="currency", quest=37410, id=823, note="Avalanche", npc=85568, },
    },
    ["FrostfireRidge"] = {

    },
    ["Gorgrond"] = {

    },
    ["Talador"] = {

    },
    ["SpiresOfArak"] = {

    },
    -- these might /all/ be junk? don't know yet
    ["garrisonsmvalliance_tier1"] = {
        [49604380]={ type="garrison", quest=35530, id=824, note="Lunarfall Egg, wagon", },
        [51800110]={ type="garrison", quest=35289, id=824, note="Spark's Stolen Supplies, cave by lake", },
        [42405436]={ type="garrison", quest=35381, id=824, note="Pippers' Buried Supplies 1", },
        [50704850]={ type="garrison", quest=35382, id=824, note="Pippers' Buried Supplies 2", },
        [30802830]={ type="garrison", quest=35383, id=824, note="Pippers' Buried Supplies 3", },
        [49197683]={ type="garrison", quest=35384, id=824, note="Pippers' Buried Supplies 4", },
    },
    ["garrisonsmvalliance_tier2"] = {
        [37306590]={ type="garrison", quest=35530, id=824, note="Lunarfall Egg, wagon", },
        [51800110]={ type="garrison", quest=35289, id=824, note="Spark's Stolen Supplies, cave by lake", },
        [41685803]={ type="garrison", quest=35381, id=824, note="Pippers' Buried Supplies 1", },
        [51874545]={ type="garrison", quest=35382, id=824, note="Pippers' Buried Supplies 2", },
        [34972345]={ type="garrison", quest=35383, id=824, note="Pippers' Buried Supplies 3", },
        [46637608]={ type="garrison", quest=35384, id=824, note="Pippers' Buried Supplies 4", },
    },
    ["garrisonsmvalliance_tier3"] = {
        [61277261]={ type="garrison", quest=35530, id=824, note="Lunarfall Egg, tent", },
        [51800110]={ type="garrison", quest=35289, id=824, note="Spark's Stolen Supplies, cave by lake", },
        [60575515]={ type="garrison", quest=35381, id=824, note="Pippers' Buried Supplies 1", },
        [37307491]={ type="garrison", quest=35382, id=824, note="Pippers' Buried Supplies 2", },
        [37864378]={ type="garrison", quest=35383, id=824, note="Pippers' Buried Supplies 3", },
        [61527154]={ type="garrison", quest=35384, id=824, note="Pippers' Buried Supplies 4", },
    },
}

local default_texture, default_texture_riches, garrison_texture, garrison_name
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
local point_info_handlers = {
    -- return: name, icon
    item = function(point)
        local name, link, _, _, _, _, _, _, _, texture = GetItemInfo(point.id)
        return link or 'item:'..point.id, trimmed_icon(db.icon_item and texture or default_texture)
    end,
    plain = function(point)
        return point.id, trimmed_icon(default_texture)
    end,
    currency = function(point)
        local name, _, texture = select(3, GetCurrencyInfo(point.currency))
        return name, trimmed_icon(texture)
    end,
    npc = function(point)
        local name
        return name or ('npc:'..point.npc), trimmed_icon(default_texture)
    end,
}
local get_point_info = function(point)
    if not default_texture then
        default_texture = select(10, GetAchievementInfo(9726))
    end
    if point then
        local label, icon = point_info_handlers[point.type](point)
        if point.note then
            label = ("%s (%s)"):format(label, point.note)
        end
        if not (point.junk) then
            label = ("%s: %s"):format(ITEM_QUALITY3_DESC, label) -- rare
        end
        local category = point.junk and "junk" or "treasure"
        return label, icon, category, point.quest
    end
end
local get_point_info_by_coord = function(mapFile, coord)
    mapFile = string.gsub(mapFile, "_terrain%d+$", "")
    return get_point_info(points[mapFile] and points[mapFile][coord])
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
    local label = get_point_info_by_coord(mapFile, coord)
    if label then
        tooltip:SetText(label)
        tooltip:Show()
    end
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
