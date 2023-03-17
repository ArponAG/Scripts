--Beta
local version = "v2.0.0b13"

---// Loading Section \\---
repeat  task.wait() until game:IsLoaded()
if game.PlaceId == 8304191830 then
    repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("collection"):FindFirstChild("grid"):FindFirstChild("List"):FindFirstChild("Outer"):FindFirstChild("UnitFrames")
else
    repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    game:GetService("ReplicatedStorage").endpoints.client_to_server.vote_start:InvokeServer()
    repeat task.wait() until game:GetService("Workspace")["_waves_started"].Value == true
end
------------------------------
local a = 'Anime_Adventures' -- Paste Name
local b = game:GetService('Players').LocalPlayer.Name .. '_AnimeAdventures.json' 
Settings = {}
function saveSettings()
    local HttpService = game:GetService('HttpService')
    if not isfolder(a) then
        makefolder(a)
    end
    writefile(a .. '/' .. b, HttpService:JSONEncode(Settings))
    Settings = ReadSetting()
    warn("Settings Saved!")
end

function ReadSetting()
    local s, e = pcall(function()
        local HttpService = game:GetService('HttpService')
        if not isfolder(a) then
            makefolder(a)
        end
        return HttpService:JSONDecode(readfile(a .. '/' .. b))
    end)
    if s then
        return e
    else
        saveSettings()
        return ReadSetting()
    end
end

Settings = ReadSetting()
------------------------------
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace") 
local plr = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local mouse = game.Players.LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")
------------------------------
getgenv().item = "-"

plr.PlayerGui:FindFirstChild("HatchInfo"):FindFirstChild("holder"):FindFirstChild("info1"):FindFirstChild("UnitName").Text = getgenv().item

function webhook()

    local url = Settings.WebhookUrl
    print("webhook?")
    if url == "" then
    warn("Webhook Url is empty!")
    return
    end 
    
    userlevel = plr.PlayerGui:FindFirstChild("spawn_units"):FindFirstChild("Lives"):FindFirstChild("Main"):FindFirstChild("Desc"):FindFirstChild("Level").Text
    totalgems = plr.PlayerGui:FindFirstChild("spawn_units"):FindFirstChild("Lives"):FindFirstChild("Frame"):FindFirstChild("Resource"):FindFirstChild("Gem"):FindFirstChild("Level").Text
    
    ResultHolder = plr.PlayerGui:FindFirstChild("ResultsUI"):FindFirstChild("Holder")
    if game.PlaceId ~= 8304191830 then
    levelname = game:GetService("Workspace"):FindFirstChild("_MAP_CONFIG"):FindFirstChild("GetLevelData"):InvokeServer()["name"]
    result = ResultHolder.Title.Text else levelname, result = "nil","nil" end
    
    gold = ResultHolder:FindFirstChild("LevelRewards"):FindFirstChild("ScrollingFrame"):FindFirstChild("GoldReward"):FindFirstChild("Main"):FindFirstChild("Amount").Text
    if gold == "+99999" then gold = "+0" end	 
    gems = ResultHolder:FindFirstChild("LevelRewards"):FindFirstChild("ScrollingFrame"):FindFirstChild("GemReward"):FindFirstChild("Main"):FindFirstChild("Amount").Text
    if gems == "+99999" then gems = "+0" end	 
    xpx = ResultHolder:FindFirstChild("LevelRewards"):FindFirstChild("ScrollingFrame"):FindFirstChild("XPReward"):FindFirstChild("Main"):FindFirstChild("Amount").Text
    xp = xpx:split(" ")
    if xp[1] == "+99999" then xp[1] = "+0" end
    trophy = ResultHolder:FindFirstChild("LevelRewards"):FindFirstChild("ScrollingFrame"):FindFirstChild("TrophyReward"):FindFirstChild("Main"):FindFirstChild("Amount").Text
    if trophy == "+99999" then trophy = "+0" end	 
    
    totaltime =  ResultHolder:FindFirstChild("Middle"):FindFirstChild("Timer").Text
    totalwaves = ResultHolder:FindFirstChild("Middle"):FindFirstChild("WavesCompleted").Text
    
    local data = {
        ["content"] =" ",
        ["embeds"] = {
         {
          ["title"] ="||"..plr.Name.."||",
          ["url"] = "https://www.roblox.com/users/"..plr.UserId,
          ["description"] = tostring(userlevel),
          ["author"] = {["name"] = version},
          ["color"] = null,
          ["fields"] = {
             {
              ["name"] ="Result",
              ["value"] = levelname.." — "..result,
              ["inline"] = true
             },
             {
              ["name"] ="Rewards",
              ["value"] = getgenv().item.."\n"..gold.." Gold\n"..gems.." Gems\n"..xp[1].." XP\n"..trophy.." Trophy\n⬖ Total Gems = "..totalgems
             }
          }
        }
      }
    }
    
    local xd = game:GetService("HttpService"):JSONEncode(data)
    
    local headers = {["content-type"] = "application/json"}
    request = http_request or request or HttpPost or syn.request or http.request
    local sex = {Url = url, Body = xd, Method = "POST", Headers = headers}
    warn("Sending webhook notification...")
    request(sex)

end
------------------------------\
if game.CoreGui:FindFirstChild("FinityUI") then
    game.CoreGui["FinityUI"]:Destroy()
end

local dir = "Anime_Adventures/"..game.Players.LocalPlayer.Name
local Uilib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ArponAG/Scripts/main/finitylib"))()
local exec = tostring(identifyexecutor())

local Window = Uilib.new(true, "[UPD 11.5.0] Anime Adventures "..version.." - "..exec)
Window.ChangeToggleKey(Enum.KeyCode.RightShift)


local Home = Window:Category(" 📋 Home")
local Developers = Home:Sector("Anime Adventures")
local asdasd = Home:Sector(" ")
local UIUPDT = Home:Sector("UI UPDATE (February 20th)")


local Farm = Window:Category(" 🏹 Auto Farm")
local SelectUnits = Farm:Sector("Units Selection")
local SelectWorld = Farm:Sector("World Selection")
local UnitPosition = Farm:Sector("Select Unit Position")
local MoreFarmConfig = Farm:Sector("More Farming Config")
local AutoFarmConfig = Farm:Sector("Auto Farm Config")
local ChallengeConfig = Farm:Sector("Challenge Config")


local UC = Window:Category(" 👥 Unit Config")
local NDY = UC:Sector("NOT DONE YET")
local emptyxx = UC:Sector(" ")
local Unit1 = UC:Sector("Unit 1")
local Unit2 = UC:Sector("Unit 2")
local Unit3 = UC:Sector("Unit 3")
local Unit4 = UC:Sector("Unit 4")
local Unit5 = UC:Sector("Unit 5")
local Unit6 = UC:Sector("Unit 6")


local Misc = Window:Category(" 🛠 Misc")
local AutoSummonSec = Misc:Sector("Auto Summon Units")
local AutoSnipeMerchantSec = Misc:Sector("Auto Snipe Merchant")
local WebhookSec = Misc:Sector("Discord Webhook")
local OtherSec = Misc:Sector("Other Options")

----------------------------------------------
---------------- Units Selection -------------
----------------------------------------------
local function UnitSec()
        --#region Select Units Tab
        local Units = {}
        
        function Check()
            local DataUnits = require(game:GetService("ReplicatedStorage").src.Data.Units)
            for i, v in pairs(getgenv().profile_data.equipped_units) do
                if DataUnits[v.unit_id] and v.equipped_slot then
                    Settings.SelectedUnits["U"..tostring(v.equipped_slot)] = tostring(DataUnits[v.unit_id].id) .. " #" .. tostring(v.uuid)
                    print("U"..tostring(v.equipped_slot).." "..tostring(DataUnits[v.unit_id].id).." #" .. tostring(v.uuid))
                end
            end
            saveSettings()
        end

        function LoadUnits()
            local DataUnits = require(game:GetService("ReplicatedStorage").src.Data.Units)
            table.clear(Units)
            for i, v in pairs(getgenv().profile_data.equipped_units) do
                if DataUnits[v.unit_id] then
                    table.insert(Units, DataUnits[v.unit_id].name .. " #" .. tostring(v.uuid))
                end
            end

            Check()
        end

        function GetUnits()
            if Settings.SelectedUnits == nil then
                Settings.SelectedUnits = {
                    U1 = "nil",
                    U2 = "nil",
                    U3 = "nil",
                    U4 = "nil",
                    U5 = "nil",
                    U6 = "nil"
                }
                saveSettings()
            end
            getgenv().profile_data = { equipped_units = {} }; repeat
                do
                    for i, v in pairs(getgc(true)) do
                        if type(v) == "table" and rawget(v, "xp") then wait()
                            table.insert(getgenv().profile_data.equipped_units, v)
                        end
                    end
                end
            until #getgenv().profile_data.equipped_units > 0
            LoadUnits()
        end

    GetUnits()

    SelectUnits:Cheat("Button", "🦸 Select Units", function() --Selects Currently Equipped Units!
        Settings.SelectedUnits = {
            U1 = "nil",
            U2 = "nil",
            U3 = "nil",
            U4 = "nil",
            U5 = "nil",
            U6 = "nil"
        }
        saveSettings()
        GetUnits()
    end)

    function switchteam(string)
        local args = { [1] = string }
        game:GetService("ReplicatedStorage").endpoints.client_to_server.switch_team_loadout:InvokeServer(unpack(args))
    end

    local a = SelectUnits:Cheat("Dropdown", "👥 Select Team",function(preset)
        Settings.SelectedPreset = preset
        print(preset)
        saveSettings()
    end, { 
        options = { "Team 1", "Team 2", "Team 3", "Team 4","Team 5" }, 
        default = Settings.SelectedPreset
    })

  --[[  SelectUnits:Cheat("Button", "💾 Save Units Preset", function() --Saves to preset
        preset = Settings.SelectedPreset
        if preset == "Team 1" then
            Settings.preset1 = Settings.SelectedUnits
        elseif preset == "Team 2" then
            Settings.preset2 = Settings.SelectedUnits
        elseif preset == "Team 3" then
            Settings.preset3 = Settings.SelectedUnits
        elseif preset == "Team 4" then
            Settings.preset4 = Settings.SelectedUnits
        elseif preset == "Team 5" then
            Settings.preset5 = Settings.SelectedUnits
        end
        print(preset)
        saveSettings()

    end)
    ]]--

    SelectUnits:Cheat("Button", "⌛ Switch Team", function() --loads preset
        preset = Settings.SelectedPreset
        if preset == "Team 1" then
            switchteam("1")
        elseif preset == "Team 2" then
            switchteam("2")
        elseif preset == "Team 3" then
            switchteam("3")
        elseif preset == "Team 4" then
            switchteam("4")
        elseif preset == "Team 5" then
            switchteam("5")
        end
        print(preset)
        GetUnits()

        --[[game:GetService("ReplicatedStorage").endpoints.client_to_server.unequip_all:InvokeServer()
            
        for i = 1, 6 do
            local unitinfo = loadpreset["U" .. i]
            warn(unitinfo)
            if unitinfo ~= nil then
                local unitinfo_ = unitinfo:split(" #")
                task.wait(0.5)
                game:GetService("ReplicatedStorage").endpoints.client_to_server.equip_unit:InvokeServer(unitinfo_[2])
            end
        end ]]--

    end)

