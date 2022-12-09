local versionx = "1.6.1"

---// Loading Section \\---
task.wait(2)
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
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace") 
local plr = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local mouse = game.Players.LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")

getgenv().savefilename = "Anime-Adventures_data7.6"..game.Players.LocalPlayer.Name..".json"
getgenv().door = "_lobbytemplategreen1"

--#region Webhook Sender
local function webhook()
	pcall(function()
		local url = tostring(getgenv().weburl) --webhook
		print("webhook?")
		if url == "" then
			return
		end 
			
    	XP = tostring(game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.XPReward.Main.Amount.Text)
		gems = tostring(game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.GemReward.Main.Amount.Text)
		cwaves = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.WavesCompleted.Text
		ctime = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.Timer.Text
		waves = cwaves:split(": ")
		ttime = ctime:split(": ")

		local data = {
			["content"] = "",
			["username"] = "Anime Adventures",
			["avatar_url"] = "https://tr.rbxcdn.com/e5b5844fb26df605986b94d87384f5fb/150/150/Image/Jpeg",
			["embeds"] = {
				{
					["author"] = {
						["name"] = "Anime Adventures | Result ✔",
						["icon_url"] = "https://cdn.discordapp.com/emojis/997123585476927558.webp?size=96&quality=lossless"
					},
					["description"] = "🎮 ||**"..game:GetService("Players").LocalPlayer.Name.."**|| 🎮",
					["color"] = 110335,

					["thumbnail"] = {
						['url'] = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. game.Players.LocalPlayer.userId .. "&width=420&height=420&format=png"
					},

					["fields"] = {
						{
							["name"] = "Total Waves:",
							["value"] = tostring(waves[2]) ..
								" <:wave:997136622363627530>",
							["inline"] = true
						}, {
							["name"] = "Recieved Gems:",
							["value"] = gems .. " <:gem:997123585476927558>",
							["inline"] = true
						}, {
                            ["name"] = "Recieved XP:",
                            ["value"] = XP .. " 🧪",
                            ["inline"] = true
                        }, {
                            ["name"] = "Total Time:",
                            ["value"] = tostring(ttime[2]) .. " ⏳",
                            ["inline"] = true
                        }, {
                            ["name"] = "Current Gems:",
                            ["value"] = tostring(game.Players.LocalPlayer._stats.gem_amount.Value).." <:gem:997123585476927558>",
                            ["inline"] = true
                        }, {
                            ["name"] = "Current Level:",
                            ["value"] = tostring(game.Players.LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text).. " ✨",
                            ["inline"] = true
                        }
					}
				}
			}
		}

		local porn = game:GetService("HttpService"):JSONEncode(data)

		local headers = {["content-type"] = "application/json"}
		request = http_request or request or HttpPost or syn.request or http.request
		local sex = {Url = url, Body = porn, Method = "POST", Headers = headers}
		warn("Sending webhook notification...")
		request(sex)
	end)
end
--#endregion

getgenv().UnitCache = {}

for _, Module in next, game:GetService("ReplicatedStorage"):WaitForChild("src"):WaitForChild("Data"):WaitForChild("Units"):GetDescendants() do
    if Module:IsA("ModuleScript") and Module.Name ~= "UnitPresets" then
        for UnitName, UnitStats in next, require(Module) do
            getgenv().UnitCache[UnitName] = UnitStats
        end
    end
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--

function sex()
    -- reads jsonfile
    local jsonData = readfile(savefilename)
    local data = HttpService:JSONDecode(jsonData)

--#region global values
    getgenv().AutoLeave = data.AutoLeave
    getgenv().AutoReplay = data.AutoReplay
    getgenv().AutoChallenge = data.AutoChallenge  
    getgenv().selectedreward = data.selectedreward
    getgenv().AutoChallengeAll = data.AutoChallengeAll
    getgenv().disableatuofarm = false
    getgenv().sellatwave = data.sellatwave 
    getgenv().autosell = data.autosell
    getgenv().AutoFarm = data.autofarm
    getgenv().AutoFarmIC = data.autofarmic
    getgenv().AutoFarmTP = data.autofarmtp
    getgenv().AutoLoadTP = data.autoloadtp
    getgenv().weburl = data.webhook
    getgenv().autostart = data.autostart
    getgenv().autoupgrade = data.autoupgrade
    getgenv().difficulty = data.difficulty
    getgenv().world = data.world
    getgenv().level = data.level
    --getgenv().door = data.door

    getgenv().SpawnUnitPos = data.xspawnUnitPos
    getgenv().SelectedUnits = data.xselectedUnits
    getgenv().autoabilities = data.autoabilities
--#endregion

---// updates the json file
--#region update json
    function updatejson()

        local xdata = {
            -- unitname = getgenv().unitname,
            -- unitid = getgenv().unitid,
            AutoLeave = getgenv().AutoLeave,
            AutoReplay = getgenv().AutoReplay,
            AutoChallenge  = getgenv().AutoChallenge, 
            selectedreward = getgenv().selectedreward,
            AutoChallengeAll = getgenv().AutoChallengeAll, 
            sellatwave = getgenv().sellatwave,
            autosell = getgenv().autosell,
            webhook = getgenv().weburl,
            autofarm = getgenv().AutoFarm,
            autofarmic = getgenv().AutoFarmIC,
            autofarmtp = getgenv().AutoFarmTP,
            autoloadtp = getgenv().AutoLoadTP,
            autostart = getgenv().autostart,
            autoupgrade = getgenv().autoupgrade,
            difficulty = getgenv().difficulty,
            world = getgenv().world,
            level = getgenv().level,
            --door = getgenv().door,

            xspawnUnitPos = getgenv().SpawnUnitPos,
            xselectedUnits = getgenv().SelectedUnits,
            autoabilities = getgenv().autoabilities
        }

        local json = HttpService:JSONEncode(xdata)
        writefile(savefilename, json)
    end
--#endregion

    --\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--
    --\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--

    -- Uilib Shits

    local exec = tostring(identifyexecutor())

    local DiscordLib = loadstring(game:HttpGet "https://raw.githubusercontent.com/Forever4D/Lib/main/DiscordLib2.lua")()
    local win = DiscordLib:Window("[🌑UPD 7.6] Anime Adventures "..versionx.." - "..exec)
       
    if exec == "Synapse X" or exec == "ScriptWare" or exec == "Trigon" then
        print("Good boi")
    else
        local gettrigonserver = win:Server("Get Trigon Evo!", "http://www.roblox.com/asset/?id=7628278821")
        local gettrigon = gettrigonserver:Channel("📐 Get Trigon Evo!")
        gettrigon:Label("⚠️ It looks like you're using "..exec..".💀⚠️")
        gettrigon:Label("❗ You maybe wanna try out Trigon Evo, It could be better\nthen "..exec..". 🤮")
        gettrigon:Label("❗ Click the button below to copy Trigon Evo's Discord server!!")
        gettrigon:Button("👉 Copy Trigon Discord Link!", function()
            setclipboard("https://discord.gg/rnZXbd2yfW")
            DiscordLib:Notification("Copied!!", "✔ Trigon Evo's Discord Invite Link Has Been Copied To Your Clipboard!!", "Okay!")
        end)
    end

    local autofrmserver = win:Server("Auto Farm Section", "http://www.roblox.com/asset/?id=11579310982")
    local webhookserver = win:Server("Discord Wehhook  ", "http://www.roblox.com/asset/?id=11585480207")
    local cngelogserver = win:Server("Changelog        ", "http://www.roblox.com/asset/?id=11579189531")
    local creditsserver = win:Server("Credits          ", "http://www.roblox.com/asset/?id=11579371312")






    if game.PlaceId == 8304191830 then

        local unitselecttab = autofrmserver:Channel("👷 Select Units")
        local slectworld = autofrmserver:Channel("🌎 Select World")
        local autofarmtab = autofrmserver:Channel("🤖 Auto Farm")
        local autoclngtab = autofrmserver:Channel("🎯 Auto Challenge")
    

