-- v1.5.4 --
-- + Added Clover Kingdom
-- + Fixed Select equipped units

-- v1.5.3 --
-- + Added Auto Load Script

-- v1.5.2 --
-- + Now you can select currently equipped units
-- + Fixed Webhook 


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
local RunService = game:GetService("RunService")
local mouse = game.Players.LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")

getgenv().savefilename = "Anime-Adventures-UPD7"..game.Players.LocalPlayer.Name..".json"

--Webhook sender
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


getgenv().UnitCache = {}

for _, Module in next, game:GetService("ReplicatedStorage"):WaitForChild("src"):WaitForChild("Data"):WaitForChild("Units"):GetDescendants() do
    if Module:IsA("ModuleScript") and Module.Name ~= "UnitPresets" then
        for UnitName, UnitStats in next, require(Module) do
            getgenv().UnitCache[UnitName] = UnitStats
        end
    end
end


function sex()
    -- reads jsonfile
    local jsonData = readfile(savefilename)
    local data = HttpService:JSONDecode(jsonData)

    -- global values
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
    getgenv().door = data.door

    getgenv().SpawnUnitPos = data.xspawnUnitPos
    getgenv().SelectedUnits = data.xselectedUnits
    getgenv().autoabilities = data.autoabilities

    ---// updates the json file
    function updatejson()

        local xdata = {
            -- unitname = getgenv().unitname,
            -- unitid = getgenv().unitid,
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
            door = getgenv().door,

            xspawnUnitPos = getgenv().SpawnUnitPos,
            xselectedUnits = getgenv().SelectedUnits,
            autoabilities = getgenv().autoabilities
        }

        local json = HttpService:JSONEncode(xdata)
        writefile(savefilename, json)

    end
    
    --------------------------------------------------
    --------------------------------------------------
    -- Uilib Shits

    local DiscordLib = loadstring(game:HttpGet "https://raw.githubusercontent.com/Forever4D/Lib/main/DiscordLib2.lua")()
    local win = DiscordLib:Window("[😈UPD 7] Anime Adventures 1.5.4".." - "..tostring(identifyexecutor()))
    local serv = win:Server("Anime Adventures", "http://www.roblox.com/asset/?id=6031075938")
            
    if game.PlaceId == 8304191830 then
        local unitselecttab = serv:Channel("Select Units")


        local autofarmtab = serv:Channel("Auto Farm")
        --------------------------------------------------
        --------------- Select Units Tab -----------------
        --------------------------------------------------

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
            DiscordLib:Notification("Equipped Units Are Selected!", "The dropdowns may not show the unit names now, but it will show next time, Dont worry!", "Okay!")

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

        --------------------------------------------------
        ------------------ Auto Farm Tab -----------------
        --------------------------------------------------
        autofarmtab:Label("Don't use Auto Start with Infinity Castle! or Thriller Park")

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

        getgenv().levels = {"nill"}

        autofarmtab:Toggle("Auto Start", getgenv().autostart, function(bool)
            getgenv().autostart = bool
            updatejson()

            if getgenv().autostart and getgenv().AutoFarm then

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
                game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(
                    args))

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
            end

        end)

        autofarmtab:Toggle("Auto Abilities", getgenv().AutoFarm, function(bool)
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

        autofarmtab:Textbox("Select Wave Number for Auto Sell {Press Enter}", tostring(getgenv().sellatwave), false, function(t)
            getgenv().sellatwave = tonumber(t)
            updatejson()
        end)

        getgenv().diff = autofarmtab:Dropdown("Select Difficulty", {"Normal", "Hard"}, getgenv().difficulty, function(diff)
            getgenv().difficulty = diff
            updatejson()
        end)

        local worlddrop = autofarmtab:Dropdown("Select World", {"Plannet Namak", "Shiganshinu District", "Snowy Town","Hidden Sand Village", "Marine's Ford","Ghoul City", "Hollow World", "Ant Kingdom", "Magic Town", "Cursed Academy","Clover Kingdom"}, getgenv().world, function(world)
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
            end
        end)

        getgenv().leveldrop = autofarmtab:Dropdown("Select Level", getgenv().levels, getgenv().level, function(level)
            getgenv().level = level
            updatejson()
        end)


        
        local autoloadtab = serv:Channel("Auto Load Script")
		autoloadtab:Label("This Automatically executes script when you teleport to man.")
        autoloadtab:Label("You don't need to put the script in AutoExec folder!")
        autoloadtab:Toggle("Auto Load Script", getgenv().AutoLoadTP, function(bool)
            queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/ArponAG/Scripts/main/AnimeAdventures.lua'))()")
            getgenv().AutoLoadTP = bool
            updatejson()
        end)

        

		local webhooktab = serv:Channel("Webhook")
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

    else -- When in a match

        local autofarmtab = serv:Channel("Auto Farm")
        local autoloadtab = serv:Channel("Auto Load Script")
        local autoseltab = serv:Channel("Auto Sell")
		local webhooktab = serv:Channel("Webhook")

		autoloadtab:Label("This Automatically executes script when you teleport to man.")
        autoloadtab:Label("You don't need to put the script in AutoExec folder!")
        autoloadtab:Toggle("Auto Load Script", getgenv().AutoLoadTP, function(bool)
            queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/ArponAG/Scripts/main/AnimeAdventures.lua'))()")
            getgenv().AutoLoadTP = bool
            updatejson()
        end)


        game.Players.LocalPlayer.PlayerGui.MessageGui.Enabled = false
        game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error.Volume = 0
        game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error_old.Volume = 0

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

    end

    --------------------------------------------------
    --------------------------------------------------


    if game.PlaceId == 8304191830 then


        --------------------------------------------------
        -------------------- Auto Buy/Sell ---------------
        getgenv().UnitSellTog = false
        getgenv().autosummontickets = false
        getgenv().autosummongem = false
        getgenv().autosummongem10 = false


        local misc = serv:Channel("Auto Buy/Sell")
        misc:Toggle("Auto Summon {Use Ticket 1}", getgenv().autosummontickets, function(bool)
            getgenv().autosummontickets = bool
            while getgenv().autosummontickets do
                task.wait()
                local args = {
                    [1] = "dbz_fighter",
                    [2] = "ticket"
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_random_fighter:InvokeServer(unpack(
                    args))
            end
            updatejson()
        end)

        misc:Toggle("Auto Summon {Buy 1}", getgenv().autosummongem, function(bool)
            getgenv().autosummongem = bool
            while getgenv().autosummongem do
                task.wait()
                local args = {
                    [1] = "dbz_fighter",
                    [2] = "gems"
                }

                game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_random_fighter:InvokeServer(unpack(
                    args))
            end
            updatejson()
        end)

        misc:Toggle("Auto Summon {Buy 10}", getgenv().autosummongem10, function(bool)
            getgenv().autosummongem10 = bool
            while getgenv().autosummongem10 do
                task.wait()
                local args = {
                    [1] = "dbz_fighter",
                    [2] = "gems10"
                }

                game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_random_fighter:InvokeServer(unpack(
                    args))

            end
            updatejson()
        end)

        local utts = misc:Dropdown("Select Rarity", {"Rare", "Epic"}, getgenv().UnitToSell, function(u)
            getgenv().UnitToSell = u
        end)

        misc:Toggle("Auto Sell Units", getgenv().UnitSellTog, function(bool)
            getgenv().UnitSellTog = bool
        end)

        


    end

    local credits = serv:Channel("Credits")
    credits:Label("Forever4D#0001")
    credits:Label("Arpon AG#6612")
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
    local xdata = {
        -- unitname = "name",
        -- unitid = "id",
        autoabilities = false,
        webhook = "",
        sellatwave = 0,
        autosell = false,
        autofarm = false,
        autofarmic = false,
        autostart = false,
        autoupgrade = false,
        difficulty = "Normal",
        world = "nil",
        level = "nil",
        door = "nil",
    
        xspawnUnitPos = {
            Namak = {
                UP1 = {
                    y = 93.3504867553711,
                    x = -2961.75341796875,
                    z = -710.6615600585938
                },
                UP3 = {
                    y = 92.5256118774414,
                    x = -2950.3916015625,
                    z = -697.1671142578125
                },
                UP2 = {
                    y = 93.32953643798828,
                    x = -2940.813720703125,
                    z = -697.09326171875
                },
                UP6 = {
                    y = 92.16944885253906,
                    x = -2946.967041015625,
                    z = -710.122802734375
                },
                UP5 = {
                    y = 92.15478515625,
                    x = -2947.684326171875,
                    z = -699.6248779296875
                },
                UP4 = {
                    y = 92.5256118774414,
                    x = -2950.408935546875,
                    z = -709.8072509765625
                }
            },
            Sand = {
                UP1 = {
                    y = 26.039566040039064,
                    x = -906.1123657226563,
                    z = 311.1694641113281
                },
                UP3 = {
                    y = 25.852432250976564,
                    x = -887.3646850585938,
                    z = 326.2743225097656
                },
                UP2 = {
                    y = 25.852432250976564,
                    x = -886.7578735351563,
                    z = 339.26519775390627
                },
                UP6 = {
                    y = 91.80620574951172,
                    x = -2952.81689453125,
                    z = -707.9673461914063
                },
                UP5 = {
                    y = 91.80620574951172,
                    x = -2952.81689453125,
                    z = -707.9673461914063
                },
                UP4 = {
                    y = 26.039566040039064,
                    x = -887.4508666992188,
                    z = 311.2672424316406
                }
            },
            Cursed = {
                UP1 = {
                    y = 122.78201293945313,
                    x = 361.69732666015627,
                    z = -89.76468658447266
                },
                UP3 = {
                    y = 122.73872375488281,
                    x = 372.2068786621094,
                    z = -62.877601623535159
                },
                UP2 = {
                    y = 122.73872375488281,
                    x = 391.6465759277344,
                    z = -62.87253189086914
                },
                UP6 = {
                    y = 121.5274887084961,
                    x = 399.4963684082031,
                    z = -60.31044387817383
                },
                UP5 = {
                    y = 121.6282958984375,
                    x = 400.8389587402344,
                    z = -64.46269226074219
                },
                UP4 = {
                    y = 122.73872375488281,
                    x = 362.14788818359377,
                    z = -77.3993148803711
                }
            },
            Ghoul = {
                UP1 = {
                    y = 59.1651496887207,
                    x = -2975.21044921875,
                    z = -40.27096176147461
                },
                UP3 = {
                    y = 59.198978424072269,
                    x = -2954.325927734375,
                    z = -38.42814636230469
                },
                UP2 = {
                    y = 59.16920471191406,
                    x = -2950.080810546875,
                    z = -31.475643157958986
                },
                UP6 = {
                    y = 91.80620574951172,
                    x = -2952.81689453125,
                    z = -707.9673461914063
                },
                UP5 = {
                    y = 91.80620574951172,
                    x = -2952.81689453125,
                    z = -707.9673461914063
                },
                UP4 = {
                    y = 58.94588851928711,
                    x = -2964.482666015625,
                    z = -39.597999572753909
                }
            },
            Hollow = {
                UP1 = {
                    y = 133.48593139648438,
                    x = -195.47457885742188,
                    z = -765.364501953125
                },
                UP3 = {
                    y = 134.15370178222657,
                    x = -192.6345672607422,
                    z = -796.1318359375
                },
                UP2 = {
                    y = 134.153564453125,
                    x = -195.1750946044922,
                    z = -812.6539306640625
                },
                UP6 = {
                    y = 91.80620574951172,
                    x = -2952.81689453125,
                    z = -707.9673461914063
                },
                UP5 = {
                    y = 91.80620574951172,
                    x = -2952.81689453125,
                    z = -707.9673461914063
                },
                UP4 = {
                    y = 133.32550048828126,
                    x = -193.80987548828126,
                    z = -780.8096923828125
                }
            },
            Ant = {
                UP1 = {
                    y = 23.63846778869629,
                    x = -160.98289489746095,
                    z = 2955.792236328125
                },
                UP3 = {
                    y = 23.637359619140626,
                    x = -188.2714080810547,
                    z = 2963.796142578125
                },
                UP2 = {
                    y = 23.637359619140626,
                    x = -205.69203186035157,
                    z = 2964.095947265625
                },
                UP6 = {
                    y = 91.80620574951172,
                    x = -2952.81689453125,
                    z = -707.9673461914063
                },
                UP5 = {
                    y = 91.80620574951172,
                    x = -2952.81689453125,
                    z = -707.9673461914063
                },
                UP4 = {
                    y = 23.637359619140626,
                    x = -174.47573852539063,
                    z = 2956.96337890625
                }
            },
            Aot = {
                UP1 = {
                    y = 34.442054748535159,
                    x = -3013.06103515625,
                    z = -681.1722412109375
                },
                UP3 = {
                    y = 34.442054748535159,
                    x = -3024.1181640625,
                    z = -682.2401123046875
                },
                UP2 = {
                    y = 34.387603759765628,
                    x = -3035.071533203125,
                    z = -683.9107055664063
                },
                UP6 = {
                    y = 34.25492477416992,
                    x = -3019.5390625,
                    z = -681.8257446289063
                },
                UP5 = {
                    y = 34.25492477416992,
                    x = -3030.930419921875,
                    z = -683.3449096679688
                },
                UP4 = {
                    y = 34.442054748535159,
                    x = -3013.065185546875,
                    z = -681.4302368164063
                }
            },
            Magic = {
                UP1 = {
                    y = 7.411101341247559,
                    x = -606.7291259765625,
                    z = -815.5218505859375
                },
                UP3 = {
                    y = 7.411093711853027,
                    x = -589.5305786132813,
                    z = -814.8512573242188
                },
                UP2 = {
                    y = 7.413991928100586,
                    x = -578.809814453125,
                    z = -814.5386962890625
                },
                UP6 = {
                    y = 10.61729621887207,
                    x = -584.30224609375,
                    z = -810.1135864257813
                },
                UP5 = {
                    y = 7.413986682891846,
                    x = -597.8843383789063,
                    z = -814.5377807617188
                },
                UP4 = {
                    y = 7.4139862060546879,
                    x = -600.348388671875,
                    z = -814.8621215820313
                }
            },
            Marine = {
                UP1 = {
                    y = 25.811565399169923,
                    x = -2555.87646484375,
                    z = -37.23297119140625
                },
                UP3 = {
                    y = 25.846670150756837,
                    x = -2532.971435546875,
                    z = -31.793981552124025
                },
                UP2 = {
                    y = 25.99869728088379,
                    x = -2523.897216796875,
                    z = -36.326053619384769
                },
                UP6 = {
                    y = 91.80620574951172,
                    x = -2952.81689453125,
                    z = -707.9673461914063
                },
                UP5 = {
                    y = 91.80620574951172,
                    x = -2952.81689453125,
                    z = -707.9673461914063
                },
                UP4 = {
                    y = 25.814455032348634,
                    x = -2545.2783203125,
                    z = -32.41024398803711
                }
            },
            Snowy = {
                UP1 = {
                    y = 34.8720588684082,
                    x = -2884.6103515625,
                    z = -139.17750549316407
                },
                UP3 = {
                    y = 35.055450439453128,
                    x = -2871.251708984375,
                    z = -131.86231994628907
                },
                UP2 = {
                    y = 34.86832046508789,
                    x = -2863.6240234375,
                    z = -120.90508270263672
                },
                UP6 = {
                    y = 34.79566192626953,
                    x = -2853.62548828125,
                    z = -123.30137634277344
                },
                UP5 = {
                    y = 34.79277038574219,
                    x = -2853.63232421875,
                    z = -119.10173034667969
                },
                UP4 = {
                    y = 34.86832046508789,
                    x = -2878.749755859375,
                    z = -138.48580932617188
                }
            },
            thriller_park = {
                UP1 = {
                    y = 113.23728942871094,
                    x =  -224.14295959472656,
                    z = -657.738037109375
                },
                UP3 = {
                    x = -224.78709411621094, 
                    y = 109.37400817871094,
                    z = -640.7178955078125 
                },
                UP2 = {
                    x= -229.42715454101562,
                    y = 109.37401580810547,
                    z = -649.636474609375 
                },
                UP6 = {
                    x = -214.7626190185547, 
                    y = 109.37400817871094,
                    z = -632.3900146484375 
                },
                UP5 = {
                    x = -230.53053283691406,
                    y = 109.37401580810547,
                    z = -657.9769287109375 
                },
                UP4 = {
                    x = -220.0915985107422,
                    y = 109.37400817871094,
                    z = -636.2127075195312 
                }
            },
            black_clover = {
                UP1 = {
                    x = -168.1631622314453,
                    y = 1.2332892417907715,
                    z = -16.510467529296875 
                },
                UP3 = {
                    x = -177.010986328125, 
                    y = 1.2332888841629028,
                    z = -8.177902221679688 
                },
                UP2 = {
                    x = -177.07766723632812, 
                    y = 1.2332888841629028, 
                    z = -15.574569702148438 
                },
                UP6 = {
                    x = -170.49185180664062, 
                    y = 1.233289122581482,
                    z = -19.157012939453125 
                },
                UP5 = {
                    x = -173.08160400390625,
                    y = 1.2332890033721924,
                    z = -11.58660888671875 
                },
                UP4 = {
                    x= -179.41287231445312,
                    y = 1.2332887649536133, 
                    z = -9.063766479492188  
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
end
--------------------------------------------------



------// Auto Farm \\------
coroutine.resume(coroutine.create(function()
    while task.wait() do
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
                end
            end
        end
    end
end))

------// Auto Leave \\------
coroutine.resume(coroutine.create(function()
	local GameFinished = game:GetService("Workspace"):WaitForChild("_DATA"):WaitForChild("GameFinished")
	GameFinished:GetPropertyChangedSignal("Value"):Connect(function()
	print("Changed", GameFinished.Value == true)
	if GameFinished.Value == true then
        repeat task.wait() until  game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Enabled == true
        task.wait()
		pcall(function() webhook() end)
		print("next")
		task.wait(2)
		game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
	end
	end)
end))


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
coroutine.resume(coroutine.create(function()

    local success, err = pcall(function() --///
        while task.wait() do
            if getgenv().autoupgrade then
                if game.PlaceId ~= 8304191830 then

                    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
                    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
                       if v:FindFirstChild("_stats") then
                            if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v["_stats"].xp.Value >= 0 then
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
                            end
                        end
                    end

                end
                
            end
        end
    end)

    if err then
        warn("//////////////////////////////////////////////////")
        error(err)
        setclipboard(err.." Auto Abilities")
        DiscordLib:Notification("Error send it to Arpon AG#6612", err.." Auto Abilities", "Okay!")
        warn("//////////////////////////////////////////////////")
    end

end))


------// Auto Sell \\------
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

--//Auto Abilities--
coroutine.resume(coroutine.create(function()

    local success, err = pcall(function() --///
        while task.wait() do
            if getgenv().autoabilities then

                if game.PlaceId ~= 8304191830 then
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
                end

            end
        end
    end)
     
     if err then
         warn("//////////////////////////////////////////////////")
         warn("//////////////////////////////////////////////////")
         error(err)
         warn("//////////////////////////////////////////////////")
         warn("//////////////////////////////////////////////////")
     end


end))


getgenv().teleporting = true

------// Auto Start \\------
coroutine.resume(coroutine.create(function()
    while task.wait() do
        if getgenv().autostart and getgenv().AutoFarm and getgenv().teleporting then
            if game.PlaceId == 8304191830 then
                for i, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
                    if v.Name == "Owner" and v.Value == nil then
                        getgenv().door = v.Parent.Name
                        getgenv().lobbypath = v.Parent:GetFullName() print(v.Parent:GetFullName())
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
                task.wait()

                for i, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
                    if v.Name == "Owner" then
                       local n = tostring(v.Value)
                        if n == game:GetService("Players").LocalPlayer.Name then
                            print(v.Parent.Teleporting.Value)
                            if v.Parent.Teleporting.Value == true then
                                getgenv().teleporting = false
                            else
                                getgenv().teleporting = true
                            end
                        end
                    end
                end  

            end
        end
    end
end))



------// Auto Start Infiniy Castle && Thriller Park \\------
coroutine.resume(coroutine.create(function()
    while task.wait() do
        if getgenv().AutoFarmIC and getgenv().AutoFarm then
            if game.PlaceId == 8304191830 then

                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(12423.1855, 155.24025, 3198.07593, -1.34111269e-06, -2.02512282e-08, 1, 3.91705386e-13, 1, 2.02512282e-08, -1, 4.18864542e-13, -1.34111269e-06)
                
                getgenv().infinityroom = 0

                for i, v in pairs(game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.InfiniteTowerUI.LevelSelect.InfoFrame.LevelButtons:GetChildren()) do
                    if v.Name == "FloorButton" then
                        if v.clear.Visible == false and v.Locked.Visible == false then
                            local room = string.split(v.Main.text.Text, " ")
                            getgenv().infinityroom = tonumber(room[2])
                        end
                    end
                end
                
                task.wait(1.5)
                local args = {
                    [1] = getgenv().infinityroom
                }
                
                game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower:InvokeServer(unpack(args))
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
end)

print("- Successfully Loaded!!")
---------------------------------------------------------------------