end

----------------------------------------------
------------------ World Section -------------
----------------------------------------------
local function WorldSec()
    SelectWorld:Cheat("Dropdown", "🌟 Select Category",function(value)
        print(value)
        Settings.WorldCategory = value
        getgenv().updateworld()
        getgenv().updatelevel()
        getgenv().updatedifficulty()
        saveSettings()
    end, {
        options = {
            "Story Worlds",
            "Legend Stages",
            "Raid Worlds",
            "Portals",
            "Dungeon"
        },
        default = Settings.WorldCategory
    })

    local selectworld = SelectWorld:Cheat("Dropdown", "🌏 Select World",function(value)
        print(value)
        Settings.SelectedWorld = value
        getgenv().updatelevel()
        getgenv().updatedifficulty()
        saveSettings()
    end, {options = { }, default = Settings.SelectedWorld })

    getgenv().updateworld = function()
        selectworld:ClearDrop() local storylist;
        if Settings.WorldCategory == "Story Worlds" then
            storylist = {"Planet Namak", "Shiganshinu District", "Snowy Town","Hidden Sand Village", "Marine's Ford",
            "Ghoul City", "Hollow World", "Ant Kingdom", "Magic Town", "Cursed Academy","Clover Kingdom","Cape Canaveral", "Alien Spaceship","Fabled Kingdom"}
        elseif Settings.WorldCategory == "Legend Stages" then
            storylist = {"Clover Kingdom (Elf Invasion)", "Hollow Invasion","Cape Canaveral (Legend)", "Fabled Kingdom (Legend)"}
        elseif Settings.WorldCategory == "Raid Worlds" then
            storylist = {"Storm Hideout","West City", "Infinity Train", "Shiganshinu District - Raid","Hiddel Sand Village - Raid"}
        elseif Settings.WorldCategory == "Portals" then
            storylist = {"Alien Portals","Devil Portals (ANY)", "Demon Portals"}
        elseif Settings.WorldCategory == "Dungeon" then
            storylist = {"JJK Finger"}   
        end
    
        for i = 1, #storylist do
            selectworld:AddOption(storylist[i])
        end
    end

    local selectlevel = SelectWorld:Cheat("Dropdown", "✨ Select Level",function(value)
        print(value)
        Settings.SelectedLevel = value
        getgenv().updatedifficulty()
        saveSettings()
    end, {options = { }, default = Settings.SelectedLevel})

    getgenv().updatelevel = function()
        selectlevel:ClearDrop() local levellist; local level = Settings.SelectedWorld;
        ---///Story Worlds\\\---
        if level == "Planet Namak" then
            levellist = {"namek_infinite", "namek_level_1", "namek_level_2", "namek_level_3", "namek_level_4", "namek_level_5", "namek_level_6"}
        elseif level == "Shiganshinu District" then
            levellist = {"aot_infinite", "aot_level_1", "aot_level_2", "aot_level_3", "aot_level_4","aot_level_5", "aot_level_6"}
        elseif level == "Snowy Town" then
            levellist = {"demonslayer_infinite", "demonslayer_level_1", "demonslayer_level_2", "demonslayer_level_3", "demonslayer_level_4", "demonslayer_level_5","demonslayer_level_6"}
        elseif level == "Hidden Sand Village" then
            levellist =  {"naruto_infinite", "naruto_level_1", "naruto_level_2", "naruto_level_3","naruto_level_4", "naruto_level_5", "naruto_level_6"}
        elseif level == "Marine's Ford" then
            levellist = {"marineford_infinite","marineford_level_1","marineford_level_2","marineford_level_3","marineford_level_4","marineford_level_5","marineford_level_6"}
        elseif level == "Ghoul City" then
            levellist = {"tokyoghoul_infinite","tokyoghoul_level_1","tokyoghoul_level_2","tokyoghoul_level_3","tokyoghoul_level_4","tokyoghoul_level_5","tokyoghoul_level_6"}
        elseif level == "Hollow World" then
            levellist = {"hueco_infinite","hueco_level_1","hueco_level_2","hueco_level_3","hueco_level_4","hueco_level_5","hueco_level_6"}
        elseif level == "Ant Kingdom" then
            levellist = {"hxhant_infinite","hxhant_level_1","hxhant_level_2","hxhant_level_3","hxhant_level_4","hxhant_level_5","hxhant_level_6"}
        elseif level == "Magic Town" then
            levellist =  {"magnolia_infinite","magnolia_level_1","magnolia_level_2","magnolia_level_3","magnolia_level_4","magnolia_level_5","magnolia_level_6"}
        elseif level == "Cursed Academy" then
            levellist = {"jjk_infinite","jjk_level_1","jjk_level_2","jjk_level_3", "jjk_level_4","jjk_level_5","jjk_level_6"}
        elseif level == "Clover Kingdom" then
            levellist = {"clover_infinite","clover_level_1","clover_level_2","clover_level_3","clover_level_4","clover_level_5","clover_level_6"}
        elseif level == "Cape Canaveral" then
            levellist = {"jojo_infinite","jojo_level_1","jojo_level_2","jojo_level_3","jojo_level_4","jojo_level_5","jojo_level_6",}
        elseif level == "Alien Spaceship" then
            levellist = {"opm_infinite","opm_level_1","opm_level_2","opm_level_3","opm_level_4","opm_level_5","opm_level_6",}
        elseif level == "Fabled Kingdom" then
            levellist = {"7ds_infinite","7ds_level_1","7ds_level_2","7ds_level_3","7ds_level_4","7ds_level_5","7ds_level_6",}
        --///Legend Stages\\\---
        elseif level == "Clover Kingdom (Elf Invasion)" then
            levellist = {"clover_legend_1","clover_legend_2","clover_legend_3"}
        elseif level == "Hollow Invasion" then
            levellist = {"bleach_legend_1","bleach_legend_2","bleach_legend_3","bleach_legend_4","bleach_legend_5","bleach_legend_6"}
        elseif level == "Cape Canaveral (Legend)" then
            levellist = {"jojo_legend_1","jojo_legend_2","jojo_legend_3"}
        elseif level == "Fabled Kingdom (Legend)" then
            levellist = {"7ds_legend_1","7ds_legend_2","7ds_legend_3"}
        --///Raids\\\---
        elseif level == "Storm Hideout" then
            levellist = {"uchiha_level_1","uchiha_level_2","uchiha_level_3","uchiha_level_4","uchiha_level_5"}
        elseif level == "West City" then
            levellist = {"west_city_raid"}
        elseif level == "Infinity Train" then
            levellist = {"demonslayer_raid_1"}
        elseif level == "Shiganshinu District - Raid" then
            levellist = {"aot_raid_1"}
        elseif level == "Hiddel Sand Village - Raid" then
            levellist = {"naruto_raid_1"}
        --///Portals\\\---
        elseif level == "Alien Portals" then
            levellist = {"portal_boros_g"}
        elseif level == "Devil Portals (ANY)" then
            levellist = {"portal_csm"}
        elseif level == "Demon Portals" then
            levellist = {"portal_zeldris"}
            ---///Dungeon\\\---    
        elseif level == "JJK Finger" then
            levellist = {"jjk_finger"} 
        end


        for i = 1, #levellist do
            selectlevel:AddOption(levellist[i])
        end
    end

    local selectdiff = SelectWorld:Cheat("Dropdown", "💦 Difficulty",function(value)
        print(value, " Selected")
        Settings.Difficulty = value
        saveSettings()
    end, {
        options = {}, default = Settings.Difficulty
    })

    getgenv().updatedifficulty = function()
        selectdiff:ClearDrop(); level = Settings.SelectedLevel; cata = Settings.WorldCategory; local diff;
        if level == "namek_infinite" or level == "aot_infinite" or level == "demonslayer_infinite" 
        or level == "naruto_infinite" or level == "marineford_infinite" or level == "tokyoghoul_infinite" or level == "hueco_infinite" 
        or level == "hxhant_infinite" or level == "magnolia_infinite" or level == "jjk_infinite" or level == "clover_infinite" 
        or level == "jojo_infinite" or level == "opm_infinite" or cata == "Legend Stages" or cata == "Raid Worlds" then
            diff = {"Hard"}
        elseif cata == "Portals" or cata == "Dungeon"  then
            diff = {"Default"}
        else
            diff = {"Normal", "Hard"}
        end
        for i = 1, #diff do
            selectdiff:AddOption(diff[i])
        end
    end
    
    SelectWorld:Cheat("Checkbox","🙋️ Friends Only  ", function(bool)
        print(bool)
        Settings.isFriendOnly = bool
        saveSettings()
    end,{enabled = Settings.isFriendOnly})