--------------------------------------------------
--------------- Select Units Tab -----------------
--------------------------------------------------
--#region Select Units Tab
        local Units = {}

        local function loadUnit()
            repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("collection"):FindFirstChild("grid"):FindFirstChild("List"):FindFirstChild("Outer"):FindFirstChild("UnitFrames")
            task.wait(2)
            table.clear(Units)
            for i, v in pairs(game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.collection.grid.List.Outer.UnitFrames:GetChildren()) do
                if v.Name == "CollectionUnitFrame" then
                    repeat task.wait() until v:FindFirstChild("_uuid")
                    table.insert(Units, v.name.Text .. " #" .. v._uuid.Value)
                end
            end
        end

        loadUnit()

        local function Check(x, y)
            for i, v in ipairs(game:GetService("Players").LocalPlayer.PlayerGui.collection.grid.List.Outer.UnitFrames:GetChildren()) do
                if v:IsA("ImageButton") then
                    if v.EquippedList.Equipped.Visible == true then
                        if v.Main.petimage:GetChildren()[2].Name == x then
                            --print(v.name.Text.." #"..v._uuid.Value)
                            getgenv().SelectedUnits["U"..tostring(y)] = tostring(v.name.Text.." #"..v._uuid.Value)
                            updatejson()
                            return true
                        end
                    end
                end
            end
        end

        local function Equip()
            game:GetService("ReplicatedStorage").endpoints.client_to_server.unequip_all:InvokeServer()
            
            for i = 1, 6 do
                local unitinfo = getgenv().SelectedUnits["U" .. i]
                warn(unitinfo)
                if unitinfo ~= nil then
                    local unitinfo_ = unitinfo:split(" #")
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.equip_unit:InvokeServer(unitinfo_[2])
                end
            end
            updatejson()
        end

        unitselecttab:Button("Select Equipped Units", function()
            for i, v in ipairs(game:GetService("Players").LocalPlayer.PlayerGui["spawn_units"].Lives.Frame.Units:GetChildren()) do
                if v:IsA("ImageButton") then
                    local unitxx = v.Main.petimage.WorldModel:GetChildren()[1]
                    if unitxx ~= nil then
                        if Check(unitxx.Name,v) then
                            print(unitxx, v)
                        end
                    end
                end
            end
            DiscordLib:Notification("Equipped Units Are Selected!", "The dropdowns may not show the unit names now, but it will show next time you execute!", "Okay!")

        end)

        local drop = unitselecttab:Dropdown("Unit 1", Units, getgenv().SelectedUnits["U1"], function(bool)
            getgenv().SelectedUnits["U1"] = bool
            Equip()
        end)

        local drop2 = unitselecttab:Dropdown("Unit 2", Units, getgenv().SelectedUnits["U2"], function(bool)
            getgenv().SelectedUnits["U2"] = bool
            Equip()
        end)

        local drop3 = unitselecttab:Dropdown("Unit 3", Units, getgenv().SelectedUnits["U3"], function(bool)
            getgenv().SelectedUnits["U3"] = bool
            Equip()
        end)

        local drop4 = unitselecttab:Dropdown("Unit 4", Units, getgenv().SelectedUnits["U4"], function(bool)
            getgenv().SelectedUnits["U4"] = bool
            Equip()
        end)

        local axx =  game.Players.LocalPlayer.PlayerGui["spawn_units"].Lives.Main.Desc.Level.Text:split(" ")
        _G.drop5 = nil
        _G.drop6 = nil
        if tonumber(axx[2]) >= 20 then
            _G.drop5 = unitselecttab:Dropdown("Unit 5", Units, getgenv().SelectedUnits["U5"], function(bool)
                getgenv().SelectedUnits["U5"] = bool
                Equip()
            end)
        end

        if tonumber(axx[2]) >= 50 then
            _G.drop6 = unitselecttab:Dropdown("Unit 6", Units, getgenv().SelectedUnits["U6"], function(bool)
                getgenv().SelectedUnits["U6"] = bool
                Equip()
            end)
        end
--------------// Refresh Unit List \\------------- 
        unitselecttab:Button("Refresh Unit List", function()
            drop:Clear()
            drop2:Clear()
            drop3:Clear()
            drop4:Clear()
            if _G.drop5 ~= nil then
                _G.drop5:Clear()
            end
            if _G.drop6 ~= nil then
                _G.drop6:Clear()
            end 

            loadUnit()
            game:GetService("ReplicatedStorage").endpoints.client_to_server.unequip_all:InvokeServer()
            for i, v in ipairs(Units) do
                drop:Add(v)
                drop2:Add(v)
                drop3:Add(v)
                drop4:Add(v)
                if _G.drop5 ~= nil then
                    _G.drop5:Add(v)
                end
                if _G.drop6 ~= nil then
                    _G.drop6:Add(v)
                end 
            end
            getgenv().SelectedUnits = {
                U1 = nil,
                U2 = nil,
                U3 = nil,
                U4 = nil,
                U5 = nil,
                U6 = nil
            }
        end) 
        unitselecttab:Label(" ")
        unitselecttab:Label(" ")
