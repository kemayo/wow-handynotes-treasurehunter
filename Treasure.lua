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
        show_lost = true,
        show_riches = true,
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
    
}

local default_texture, default_texture_riches
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
    item = function(point)
        local name, link, _, _, _, _, _, _, _, texture = GetItemInfo(point.id)
        return link or 'item:'..point.id, trimmed_icon(db.icon_item and texture or (point.riches and default_texture_riches or default_texture))
    end,
    plain = function(point)
        return point.id, trimmed_icon(point.riches and default_texture_riches or default_texture)
    end,
}
local get_point_info = function(point)
    if not default_texture then
        default_texture = select(10, GetAchievementInfo(7284))
        default_texture_riches = select(10, GetAchievementInfo(7997))
    end
    if point then
        local label, icon = point_info_handlers[point.type](point)
        if point.note then
            label = ("%s (%s)"):format(label, point.note)
        end
        if not (point.junk or point.riches) then
            label = ("%s: %s"):format(ITEM_QUALITY3_DESC, label) -- rare
        end
        local category = point.junk and "junk" or (point.riches and "riches") or "lost"
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
                    if quest == 31865 then
                        Debug(label, category, quest)
                        Debug("SETTINGS", db.show_junk, db.show_riches, db.show_lost, db.found)
                        Debug("TEST",
                            (category ~= "junk" or db.show_junk),
                            (category ~= "riches" or db.show_riches),
                            (category ~= "lost" or db.show_lost),
                            (db.found or not (quest and IsQuestFlaggedCompleted(quest))),
                            (category ~= "junk" or db.show_junk)
                                and (category ~= "riches" or db.show_riches)
                                and (category ~= "lost" or db.show_lost)
                                and (db.found or not (quest and IsQuestFlaggedCompleted(quest)))
                        )
                    end
                    if (
                        (category ~= "junk" or db.show_junk)
                        and (category ~= "riches" or db.show_riches)
                        and (category ~= "lost" or db.show_lost)
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
        show_lost = {
            type = "toggle",
            name = "Lost and Found",
            desc = "Show items that count for the Lost and Found achievement",
        },
        show_riches = {
            type = "toggle",
            name = "Riches of Pandaria",
            desc = "Show items that count for the Riches of Pandaria achievement",
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