end

----------------------------------------------
---------------- AutoFarm Config -------------
----------------------------------------------
local function AutoFarmSec()
    AutoFarmConfig:Cheat("Checkbox","🌾 Auto Farm  ", function(bool)
        print(bool)
        Settings.AutoFarm = bool
        saveSettings()
    end,{enabled = Settings.AutoFarm })

    AutoFarmConfig:Cheat("Checkbox","🏃 Auto Replay  ", function(bool)
        print(bool)
        Settings.AutoReplay = bool
        saveSettings()
    end,{enabled = Settings.AutoReplay})

    AutoFarmConfig:Cheat("Checkbox","🏃 Auto Next Story  ", function(bool)
        print(bool)
        Settings.AutoNext = bool
        saveSettings()
    end,{enabled = Settings.AutoNext})

    AutoFarmConfig:Cheat("Checkbox","🏃 Auto Leave  ", function(bool)
        print(bool)
        Settings.AutoLeave = bool
        saveSettings()
    end,{enabled = Settings.AutoLeave})
    
    AutoFarmConfig:Cheat("Checkbox","🔥 Auto Abilities  ", function(bool)
        print(bool)
        Settings.AutoAbilities = bool
        saveSettings()
    end,{enabled = Settings.AutoAbilities})

    AutoFarmConfig:Cheat("Checkbox","⭐️ Auto Upgrade Units  ", function(bool)
        print(bool)
        Settings.AutoUpgrade = bool
        saveSettings()
    end,{enabled = Settings.AutoUpgrade})

    AutoFarmConfig:Cheat("Checkbox","⭐️ Auto Sell Units  ", function(bool)
        print(bool)
        Settings.AutoSell = bool
        saveSettings()
    end,{enabled = Settings.AutoSell})

    AutoFarmConfig:Cheat("Textbox", "💸 Auto Sell Wave", function(Value)
        Value = tonumber(Value)
        Settings.AutoSellWave = Value
        saveSettings()
    end, {placeholder = Settings.AutoSellWave})
end

----------------------------------------------
--------------- More Farm Config -------------
----------------------------------------------
local function MoreFarmSec()
    MoreFarmConfig:Cheat("Checkbox","🏰️ Auto Infinity Castle  ", function(bool)
        print(bool)
        Settings.AutoInfinityCastle = bool
        saveSettings()
    end,{enabled = Settings.AutoInfinityCastle})

    --[[
    MoreFarmConfig:Cheat("Checkbox","⚡️ Auto Event Farm  ", function(bool)
        print(bool)
        Settings.AutoEventFarm = bool
        saveSettings()
    end,{enabled = Settings.AutoEventFarm})
    ]]--
end

----------------------------------------------
----------------- Challenge ------------------
----------------------------------------------
local function ChallengeSec()
    local challengeconfig = ChallengeConfig:Cheat("Dropdown", "🥇 Select Reward",function(value)
        print(value)
        Settings.SelectedReward = value
        saveSettings()
    end, { options = {"star_fruit_random","star_remnant","gems", "gold"}, default =Settings.SelectedReward})

    ChallengeConfig:Cheat("Checkbox","🎯 Auto Challenge  ", function(bool)
        print(bool)
        Settings.AutoChallenge = bool
        saveSettings()
    end, {enabled =Settings.AutoChallenge})

    ChallengeConfig:Cheat("Checkbox","🏆 Farm Any Rewards  ", function(bool)
        print(bool)
       Settings.AutoChallengeAll = bool
        saveSettings()
    end,{enabled =Settings.AutoChallengeAll})
end

----------------------------------------------
------------------ credits -------------------
----------------------------------------------
local function credits()
    Developers:Cheat("Label","📝 Scripted by: Arpon AG#6612 & Forever4D#0001 ")    
    Developers:Cheat("Label","📝 Also thanks to Trapstar#7845, bytenode#9646, HOLYSHz#3819 for the help!")    
    Developers:Cheat("Label","📐 UI By: detourious @ v3rmillion.net")    
    Developers:Cheat("Label","🔧 To toggle the script press \"RightShift\"")   
    Developers:Cheat("Button","🔗 Discord Invite", function()
        setclipboard("https://discord.gg/2ttfCfzxut")
    end)    
    UIUPDT:Cheat("Label","[+] idk \n[+]reeeeeeeeeee")    
end

getgenv().posX = 1.5
getgenv().posZ = 1.5

----------------------------------------------
---------------- Unit Config -----------------
----------------------------------------------
function updatepos(map, UnitPos, a,a2,a3,a4,a5,a6)
    warn(map)		

    if Settings[map] == nil then
        Settings[map] = {}
        saveSettings()
    end
    if Settings[map][UnitPos] == nil then
        Settings[map] = {
            UP1 = {
                x = 0,
                z = 0,
                y = 0,
                y2 = 0,
                y3 = 0,
                y4 = 0,
                y5 = 0,
                y6 = 0
            },
            UP2 = {
                x = 0,
                z = 0,
                y = 0,
                y2 = 0,
                y3 = 0,
                y4 = 0,
                y5 = 0,
                y6 = 0
                },
            UP3 = {
                x = 0,
                z = 0,
                y = 0,
                y2 = 0,
                y3 = 0,
                y4 = 0,
                y5 = 0,
                y6 = 0
            },
            UP4 = {
                x = 0,
                z = 0,
                y = 0,
                y2 = 0,
                y3 = 0,
                y4 = 0,
                y5 = 0,
                y6 = 0
            },
            UP5 = {
                x = 0,
                z = 0,
                y = 0,
                y2 = 0,
                y3 = 0,
                y4 = 0,
                y5 = 0,
                y6 = 0
            },
            UP6 = {
                x = 0,
                z = 0,
                y = 0,
                y2 = 0,
                y3 = 0,
                y4 = 0,
                y5 = 0,
                y6 = 0
            }
        }
    saveSettings()
    end
    pcall(function()
        
    end)
    Settings[map][UnitPos]["x"] = a.Position.X
    Settings[map][UnitPos]["z"] = a.Position.Z

    Settings[map][UnitPos]["y"] = a.Position.Y
    Settings[map][UnitPos]["y2"] = a2.Position.Y
    Settings[map][UnitPos]["y3"] = a3.Position.Y
    Settings[map][UnitPos]["y4"] = a4.Position.Y
    Settings[map][UnitPos]["y5"] = a5.Position.Y
    Settings[map][UnitPos]["y6"] = a6.Position.Y
    print("updatepos")
    saveSettings()
end