--#endregion
--------------------------------------------------
--------------- Select World Tab -----------------
--------------------------------------------------
--#region Select world tab
        getgenv().levels = {"nill"}

        getgenv().diff = slectworld:Dropdown("Select Difficulty", {"Normal", "Hard"}, getgenv().difficulty, function(diff)
            getgenv().difficulty = diff
            updatejson()
        end)

        local worlddrop = slectworld:Dropdown("Select World", {"Plannet Namak", "Shiganshinu District", "Snowy Town","Hidden Sand Village", "Marine's Ford",
        "Ghoul City", "Hollow World", "Ant Kingdom", "Magic Town", "Cursed Academy","Clover Kingdom", "Clover Legend - HARD","Hollow Legend - HARD"}, getgenv().world, function(world)
            getgenv().world = world
            updatejson()
            if world == "Plannet Namak" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"namek_infinite", "namek_level_1", "namek_level_2", "namek_level_3",
                                    "namek_level_4", "namek_level_5", "namek_level_6"}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Shiganshinu District" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"aot_infinite", "aot_level_1", "aot_level_2", "aot_level_3", "aot_level_4",
                                    "aot_level_5", "aot_level_6"}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Snowy Town" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"demonslayer_infinite", "demonslayer_level_1", "demonslayer_level_2",
                                    "demonslayer_level_3", "demonslayer_level_4", "demonslayer_level_5",
                                    "demonslayer_level_6"}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Hidden Sand Village" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"naruto_infinite", "naruto_level_1", "naruto_level_2", "naruto_level_3",
                                    "naruto_level_4", "naruto_level_5", "naruto_level_6"}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Marine's Ford" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"marineford_infinite","marineford_level_1","marineford_level_2","marineford_level_3",
                "marineford_level_4","marineford_level_5","marineford_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Ghoul City" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"tokyoghoul_infinite","tokyoghoul_level_1","tokyoghoul_level_2","tokyoghoul_level_3",
                                    "tokyoghoul_level_4","tokyoghoul_level_5","tokyoghoul_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Hollow World" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"hueco_infinite","hueco_level_1","hueco_level_2","hueco_level_3",
                                    "hueco_level_4","hueco_level_5","hueco_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Ant Kingdom" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"hxhant_infinite","hxhant_level_1","hxhant_level_2","hxhant_level_3",
                                    "hxhant_level_4","hxhant_level_5","hxhant_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
               
            elseif world == "Magic Town" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"magnolia_infinite","magnolia_level_1","magnolia_level_2","magnolia_level_3",
                                    "magnolia_level_4","magnolia_level_5","magnolia_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Cursed Academy" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"jjk_infinite","jjk_level_1","jjk_level_2","jjk_level_3",
                                    "jjk_level_4","jjk_level_5","jjk_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Clover Kingdom" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"clover_infinite","clover_level_1","clover_level_2","clover_level_3",
                                    "clover_level_4","clover_level_5","clover_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Clover Legend - HARD" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"clover_legend_1","clover_legend_2","clover_legend_3",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Hollow Legend - HARD" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"bleach_legend_1","bleach_legend_2","bleach_legend_3","bleach_legend_4","bleach_legend_5",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            end
        end)

      
            getgenv().leveldrop = slectworld:Dropdown("Select Level", getgenv().levels, getgenv().level, function(level)
            getgenv().level = level
            updatejson()
            
        end)
--#endregion
--------------------------------------------------
------------------ Auto Farm Tab -----------------
--------------------------------------------------
--#region Auto Farm Tab
        autofarmtab:Toggle("Auto Replay", getgenv().AutoReplay, function(bool)
            getgenv().AutoReplay = bool
            updatejson()
        end)
        autofarmtab:Toggle("Auto Leave", getgenv().AutoLeave, function(bool)
            getgenv().AutoLeave = bool
            updatejson()
        end)
        autofarmtab:Toggle("Auto Start Thriller Park", getgenv().AutoFarmTP, function(bool)
            getgenv().AutoFarmTP = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Start Infinity Castle", getgenv().AutoFarmIC, function(bool)
            getgenv().AutoFarmIC = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Farm", getgenv().AutoFarm, function(bool)
            getgenv().AutoFarm = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Start", getgenv().autostart, function(bool)
            getgenv().autostart = bool
            updatejson()

            --[[if getgenv().autostart and getgenv().AutoFarm then

                for i, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
                    if v.Name == "Owner" and v.Value == nil then
                        getgenv().door = v.Parent.Name
                        break
                    end
                end

                task.wait()

                local args = {
                    [1] = getgenv().door
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))

                task.wait()

                if getgenv().level:match("infinite") then
                    local args = {
                        [1] = getgenv().door, -- Lobby 
                        [2] = getgenv().level, -- World
                        [3] = true, -- Friends Only or not
                        [4] = "Hard"
                    }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
                else
                    local args = {
                        [1] = getgenv().door, -- Lobby 
                        [2] = getgenv().level, -- World
                        [3] = true, -- Friends Only or not
                        [4] = getgenv().difficulty
                    }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
                end


                task.wait()

                local args = {
                    [1] = getgenv().door
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
            end ]]

        end)

        autofarmtab:Toggle("Auto Abilities", getgenv().autoabilities, function(bool)
            getgenv().autoabilities = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Upgrade Units", getgenv().autoupgrade, function(bool)
            getgenv().autoupgrade = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Sell at spectic Wave", getgenv().autosell, function(x)
            getgenv().autosell = x
            updatejson()
            if getgenv().autosell == false then
                getgenv().disableatuofarm = false
            end
        end)

        ---- 
        autofarmtab:Textbox("Select Wave Number for Auto Sell {Press Enter}", tostring(getgenv().sellatwave), false, function(t)
            getgenv().sellatwave = tonumber(t)
            updatejson()
        end)
        
        local autoloadtab = autofrmserver:Channel("⌛ Auto Load Script")
		autoloadtab:Label("This Automatically executes script when you teleport to man.")
        autoloadtab:Label("You don't need to put the script in AutoExec folder!")
        autoloadtab:Toggle("Auto Load Script", getgenv().AutoLoadTP, function(bool)
            queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/ArponAG/Scripts/main/AnimeAdventures.lua'))()")
            getgenv().AutoLoadTP = bool
            updatejson()
        end)
        autoloadtab:Label("⚠️ If it doesnt work properly then put the script in Autoexec\nfolder!!! ⚠️")

        

		local webhooktab = webhookserver:Channel("🌐 Webhook")
		webhooktab:Label("Webhook sends notification in discord everytime\nGame is Finished!")
		
		local webhoolPlaceholder
		if getgenv().weburl == "" then
			webhoolPlaceholder = "Insert url here!"
		else
			webhoolPlaceholder = getgenv().weburl
		end
		webhooktab:Textbox("Webhook URL {Press Enter}" , webhoolPlaceholder, false, function(web_url)
            getgenv().weburl = web_url
            updatejson()
        end)

        autofarmtab:Label(" ")
        autofarmtab:Label(" ")
        autofarmtab:Label(" ")
        autofarmtab:Label(" ")
--#endregion
--------------------------------------------------
-------------------- Auto Challenge --------------
--------------------------------------------------
--#region Auto Challenge
        autoclngtab:Toggle("Auto Challenge", getgenv().AutoChallenge, function(bool)
            getgenv().AutoChallenge = bool
            updatejson()
        end)
        local worlddrop = autoclngtab:Dropdown("Select Reward", {"star_fruit_random","star_remnant","gems", "gold"}, getgenv().selectedreward, function(reward)
            getgenv().selectedreward = reward
            updatejson()
        end)

        autoclngtab:Toggle("Farm All Rewards", getgenv().AutoChallengeAll, function(bool)
            getgenv().AutoChallengeAll = bool
            updatejson()
        end)
--#endregion
--------------------------------------------------
-------------------- Auto Buy/Sell ---------------
--------------------------------------------------
--#region Auto Buy/Sell
        getgenv().UnitSellTog = false
        getgenv().autosummontickets = false
        getgenv().autosummongem = false
        getgenv().autosummongem10 = false

        getgenv().autosummonticketse = false
        getgenv().autosummongeme = false
        getgenv().autosummongem10e = false

        local misc = autofrmserver:Channel("💸 Auto Buy/Sell")


        local function autobuyfunc(xx, item)
            task.wait()

            local args = {
                [1] = xx,
                [2] = item
            }
            game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_from_banner:InvokeServer(unpack(args))
            
        end

        misc:Label("Special - 2x Mythic")
        misc:Toggle("Auto Summon {Use Ticket 1}", getgenv().autosummonticketse, function(bool)
            getgenv().autosummonticketse = bool
            while getgenv().autosummonticketse do
                autobuyfunc("EventClover", "ticket")
            end
            updatejson()
        end)

        misc:Toggle("Auto Summon {Buy 1}", getgenv().autosummongeme, function(bool)
            getgenv().autosummongeme = bool
            while getgenv().autosummongeme do
                autobuyfunc("EventClover", "gems")
            end
            updatejson()
        end)

        misc:Toggle("Auto Summon {Buy 10}", getgenv().autosummongem10e, function(bool)
            getgenv().autosummongem10 = bool
            while getgenv().autosummongem10 do
                autobuyfunc("EventClover", "gems10")
            end
            updatejson()
        end)
        misc:Label("Standard")
        misc:Toggle("Auto Summon {Use Ticket 1}", getgenv().autosummontickets, function(bool)
            getgenv().autosummontickets = bool
            while getgenv().autosummontickets do
                autobuyfunc("Standard", "ticket")
            end
            updatejson()
        end)

        misc:Toggle("Auto Summon {Buy 1}", getgenv().autosummongem, function(bool)
            getgenv().autosummongem = bool
            while getgenv().autosummongem do
                autobuyfunc("Standard", "gems")
            end
            updatejson()
        end)

        misc:Toggle("Auto Summon {Buy 10}", getgenv().autosummongem10, function(bool)
            getgenv().autosummongem10 = bool
            while getgenv().autosummongem10 do
                autobuyfunc("Standard", "gems10")
            end
            updatejson()
        end)

        misc:Label("Sell Units")
        local utts = misc:Dropdown("Select Rarity", {"Rare", "Epic"}, getgenv().UnitToSell, function(u)
            getgenv().UnitToSell = u
        end)

        misc:Toggle("Auto Sell Units", getgenv().UnitSellTog, function(bool)
            getgenv().UnitSellTog = bool
        end) 
--#endregion
--------------------------------------------------
--------------------------------------------------
--------------------------------------------------
--#region --- Inside match ---
    else -- When in a match
        game.Players.LocalPlayer.PlayerGui.MessageGui.Enabled = false
        game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error.Volume = 0
        game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error_old.Volume = 0
        




    local autofarmtab = autofrmserver:Channel("🤖 Auto Farm")
    local autoclngtab = autofrmserver:Channel("🎯 Auto Challenge")
    local autoloadtab = autofrmserver:Channel("⌛ Auto Load Script")
    local autoseltab = autofrmserver:Channel("💸 Auto Sell")
    local webhooktab = webhookserver:Channel("🌐 Webhook")
    
		autoloadtab:Label("This Automatically executes script when you teleport to man.")
        autoloadtab:Label("You don't need to put the script in AutoExec folder!")
        autoloadtab:Toggle("Auto Load Script", getgenv().AutoLoadTP, function(bool)
            queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/ArponAG/Scripts/main/AnimeAdventures.lua'))()")
            getgenv().AutoLoadTP = bool
            updatejson()
        end)
        autoloadtab:Label("⚠️ If it doesnt work properly then put the script in Autoexec\nfolder!!! ⚠️")