function savepos(UnitPos, a,a2,a3,a4,a5,a6)
    if game.Workspace._map:FindFirstChild("namek mushroom model") then
        updatepos("Namak", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("houses_new") then
        updatepos("Aot", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("Snow Particles") then
        updatepos("Snowy", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("sand_gate") then 
        updatepos("Sand", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("icebergs") then
        updatepos("Marine", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("Helicopter Pad") then
        updatepos("Ghoul", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("Bones/dust") then
        updatepos("Hollow", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("Ant Nest") then
        updatepos("Ant", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("light poles") then
        updatepos("Magic", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("LanternsGround") then
        updatepos("Cursed", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("pumpkins") then    
        updatepos("thriller_park", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("skeleton") then
        updatepos("black_clover", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("graves") then
        updatepos("hollow_leg", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("vending machines") then
        updatepos("chainsaw", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("SpaceCenter") then
        updatepos("jojo", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("secret") then
        updatepos("opm", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("s") then
        updatepos("west_city", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("Capybara") then
        updatepos("Storm_Hideout", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("snow grass") then
       updatepos("infinity_trian", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("misc nonocollide obstacles") then
        updatepos("fabled_kingdom", UnitPos, a,a2,a3,a4,a5,a6)
    end
    warn("savepos")
end

function mobilegui(UnitPos, a,a2,a3,a4,a5,a6)
	local BillboardGui = Instance.new("BillboardGui")
	local Frame = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local Done = Instance.new("TextButton")
	local UICorner = Instance.new("UICorner")
	local Cancel = Instance.new("TextButton")
	local UICorner_2 = Instance.new("UICorner")

	--Properties:
	BillboardGui.Adornee = a
	BillboardGui.Parent = game.Players.LocalPlayer.PlayerGui 
	BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	BillboardGui.Active = true
	BillboardGui.LightInfluence = 1.000
	BillboardGui.Size = UDim2.new(7, 0, 3, 0)
	BillboardGui.SizeOffset = Vector2.new(0, 1.5)

	Frame.Parent = BillboardGui
	Frame.BackgroundColor3 = Color3.fromRGB(49, 49, 57)
	Frame.BackgroundTransparency = 1.000
	Frame.Size = UDim2.new(1, 0, 0.5, 0)

	UIListLayout.Parent = Frame
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0.0599999987, 0)

	Done.Name = "Done"
	Done.Parent = Frame
	Done.BackgroundColor3 = Color3.fromRGB(34, 255, 0)
	Done.Size = UDim2.new(0.469999999, 0, 1, 0)
	Done.Font = Enum.Font.SourceSansBold
	Done.Text = "Done"
	Done.TextColor3 = Color3.fromRGB(255, 255, 255)
	Done.TextScaled = true
	Done.TextSize = 1.000
	Done.TextWrapped = true
	Done.Activated:Connect(function()
		_G.gg = false 
		savepos(UnitPos, a,a2,a3,a4,a5,a6)
		for i = 0, 1, 0.1 do
			a.Transparency = i
			a2.Transparency = i
			a3.Transparency = i
			a4.Transparency = i
			a5.Transparency = i
			a6.Transparency = i
			task.wait()
		end
		a:Destroy()
		a2:Destroy()
		a3:Destroy()
		a4:Destroy()
		a5:Destroy()
		a6:Destroy()
		BillboardGui:Destroy();
	end)
	
	UICorner.CornerRadius = UDim.new(0.119999997, 0)
	UICorner.Parent = Done

	Cancel.Name = "Cancel"
	Cancel.Parent = Frame
	Cancel.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
	Cancel.Size = UDim2.new(0.469999999, 0, 1, 0)
	Cancel.Font = Enum.Font.SourceSansBold
	Cancel.Text = "Cancel"
	Cancel.TextColor3 = Color3.fromRGB(255, 255, 255)
	Cancel.TextScaled = true
	Cancel.TextSize = 1.000
	Cancel.TextWrapped = true
	Cancel.Activated:Connect(function()
		print("Cancel")
		_G.gg = false 
		for i = 0, 1, 0.1 do
			a.Transparency = i
			a2.Transparency = i
			a3.Transparency = i
			a4.Transparency = i
			a5.Transparency = i
			a6.Transparency = i
			task.wait()
		end
		a:Destroy()
		a2:Destroy()
		a3:Destroy()
		a4:Destroy()
		a5:Destroy()
		a6:Destroy()
		BillboardGui:Destroy();
	end)
	
	UICorner_2.CornerRadius = UDim.new(0.119999997, 0)
	UICorner_2.Parent = Cancel
end

function MouseClick2(UnitPos)
	if UserInputService.TouchEnabled then mobile = true else mobile = false end 
	print("a")
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Whitelist
	raycastParams.FilterDescendantsInstances = {game:GetService("Workspace")["_terrain"]}

	_G.gg = true
	task.wait(0.5)
	local x = getgenv().posX
	local z = getgenv().posZ

	local a = Instance.new("Part", game.Workspace)
	local a2 = Instance.new("Part", game.Workspace)
	local a3 = Instance.new("Part", game.Workspace)
	local a4 = Instance.new("Part", game.Workspace)
	local a5 = Instance.new("Part", game.Workspace)
	local a6 = Instance.new("Part", game.Workspace)

	a.Size = Vector3.new(1, 1, 1)
	a2.Size = Vector3.new(1, 1, 1)
	a3.Size = Vector3.new(1, 1, 1)
	a4.Size = Vector3.new(1, 1, 1)
	a5.Size = Vector3.new(1, 1, 1)
	a6.Size = Vector3.new(1, 1, 1)

	a.Material = Enum.Material.Neon
	a2.Material = Enum.Material.Neon
	a3.Material = Enum.Material.Neon
	a4.Material = Enum.Material.Neon
	a5.Material = Enum.Material.Neon
	a6.Material = Enum.Material.Neon

	--a.Position = mouse.hit.p
	game:GetService("RunService").RenderStepped:Connect(function()
		pcall(function()
			if _G.gg and not mobile then
				mouse.TargetFilter  = a

				local xPos = mouse.Hit.Position.X --x position of unit
				local zPos = mouse.Hit.Position.Z --z position of unit
				local rayOrigin = CFrame.new(xPos, 1000, zPos).p
				local rayDestination = CFrame.new(xPos, -500, zPos).p
				local rayDirection = (rayDestination - rayOrigin)
				local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
				a.CFrame = CFrame.new(raycastResult.Position) * CFrame.Angles(0, -0, -0)


				local xPos2 = a.Position.X --x position of unit
				local zPos2 = a.Position.Z + z --z position of unit
				local rayOrigin2 = CFrame.new(xPos2, 1000, zPos2).p
				local rayDestination2 = CFrame.new(xPos2, -500, zPos2).p
				local rayDirection2 = (rayDestination2 - rayOrigin2)
				local raycastResult2 = workspace:Raycast(rayOrigin2, rayDirection2, raycastParams)
				a2.CFrame = CFrame.new(raycastResult2.Position) * CFrame.Angles(0, -0, -0)

				local xPos3 = a.Position.X + x --x position of unit
				local zPos3 = a.Position.Z  --z position of unit
				local rayOrigin3 = CFrame.new(xPos3, 1000, zPos3).p
				local rayDestination3 = CFrame.new(xPos3, -500, zPos3).p
				local rayDirection3 = (rayDestination3 - rayOrigin3)
				local raycastResult3 = workspace:Raycast(rayOrigin3, rayDirection3, raycastParams)
				a3.CFrame = CFrame.new(raycastResult3.Position) * CFrame.Angles(0, -0, -0)

				local xPos4 = a.Position.X - x --x position of unit
				local zPos4 = a.Position.Z  --z position of unit
				local rayOrigin4 = CFrame.new(xPos4, 1000, zPos4).p
				local rayDestination4 = CFrame.new(xPos4, -500, zPos4).p
				local rayDirection4 = (rayDestination4 - rayOrigin4)
				local raycastResult4 = workspace:Raycast(rayOrigin4, rayDirection4, raycastParams)
				a4.CFrame = CFrame.new(raycastResult4.Position) * CFrame.Angles(0, -0, -0)

				local xPos5 = a.Position.X + x--x position of unit
				local zPos5 = a.Position.Z + z --z position of unit
				local rayOrigin5 = CFrame.new(xPos5, 1000, zPos5).p
				local rayDestination5 = CFrame.new(xPos5, -500, zPos5).p
				local rayDirection5 = (rayDestination5 - rayOrigin5)
				local raycastResult5 = workspace:Raycast(rayOrigin5, rayDirection5, raycastParams)
				a5.CFrame = CFrame.new(raycastResult5.Position) * CFrame.Angles(0, -0, -0)

				local xPos6 = a.Position.X - x --x position of unit
				local zPos6 = a.Position.Z + z --z position of unit
				local rayOrigin6 = CFrame.new(xPos6, 1000, zPos6).p
				local rayDestination6 = CFrame.new(xPos6, -500, zPos6).p
				local rayDirection6 = (rayDestination6 - rayOrigin6)
				local raycastResult6 = workspace:Raycast(rayOrigin6, rayDirection6, raycastParams)
				a6.CFrame = CFrame.new(raycastResult6.Position) * CFrame.Angles(0, -0, -0)	
			elseif _G.gg and mobile then
				warn("MOBILE DEVICE")
				UserInputService.TouchLongPress:Connect(function()
					mouse.TargetFilter  = a

					local xPos = mouse.Hit.Position.X --x position of unit
					local zPos = mouse.Hit.Position.Z --z position of unit
					local rayOrigin = CFrame.new(xPos, 1000, zPos).p
					local rayDestination = CFrame.new(xPos, -500, zPos).p
					local rayDirection = (rayDestination - rayOrigin)
					local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
					a.CFrame = CFrame.new(raycastResult.Position) * CFrame.Angles(0, -0, -0)


					local xPos2 = a.Position.X --x position of unit
					local zPos2 = a.Position.Z + z --z position of unit
					local rayOrigin2 = CFrame.new(xPos2, 1000, zPos2).p
					local rayDestination2 = CFrame.new(xPos2, -500, zPos2).p
					local rayDirection2 = (rayDestination2 - rayOrigin2)
					local raycastResult2 = workspace:Raycast(rayOrigin2, rayDirection2, raycastParams)
					a2.CFrame = CFrame.new(raycastResult2.Position) * CFrame.Angles(0, -0, -0)

					local xPos3 = a.Position.X + x --x position of unit
					local zPos3 = a.Position.Z  --z position of unit
					local rayOrigin3 = CFrame.new(xPos3, 1000, zPos3).p
					local rayDestination3 = CFrame.new(xPos3, -500, zPos3).p
					local rayDirection3 = (rayDestination3 - rayOrigin3)
					local raycastResult3 = workspace:Raycast(rayOrigin3, rayDirection3, raycastParams)
					a3.CFrame = CFrame.new(raycastResult3.Position) * CFrame.Angles(0, -0, -0)

					local xPos4 = a.Position.X - x --x position of unit
					local zPos4 = a.Position.Z  --z position of unit
					local rayOrigin4 = CFrame.new(xPos4, 1000, zPos4).p
					local rayDestination4 = CFrame.new(xPos4, -500, zPos4).p
					local rayDirection4 = (rayDestination4 - rayOrigin4)
					local raycastResult4 = workspace:Raycast(rayOrigin4, rayDirection4, raycastParams)
					a4.CFrame = CFrame.new(raycastResult4.Position) * CFrame.Angles(0, -0, -0)

					local xPos5 = a.Position.X + x--x position of unit
					local zPos5 = a.Position.Z + z --z position of unit
					local rayOrigin5 = CFrame.new(xPos5, 1000, zPos5).p
					local rayDestination5 = CFrame.new(xPos5, -500, zPos5).p
					local rayDirection5 = (rayDestination5 - rayOrigin5)
					local raycastResult5 = workspace:Raycast(rayOrigin5, rayDirection5, raycastParams)
					a5.CFrame = CFrame.new(raycastResult5.Position) * CFrame.Angles(0, -0, -0)

					local xPos6 = a.Position.X - x --x position of unit
					local zPos6 = a.Position.Z + z --z position of unit
					local rayOrigin6 = CFrame.new(xPos6, 1000, zPos6).p
					local rayDestination6 = CFrame.new(xPos6, -500, zPos6).p
					local rayDirection6 = (rayDestination6 - rayOrigin6)
					local raycastResult6 = workspace:Raycast(rayOrigin6, rayDirection6, raycastParams)
					a6.CFrame = CFrame.new(raycastResult6.Position) * CFrame.Angles(0, -0, -0)	
				end)
			end
		end)

	end)
	task.wait()

	a.Anchored = true
	a2.Anchored = true
	a3.Anchored = true
	a4.Anchored = true
	a5.Anchored = true
	a6.Anchored = true

	a.CanCollide = false
	a2.CanCollide = false
	a3.CanCollide = false
	a4.CanCollide = false
	a5.CanCollide = false
	a6.CanCollide = false
	if _G.gg and not mobile then
		kjqhwe = mouse.Button1Down:Connect(function()
			kjqhwe:Disconnect()
			print("b")
			savepos(UnitPos, a,a2,a3,a4,a5,a6)
			_G.gg = false 

			for i = 0, 1, 0.1 do
				a.Transparency = i
				a2.Transparency = i
				a3.Transparency = i
				a4.Transparency = i
				a5.Transparency = i
				a6.Transparency = i
				task.wait()
			end
			a:Destroy()
			a2:Destroy()
			a3:Destroy()
			a4:Destroy()
			a5:Destroy()
			a6:Destroy()
		end)
	elseif _G.gg  and mobile then
		mobilegui(UnitPos, a,a2,a3,a4,a5,a6)
	end

end


local function UnitPosSec()

    UnitPosition:Cheat("Button", "Unit 1 Position", function()
        MouseClick2("UP1")
    end)
    UnitPosition:Cheat("Button", "Unit 2 Position", function()
        MouseClick2("UP2")
    end)
    UnitPosition:Cheat("Button", "Unit 3 Position", function()
        MouseClick2("UP3")
    end)
    UnitPosition:Cheat("Button", "Unit 4 Position", function()
        MouseClick2("UP4")
    end)
    UnitPosition:Cheat("Button", "Unit 5 Position", function()
        MouseClick2("UP5")
    end)
    UnitPosition:Cheat("Button", "Unit 6 Position", function()
        MouseClick2("UP6")
    end)
end

local function unitconfig()
    emptyxx:Cheat("Label","    ")
    NDY:Cheat("Label","THIS SECTION IS NOT FINISHED SO IT WILL NOT WORK. FOR UPDATE JOIN DISCORD!")
    --//UNIT 1
    Unit1:Cheat("Textbox", "Place from wave", function(Value)
        Value = tonumber(Value)
        Settings.U1_Wave = Value
        saveSettings()
    end, {placeholder = Settings.U1_Wave})

    Unit1:Cheat("Textbox", "Total Units", function(Value)
        Value = tonumber(Value)
        Settings.U1_TotalAmmount = Value
        saveSettings()
    end, {placeholder = Settings.U1_TotalAmmount})

    Unit1:Cheat("Textbox", "Upgrade from wave", function(Value)
        Value = tonumber(Value)
        Settings.U1_UpgWave = Value
    end, {placeholder = Settings.U1_UpgWave})

    Unit1:Cheat("Textbox", "Upgrade Cap", function(Value)
        Value = tonumber(Value)
        Settings.U1_UpgCap = Value
    end, {placeholder = Settings.U1_UpgCap})

    Unit1:Cheat("Textbox", "Auto Sell at wave", function(Value)
        Value = tonumber(Value)
        Settings.U1_SellWave = Value
    end, {placeholder = Settings.U1_SellWave}) 


    --//UNIT 2
    Unit2:Cheat("Textbox", "Place from wave", function(Value)
        Value = tonumber(Value)
        Settings.U2_Wave = Value
        saveSettings()
    end, {placeholder = Settings.U2_Wave})

    Unit2:Cheat("Textbox", "Total Units", function(Value)
        Value = tonumber(Value)
        Settings.U2_TotalAmmount = Value
        saveSettings()
    end, {placeholder = Settings.U2_TotalAmmount})

    Unit2:Cheat("Textbox", "Upgrade from wave", function(Value)
        Value = tonumber(Value)
        Settings.U2_UpgWave = Value
    end, {placeholder = Settings.U2_UpgWave})

    Unit2:Cheat("Textbox", "Upgrade Cap", function(Value)
        Value = tonumber(Value)
        Settings.U2_UpgCap = Value
    end, {placeholder = Settings.U2_UpgCap})

    Unit2:Cheat("Textbox", "Auto Sell at wave", function(Value)
        Value = tonumber(Value)
        Settings.U2_SellWave = Value
    end, {placeholder = Settings.U2_SellWave}) 
    
    --//UNIT 3
    Unit3:Cheat("Textbox", "Place from wave", function(Value)
        Value = tonumber(Value)
    end, {placeholder = 0})

    Unit3:Cheat("Textbox", "Upgrade from wave", function(Value)
        Value = tonumber(Value)
    end, {placeholder = 0})

    Unit3:Cheat("Textbox", "Upgrade Cap", function(Value)
        Value = tonumber(Value)
    end, {placeholder = 0})
    Unit3:Cheat("Textbox", "Auto Sell at wave", function(Value)
        Value = tonumber(Value)
    end, {placeholder = 999}) 

    --//UNIT 4
    Unit4:Cheat("Textbox", "Place from wave", function(Value)
        Value = tonumber(Value)
    end, {placeholder = 0})

    Unit4:Cheat("Textbox", "Upgrade from wave", function(Value)
        Value = tonumber(Value)
    end, {placeholder = 0})

    Unit4:Cheat("Textbox", "Upgrade Cap", function(Value)
        Value = tonumber(Value)
    end, {placeholder = 0})
    Unit4:Cheat("Textbox", "Auto Sell at wave", function(Value)
        Value = tonumber(Value)
    end, {placeholder = 999}) 
    
        --//UNIT 5
        Unit5:Cheat("Textbox", "Place from wave", function(Value)
        Value = tonumber(Value)
    end, {placeholder = 0})

    Unit5:Cheat("Textbox", "Upgrade from wave", function(Value)
        Value = tonumber(Value)
    end, {placeholder = 0})

    Unit5:Cheat("Textbox", "Upgrade Cap", function(Value)
        Value = tonumber(Value)
    end, {placeholder = 0})
    Unit5:Cheat("Textbox", "Auto Sell at wave", function(Value)
        Value = tonumber(Value)
    end, {placeholder = 999}) 

    --//UNIT 6
    Unit6:Cheat("Textbox", "Place from wave", function(Value)
        Value = tonumber(Value)
    end, {placeholder = 0})

    Unit6:Cheat("Textbox", "Upgrade from wave", function(Value)
        Value = tonumber(Value)
    end, {placeholder = 0})

    Unit6:Cheat("Textbox", "Upgrade Cap", function(Value)
        Value = tonumber(Value)
    end, {placeholder = 0})
    Unit6:Cheat("Textbox", "Auto Sell at wave", function(Value)
        Value = tonumber(Value)
    end, {placeholder = 999}) 
end

----------------------------------------------
---------------- Auto Summon -----------------
----------------------------------------------
function SummonUnits(banner, method)
    local args = {
        [1] = tostring(banner),
        [2] = tostring(method)
    }
    game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_from_banner:InvokeServer(unpack(args)) 
    wait(1.5)
end

function AutoSummon()
    local aaselectbanner = AutoSummonSec:Cheat("Dropdown", "Select Banner",function(value)
        getgenv().SelectedBanner = value
    end, { options = {"Special", "Standard"}})

    local aaselectbanner = AutoSummonSec:Cheat("Dropdown", "Select Method",function(value)
        getgenv().SelectedMethod = value
    end, { options = {"ticket", "gems", "gems10"}})

    AutoSummonSec:Cheat("Checkbox","Auto Summon", function(bool)
        getgenv().AutoSummon = bool
    end)
end

----------------------------------------------
------------ Auto Snipe Merchant -------------
----------------------------------------------

function buymerchant(item)
    local args = { [1] = item } 
    game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_travelling_merchant_item:InvokeServer(unpack(args))
end

function snipefunc(item)
    if item =="Any StarFruits" then
        if game:GetService("Workspace")["travelling_merchant"]["is_open"].Value == true then
            for i,v in pairs(game:GetService("Workspace")["travelling_merchant"]:FindFirstChild("stand"):FindFirstChild("items"):GetChildren()) do
                if v.Name:match("StarFruit") then
                    buymerchant(v.Name)
                    print(v.Name)
                end   
            end
        end        
    elseif item == "Any Items"then
        if game:GetService("Workspace")["travelling_merchant"]["is_open"].Value == true then
            for i,v in pairs(game:GetService("Workspace")["travelling_merchant"]:FindFirstChild("stand"):FindFirstChild("items"):GetChildren()) do
                if v.Name:match("LuckPotion") or v.Name:match("star_remnant") or v.Name:match("summon_ticket") then
                    buymerchant(v.Name)
                    print(v.Name)
                end  
            end
        end
    else
        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.ItemShop:FindFirstChild("Window"):FindFirstChild("Outer"):FindFirstChild("ItemFrames"):GetChildren()) do
            if game:GetService("Workspace")["travelling_merchant"]["is_open"].Value == true then
                for i,v in pairs(game:GetService("Workspace")["travelling_merchant"]:FindFirstChild("stand"):FindFirstChild("items"):GetChildren()) do
                    if v.Name:match(tostring(item)) then
                        buymerchant(v.Name)
                        print(v.Name)
                    end  
                end
            end 
        end
    end
end


function SnipeMerchant()
    AutoSnipeMerchantSec:Cheat("Dropdown", "Select Star Fruit",function(value)
        Settings.ASM_SelectedFruit = value
        saveSettings()
    end, { options = {"None","Any StarFruits","StarFruit","StarFruitGreen","StarFruitRed", "StarFruitPink","StarFruitBlue","StarFruitEpic"}, default =Settings.ASM_SelectedFruit})
   
    AutoSnipeMerchantSec:Cheat("Dropdown", "Select Other Items",function(value)
        Settings.ASM_SelectedOtherItems = value
        saveSettings()
    end, { options = {"None","Any Items","LuckPotion","star_remnant","summon_ticket"}, default =Settings.ASM_SelectedOtherItems})

    AutoSnipeMerchantSec:Cheat("Dropdown", "Select Evo Items",function(value)
        Settings.ASM_SelectedEvoItems = value
        saveSettings()
    end, { options = {"None"}, default =Settings.ASM_SelectedEvoItems})

    AutoSnipeMerchantSec:Cheat("Checkbox","Enable Auto Snipe", function(bool)
        Settings.AutoSnipeMerchant = bool
        saveSettings()
    end,{enabled = Settings.AutoSnipeMerchant })

end

----------------------------------------------
-------------- Discord Webhook ---------------
----------------------------------------------
function Webhooksec()
    WebhookSec:Cheat("Textbox", "Webhook Url", function(Value)
        Settings.WebhookUrl = Value
        saveSettings()
    end, {placeholder = Settings.WebhookUrl})

    WebhookSec:Cheat("Checkbox","Enable Webhook", function(bool)
        Settings.WebhookEnabled = bool
        saveSettings()
    end,{enabled = Settings.WebhookEnabled})

    WebhookSec:Cheat("Button", "Test Webhook", function()
        print(Settings.WebhookUrl)
        webhook()
    end)
end

----------------------------------------------
------------------ Others --------------------
----------------------------------------------
function autoload()
    pcall(function()
        local exec = tostring(identifyexecutor())
        if exec == "Synapse X" and Settings.AutoLoadScript then
            syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/ArponAG/Scripts/main/AnimeAdventures_v2__Beta.lua'))()")
        elseif exec ~= "Synapse X" and Settings.AutoLoadScript then
            queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/ArponAG/Scripts/main/AnimeAdventures_v2__Beta.lua'))()")
        end
    end)
end

function others()
    OtherSec:Cheat("Checkbox","Auto Load Script", function(bool)
        Settings.AutoLoadScript = bool
        saveSettings()
        autoload()
    end,{enabled = Settings.AutoLoadScript})
end
----------------------------------------------
------------ /\/\/\/\/\/\/\/\/\ --------------
----------------------------------------------
if game.PlaceId == 8304191830 then
    UnitPosition:Cheat("Label","Not available in game Lobby!")    
    UnitSec()
    WorldSec()
    AutoFarmSec()
    MoreFarmSec()
    ChallengeSec()
    unitconfig()
    credits()
    AutoSummon()
    SnipeMerchant()
    Webhooksec()
    others()
else
    SelectUnits:Cheat("Label","Only available in game Lobby!")    
    AutoSummonSec:Cheat("Label","Only available in game Lobby!")    
    WorldSec()
    AutoFarmSec()
    MoreFarmSec()
    ChallengeSec()
    UnitPosSec()
    unitconfig()
    credits()
    SnipeMerchant()
    Webhooksec()
    others()
end
----------------------------------------------
------------ /\/\/\/\/\/\/\/\/\ --------------
----------------------------------------------

local function checkChallenge()
    for i,v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
        if v:IsA("SurfaceGui") then
            if v:FindFirstChild("ChallengeCleared") then
                return v.ChallengeCleared.Visible
            end
        end
    end
end

local function checkReward()
    if checkChallenge() == false then
        if Settings.SelectedReward == game:GetService("Workspace")["_LOBBIES"]["_DATA"]["_CHALLENGE"]["current_reward"].Value then
            return true
        elseif Settings.AutoChallengeAll then
            return true
        else
            return false
        end
    else
        return false
    end
end

local function startChallenge()
    if game.PlaceId == 8304191830 then
        local cpos = plr.Character.HumanoidRootPart.CFrame
        if Settings.AutoChallenge and Settings.AutoFarm  and checkReward() == true then
            for i, v in pairs(game:GetService("Workspace")["_CHALLENGES"].Challenges:GetDescendants()) do
                if v.Name == "Owner" and v.Value == nil then
                    --print(v.Parent.Name.." "..v.Parent:GetFullName())
                    local args = {  [1] = tostring(v.Parent.Name) }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
                    Settings.chdoor = v.Parent.Name
                    break
                end
            end
            task.wait()
            plr.Character.HumanoidRootPart.CFrame = cpos
        end
    end
end

function GetPortals(id)
    local reg = getreg()  --> returns Roblox's registry in a table
    local portals = {}
    for i,v in next, reg do
        if type(v) == 'function' then --> Checks if the current iteration is a function
            if getfenv(v).script then --> Checks if the function's environment is in a script
                for _, v in pairs(debug.getupvalues(v)) do  --> Basically a for loop that prints everything, but in one line
                    if type(v) == 'table' then
                        if v["session"] then
                            for _, item in pairs(v["session"]["inventory"]['inventory_profile_data']['unique_items']) do
                            if item["item_id"]:match(id) then
                                    table.insert(portals, item)
                              end
                            end
                            return portals
                        end
                    end
                end
            end
        end
    end
end

Settings.teleporting = true
getgenv().door = "_lobbytemplategreen1"


local function startfarming()
    if game.PlaceId == 8304191830 and not Settings.farmprotal and Settings.AutoFarm and Settings.teleporting and not Settings.AutoInfinityCastle then
        local cpos = plr.Character.HumanoidRootPart.CFrame; cata = Settings.WorldCategory; level = Settings.SelectedLevel;
        
        if cata == "Story Worlds" or cata == "Legend Stages" then
            if tostring(game.Workspace._LOBBIES.Story[getgenv().door].Owner.Value) ~= plr.Name then
                for i, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
                    if v.Name == "Owner" and v.Value == nil then
                        local args = { [1] = tostring(v.Parent.Name) }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
    
                        task.wait()
                    
                        local args = {
                            [1] = tostring(v.Parent.Name), -- Lobby 
                            [2] = Settings.SelectedLevel, -- World/Level
                            [3] = Settings.isFriendOnly or true, -- Friends Only or not
                            [4] = Settings.Difficulty }
    
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
    
                        local args = { [1] =tostring(v.Parent.Name) }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
                        
                        getgenv().door = v.Parent.Name print(v.Parent.Name) --v.Parent:GetFullName()
                        plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
                        break
                    end
                end
    
                task.wait()
    
                plr.Character.HumanoidRootPart.CFrame = cpos
    
                if Workspace._LOBBIES.Story[getgenv().door].Owner == plr.Name then
                    if Workspace._LOBBIES.Story[getgenv().door].Teleporting.Value == true then
                        getgenv().teleporting = false
                    else
                        getgenv().teleporting = true
                    end
                end
    
                warn("farming")
                task.wait(3)
            end
        elseif cata == "Raid Worlds" then
            getgenv().door =  "_lobbytemplate212"
            if tostring(game.Workspace._RAID.Raid[getgenv().door].Owner.Value) ~= plr.Name then
                for i, v in pairs(game:GetService("Workspace")["_RAID"].Raid:GetDescendants()) do
                    if v.Name == "Owner" and v.Value == nil then
                        local args = { [1] = tostring(v.Parent.Name) }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
    
                        task.wait()
                    
                        local args = {
                            [1] = tostring(v.Parent.Name), -- Lobby 
                            [2] = Settings.SelectedLevel, -- World/Level
                            [3] = Settings.isFriendOnly or true, -- Friends Only or not
                            [4] = Settings.Difficulty }
    
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
    
                        local args = { [1] =tostring(v.Parent.Name) }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
                        
                        getgenv().door = v.Parent.Name print(v.Parent.Name) --v.Parent:GetFullName()
                        plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
                        break
                    end
                end
    
                task.wait()
    
                plr.Character.HumanoidRootPart.CFrame = cpos
    
                if Workspace._RAID.Raid[getgenv().door].Owner == plr.Name then
                    if Workspace._RAID.Raid[getgenv().door].Teleporting.Value == true then
                        getgenv().teleporting = false
                    else
                        getgenv().teleporting = true
                    end
                end
    
                warn("farming")
                task.wait(3)
            end
        elseif cata == "Portals" then
            pcall(function() 
                if level == "portal_boros_g" then
                    local args = {
                        [1] = GetPortals("portal_boros_g")[1]["uuid"],
                        [2] = { ["friends_only"] = getgenv().isFriendOnly } }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.use_portal:InvokeServer(unpack(args))
                    
                    task.wait(1.5)
                    for i,v in pairs(game:GetService("Workspace")["_PORTALS"].Lobbies:GetDescendants()) do
                        if v.Name == "Owner" and tostring(v.value) == game.Players.LocalPlayer.Name then
                            local args = { [1] = tostring(v.Parent.Name) }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
                            break;
                        end 
                    end
                    warn("Aline farming")
                    task.wait(7)
                elseif level == "portal_csm" then
                    local args = {
                        [1] = GetPortals("portal_csm")[1]["uuid"],
                        [2] = { ["friends_only"] = getgenv().isFriendOnly } }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.use_portal:InvokeServer(unpack(args))
                    
                    task.wait(1.5)
                    for i,v in pairs(game:GetService("Workspace")["_PORTALS"].Lobbies:GetDescendants()) do
                        if v.Name == "Owner" and tostring(v.value) == game.Players.LocalPlayer.Name then
                            local args = { [1] = tostring(v.Parent.Name) }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
                            break;
                        end 
                    end
                    warn("devil portal farming")
                    task.wait(7)
                elseif level == "portal_zeldris" then
                    local args = {
                        [1] = GetPortals("portal_zeldris")[1]["uuid"],
                        [2] = { ["friends_only"] = getgenv().isFriendOnly } }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.use_portal:InvokeServer(unpack(args))
                    
                    task.wait(1.5)
                    for i,v in pairs(game:GetService("Workspace")["_PORTALS"].Lobbies:GetDescendants()) do
                        if v.Name == "Owner" and tostring(v.value) == game.Players.LocalPlayer.Name then
                            local args = { [1] = tostring(v.Parent.Name) }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
                            break;
                        end 
                    end
                    warn("Demon Portal farming")
                    task.wait(7)
            elseif cata == "Dungeon" then
            getgenv().door = "_lobbytemplate_event222"
            local string_1 = "_lobbytemplate_event222";
            local table_1 = {
                ["selected_key"] = "key_jjk_finger"
            };
            local Target = game:GetService("ReplicatedStorage").endpoints["client_to_server"]["request_join_lobby"];
            Target:InvokeServer(string_1, table_1);
        
            if tostring(game.Workspace._DUNGEONS.Lobbies[getgenv().door].Owner.Value) ~= plr.Name then
                for i, v in pairs(game:GetService("Workspace")["_DUNGEONS"].Lobbies:GetDescendants()) do
                    if v.Name == "Owner" and v.Value == nil then
                        local args = { [1] = tostring(v.Parent.Name) }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
    
                        task.wait()
                    
                        local args = {
                            [1] = tostring(v.Parent.Name), -- Lobby 
                            [2] = Settings.SelectedLevel, -- World/Level
                            [3] = Settings.isFriendOnly or true, -- Friends Only or not
                            [4] = Settings.Difficulty 
                        }
    
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
    
                        local args = { [1] =tostring(v.Parent.Name) }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
                        
                        getgenv().door = v.Parent.Name print(v.Parent.Name) --v.Parent:GetFullName()
                        plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
                        break
                    end
                end
    
                task.wait()
    
                plr.Character.HumanoidRootPart.CFrame = cpos
    
                if Workspace._DUNGEONS.Lobbies[getgenv().door].Owner == plr.Name then
                    if Workspace._DUNGEONS.Lobbies[getgenv().door].Teleporting.Value == true then
                        getgenv().teleporting = false
                    else
                        getgenv().teleporting = true
                    end
                end
    
                warn("DUNGEONS farming")
                task.wait(3)
            end

                end
            end)
        end
    end
end

getgenv().autoabilityerr = false

function autoabilityfunc()
    local success, err = pcall(function() --///
        repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
        for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
            if v:FindFirstChild("_stats") then
                if v._stats:FindFirstChild("player") and v._stats:FindFirstChild("xp") then
                    if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v["_stats"].xp.Value > 0 then
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                    end
                end
            end
        end
    end)
     
     if err then
         warn("//////////////////////////////////////////////////")
         getgenv().autoabilityerr = true
         error(err)
     end

end

function autoupgradefunc()
    local success, err = pcall(function() --///

        repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
        for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
           if v:FindFirstChild("_stats") then
                if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v["_stats"].xp.Value >= 0 then
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
                end
            end
        end

    end)

    if err then
        warn("//////////////////////////////////////////////////")
        warn("//////////////////////////////////////////////////")
        getgenv().autoupgradeerr = true
        error(err)
    end
end

local function FarmInfinityCastle()
    if Settings.AutoInfinityCastle and Settings.AutoFarm or Settings.AutoInfinityCastle then
        if game.PlaceId == 8304191830 then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(12423.1855, 155.24025, 3198.07593, -1.34111269e-06, -2.02512282e-08, 1, 3.91705386e-13, 1, 2.02512282e-08, -1, 4.18864542e-13, -1.34111269e-06)
            getgenv().infinityroom = 0

            for i, v in pairs(game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.InfiniteTowerUI.LevelSelect.InfoFrame.LevelButtons:GetChildren()) do
                if v.Name == "FloorButton" then
                    if v.clear.Visible == false and v.Locked.Visible == false then
                        local room = string.split(v.Main.text.Text, " ")

                        local args = {
                            [1] = tonumber(room[2])
                        }
                        
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower:InvokeServer(unpack(args))
                        getgenv().infinityroom = tonumber(room[2])
                        break
                    end
                end
            end
            task.wait(6)
        end
    end
end

coroutine.resume(coroutine.create(function()
    while task.wait() do
        if not Settings.AutoInfinityCastle then
            if not checkChallenge() then --Challenge_Not_Complete
                if  Settings.AutoChallenge and checkReward() == true then
                    startChallenge() --S_Challenge
                else
                    startfarming()--S_Farming
                end
            elseif checkChallenge() == true then
                startfarming()--S_Farming
            end
        elseif Settings.AutoInfinityCastle == true then--Infiniy Castle
            if not checkChallenge() then --Challenge_Not_Complete
                if  Settings.AutoChallenge and checkReward() == true then
                    startChallenge() --S_Challenge
                else
                    FarmInfinityCastle()--S_Farming
                end
            elseif checkChallenge() == true then
                FarmInfinityCastle()--S_Farming
            end
        end

        if game.PlaceId ~= 8304191830 then
            local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
            if Settings.AutoSell and tonumber(Settings.AutoSellWave) <= _wave.Value then
                getgenv().disableatuofarm = true
                repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
                for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
                    repeat task.wait()
                    until v:WaitForChild("_stats")
                    if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
                        repeat
                            task.wait()
                        until v:WaitForChild("_stats"):WaitForChild("upgrade")
            
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
                    end
                end
            end
        end
    end
end))


coroutine.resume(coroutine.create(function()
    while task.wait(2) do

        if Settings.AutoAbilities then
            if game.PlaceId ~= 8304191830 then
                pcall(function()
                    autoabilityfunc()
                end)
            end
            if  getgenv().autoabilityerr == true then
                task.wait()
                autoabilityfunc()
                getgenv().autoabilityerr = false
            end
        end
        
        if Settings.AutoUpgrade then
            if game.PlaceId ~= 8304191830 then
                pcall(function()
                    autoupgradefunc()
                end)
            end
            if  getgenv().autoupgradeerr == true then
                task.wait()
                autoupgradefunc()
                getgenv().autoupgradeerr = false
            end
        end
    end
end))



coroutine.resume(coroutine.create(function()
	
    task.spawn(function()
        local GameFinished = game:GetService("Workspace"):WaitForChild("_DATA"):WaitForChild("GameFinished")
        GameFinished:GetPropertyChangedSignal("Value"):Connect(function()
            print("Changed", GameFinished.Value == true)
            if GameFinished.Value == true then
                repeat task.wait() until  game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Enabled == true
                if Settings.WebhookEnabled then 
                    local btn = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Buttons.Next
                    task.spawn(function()
                        pcall(function()
                            for i,v in pairs(getconnections(btn.Activated)) do
                                v:Fire()
                            end 
                        end)
                    end)
                    task.wait(2)
                    getgenv().item = game:GetService("Players").LocalPlayer.PlayerGui.HatchInfo.holder.info1.UnitName.Text
                    warn(game:GetService("Players").LocalPlayer.PlayerGui.HatchInfo.holder.info1.UnitName.Text)
    
                    webhook()
                end
                print("next")
                task.wait(1)
                if Settings.AutoReplay then
                    local a={[1]="replay"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
                    local a={[1]="replay"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
                    print("Replay...")
                elseif Settings.AutoNext and Settings.AutoInfinityCastle then
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer()
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer()
                    print("Next Room...")
                elseif Settings.AutoNext and not Settings.AutoInfinityCastle then
                    local a={[1]="next_story"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
                    local a={[1]="next_story"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
                    print("Next Story...")
                elseif Settings.AutoLeave and not Settings.AutoReplay and not Settings.AutoNext then
                    game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
                    print("Returning to lobby...")
                end
            end
        end)
    end)

    while task.wait() do
        if getgenv().AutoSummon then
            if getgenv().SelectedBanner == "Special" and getgenv().SelectedMethod ~= nil then
                SummonUnits("EventClover", getgenv().SelectedMethod)
            elseif getgenv().SelectedBanner == "Standard" and getgenv().SelectedMethod ~= nil then
                SummonUnits("Standard", getgenv().SelectedMethod)
            end
        end

        if Settings.AutoSnipeMerchant then
            if Settings.ASM_SelectedFruit ~= "None" or Settings.ASM_SelectedFruit ~= nil then
                if Settings.ASM_SelectedFruit == "Any StarFruits" then
                    snipefunc("Any StarFruits")
                else
                    snipefunc(Settings.ASM_SelectedFruit)
                end
            end
            if Settings.ASM_SelectedOtherItems ~= "None" or Settings.ASM_SelectedOtherItems ~= nil then
                if Settings.ASM_SelectedOtherItems == "Any StarFruits" then
                    snipefunc("Any Items")
                else
                    snipefunc(Settings.ASM_SelectedOtherItems)
                end
            end
            if Settings.ASM_SelectedEvoItems ~= "None" or Settings.ASM_SelectedEvoItems ~= nil then
           
            end
        end
    end  
end))



function PlacePos(map,name,_uuid,unit)
    if Settings.AutoFarm and not getgenv().disableatuofarm then
        x = getgenv().posX; z = getgenv().posZ
        local pos = Settings[map][unit]

        warn(map.." attempt to place "..name)

        if name ~= "metal_knight_evolved" then
            local i = math.random(1,6)
            if i == 1 then
                    local args = {
                    [1] = _uuid,
                    [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"]) )
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                return
            elseif i == 2 then
                    local args = {
                    [1] = _uuid,
                    [2] = CFrame.new(Vector3.new(pos["x"], pos["y2"], pos["z"] + z) )
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                return
            elseif i == 3 then
                    local args = {
                    [1] = _uuid,
                    [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y3"], pos["z"]) )
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                return
            elseif i == 4 then
                    local args = {
                    [1] = _uuid,
                    [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y4"], pos["z"]) )
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                return
            elseif i == 5 then
                    local args = {
                    [1] = _uuid,
                    [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y5"], pos["z"] + z) )
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                return
            elseif i == 6 then
                    local args = {
                    [1] = _uuid,
                    [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y6"], pos["z"] + z) )
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                return
            end
        elseif name == "metal_knight_evolved" then
            local i = math.random(1,6)
            if i == 1 then
                task.spawn(function()
                    --place units 0
                    print("p1")
                    local args = {
                        [1] = _uuid,
                        [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"]) )
                    }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                end)
                return
            elseif i == 2 then
                task.spawn(function()
                    --place units 1
                    task.wait(2)
                    local args = {
                        [1] = _uuid,
                        [2] = CFrame.new(Vector3.new(pos["x"], pos["y2"], pos["z"] + z) )
                    }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                end)
                return
            elseif i == 3 then
                task.spawn(function()
                    --place units 2
                    task.wait(3)
                    local args = {
                        [1] = _uuid,
                        [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y3"], pos["z"]) )
                    }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                end)
                return
            end
        end
    end
end


function upgradeunit(name, min)
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
       if v:FindFirstChild("_stats") then
            if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v["_stats"].xp.Value >= 0 then
                if v.Name == name and v._stats.upgrade.Value <= min then
                   game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
                end
            end
        end
    end
end

function sellunit(name) 
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v.Name == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v._stats:FindFirstChild("upgrade") then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
        end
    end
end


function GetUnitInfo(Unit)
    local unitinfo = Settings.SelectedUnits[Unit]
    local unitinfo_ = unitinfo:split(" #")
    local _units = {}
    local uu = {}
    table.clear(_units)
    table.clear(uu)
    local name = " "
    local min;
    for i, v in pairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do 
        for i,v in pairs(v:GetChildren()) do 
            if v.Name == "_stats" then
                if v:FindFirstChild("uuid") then
                    if v.uuid.Value == unitinfo_[2] then
                        table.insert(_units,v.Parent.Name)
                        name = v.Parent.Name
                    end
                end
                if v:FindFirstChild("uuid") and v:FindFirstChild("upgrade") then
                    if v.uuid.Value == unitinfo_[2] then
                        table.insert(uu,v.upgrade.Value)
                    end
                end
            end
        end
    end
    
    if #uu ~= 0 then
        min = math.min(table.unpack(uu))
        table.sort(uu, function(a, b) return a < b end)
        local min = uu[1]
    end
    
    return #_units or 0, unitinfo_[1], unitinfo_[2], min or 0
end


function PlaceUnitsTEST(map)
    current_wave = game:GetService("Workspace")["_wave_num"].Value

    U1_wv, U2_wv = Settings.U1_Wave or 0, Settings.U2_Wave or 0
    U1_TAmm, U2_TAmm = Settings.U1_TotalAmmount or 6, Settings.U2_TotalAmmount or 6
    U1_upgW, U2_upgW = Settings.U1_UpgWave or 0, Settings.U2_UpgWave or 0
    U1_upgCap, U2_upgCap = Settings.U1_UpgCap or 99, Settings.U2_UpgCap or 99
    U1_sellW, U2_sellW = Settings.U1_SellWave or 999, Settings.U2_SellWave or 999

    --//Unit 1
    local U1_amm, U1_name, U1_uuid, U1_u = GetUnitInfo("U1")
    if U1_wv <= current_wave and U1_amm <= U1_TAmm then
        if U1_sellW >= current_wave and U1_amm < U1_TAmm then
            print("placing u1..")
            PlacePos(map, U1_name, U1_uuid,"UP1")
        elseif U1_sellW <= current_wave then
            print("selling u1..")
            sellunit(U1_name)
        end
        if U1_u < U1_upgCap and U1_upgW <= current_wave and U1_sellW >= current_wave then
            print("upgrading u1..")
            upgradeunit(tostring(U1_name), U1_upgCap)
        end
    end

    --//Unit 2
    U2_amm, U2_name, U2_uuid, U2_u = GetUnitInfo("U2")
    if U2_wv <= current_wave and U2_amm <= U2_TAmm then
        if U2_sellW >= current_wave and U2_amm < U2_TAmm then
            print("placing u2..")
            PlacePos(map, U2_name, U2_uuid,"UP2")
        elseif U2_sellW <= current_wave then
            print("selling u2..")
            sellunit(U2_name)
        end
        if U2_u < U2_upgCap and U2_upgW <= current_wave and U2_sellW >= current_wave then
            print("upgrading u2..")
            upgradeunit(tostring(U2_name), U2_upgCap)
        end
    end


end
--fix sell and place spam

function PlaceUnits(map)
    pcall(function()
        if Settings.AutoFarm and not getgenv().disableatuofarm then
            x = getgenv().posX; z = getgenv().posZ
            for i = 1, 6 do
                local unitinfo = Settings.SelectedUnits["U" .. i]
                if unitinfo ~= nil then
                    local unitinfo_ = unitinfo:split(" #")
                    local pos = Settings[map]["UP" .. i]
                    print(map.." attempt to place "..unitinfo_[1])
    
                    if unitinfo_[1] ~= "metal_knight_evolved" then
    
                        --place units 0
                        local args = {
                            [1] = unitinfo_[2],
                            [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"]) )
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
            
                        --place units 1
                        local args = {
                            [1] = unitinfo_[2],
                            [2] = CFrame.new(Vector3.new(pos["x"], pos["y2"], pos["z"] + z) )
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
            
                        --place units 2 
                        local args = {
                            [1] = unitinfo_[2],
                            [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y3"], pos["z"]) )
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
            
                        --place units 3 
                        local args = {
                            [1] = unitinfo_[2],
                            [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y4"], pos["z"]) )
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
            
                        --place units 4
                        local args = {
                            [1] = unitinfo_[2],
                            [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y5"], pos["z"] + z) )
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
            
                        --place units 5
                        local args = {
                            [1] = unitinfo_[2],
                            [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y6"], pos["z"] + z) )
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                    elseif unitinfo_[1] == "metal_knight_evolved" then
                        task.spawn(function()
                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"]) )
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end)
    
                        task.spawn(function()
                            --place units 1
                            task.wait(2)
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"] + z) )
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end)
    
                        task.spawn(function()
                            --place units 2
                            task.wait(3)
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"], pos["z"]) )
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end)
                    end
                end
            end
        end
    end)
end

coroutine.resume(coroutine.create(function()
    while task.wait(1.5) do
        if game.PlaceId ~= 8304191830 and Settings.AutoFarm and not getgenv().disableatuofarm then
            local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
            repeat task.wait() until game:GetService("Workspace"):WaitForChild("_map")
            if game.Workspace._map:FindFirstChild("namek mushroom model") then
                PlaceUnitsTEST("Namak")
                --PlaceUnits("Namak")
            elseif game.Workspace._map:FindFirstChild("houses_new") then
                PlaceUnits("Aot")
            elseif game.Workspace._map:FindFirstChild("Snow Particles") then
                PlaceUnits("Snowy")
            elseif game.Workspace._map:FindFirstChild("sand_gate") then 
                PlaceUnits("Sand")
            elseif game.Workspace._map:FindFirstChild("icebergs") then
                PlaceUnits("Marine")
            elseif game.Workspace._map:FindFirstChild("Helicopter Pad") then
                PlaceUnits("Ghoul")
            elseif game.Workspace._map:FindFirstChild("Bones/dust") then
                PlaceUnits("Hollow")
            elseif game.Workspace._map:FindFirstChild("Ant Nest") then
                PlaceUnits("Ant")
            elseif game.Workspace._map:FindFirstChild("light poles") then
                PlaceUnits("Magic")
            elseif game.Workspace._map:FindFirstChild("LanternsGround") then
                PlaceUnits("Cursed")
            elseif game.Workspace._map:FindFirstChild("pumpkins") then    
                PlaceUnits("thriller_park")  
            elseif game.Workspace._map:FindFirstChild("skeleton") then
                PlaceUnits("black_clover")
            elseif game.Workspace._map:FindFirstChild("graves") then
                PlaceUnits("hollow_leg")
            elseif game.Workspace._map:FindFirstChild("vending machines") then
                PlaceUnits("chainsaw")
            elseif game.Workspace._map:FindFirstChild("SpaceCenter") then
                PlaceUnits("jojo")
            elseif game.Workspace._map:FindFirstChild("secret") then
                PlaceUnits("opm")
            elseif game.Workspace._map:FindFirstChild("s") then
                PlaceUnits("west_city")
            elseif game.Workspace._map:FindFirstChild("Capybara") then
                PlaceUnits("Storm_Hideout")
            elseif game.Workspace._map:FindFirstChild("snow grass") then
                PlaceUnits("infinity_trian")
            elseif game.Workspace._map:FindFirstChild("misc nonocollide obstacles") then
                PlaceUnits("fabled_kingdom")
            end
        end
    end
end))

pcall(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
    game:GetService("ReplicatedStorage").endpoints.client_to_server.claim_daily_reward:InvokeServer()
    warn("Anti-AFK loaded!")
end)

if Settings.AutoLoadScript then
    autoload()
end

-- game:GetService("Players")["Nimble_Bot"].PlayerGui.HatchGuiNew.BannerFrames.EventClover.Main

if game.PlaceId ~= 8304191830 then
    game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error.Volume = 0
    game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error_old.Volume = 0
    game.Players.LocalPlayer.PlayerGui.MessageGui.Enabled = false --disables the annoying error messages 
end

print("Loaded!")