--#region Auto Farm Tab
        autofarmtab:Toggle("Auto Replay", getgenv().AutoReplay, function(bool)
            getgenv().AutoReplay = bool
            updatejson()
        end)
        autofarmtab:Toggle("Auto Leave", getgenv().AutoLeave, function(bool)
            getgenv().AutoLeave = bool
            updatejson()
        end)
        autofarmtab:Toggle("Auto Start Thriller Park", getgenv().AutoFarmTP, function(bool)
            getgenv().AutoFarmTP = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Start Infinity Castle", getgenv().AutoFarmIC, function(bool)
            getgenv().AutoFarmIC = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Farm", getgenv().AutoFarm, function(bool)
            getgenv().AutoFarm = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Abilities", getgenv().autoabilities, function(bool)
            getgenv().autoabilities = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Start", getgenv().autostart, function(bool)
            getgenv().autostart = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Upgrade Units", getgenv().autoupgrade, function(bool)
            getgenv().autoupgrade = bool
            updatejson()
        end)

        function MouseClick(UnitPos)
            local connection
            local _map = game:GetService("Workspace")["_BASES"].player.base["fake_unit"]:WaitForChild("HumanoidRootPart")
            connection = UserInputService.InputBegan:Connect(
                function(input, gameProcessed)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        connection:Disconnect()
                        local a = Instance.new("Part", game.Workspace)
                        a.Size = Vector3.new(1, 1, 1)
                        a.Material = Enum.Material.Neon
                        a.Position = mouse.hit.p
                        task.wait()
                        a.Anchored = true
                        DiscordLib:Notification("Spawn Unit Posotion:", tostring(a.Position), "Okay!")
                        a.CanCollide = false
                        for i = 0, 1, 0.1 do
                            a.Transparency = i
                            task.wait()
                        end
                        a:Destroy()

                        if game.Workspace._map:FindFirstChild("namek mushroom model") then
                            print("Namak")
                            SpawnUnitPos["Namak"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Namak"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Namak"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("houses_new") then
                            print("Aot")
                            SpawnUnitPos["Aot"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Aot"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Aot"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("Snow Particles") then
                            print("Snowy")
                            SpawnUnitPos["Snowy"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Snowy"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Snowy"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("sand_gate") then
                            warn("Sand")
                            SpawnUnitPos["Sand"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Sand"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Sand"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("icebergs") then
                            print("Marine")
                            SpawnUnitPos["Marine"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Marine"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Marine"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("Helicopter Pad") then
                            print("Ghoul")
                            SpawnUnitPos["Ghoul"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Ghoul"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Ghoul"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("Bones/dust") then
                            print("Hollow")
                            SpawnUnitPos["Hollow"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Hollow"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Hollow"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("Ant Nest") then
                            print("Ant")
                            SpawnUnitPos["Ant"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Ant"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Ant"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("light poles") then
                            print("Magic")
                            SpawnUnitPos["Magic"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Magic"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Magic"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("LanternsGround") then
                            print("Cursed")    
                            SpawnUnitPos["Cursed"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Cursed"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Cursed"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("pumpkins") then
                            print("thriller_park")    
                            SpawnUnitPos["thriller_park"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["thriller_park"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["thriller_park"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("skeleton") then
                            print("black_clover")    
                            SpawnUnitPos["black_clover"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["black_clover"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["black_clover"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("graves") then
                            print("hollow_leg")    
                            SpawnUnitPos["hollow_leg"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["hollow_leg"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["hollow_leg"][UnitPos]["z"] = a.Position.Z
                        end

                        updatejson()
                    end
                end)
        end

        --// Set Position \\--
        autofarmtab:Button("Set Unit 1 Postion", function()
            DiscordLib:Notification("Set Unit 1 Spawn Position",
                "Click on the floor to set the spawn unit position!\n (don't press \"Done\" until you set position)",
                "Done")
                warn(1)
            MouseClick("UP1")
            warn(2)
        end)

        autofarmtab:Button("Set Unit 2 Postion", function()
            DiscordLib:Notification("Set Unit 2 Spawn Position",
                "Click on the floor to set the spawn unit position!\n (don't press \"Done\" until you set position)",
                "Done")
            MouseClick("UP2")
        end)
        autofarmtab:Button("Set Unit 3 Postion", function()
            DiscordLib:Notification("Set Unit 3 Spawn Position",
                "Click on the floor to set the spawn unit position!\n (don't press \"Done\" until you set position)",
                "Done")
            MouseClick("UP3")
        end)
        autofarmtab:Button("Set Unit 4 Postion", function()
            DiscordLib:Notification("Set Unit 4 Spawn Position",
                "Click on the floor to set the spawn unit position!\n (don't press \"Done\" until you set position)",
                "Done")
            MouseClick("UP4")
        end)

        
        local axxc = game.Players.LocalPlayer.PlayerGui["spawn_units"].Lives.Main.Desc.Level.Text:split(" ")

        if tonumber(axxc[2]) >= 20 then
            autofarmtab:Button("Set Unit 5 Postion", function()
                DiscordLib:Notification("Set Unit 5 Spawn Position",
                    "Click on the floor to set the spawn unit position!\n (don't press \"Done\" until you set position)",
                    "Done")
                MouseClick("UP5")
            end)
        end

        if tonumber(axxc[2]) >= 50 then
            autofarmtab:Button("Set Unit 6 Postion", function()
                DiscordLib:Notification("Set Unit 6 Spawn Position",
                    "Click on the floor to set the spawn unit position!\n (don't press \"Done\" until you set position)",
                    "Done")
                MouseClick("UP6")
            end)
        end


        -- set unit position end--
        autofarmtab:Label("--- Saved Config (Doesn't Refresh) ---")
        autofarmtab:Label("Auto Sell at Wave: " .. tostring(getgenv().sellatwave))
        autofarmtab:Label("Webhook: " .. tostring(getgenv().weburl))
        autofarmtab:Label("Auto Farm: " .. tostring(getgenv().AutoFarm))
        autofarmtab:Label("Auto Start: " .. tostring(getgenv().autostart))
        autofarmtab:Label("Auto Sell: " .. tostring(getgenv().autosell))
        autofarmtab:Label("Auto Upgrade: " .. tostring(getgenv().autoupgrade))
        autofarmtab:Label("Difficulty: " .. tostring(getgenv().difficulty))
        autofarmtab:Label("Selected World: " .. tostring(getgenv().world))
        autofarmtab:Label("Selected Level: " .. tostring(getgenv().level))
        autofarmtab:Label(" ")
        autofarmtab:Label(" ")

--#endregion

--#region Auto Challenge 
autoclngtab:Toggle("Auto Challenge", getgenv().AutoChallenge, function(bool)
    getgenv().AutoChallenge = bool
    updatejson()
end)
local worlddrop = autoclngtab:Dropdown("Select Reward", {"star_fruit_random","star_remnant","gems", "gold"}, getgenv().selectedreward, function(reward)
    getgenv().selectedreward = reward
    updatejson()
end)

autoclngtab:Toggle("Farm All Rewards", getgenv().AutoChallengeAll, function(bool)
    getgenv().AutoChallengeAll = bool
    updatejson()
end)
--#endregion

--#region Auto Sell Tab
        autoseltab:Toggle("Auto Sell at Specfic Wave", getgenv().autosell, function(x)
            getgenv().autosell = x
            updatejson()
            if getgenv().autosell == false then
                getgenv().disableatuofarm = false
            end
        end)

        autoseltab:Textbox("Select Wave Number for Auto Sell {Press Enter}", getgenv().sellatwave, false, function(t)
            getgenv().sellatwave = tonumber(t)
            updatejson()
        end)
--#endregion



--#region Webhook
		--//Webhook Tab (in-game)\\--
		webhooktab:Label("Webhook sends notification in discord everytime game Finishes.")
		local webhoolPlaceholder
		if getgenv().weburl == "" then
			webhoolPlaceholder = "Insert url here!"
		else
			webhoolPlaceholder = getgenv().weburl
		end
		webhooktab:Textbox("Webhook URL {Press Enter}" , webhoolPlaceholder, false, function(web_url)
            getgenv().weburl = web_url
            updatejson()
        end)
        webhooktab:Button("Test Webhook", function()
            webhook()
        end)
--#endregion


    end
--#endregion

--#region changelog
    local changelog = cngelogserver:Channel("💬 Changelog")
    changelog:Label("-- 1.6.1 --")
    changelog:Label("+ Added Auto Replay")
    changelog:Label("+ Fixed Hollow Stage")
    changelog:Label("-- 1.6.0 --")
    changelog:Label("+ Added Legend Stages - Hollow Invation")
    changelog:Label("-- 1.5.9 --")
    changelog:Label("+ Fixed Auto Farm not starting\n+ Added new default positions for units.")
    changelog:Label("-- 1.5.8 --\n")
    changelog:Label("+ Added Auto Challenge\n+ Added Auto Leave Toggle\n+ Better Auto Farming now\n+ Fixed some bugs\n")
    changelog:Label("-- 1.5.7 -- ")
    changelog:Label("+ Added Auto Buy for Special Banner")
    changelog:Label("-- 1.5.6 -- ")
    changelog:Label("+ Fixed not executing")
    changelog:Label("-- 1.5.5 -- ")
    changelog:Label("+ Added Clover Legend\n+ Fixed Auto Ability breaking randomly")
    changelog:Label("-- v1.5.4 --")
    changelog:Label("+ Added Clover Kingdom")
--#endregion

    local credits = creditsserver:Channel("✨ Credits")
    credits:Label("Arpon AG#6612")
    credits:Label("Forever4D#0001")
    credits:Label(" ")
end

--------------------------------------------------
--------------------------------------------------

---// Checks if file exist or not\\---
if isfile(savefilename) then 

    local jsonData = readfile(savefilename)
    local data = HttpService:JSONDecode(jsonData)

    sex()

else
--#region CREATES JSON
    local xdata = {
        -- unitname = "name",
        -- unitid = "id",
        AutoReplay = false,
        AutoLeave = true,
        AutoChallenge = false,
        selectedreward = "star_fruit_random",
        AutoChallengeAll = false,
        autoabilities = false,
        autofarmtp = false,
        webhook = "",
        sellatwave = 0,
        autosell = false,
        autofarm = false,
        autofarmic = false,
        autostart = false,
        autoloadtp = true,
        autoupgrade = false,
        difficulty = "nil",
        world = "nil",
        level = "nil",
        door = "nil",
    
        xspawnUnitPos  = {
            black_clover  = {
              UP1  = {
                y  = 1.4244641065597535,
                x  = -109.30056762695313,
                z  = -54.575347900390628
             },
              UP3  = {
                y  = 1.4322717189788819,
                x  = -114.2433853149414,
                z  = -55.260982513427737
             },
              UP2  = {
                y  = 1.7082736492156983,
                x  = -127.53932189941406,
                z  = -55.277626037597659
             },
              UP6  = {
                y  = 1.4487617015838624,
                x  = -107.07078552246094,
                z  = -51.333045959472659
             },
              UP5  = {
                y  = 1.8965977430343629,
                x  = -118.5692138671875,
                z  = -57.20484161376953
             },
              UP4  = {
                y  = 1.4205386638641358,
                x  = -105.46223449707031,
                z  = -51.20615005493164
             }
           },
           hollow_leg = {
            UP1 = {
                x = -168.71795654296875,
                y = 36.04443359375, 
                z = 564.4705810546875 
            },
            UP2 = {
                x = -161.105712890625, 
                y = 36.04443359375, 
                z = 558.4195556640625 
            },
            UP3 = {
                x = -161.05670166015625, 
                y = 36.04443359375, 
                z = 546.204833984375 
               
            },
            UP4 = {
                x = -163.51824951171875, 
                y = 36.04443359375, 
                z = 534.6953735351562 
            },
            UP5 = {
                x = -170.02479553222656, 
                y = 36.04443359375, 
                z = 528.9660034179688
            },
            UP6 = {
                x = -160.92405700683594, 
                y = 36.04443359375, 
                z = 565.2430419921875 
            }
           },
            Cursed  = {
              UP1  = {
                y  = 122.78201293945313,
                x  = 361.69732666015627,
                z  = -89.76468658447266
             },
              UP3  = {
                y  = 122.73872375488281,
                x  = 372.2068786621094,
                z  = -62.877601623535159
             },
              UP2  = {
                y  = 122.73872375488281,
                x  = 391.6465759277344,
                z  = -62.87253189086914
             },
              UP6  = {
                y  = 121.5274887084961,
                x  = 399.4963684082031,
                z  = -60.31044387817383
             },
              UP5  = {
                y  = 121.6282958984375,
                x  = 400.8389587402344,
                z  = -64.46269226074219
             },
              UP4  = {
                y  = 122.73872375488281,
                x  = 362.14788818359377,
                z  = -77.3993148803711
             }
           },
            Sand  = {
              UP1  = {
                y  = 25.514015197753908,
                x  = -919.7685546875,
                z  = 290.9293518066406
             },
              UP3  = {
                y  = 25.518001556396486,
                x  = -919.7103881835938,
                z  = 288.1217346191406
             },
              UP2  = {
                y  = 26.06340980529785,
                x  = -920.3797607421875,
                z  = 300.7817077636719
             },
              UP6  = {
                y  = 25.528093338012697,
                x  = -916.4822998046875,
                z  = 287.9609069824219
             },
              UP5  = {
                y  = 25.71731185913086,
                x  = -920.7069091796875,
                z  = 296.8504943847656
             },
              UP4  = {
                y  = 25.508501052856447,
                x  = -919.2952270507813,
                z  = 294.7797546386719
             }
           },
            Namak  = {
              UP1  = {
                y  = 92.14557647705078,
                x  = -2931.182861328125,
                z  = -698.5640869140625
             },
              UP3  = {
                y  = 92.5256118774414,
                x  = -2950.3916015625,
                z  = -697.1671142578125
             },
              UP2  = {
                y  = 93.32953643798828,
                x  = -2940.813720703125,
                z  = -697.09326171875
             },
              UP6  = {
                y  = 92.16944885253906,
                x  = -2946.967041015625,
                z  = -710.122802734375
             },
              UP5  = {
                y  = 92.15478515625,
                x  = -2947.684326171875,
                z  = -699.6248779296875
             },
              UP4  = {
                y  = 92.5256118774414,
                x  = -2950.408935546875,
                z  = -709.8072509765625
             }
           },
            Hollow  = {
              UP1  = {
                y  = 133.10752868652345,
                x  = -168.9812774658203,
                z  = -692.3645629882813
             },
              UP3  = {
                y  = 133.09632873535157,
                x  = -167.3197021484375,
                z  = -695.4755249023438
             },
              UP2  = {
                y  = 133.50978088378907,
                x  = -160.6356964111328,
                z  = -709.1862182617188
             },
              UP6  = {
                y  = 133.08169555664063,
                x  = -176.02857971191407,
                z  = -691.7825317382813
             },
              UP5  = {
                y  = 133.0151824951172,
                x  = -161.20188903808595,
                z  = -702.9484252929688
             },
              UP4  = {
                y  = 133.17193603515626,
                x  = -172.60714721679688,
                z  = -691.3147583007813
             }
           },
            Ant  = {
              UP1  = {
                y  = 23.502197265625,
                x  = -180.23072814941407,
                z  = 2961.130126953125
             },
              UP3  = {
                y  = 23.855152130126954,
                x  = -167.0123748779297,
                z  = 2954.2958984375
             },
              UP2  = {
                y  = 23.637359619140626,
                x  = -205.69203186035157,
                z  = 2964.095947265625
             },
              UP6  = {
                y  = 23.31997299194336,
                x  = -163.1376953125,
                z  = 2959.968017578125
             },
              UP5  = {
                y  = 23.598222732543947,
                x  = -170.1063232421875,
                z  = 2955.477294921875
             },
              UP4  = {
                y  = 23.855152130126954,
                x  = -156.4979705810547,
                z  = 2959.6123046875
             }
           },
            Aot  = {
              UP1  = {
                y  = 34.25483703613281,
                x  = -3016.723388671875,
                z  = -682.4714965820313
             },
              UP3  = {
                y  = 34.442054748535159,
                x  = -3024.1181640625,
                z  = -682.2401123046875
             },
              UP2  = {
                y  = 34.387603759765628,
                x  = -3035.071533203125,
                z  = -683.9107055664063
             },
              UP6  = {
                y  = 34.25492477416992,
                x  = -3019.5390625,
                z  = -681.8257446289063
             },
              UP5  = {
                y  = 34.25492477416992,
                x  = -3030.930419921875,
                z  = -683.3449096679688
             },
              UP4  = {
                y  = 34.442054748535159,
                x  = -3013.065185546875,
                z  = -681.4302368164063
             }
           },
            Snowy  = {
              UP1  = {
                y  = 34.8720588684082,
                x  = -2884.6103515625,
                z  = -139.17750549316407
             },
              UP3  = {
                y  = 35.055450439453128,
                x  = -2871.251708984375,
                z  = -131.86231994628907
             },
              UP2  = {
                y  = 34.86832046508789,
                x  = -2863.6240234375,
                z  = -120.90508270263672
             },
              UP6  = {
                y  = 34.79566192626953,
                x  = -2853.62548828125,
                z  = -123.30137634277344
             },
              UP5  = {
                y  = 34.79277038574219,
                x  = -2853.63232421875,
                z  = -119.10173034667969
             },
              UP4  = {
                y  = 34.86832046508789,
                x  = -2878.749755859375,
                z  = -138.48580932617188
             }
           },
            Ghoul  = {
              UP1  = {
                y  = 59.36590576171875,
                x  = -3008.964111328125,
                z  = -56.00475311279297
             },
              UP3  = {
                y  = 59.03008270263672,
                x  = -3008.75732421875,
                z  = -58.37107849121094
             },
              UP2  = {
                y  = 59.382938385009769,
                x  = -2998.44140625,
                z  = -42.68498992919922
             },
              UP6  = {
                y  = 59.03008270263672,
                x  = -3009.03125,
                z  = -67.12299346923828
             },
              UP5  = {
                y  = 59.03008270263672,
                x  = -3007.1025390625,
                z  = -52.12919998168945
             },
              UP4  = {
                y  = 59.03008270263672,
                x  = -3008.94580078125,
                z  = -63.67665100097656
             }
           },
            Magic  = {
              UP1  = {
                y  = 7.411101341247559,
                x  = -606.7291259765625,
                z  = -815.5218505859375
             },
              UP3  = {
                y  = 7.411093711853027,
                x  = -589.5305786132813,
                z  = -814.8512573242188
             },
              UP2  = {
                y  = 7.413991928100586,
                x  = -578.809814453125,
                z  = -814.5386962890625
             },
              UP6  = {
                y  = 7.372146129608154,
                x  = -605.3615112304688,
                z  = -820.8731079101563
             },
              UP5  = {
                y  = 7.413986682891846,
                x  = -597.8843383789063,
                z  = -814.5377807617188
             },
              UP4  = {
                y  = 7.4139862060546879,
                x  = -600.348388671875,
                z  = -814.8621215820313
             }
           },
            Marine  = {
              UP1  = {
                y  = 25.521255493164064,
                x  = -2566.733642578125,
                z  = -62.77167892456055
             },
              UP3  = {
                y  = 25.5211124420166,
                x  = -2565.930419921875,
                z  = -57.89338684082031
             },
              UP2  = {
                y  = 25.210872650146486,
                x  = -2560.966796875,
                z  = -44.40180969238281
             },
              UP6  = {
                y  = 25.676485061645509,
                x  = -2566.796142578125,
                z  = -67.01408386230469
             },
              UP5  = {
                y  = 25.5211238861084,
                x  = -2563.39990234375,
                z  = -63.74509811401367
             },
              UP4  = {
                y  = 24.990556716918947,
                x  = -2570.3349609375,
                z  = -69.34259033203125
             }
           },
            thriller_park  = {
              UP1  = {
                y  = 113.23728942871094,
                x  = -224.14295959472657,
                z  = -657.738037109375
             },
              UP3  = {
                y  = 109.37400817871094,
                x  = -224.78709411621095,
                z  = -640.7178955078125
             },
              UP2  = {
                y  = 109.37401580810547,
                x  = -229.42715454101563,
                z  = -649.636474609375
             },
              UP6  = {
                y  = 109.37400817871094,
                x  = -214.7626190185547,
                z  = -632.3900146484375
             },
              UP5  = {
                y  = 109.37401580810547,
                x  = -230.53053283691407,
                z  = -657.9769287109375
             },
              UP4  = {
                y  = 109.37400817871094,
                x  = -220.0915985107422,
                z  = -636.2127075195313
             }
           }
         },

        xselectedUnits = {
            U1 = nil,
            U2 = nil,
            U3 = nil,
            U4 = nil,
            U5 = nil,
            U6 = nil
        }
    
    }

    local json = HttpService:JSONEncode(xdata)
    writefile(savefilename, json)

    sex()
--#endregion
end

--#region ----------------------
--#endregion
--------------------------------------------------



------// Auto Farm \\------
--#region Auto Farm Loop
coroutine.resume(coroutine.create(function()
    while task.wait(1.5) do
        local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
        
        if getgenv().AutoFarm and not getgenv().disableatuofarm then
            if game.PlaceId ~= 8304191830 then
                x = 1
                y = 0.7
                z = 1
                --print("AutoFarming")
                if game.Workspace._map:FindFirstChild("namek mushroom model") then
                    print("Namak")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Namak"]["UP" .. i]
    
                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("houses_new") then
                    print("Aot")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Aot"]["UP" .. i]

                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y , pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("Snow Particles") then
                    print("Snowy")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Snowy"]["UP" .. i]

                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("sand_gate") then
                    print("Sand")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Sand"]["UP" .. i]

                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("icebergs") then
                    print("Marine")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Marine"]["UP" .. i]

                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("Helicopter Pad") then
                    print("Ghoul")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Ghoul"]["UP" .. i]

                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("Bones/dust") then
                    print("Hollow")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Hollow"]["UP" .. i]

                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("Ant Nest") then
                    print("Ant")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Ant"]["UP" .. i]

                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("light poles") then
                    print("Magic")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Magic"]["UP" .. i]

                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("LanternsGround") then
                    print("Cursed")    
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Cursed"]["UP" .. i]
    
                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("pumpkins") then
                        print("thriller_park")    
                        for i = 1, 6 do
                            local unitinfo = getgenv().SelectedUnits["U" .. i]
                            if unitinfo ~= nil then
                                local unitinfo_ = unitinfo:split(" #")
                                local pos = getgenv().SpawnUnitPos["thriller_park"]["UP" .. i]
        
                                --place units 0
                                local args = {
                                    [1] = unitinfo_[2],
                                    [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                                }
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
        
                                --place units 1
                                local args = {
                                    [1] = unitinfo_[2],
                                    [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                                }
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
        
                                --place units 2 
                                local args = {
                                    [1] = unitinfo_[2],
                                    [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                                }
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
        
                                --place units 3 
                                local args = {
                                    [1] = unitinfo_[2],
                                    [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                                }
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
        
                                --place units 4
                                local args = {
                                    [1] = unitinfo_[2],
                                    [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                                }
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
        
                                --place units 5
                                local args = {
                                    [1] = unitinfo_[2],
                                    [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                                }
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                            end
                        end
                elseif game.Workspace._map:FindFirstChild("skeleton") then
                    print("black_clover")    
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["black_clover"]["UP" .. i]
    
                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("graves") then
                    print("Hollow Legend")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["hollow_leg"]["UP" .. i]
    
                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                end
            end
        end
    end
end))
--#endregion



------// Auto Leave \\------
--#region Auto Leave 

coroutine.resume(coroutine.create(function()
	local GameFinished = game:GetService("Workspace"):WaitForChild("_DATA"):WaitForChild("GameFinished")
    GameFinished:GetPropertyChangedSignal("Value"):Connect(function()
        print("Changed", GameFinished.Value == true)
        if GameFinished.Value == true then
            repeat task.wait() until  game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Enabled == true
            task.wait()
            pcall(function() webhook() end)
            print("next")
            task.wait(2.1)
            if getgenv().AutoReplay then
                
                local a={[1]="replay"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
                local a={[1]="replay"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))

            elseif getgenv().AutoLeave then
                game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
            end
        end
	end)
end))
--#endregion

------// Auto Sell Units \\------
coroutine.resume(coroutine.create(function()
while task.wait() do
    if getgenv().UnitSellTog then

        for i, v in pairs(game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.collection.grid.List.Outer.UnitFrames:GetChildren()) do
            if v.Name == "CollectionUnitFrame" then
                repeat task.wait() until v:FindFirstChild("name")
                for _, Info in next, getgenv().UnitCache do
                    if Info.name == v.name.Text and Info.rarity == getgenv().UnitToSell then
                        local args = {
                            [1] = {
                                [1] = tostring(v._uuid.Value)
                            }
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_units:InvokeServer(unpack(args))
                     end
                end
            end
        end
        
    end
end
end))

------// Auto Upgrade \\------
--#region Auto Upgrade Loop
getgenv().autoupgradeerr = false

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

coroutine.resume(coroutine.create(function()
    while task.wait(2) do
        if getgenv().autoupgrade then
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
--#endregion


------// Auto Sell \\------
--#region Auto Sell loop
coroutine.resume(coroutine.create(function()
    while task.wait() do
        local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
        if getgenv().autosell and tonumber(getgenv().sellatwave) <= _wave.Value then
            getgenv().disableatuofarm = true
            if game.PlaceId ~= 8304191830 then
                repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
                for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
                    repeat
                        task.wait()
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
--#endregion

--//Auto Abilities--
--#region Auto Abilities loop
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
         warn("//////////////////////////////////////////////////")
         getgenv().autoabilityerr = true
         error(err)
     end

end

coroutine.resume(coroutine.create(function()

    while task.wait(2) do
        if getgenv().autoabilities then
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
    end   

end))
--#endregion


getgenv().teleporting = true

------// Auto Start \\------
--#region Auto Start loop

local function checkChallenge()
    for i,v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
        if v:IsA("SurfaceGui") then
            if v:FindFirstChild("ChallengeCleared") then
                --print(v.ChallengeCleared.Visible)
                return v.ChallengeCleared.Visible
            end
        end
    end
end

local function checkReward()
    if checkChallenge() == false then
        if getgenv().selectedreward == game:GetService("Workspace")["_LOBBIES"]["_DATA"]["_CHALLENGE"]["current_reward"].Value then
            return true
        elseif getgenv().AutoChallengeAll then
            return true
        else
            return false
        end
    else
        return false
    end
end

local function startfarming()
    if getgenv().autostart and getgenv().AutoFarm and getgenv().teleporting 
                           and getgenv().AutoFarmTP == false and getgenv().AutoFarmIC == false then
        if game.PlaceId == 8304191830 then
            local cpos = plr.Character.HumanoidRootPart.CFrame

            if tostring(Workspace._LOBBIES.Story[getgenv().door].Owner.Value) ~= plr.Name then
                for i, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
                    if v.Name == "Owner" and v.Value == nil then

                        local args = {
                            [1] = tostring(v.Parent.Name)
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
                    
                        task.wait()
                    
                        if getgenv().level:match("infinite") then
                            local args = {
                                [1] = tostring(v.Parent.Name), -- Lobby 
                                [2] = getgenv().level, -- World
                                [3] = true, -- Friends Only or not
                                [4] = "Hard"
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
                        else
                            local args = {
                                [1] = tostring(v.Parent.Name), -- Lobby 
                                [2] = getgenv().level, -- World
                                [3] = true, -- Friends Only or not
                                [4] = getgenv().difficulty
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
                        end

                        local args = { 
                            [1] =tostring(v.Parent.Name)
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
                        getgenv().door = v.Parent.Name print(v.Parent.Name) --v.Parent:GetFullName()
                        plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
                        break
                    end
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

        --[[for i, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
                if v.Name == "Owner" then
                local n = tostring(v.Value)
                    if n == game:GetService("Players").LocalPlayer.Name then
                        if v.Parent.Teleporting.Value == true then
                            getgenv().teleporting = false
                        else
                            getgenv().teleporting = true
                        end
                    end
                end
            end  ]]

        end
    end
end

local function startChallenge()
    if game.PlaceId == 8304191830 then
        local cpos = plr.Character.HumanoidRootPart.CFrame

        if getgenv().AutoChallenge and getgenv().autostart and getgenv().AutoFarm  and checkReward() == true then

            for i, v in pairs(game:GetService("Workspace")["_CHALLENGES"].Challenges:GetDescendants()) do
                if v.Name == "Owner" and v.Value == nil then
                    --print(v.Parent.Name.." "..v.Parent:GetFullName())
                    local args = { 
                        [1] = tostring(v.Parent.Name)
                    }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))

                    getgenv().chdoor = v.Parent.Name
                    break
                end
            end
            task.wait()
            plr.Character.HumanoidRootPart.CFrame = cpos
           
        end
    end
end

coroutine.resume(coroutine.create(function()
    while task.wait() do
        if getgenv().AutoFarmIC == false and getgenv().AutoFarmTP == false then
            if checkChallenge() == false  then --challenge is not cleared
                if  getgenv().AutoChallenge and checkReward() == true then
                    startChallenge() --start challenge
                else
                    startfarming()--regular farming
                end
            elseif checkChallenge() == true then
                startfarming()--regular farming
            end
        end
    end
end))
--#endregion


------// Auto Start Infiniy Castle && Thriller Park \\------

local function FarmCastlePark()
    if getgenv().AutoFarmIC and getgenv().AutoFarm then
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
    elseif getgenv().AutoFarmTP and getgenv().AutoFarm then
        if game.PlaceId == 8304191830 then
            local args = {
                [1] = "_lobbytemplate_event330"
            }
            game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
            
            task.wait(5)
        end
    end
end

coroutine.resume(coroutine.create(function()
    while task.wait() do
        if checkChallenge() == false  then --challenge is not cleared
            if  getgenv().AutoChallenge and checkReward() == true then
                startChallenge() --start challenge
            else
                FarmCastlePark()--regular farming
            end
        elseif checkChallenge() == true then
            FarmCastlePark()--regular farming
        end
    end
end))

if getgenv().AutoLoadTP == true then
    queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/ArponAG/Scripts/main/AnimeAdventures.lua'))()")
end


--hide name
task.spawn(function()  -- Hides name for yters (not sure if its Fe)
    while task.wait() do
        pcall(function()
            if game.Players.LocalPlayer.Character.Head:FindFirstChild("_overhead") then
               workspace[game.Players.LocalPlayer.Name].Head["_overhead"]:Destroy()
            end
        end)
    end
end)


--anti afk
pcall(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)

    game:GetService("ReplicatedStorage").endpoints.client_to_server.claim_daily_reward:InvokeServer()
end)

print("Successfully Loaded!!")
---------------------------------------------------------------------
