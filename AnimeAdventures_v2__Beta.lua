--Beta updatefix
local version = "v2.0.0b31"

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
local a = 'V2_Anime_Adventures' -- Paste Name
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

    -- Start of Get Level Data of Map [Added by Craymel02]
    function GLD()
        local list = {}
        for i,v in pairs(game.Workspace._MAP_CONFIG:WaitForChild("GetLevelData"):InvokeServer()) do
            list[i] = v
        end
        return list
    end
    
    if game.PlaceId ~= 8304191830 then
        GLD()
    end
        -- End of Get Level Data of Map
------------------------------
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace") 
local plr = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local mouse = game.Players.LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")
------------------------------
------------item drop result
local v5 = require(game.ReplicatedStorage.src.Loader)
local v19 = v5.load_client_service(script, "ItemInventoryServiceClient")
function get_inventory_items_unique_items()
	return v19["session"]['inventory']['inventory_profile_data']['unique_items']
end
function get_inventory_items()
	return v19["session"]["inventory"]['inventory_profile_data']['normal_items']
end
function get_Units_Owner()
	return v19["session"]["collection"]["collection_profile_data"]['owned_units']
end
local Count_Portal_list = 0
local Table_All_Items_Old_data = {}
local Table_All_Items_New_data = {}
for v2, v3 in pairs(game:GetService("ReplicatedStorage").src.Data.Items:GetDescendants()) do
	if v3:IsA("ModuleScript") then
		for v4, v5 in pairs(require(v3)) do
		    Table_All_Items_Old_data[v4] = {}
			Table_All_Items_Old_data[v4]['Name'] = v5['name']
		    Table_All_Items_Old_data[v4]['Count'] = 0
			Table_All_Items_New_data[v4] = {}
			Table_All_Items_New_data[v4]['Name'] = v5['name']
			Table_All_Items_New_data[v4]['Count'] = 0
		end
	end
end
local Data_Units_All_Games = require(game:GetService("ReplicatedStorage").src.Data.Units)
for i,v in pairs(Data_Units_All_Games) do
    if v.rarity then
        Table_All_Items_Old_data[i] = {}
        Table_All_Items_Old_data[i]['Name'] = v['name']
        Table_All_Items_Old_data[i]['Count'] = 0
        Table_All_Items_Old_data[i]['Count Shiny'] = 0
        Table_All_Items_New_data[i] = {}
        Table_All_Items_New_data[i]['Name'] = v['name']
        Table_All_Items_New_data[i]['Count'] = 0
        Table_All_Items_New_data[i]['Count Shiny'] = 0
    end
end
for i,v in pairs(get_inventory_items()) do
	Table_All_Items_Old_data[i]['Count'] = v
end
for i,v in pairs(get_inventory_items_unique_items()) do
    if string.find(v['item_id'],"portal") or string.find(v['item_id'],"disc") then
        Count_Portal_list = Count_Portal_list + 1
        Table_All_Items_Old_data[v['item_id']]['Count'] = Table_All_Items_Old_data[v['item_id']]['Count'] + 1
    end
end
for i,v in pairs(get_Units_Owner()) do
    Table_All_Items_Old_data[v["unit_id"]]['Count'] = Table_All_Items_Old_data[v["unit_id"]]['Count'] + 1
    if v.shiny then
        Table_All_Items_Old_data[v["unit_id"]]['Count'] = Table_All_Items_Old_data[v["unit_id"]]['Count'] - 1
        Table_All_Items_Old_data[v["unit_id"]]['Count Shiny'] = Table_All_Items_Old_data[v["unit_id"]]['Count Shiny'] + 1
    end
end
----------------Map & ID Map
local function GetCurrentLevelId()
    if game.Workspace._MAP_CONFIG then
        return game:GetService("Workspace")._MAP_CONFIG.GetLevelData:InvokeServer()["id"]
    end
end
local function GetCurrentLevelName()
    if game.Workspace._MAP_CONFIG then
        return game:GetService("Workspace")._MAP_CONFIG.GetLevelData:InvokeServer()["name"]
    end
end
function comma_value(p1)
	local value = p1;
	while true do
		local value2, value3 = string.gsub(value, "^(-?%d+)(%d%d%d)", "%1,%2");
		value = value2;
		if value3 ~= 0 then else
			break;
		end;
	end;
	return value;
end;
----------------endMap & ID Map
getgenv().item = "-"
plr.PlayerGui:FindFirstChild("HatchInfo"):FindFirstChild("holder"):FindFirstChild("info1"):FindFirstChild("UnitName").Text = getgenv().item
function webhook()
    if Settings.WebhookEnabled then
    local url = Settings.WebhookUrl
    print("webhook?")
    if url == "" then
        warn("Webhook Url is empty!")
        return
    end 
    
    local Time = os.date('!*t', OSTime);
	local thumbnails_avatar = HttpService:JSONDecode(game:HttpGet("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. game:GetService("Players").LocalPlayer.UserId .. "&size=150x150&format=Png&isCircular=true", true))
    local exec = tostring(identifyexecutor())
    userlevel = plr.PlayerGui:FindFirstChild("spawn_units"):FindFirstChild("Lives"):FindFirstChild("Main"):FindFirstChild("Desc"):FindFirstChild("Level").Text
    totalgems = plr.PlayerGui:FindFirstChild("spawn_units"):FindFirstChild("Lives"):FindFirstChild("Frame"):FindFirstChild("Resource"):FindFirstChild("Gem"):FindFirstChild("Level").Text
    
    ResultHolder = plr.PlayerGui:FindFirstChild("ResultsUI"):FindFirstChild("Holder")
    if game.PlaceId ~= 8304191830 then
    levelname = game:GetService("Workspace"):FindFirstChild("_MAP_CONFIG"):FindFirstChild("GetLevelData"):InvokeServer()["name"]
    result = ResultHolder.Title.Text else levelname, result = "nil","nil" end
    if result == "VICTORY" then result = "VICTORY" end
    if result == "DEFEAT" then result = "DEFEAT" end
    
    _map = game:GetService("Workspace")["_BASES"].player.base["fake_unit"]:WaitForChild("HumanoidRootPart")
    GetLevelData = game.workspace._MAP_CONFIG:WaitForChild("GetLevelData"):InvokeServer()
    world = GetLevelData.world or GetLevelData.name
    mapname = game:GetService("Workspace")._MAP_CONFIG.GetLevelData:InvokeServer()["name"]
    cwaves = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.WavesCompleted.Text
	ctime = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.Timer.Text
    waves = cwaves:split(": ")
    if waves ~= nil and waves[2] == "999" then waves[2] = "Use [Auto Leave at Wave] or [Test Webhook]" end	
	ttime = ctime:split(": ")
    if waves ~= nil and ttime[2] == "22:55" then ttime[2] = "Use [Auto Leave at Wave] or [Test Webhook]" end	
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
      
    local TextDropLabel = ""
	local CountAmount = 1
    for i,v in pairs(get_inventory_items()) do
       Table_All_Items_New_data[i]['Count'] = v
    end
    for i,v in pairs(get_inventory_items_unique_items()) do
        if string.find(v['item_id'],"portal") or string.find(v['item_id'],"disc") then
            Table_All_Items_New_data[v['item_id']]['Count'] = Table_All_Items_New_data[v['item_id']]['Count'] + 1
        end
    end
    for i,v in pairs(get_Units_Owner()) do
        Table_All_Items_New_data[v["unit_id"]]['Count'] = Table_All_Items_New_data[v["unit_id"]]['Count'] + 1
        if v.shiny then
            Table_All_Items_New_data[v["unit_id"]]['Count'] = Table_All_Items_New_data[v["unit_id"]]['Count'] - 1
           Table_All_Items_New_data[v["unit_id"]]['Count Shiny'] = Table_All_Items_New_data[v["unit_id"]]['Count Shiny'] + 1
        end
    end
	for i,v in pairs(Table_All_Items_New_data) do
		if v['Count'] > 0 and (v['Count'] - Table_All_Items_Old_data[i]['Count']) > 0 then
			if v['Count Shiny'] and v['Count'] then
				if v['Count'] > 0 or v['Count Shiny'] > 0 then
					if v['Count'] > 0 and (v['Count'] - Table_All_Items_Old_data[i]['Count']) > 0 then
						TextDropLabel = TextDropLabel .. tostring(CountAmount) .. ". " .. tostring(v['Name']) .. " : x" .. tostring(v['Count'] - Table_All_Items_Old_data[i]['Count'])
						if v['Count Shiny'] > 0 and (v['Count Shiny'] - Table_All_Items_Old_data[i]['Count Shiny']) > 0 then
							TextDropLabel = TextDropLabel .. " | " .. tostring(v['Name']) .. " (Shiny) : x" .. tostring(v['Count Shiny'] - Table_All_Items_Old_data[i]['Count Shiny']) .. "\n"
                            CountAmount = CountAmount + 1
                        else
                            TextDropLabel = TextDropLabel .. "\n"
                            CountAmount = CountAmount + 1
						end
					end
				end
			end
		elseif v['Count Shiny'] and v['Count Shiny'] > 0 and (v['Count Shiny'] - Table_All_Items_Old_data[i]['Count Shiny']) > 0 then
			TextDropLabel = TextDropLabel .. tostring(CountAmount) .. ". " .. tostring(v['Name']) .. " (Shiny) : x" .. tostring(v['Count Shiny'] - Table_All_Items_Old_data[i]['Count Shiny']) .. "\n"
			CountAmount = CountAmount + 1
		end
	end
    for i,v in pairs(Table_All_Items_New_data) do
		if v['Count'] > 0 and (v['Count'] - Table_All_Items_Old_data[i]['Count']) > 0 then
            if v['Count Shiny'] and v['Count'] then
			elseif string.find(i,"portal") or string.find(i,"disc") then
				Count_Portal_list = Count_Portal_list + 1
			if string.gsub(i, "%D", "") == "" then
					TextDropLabel = TextDropLabel .. tostring(CountAmount) .. ". " .. tostring(v['Name']) .. " : x" .. tostring(v['Count'] - Table_All_Items_Old_data[i]['Count']) .. "\n"
			else
					TextDropLabel = TextDropLabel .. tostring(CountAmount) .. ". " .. tostring(v['Name']) .. " Tier " .. tostring(string.gsub(i, "%D", "")) .. " : x" .. tostring(v['Count'] - Table_All_Items_Old_data[i]['Count']) .. "\n"
                end
				CountAmount = CountAmount + 1
			else
				TextDropLabel = TextDropLabel .. tostring(CountAmount) .. ". " .. tostring(v['Name']) .. " : x" .. tostring(v['Count'] - Table_All_Items_Old_data[i]['Count']) .. "\n"
                CountAmount = CountAmount + 1
		    end
		end
	end
	if TextDropLabel == "" then
		TextDropLabel = "Not Have Items Drops"
	end
    
        local data = {
            ["content"] = "",
                ["username"] = "Anime Adventures | ArponAG V2",
                ["avatar_url"] = "https://tr.rbxcdn.com/2a167faf9e626e51c939309a70fca28e/150/150/Image/Png",
                ["embeds"] = {
                    {
                        ["author"] = {
                            ["name"] = "ArponAG V2 | Results ✔️",
                            ["icon_url"] = "https://cdn.discordapp.com/emojis/997123585476927558.webp?size=96&quality=lossless"
                        },
                        ["thumbnail"] = {
                            ['url'] = thumbnails_avatar.data[1].imageUrl,
                        },
                        ["description"] = " Player Name : 🐱 ||**"..game:GetService("Players").LocalPlayer.Name.."**|| 🐱\nExecutors  : 🎮 "..exec.." 🎮 ",
                        ["color"] = 110335,
                        ["timestamp"] = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec),
                        ["fields"] = {
                            {
                                ["name"] ="Current Level ✨ & Portals 🌀 & Gems 💎 & Gold 💰",
                                ["value"] = "```ini\n"..tostring(game.Players.LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text)..  " ✨\nCurrent Portals : ".. tostring(Count_Portal_list) .." 🌀\nCurrent Gems : "..tostring(comma_value(game.Players.LocalPlayer._stats.gem_amount.Value)).. " 💎\nCurrent Gold : "  ..tostring(comma_value(game.Players.LocalPlayer._stats.gold_amount.Value))..  " 💰```",
                            },
                            {
                                ["name"] ="Results :",
                                ["value"] = " ```ini\nWorld : "..mapname.. " 🌏\nMap : "..world.. " 🗺️\nResults : "..result.. " ⚔️\nWave End : " ..tostring(waves[2]).." 🌊\nTime : " ..tostring(ttime[2]).." ⌛```",
                                ["inline"] = true
                            },
                            {
                                ["name"] ="Rewards :",
                                ["value"] = "```ini\n" ..comma_value(gold).." Gold 💰\n"..comma_value(gems).." Gems 💎\n"..comma_value(xp[1]).." XP 🧪\n"..trophy.." Trophy 🏆```",
                            },
                            {
                                ["name"] ="Items Drop :",
                                ["value"] = "```ini\n" .. TextDropLabel .. "```",
                                ["inline"] = false 
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
end

function BabyWebhook()
    if Settings.BabyWebhookEnabled then
	local url = Settings.BabyWebhookUrl
    print("webhook baby?")
    if url == "" then
        warn("BabyWebhook Url is empty!")
        return
    end 
		
        local Time = os.date('!*t', OSTime);
	    local thumbnails_avatar = HttpService:JSONDecode(game:HttpGet("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. game:GetService("Players").LocalPlayer.UserId .. "&size=150x150&format=Png&isCircular=true", true))
        local exec = tostring(identifyexecutor())
        --BTP lv.
        btplv = game:GetService("Players").LocalPlayer.PlayerGui.BattlePass.Main.Level.V.Text
        --next ammo level
        nextlvbtp = game:GetService("Players").LocalPlayer.PlayerGui.BattlePass.Main.FurthestRoom.V.Text
       --room
        rankroom = game:GetService("Players").LocalPlayer.PlayerGui.InfinityCastleRankingUI.Main.Main.Scroll.YourRanking.FurthestRoom.V.V.Text
        if rankroom == "10" then rankroom = "Inf Castle Load Not Yet" end
        --Rank title 
        ranktitle = game:GetService("Players").LocalPlayer.PlayerGui.InfinityCastleRankingUI.Main.Main.Scroll.YourRanking.RankTitle.V.V.Text
        if ranktitle == "Grandmaster" then ranktitle = "Inf Castle Load Not Yet" end
        --rank %
        rankper = game:GetService("Players").LocalPlayer.PlayerGui.InfinityCastleRankingUI.Main.Main.Scroll.YourRanking.Ranking.V.V.Text
        if rankper == "10%" then rankper = "Inf Castle Load Not Yet" end
        --Current Rank
        crt = game:GetService("Players").LocalPlayer.PlayerGui.TournamentRankingUI.Leaderboard.Ranking.Wrapper.CurrentRank.Ranking.V.Text
        if crt == "10%" then crt = "Tournament Load Not Yet" end
        --Current Prize%
        cpp = game:GetService("Players").LocalPlayer.PlayerGui.TournamentRankingUI.Leaderboard.Ranking.Wrapper.CurrentPrize.V.Text
        if cpp == "10%" then cpp = "Tournament Load Not Yet" end
        --Current Prize
        cp = game:GetService("Players").LocalPlayer.PlayerGui.TournamentRankingUI.Leaderboard.Ranking.Wrapper.CurrentPrize.Prize.Text
        if cp == "0% ~ 49.99%" then cp = "Tournament Load Not Yet" end
        --Current Place#
        cpr = game:GetService("Players").LocalPlayer.PlayerGui.TournamentRankingUI.Leaderboard.Main.Wrapper.Container.YourRow.Place.Text
        if cpr == "#123456" then cpr = "Tournament Load Not Yet" end
        --Dmg or kill 
        cdk = game:GetService("Players").LocalPlayer.PlayerGui.TournamentRankingUI.Leaderboard.Main.Wrapper.Container.YourRow.Amount.Text
        if cdk == "123456789000000" then cdk = "Tournament Load Not Yet" end
        --Bracket
        cubk = game:GetService("Players").LocalPlayer.PlayerGui.TournamentRankingUI.LevelSelect.InfoFrame.ScoreInfo.Bracket.V.Text
        if cubk == "N" then cubk = "Tournament Load Not Yet" end

		local data = {
            ["content"] = "",
                ["username"] = "Anime Adventures V2",
                ["avatar_url"] = "https://tr.rbxcdn.com/46f3a2a4f78c2a8f69e5e423f5b29ddc/150/150/Image/Png",
                ["embeds"] = {
                    {
                        ["author"] = {
                            ["name"] = " Current BTP & Inf Castle & Tournament Results ✔️",
                            ["icon_url"] = "https://cdn.discordapp.com/emojis/997123585476927558.webp?size=96&quality=lossless"
                        },
                        ["thumbnail"] = {
                            ['url'] = thumbnails_avatar.data[1].imageUrl,
                        },
                        ["description"] = " Player Name : 🐱 ||**"..game:GetService("Players").LocalPlayer.Name.."**|| 🐱",
                        ["color"] = 110335,
                        ["timestamp"] = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec),
                        ["fields"] = {
                            {
                                ["name"] ="Current Battle Pass Results 🔋 ",
                                ["value"] = "```ini\nCurrent BTP Lv. : "..btplv.."  🔋\nNEED TO NEXT : "..nextlvbtp.. "  🔋```",
                            },
                            {
                                ["name"] ="Current Tournament Results 🏆",
                                ["value"] = "```ini\nYour Bracket: : "..cubk.."  🏆\nCurrent Rank : ["..cpr.." - "..crt.."]  🏆\nDMG or Kill : "..cdk.. "  🏆\nCurrent Prize : "..cpp.. "  🏆\nReward Prize : "  ..cp..  "  🏆```",
                            },
                            {
                                ["name"] ="Current Infinity Castle Results  🚪",
                                ["value"] = "```ini\nCurrent Room : "..rankroom.."  🚪\nCurrent Rank : "..ranktitle.. "  📊\nCurrent Percent : "  ..rankper..  "  🏅```",
                            }
                        }
                    }
                }
            }
        
    
            local xd = game:GetService("HttpService"):JSONEncode(data)
    
            local headers = {["content-type"] = "application/json"}
            request = http_request or request or HttpPost or syn.request or http.request
            local sex = {Url = url, Body = xd, Method = "POST", Headers = headers}
            warn("Sending infcastle webhook notification...")
            request(sex)
        end
end

function SnipeShopNew()
    if Settings.snipeWebhookEnabled then
pcall(function() 
    SpecialSummonSniperWebhook()
    StandardSummonSniperWebhook()
    ShopSniperWebhook()
end)
end
end
--special
function SpecialSummonSniperWebhook()
    if Settings.snipeWebhookEnabled then
	local url = Settings.SnipeWebhookUrl
    print("webhook Special banner?")
    if url == "" then
        warn("SnipeWebhook Url is empty!")
        return
    end 
		
        local Time = os.date('!*t', OSTime);

	    local thumbnails_avatar = HttpService:JSONDecode(game:HttpGet("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. game:GetService("Players").LocalPlayer.UserId .. "&size=150x150&format=Png&isCircular=true", true))

        local exec = tostring(identifyexecutor())

        special_banner = game:GetService("Players").LocalPlayer.PlayerGui.HatchGuiNew.BannerFrames.EventClover.Main
        units = {
            special_banner["Featured_One"],
            special_banner["Featured_Two"],
            special_banner["Featured_Three"]
        }

        unitNamesForJson = {
            special_banner["Featured_One"].name.Text,
            special_banner["Featured_Two"].name.Text,
            special_banner["Featured_Three"].name.Text
        }

		local data = {
            ["content"] = "",
                ["username"] = "Anime Adventures V2",
                ["avatar_url"] = "https://tr.rbxcdn.com/46f3a2a4f78c2a8f69e5e423f5b29ddc/150/150/Image/Png",
                ["embeds"] = {
                    {
                        ["author"] = {
                            ["name"] = " Special Banner ",
                            ["icon_url"] = "https://cdn.discordapp.com/emojis/997123585476927558.webp?size=96&quality=lossless"
                        },
                        ["thumbnail"] = {
                            ['url'] = thumbnails_avatar.data[1].imageUrl,
                        },
                        ["description"] = " Player Name : 🐱 ||**"..game:GetService("Players").LocalPlayer.Name.."**|| 🐱",
                        ["color"] = 110335,
                        ["timestamp"] = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec),
                        ["fields"] = {
                            {
                                ["name"] = "```" .. units[1].name.Text .. "```",
                                ["value"] = "```(" .. units[1].Rarity.Text .. ") [Featured]```",
                                ["inline"] = true
                            },
                            {
                                ["name"] = "```" .. units[2].name.Text .. "```",
                                ["value"] = "```(" .. units[2].Rarity.Text .. ")```",
                                ["inline"] = true
                            },
                            {
                                ["name"] = "```" .. units[3].name.Text .. "```",
                                ["value"] = "```(" .. units[3].Rarity.Text .. ")```",
                                ["inline"] = true
                            }
                        }
                    }
                }
            }
        
    
            local xd = game:GetService("HttpService"):JSONEncode(data)
    
            local headers = {["content-type"] = "application/json"}
            request = http_request or request or HttpPost or syn.request or http.request
            local sex = {Url = url, Body = xd, Method = "POST", Headers = headers}
            warn("Sending special banner webhook notification...")
            request(sex)
        end
end

--Standar
function StandardSummonSniperWebhook()
    if Settings.snipeWebhookEnabled then
	local url = Settings.SnipeWebhookUrl
    print("webhook Standard Banner?")
    if url == "" then
        warn("Webhook Url is empty!")
        return
    end 
		
        local Time = os.date('!*t', OSTime);

	    local thumbnails_avatar = HttpService:JSONDecode(game:HttpGet("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. game:GetService("Players").LocalPlayer.UserId .. "&size=150x150&format=Png&isCircular=true", true))

        local exec = tostring(identifyexecutor())

        units = {
            game:GetService("Players").LocalPlayer.PlayerGui.HatchGuiNew.BannerFrames.Standard.Main.Scroll["1"].Main,
            game:GetService("Players").LocalPlayer.PlayerGui.HatchGuiNew.BannerFrames.Standard.Main.Scroll["2"].Main,
            game:GetService("Players").LocalPlayer.PlayerGui.HatchGuiNew.BannerFrames.Standard.Main.Scroll["3"].Main,
            game:GetService("Players").LocalPlayer.PlayerGui.HatchGuiNew.BannerFrames.Standard.Main.Scroll["4"].Main,
            game:GetService("Players").LocalPlayer.PlayerGui.HatchGuiNew.BannerFrames.Standard.Main.Scroll["5"].Main,
            game:GetService("Players").LocalPlayer.PlayerGui.HatchGuiNew.BannerFrames.Standard.Main.Scroll["6"].Main
        }

        
            U1 = units[1].petimage.WorldModel:GetChildren()[1].Name
            U2 = units[2].petimage.WorldModel:GetChildren()[1].Name
            U3 = units[3].petimage.WorldModel:GetChildren()[1].Name
            U4 = units[4].petimage.WorldModel:GetChildren()[1].Name
            U5 = units[5].petimage.WorldModel:GetChildren()[1].Name
            U6 = units[6].petimage.WorldModel:GetChildren()[1].Name
        

		local data = {
            ["content"] = "",
                ["username"] = "Anime Adventures V2",
                ["avatar_url"] = "https://tr.rbxcdn.com/46f3a2a4f78c2a8f69e5e423f5b29ddc/150/150/Image/Png",
                ["embeds"] = {
                    {
                        ["author"] = {
                            ["name"] = " Standard Banner ",
                            ["icon_url"] = "https://cdn.discordapp.com/emojis/997123585476927558.webp?size=96&quality=lossless"
                        },
                        ["thumbnail"] = {
                            ['url'] = thumbnails_avatar.data[1].imageUrl,
                        },
                        ["description"] = " Player Name : 🐱 ||**"..game:GetService("Players").LocalPlayer.Name.."**|| 🐱",
                        ["color"] = 110335,
                        ["timestamp"] = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec),
                        ["fields"] = {

                        }
				    }
			    }
		    }

        for i, unit in pairs(units) do
            unit_stats = {
                ["name"] = "```" .. unit.petimage.WorldModel:GetChildren()[1].Name .."```",
                ["value"] = "```(" ..unit.Rarity.Text ..")```",
                ["inline"] = true
            }
            table.insert(data["embeds"][1]["fields"], unit_stats)
        end
        
    
            local xd = game:GetService("HttpService"):JSONEncode(data)
    
            local headers = {["content-type"] = "application/json"}
            request = http_request or request or HttpPost or syn.request or http.request
            local sex = {Url = url, Body = xd, Method = "POST", Headers = headers}
            warn("Sending Standard banner webhook notification...")
            request(sex)
        end
    end

--Bulma's Shop webhook

function ShopSniperWebhook()
    if Settings.snipeWebhookEnabled then
        local url = Settings.SnipeWebhookUrl
        print("webhook Bulma's webhook?")
        if url == "" then
            warn("Webhook Url is empty!")
            return
        end 
		print(game:GetService("ReplicatedStorage").src.client.Services.TravellingMerchantServiceClient)

        local Time = os.date('!*t', OSTime);

	    local thumbnails_avatar = HttpService:JSONDecode(game:HttpGet("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. game:GetService("Players").LocalPlayer.UserId .. "&size=150x150&format=Png&isCircular=true", true))

        local exec = tostring(identifyexecutor())

        shop_items = require(game:GetService("ReplicatedStorage").src.client.Services["TravellingMerchantServiceClient"]).SELLING_ITEMS
        shop_item_ids = {}
        
        print("exechere9")

		local data = {
            ["content"] = "",
                ["username"] = "Anime Adventures V2",
                ["avatar_url"] = "https://tr.rbxcdn.com/46f3a2a4f78c2a8f69e5e423f5b29ddc/150/150/Image/Png",
                ["embeds"] = {
                    {
                        ["author"] = {
                            ["name"] = " Bulma's Shop ",
                            ["icon_url"] = "https://cdn.discordapp.com/emojis/997123585476927558.webp?size=96&quality=lossless"
                        },
                        ["thumbnail"] = {
                            ['url'] = thumbnails_avatar.data[1].imageUrl,
                        },
                        ["description"] = " Player Name : 🐱 ||**"..game:GetService("Players").LocalPlayer.Name.."**|| 🐱",
                        ["color"] = 110335,
                        ["timestamp"] = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec),
                        ["fields"] = {

                        }
				    }
			    }
		    }

		
		print("exechere4")
		
		for i, item in pairs(shop_items) do
            table.insert(shop_item_ids, item["id"])
            if item["gem_cost"] then
                table.insert(data["embeds"][1]["fields"], {
                    ["name"] = "```" .. item["id"].."```",
                    ["value"] = "```" .. item["gem_cost"] .. " 💎```",
                    ["inline"] = true
                })
            else
                table.insert(data["embeds"][1]["fields"], {
                    ["name"] = "```" .. item["id"].."```",
                    ["value"] = "```" .. item["gold_cost"] .. " 💰```",
                    ["inline"] = true
                })
            end
		end
    
        --print(dump(data["embeds"][1]["fields"]))

        if not game:GetService("Workspace")["travelling_merchant"]["is_open"].Value then
            table.insert(data["embeds"][1]["fields"], {
                    ["name"] = "SHOP CLOSED",
                    ["value"] = "SHOP CLOSED",
                    ["inline"] = true
                })
        end
        print("exec1")

		local xd = game:GetService("HttpService"):JSONEncode(data)
    
            local headers = {["content-type"] = "application/json"}
            request = http_request or request or HttpPost or syn.request or http.request
            local sex = {Url = url, Body = xd, Method = "POST", Headers = headers}
            warn("Sending Snipe Bulma's Shop webhook notification...")
            request(sex)
        end
    end
------------------------------\
if game.CoreGui:FindFirstChild("FinityUI") then
    game.CoreGui["FinityUI"]:Destroy()
end
local dir = "Anime_Adventures/"..game.Players.LocalPlayer.Name
local Uilib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ArponAG/Scripts/main/finitylib"))()
local exec = tostring(identifyexecutor())
--updatefix fixmap
local Window = Uilib.new(true, "[UPD 12.5.0] Anime Adventures "..version.." - "..exec)
Window.ChangeToggleKey(Enum.KeyCode.RightControl)
local Home = Window:Category(" 📋 Home")
local Developers = Home:Sector("Anime Adventures")
local asdasd = Home:Sector(" ")
local UIUPDT = Home:Sector("UI UPDATE (February 20th)")
local Farm = Window:Category(" 🏹 Auto Farm")
local SelectUnits = Farm:Sector("Units Selection")
local SelectWorld = Farm:Sector("World Selection")
local UnitPosition = Farm:Sector("Select Unit Position")
local MoreFarmConfig = Farm:Sector("More Farming Config")
local DeleteConfig2 = Farm:Sector("")
local DeleteConfig = Farm:Sector("More Function Config")
local AutoFarmConfig = Farm:Sector("Auto Farm Config")
local ChallengeConfig = Farm:Sector("Challenge Config")

local UC = Window:Category(" 👥 Unit Config")
local NDY = UC:Sector("Beta Unit Config ")
local NDY2 = UC:Sector(" Reset Unit Config ")
local emptyxx = UC:Sector(" ")
local emptyxx2 = UC:Sector(" ")
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
--local OtherSec = Misc:Sector("Other Options")

local LG = Window:Category("🛠️ OTHER [BETA]")
local LG1 = LG:Sector("Beta LAGGY Config ")
local OtherSec = LG:Sector("Other Options")
local OtherSec2 = LG:Sector("")
local reFarmConfig = LG:Sector("🤖 Reset Farm Config 🤖")


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
    end)
end
----------------------------------------------
------------------ World Section -------------updatefix
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
--fixmap
    getgenv().updateworld = function()
        selectworld:ClearDrop() local storylist;
        if Settings.WorldCategory == "Story Worlds" then
            storylist = {"Planet Namak", "Shiganshinu District", "Snowy Town","Hidden Sand Village", "Marine's Ford",
            "Ghoul City", "Hollow World", "Ant Kingdom", "Magic Town", "Cursed Academy","Clover Kingdom","Cape Canaveral", "Alien Spaceship","Fabled Kingdom",
            "Hero City"}
        elseif Settings.WorldCategory == "Legend Stages" then
            storylist = {"Clover Kingdom (Elf Invasion)", "Hollow Invasion","Cape Canaveral (Legend)", "Fabled Kingdom (Legend)", "Hero City (Midnight)"}
        elseif Settings.WorldCategory == "Raid Worlds" then
            storylist = {"Storm Hideout","West City", "Infinity Train", "Shiganshinu District - Raid","Hiddel Sand Village - Raid", "Freezo's Invasion", "Entertainment District"}
        elseif Settings.WorldCategory == "Portals" then
            storylist = {"Alien Portals","Zeldris Portals", "Demon Portals"}
        elseif Settings.WorldCategory == "Dungeon" then 
            storylist = {"Cursed Womb","Crused Parade"}   
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
        elseif level == "Hero City" then
            levellist = {"mha_infinite","mha_level_1","mha_level_2","mha_level_3","mha_level_4","mha_level_5","mha_level_6",}
        --///Legend Stages\\\---
        elseif level == "Clover Kingdom (Elf Invasion)" then
            levellist = {"clover_legend_1","clover_legend_2","clover_legend_3"}
        elseif level == "Hollow Invasion" then
            levellist = {"bleach_legend_1","bleach_legend_2","bleach_legend_3","bleach_legend_4","bleach_legend_5","bleach_legend_6"}
        elseif level == "Cape Canaveral (Legend)" then
            levellist = {"jojo_legend_1","jojo_legend_2","jojo_legend_3"}
        elseif level == "Fabled Kingdom (Legend)" then
            levellist = {"7ds_legend_1","7ds_legend_2","7ds_legend_3"}
        elseif level == "Hero City (Midnight)" then
            levellist = {"mha_legend_1","mha_legend_2","mha_legend_3","mha_legend_4","mha_legend_5","mha_legend_6"}
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
        elseif level == "Freezo's Invasion" then
            levellist = {"west_city_frieza_level_1","west_city_frieza_level_2","west_city_frieza_level_3","west_city_frieza_level_4","west_city_frieza_level_5"}
        elseif level == "Entertainment District" then
            levellist = {"entertainment_district_level_1","entertainment_district_level_2","entertainment_district_level_3","entertainment_district_level_4","entertainment_district_level_5"}
        --///Portals\\\---
        elseif level == "Alien Portals" then
            levellist = {"portal_boros_g"}
        elseif level == "Demon Portals" then
            levellist = {"april_portal_item"}
        elseif level == "Zeldris Portals" then
            levellist = {"portal_zeldris"}
            ---///Dungeon\\\---    updatefix
        elseif level == "Cursed Womb" then
            levellist = {"jjk_finger"} 
        elseif level == "Crused Parade" then
            levellist = {"jjk_raid"} 
        end
        for i = 1, #levellist do
            selectlevel:AddOption(levellist[i])
        end
    end
    --fixmap
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
        or level == "jojo_infinite" or level == "opm_infinite" or level == "7ds_infinite"  or level == "mha_infinite"  or cata == "Legend Stages" or cata == "Raid Worlds" then
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
    AutoFarmConfig:Cheat("Checkbox","🌾 Auto Start  ", function(bool)
        print(bool)
        Settings.autostart = bool
        saveSettings()
    end,{enabled = Settings.autostart })
    AutoFarmConfig:Cheat("Checkbox","👨‍🌾 Auto Place unit  ", function(bool)
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
    AutoFarmConfig:Cheat("Checkbox","⭐️ Sell Units At Wave  ", function(bool)
        print(bool)
        Settings.AutoSell = bool
        saveSettings()
    end,{enabled = Settings.AutoSell})
    AutoFarmConfig:Cheat("Checkbox","⭐️ Leave At Wave  ", function(bool)
        print(bool)
        Settings.autoQuit = bool
        saveSettings()
    end,{enabled = Settings.autoQuit})
    AutoFarmConfig:Cheat("Textbox", "Sell or Leave at Wave", function(Value)
        Value = tonumber(Value)
        Settings.AutoSellWave = Value
        saveSettings()
    end, {placeholder = Settings.AutoSellWave})
end
----------------------------------------------
--------------- More Farm Config ------------- 
----------------------------------------------
local function MoreFarmSec()
    MoreFarmConfig:Cheat("Checkbox","🏯 Auto Next Level inf castle  ", function(bool)
        print(bool)
        Settings.AutoContinue = bool
        saveSettings()
    end,{enabled = Settings.AutoContinue })
    MoreFarmConfig:Cheat("Checkbox","🏰️ Auto Infinity Castle  ", function(bool)
        print(bool)
        Settings.AutoInfinityCastle = bool
        saveSettings()
    end,{enabled = Settings.AutoInfinityCastle})
end

-----------------------------------------------
--resetautofarm config
--resetall
function refarmcon()
    print("reset AutoFarm & find Picoro config ?")

    --findPicoro
    if Settings.picoHOP then
        Settings.picoHOP = false end
   --Start
    if Settings.autostart then
        Settings.autostart = false end
    --Place unit
    if Settings.AutoFarm then
        Settings.AutoFarm = false end
    --Replay
    if Settings.AutoReplay then
        Settings.AutoReplay = false end
    --Next Story
    if Settings.AutoNext then
        Settings.AutoNext = false end
    --Leave
    if Settings.AutoLeave then
        Settings.AutoLeave = false end
    --Abilities
    if Settings.AutoAbilities then
        Settings.AutoAbilities = false end
    --Upgrade
    if Settings.AutoUpgrade then
        Settings.AutoUpgrade = false end
    --AutoSell
    if Settings.AutoSell then
        Settings.AutoSell = false end
    --autoQuitWave
    if Settings.autoQuit then
        Settings.autoQuit = false end
    --AutoSellWave
    if Settings.AutoSellWave then
        Settings.AutoSellWave = 0 end
    --Inf Castle--
    --Next Level inf cas
    if Settings.AutoContinue then
        Settings.AutoContinue = false end
    --Auto Infinity Castle 
    if Settings.AutoInfinityCastle then
        Settings.AutoInfinityCastle = false end
        saveSettings()
        autoload2()
  
end

if Settings.refarmc then
    refarmcon()
    autoload2()
end

--setAutoFarmStory
function setfarm1()
    print("Set AutoFarm Story ?")

   --Start
    if Settings.autostart then
        Settings.autostart = true end
    --Place unit
    if Settings.AutoFarm then
        Settings.AutoFarm = true end
    --Replay
    if Settings.AutoReplay then
        Settings.AutoReplay = false end
    --Next Story
    if Settings.AutoNext then
        Settings.AutoNext = false end
    --Leave
    if Settings.AutoLeave then
        Settings.AutoLeave = true end
    --Abilities
    if Settings.AutoAbilities then
        Settings.AutoAbilities = true end
    --Upgrade
    if Settings.AutoUpgrade then
        Settings.AutoUpgrade = true end
    --AutoSell
    if Settings.AutoSell then
        Settings.AutoSell = true end
    --autoQuitWave
    if Settings.autoQuit then
        Settings.autoQuit = false end
    --AutoSellWave
    if Settings.AutoSellWave then
        Settings.AutoSellWave = 50 end
    --Inf Castle--
    --Next Level inf cas
    if Settings.AutoContinue then
        Settings.AutoContinue = false end
    --Auto Infinity Castle 
    if Settings.AutoInfinityCastle then
        Settings.AutoInfinityCastle = false end
        saveSettings()
        autoload2()
  
end

if Settings.setfarm1 then
    setfarm1()
    autoload2()
end

--setAutoFarmStorynReplay
function setfarm2()
    print("Set AutoFarm Story & Replay ?")

   --Start
    if Settings.autostart then
        Settings.autostart = true end
    --Place unit
    if Settings.AutoFarm then
        Settings.AutoFarm = true end
    --Replay
    if Settings.AutoReplay then
        Settings.AutoReplay = true end
    --Next Story
    if Settings.AutoNext then
        Settings.AutoNext = false end
    --Leave
    if Settings.AutoLeave then
        Settings.AutoLeave = true end
    --Abilities
    if Settings.AutoAbilities then
        Settings.AutoAbilities = true end
    --Upgrade
    if Settings.AutoUpgrade then
        Settings.AutoUpgrade = true end
    --AutoSell
    if Settings.AutoSell then
        Settings.AutoSell = true end
    --autoQuitWave
    if Settings.autoQuit then
        Settings.autoQuit = false end
    --AutoSellWave
    if Settings.AutoSellWave then
        Settings.AutoSellWave = 50 end
    --Inf Castle--
    --Next Level inf cas
    if Settings.AutoContinue then
        Settings.AutoContinue = false end
    --Auto Infinity Castle 
    if Settings.AutoInfinityCastle then
        Settings.AutoInfinityCastle = false end
        saveSettings()
        autoload2()
  
end

if Settings.setfarm2 then
    setfarm2()
    autoload2()
end

--setAutoInfCastle
function setfarmIC()
    print("Set AutoFarm Inf Castle ?")

   --Start
    if Settings.autostart then
        Settings.autostart = false end
    --Place unit
    if Settings.AutoFarm then
        Settings.AutoFarm = true end
    --Replay
    if Settings.AutoReplay then
        Settings.AutoReplay = false end
    --Next Story
    if Settings.AutoNext then
        Settings.AutoNext = false end
    --Leave
    if Settings.AutoLeave then
        Settings.AutoLeave = false end
    --Abilities
    if Settings.AutoAbilities then
        Settings.AutoAbilities = true end
    --Upgrade
    if Settings.AutoUpgrade then
        Settings.AutoUpgrade = true end
    --AutoSell
    if Settings.AutoSell then
        Settings.AutoSell = true end
    --autoQuitWave
    if Settings.autoQuit then
        Settings.autoQuit = false end
    --AutoSellWave
    if Settings.AutoSellWave then
        Settings.AutoSellWave = 50 end
    --Inf Castle--
    --Next Level inf cas
    if Settings.AutoContinue then
        Settings.AutoContinue = true end
    --Auto Infinity Castle 
    if Settings.AutoInfinityCastle then
        Settings.AutoInfinityCastle = true end
        saveSettings()
        autoload2()
  
end

if Settings.setfarmIC then
    setfarmIC()
    autoload2()
end


-----------------------------------------------


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
    Developers:Cheat("Label","📝 Scripted by: Arpon AG#6612 & Forever4D#0001 & HOLYSHz#3819 ")    
    Developers:Cheat("Label","📝 Also thanks to Trapstar#7845, bytenode#9646 for the help!")    
    Developers:Cheat("Label","📐 UI By: detourious @ v3rmillion.net")    
    Developers:Cheat("Label","🔧 To toggle the script press \"RightControl\"")   
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
    local GetLevelData = game.workspace._MAP_CONFIG:WaitForChild("GetLevelData"):InvokeServer()
    world = GetLevelData.world or GetLevelData.name
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
--updatefix fixmap
function saveposTEST(UnitPos, a,a2,a3,a4,a5,a6)
    local GetLevelData = game.workspace._MAP_CONFIG:WaitForChild("GetLevelData"):InvokeServer()
    world = GetLevelData.world or GetLevelData.name
    if game.workspace._MAP_CONFIG:WaitForChild("GetLevelData") then
        updatepos(world, UnitPos, a,a2,a3,a4,a5,a6)
    end
    warn("savepos test")
end

function savepos(UnitPos, a,a2,a3,a4,a5,a6)
    if game.Workspace._map:FindFirstChild("namek mushroom model") then
        updatepos("namek", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("houses_new") then
        updatepos("aot", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("Snow Particles") then
        updatepos("demonslayer", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("sand_gate") then 
        updatepos("naruto", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("icebergs") then
        updatepos("marineford", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("new buildings") then
        updatepos("tokyo_ghoul", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("Bones/dust") then
        updatepos("hueco", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("light poles") then
        updatepos("magnolia", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("LanternsGround") then
        updatepos("jjk", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("pumpkins") then    
        updatepos("thriller_park", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("sand_bags") then
        updatepos("bleach_legend", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("vending machines") then
        updatepos("chainsaw", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("SpaceCenter") then
        updatepos("jojo", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("secret") then
        updatepos("opm", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("s") then
        updatepos("west_city", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("bushes and flowers") then
        updatepos("uchiha", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("snow grass") then
       updatepos("demonslayer_raid_1", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("misc nonocollide obstacles") then
        updatepos("7ds", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("bridge nocollide") then
        updatepos("mha", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("benches and barrels") then
        updatepos("entertain", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("Ant Nest") then
        updatepos("hxhant", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map["misc deco"]:FindFirstChild("bushes") then
        updatepos("clover", UnitPos, a,a2,a3,a4,a5,a6)
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
    --emptyxx:Cheat("Label","    ")
    --NDY:Cheat("Label","THIS SECTION IS NOT FINISHED SO IT WILL NOT WORK. FOR UPDATE JOIN DISCORD!")
    --NDY2:Cheat("Label","    ")
    NDY:Cheat("Checkbox"," Open Unit Config  ", function(bool)
        print(bool)
        Settings.unitconfig = bool
        saveSettings()
    end,{enabled = Settings.unitconfig })
    NDY2:Cheat("Button", "Test Reset unit config", function()
        print(Settings.reunitc)
        reunitcon()
    end)
    --//UNIT 1
   --[[ Unit1:Cheat("Textbox", "Placement Priority", function(Value)
        Value = tonumber(Value)
        Settings.U1_UnPlace = Value
        saveSettings()
    end, {placeholder = Settings.U1_UnPlace})]]
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
   --[[ Unit1:Cheat("Textbox", "Upgrade Priority", function(Value)
        Value = tonumber(Value)
        Settings.U1_UpgPro = Value
        saveSettings()
    end, {placeholder = Settings.U1_UpgPro})]]
    Unit1:Cheat("Textbox", "Upgrade from wave", function(Value)
        Value = tonumber(Value)
        Settings.U1_UpgWave = Value
        saveSettings()
    end, {placeholder = Settings.U1_UpgWave})
    --[[Unit1:Cheat("Textbox", "Upgrade Cap", function(Value)
        Value = tonumber(Value)
        Settings.U1_UpgCap = Value
        saveSettings()
    end, {placeholder = Settings.U1_UpgCap})]]
    Unit1:Cheat("Textbox", "Auto Sell at wave", function(Value)
        Value = tonumber(Value)
        Settings.U1_SellWave = Value
        saveSettings()
    end, {placeholder = Settings.U1_SellWave}) 
    --//UNIT 2
   --[[ Unit2:Cheat("Textbox", "Placement Priority", function(Value)
        Value = tonumber(Value)
        Settings.U2_UnPlace = Value
        saveSettings()
    end, {placeholder = Settings.U2_UnPlace})]]
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
    --[[Unit2:Cheat("Textbox", "Upgrade Priority", function(Value)
        Value = tonumber(Value)
        Settings.U2_UpgPro = Value
        saveSettings()
    end, {placeholder = Settings.U2_UpgPro})]]
    Unit2:Cheat("Textbox", "Upgrade from wave", function(Value)
        Value = tonumber(Value)
        Settings.U2_UpgWave = Value
        saveSettings()
    end, {placeholder = Settings.U2_UpgWave})
    --[[Unit2:Cheat("Textbox", "Upgrade Cap", function(Value)
        Value = tonumber(Value)
        Settings.U2_UpgCap = Value
        saveSettings()
    end, {placeholder = Settings.U2_UpgCap})]]
    Unit2:Cheat("Textbox", "Auto Sell at wave", function(Value)
        Value = tonumber(Value)
        Settings.U2_SellWave = Value
        saveSettings()
    end, {placeholder = Settings.U2_SellWave}) 
    
    ---//UNIT 3
    --[[Unit3:Cheat("Textbox", "Placement Priority", function(Value)
        Value = tonumber(Value)
        Settings.U3_UnPlace = Value
        saveSettings()
    end, {placeholder = Settings.U3_UnPlace})]]
    Unit3:Cheat("Textbox", "Place from wave", function(Value)
        Value = tonumber(Value)
        Settings.U3_Wave = Value
        saveSettings()
    end, {placeholder = Settings.U3_Wave})
    
    Unit3:Cheat("Textbox", "Total Units", function(Value)
        Value = tonumber(Value)
        Settings.U3_TotalAmmount = Value
        saveSettings()
    end, {placeholder = Settings.U3_TotalAmmount})
    --[[Unit3:Cheat("Textbox", "Upgrade Priority", function(Value)
        Value = tonumber(Value)
        Settings.U3_UpgPro = Value
        saveSettings()
    end, {placeholder = Settings.U3_UpgPro})]]
    
    Unit3:Cheat("Textbox", "Upgrade from wave", function(Value)
        Value = tonumber(Value)
        Settings.U3_UpgWave = Value
        saveSettings()
    end, {placeholder = Settings.U3_UpgWave})
    
    --[[Unit3:Cheat("Textbox", "Upgrade Cap", function(Value)
        Value = tonumber(Value)
        Settings.U3_UpgCap = Value
        saveSettings()
    end, {placeholder = Settings.U3_UpgCap})]]
    
    Unit3:Cheat("Textbox", "Auto Sell at wave", function(Value)
        Value = tonumber(Value)
        Settings.U3_SellWave = Value
        saveSettings()
    end, {placeholder = Settings.U3_SellWave}) 
    --//UNIT 4
    --[[Unit4:Cheat("Textbox", "Placement Priority", function(Value)
        Value = tonumber(Value)
        Settings.U4_UnPlace = Value
        saveSettings()
    end, {placeholder = Settings.U4_UnPlace})]]
    Unit4:Cheat("Textbox", "Place from wave", function(Value)
        Value = tonumber(Value)
        Settings.U4_Wave = Value
        saveSettings()
    end, {placeholder = Settings.U4_Wave})
    
    Unit4:Cheat("Textbox", "Total Units", function(Value)
        Value = tonumber(Value)
        Settings.U4_TotalAmmount = Value
        saveSettings()
    end, {placeholder = Settings.U4_TotalAmmount})
    --[[Unit4:Cheat("Textbox", "Upgrade Priority", function(Value)
        Value = tonumber(Value)
        Settings.U4_UpgPro = Value
        saveSettings()
    end, {placeholder = Settings.U4_UpgPro})]]
    
    Unit4:Cheat("Textbox", "Upgrade from wave", function(Value)
        Value = tonumber(Value)
        Settings.U4_UpgWave = Value
        saveSettings()
    end, {placeholder = Settings.U4_UpgWave})
    
    --[[Unit4:Cheat("Textbox", "Upgrade Cap", function(Value)
        Value = tonumber(Value)
        Settings.U4_UpgCap = Value
        saveSettings()
    end, {placeholder = Settings.U4_UpgCap})]]
    
    Unit4:Cheat("Textbox", "Auto Sell at wave", function(Value)
        Value = tonumber(Value)
        Settings.U4_SellWave = Value
        saveSettings()
    end, {placeholder = Settings.U4_SellWave}) 
    
    --//UNIT 5
    --[[Unit5:Cheat("Textbox", "Placement Priority", function(Value)
        Value = tonumber(Value)
        Settings.U5_UnPlace = Value
        saveSettings()
    end, {placeholder = Settings.U5_UnPlace})]]
    Unit5:Cheat("Textbox", "Place from wave", function(Value)
        Value = tonumber(Value)
        Settings.U5_Wave = Value
        saveSettings()
    end, {placeholder = Settings.U5_Wave})
        
    Unit5:Cheat("Textbox", "Total Units", function(Value)
        Value = tonumber(Value)
        Settings.U5_TotalAmmount = Value
        saveSettings()
    end, {placeholder = Settings.U5_TotalAmmount})
    --[[Unit5:Cheat("Textbox", "Upgrade Priority", function(Value)
        Value = tonumber(Value)
        Settings.U5_UpgPro = Value
        saveSettings()
    end, {placeholder = Settings.U5_UpgPro})]]
        
    Unit5:Cheat("Textbox", "Upgrade from wave", function(Value)
        Value = tonumber(Value)
        Settings.U5_UpgWave = Value
        saveSettings()
    end, {placeholder = Settings.U5_UpgWave})
        
    --[[Unit5:Cheat("Textbox", "Upgrade Cap", function(Value)
        Value = tonumber(Value)
        Settings.U5_UpgCap = Value
        saveSettings()
    end, {placeholder = Settings.U5_UpgCap})]]
        
    Unit5:Cheat("Textbox", "Auto Sell at wave", function(Value)
        Value = tonumber(Value)
        Settings.U5_SellWave = Value
        saveSettings()
    end, {placeholder = Settings.U5_SellWave}) 
    --//UNIT 6
    --[[Unit6:Cheat("Textbox", "Placement Priority", function(Value)
        Value = tonumber(Value)
        Settings.U6_UnPlace = Value
        saveSettings()
    end, {placeholder = Settings.U6_UnPlace})]]
    Unit6:Cheat("Textbox", "Place from wave", function(Value)
        Value = tonumber(Value)
        Settings.U6_Wave = Value
        saveSettings()
    end, {placeholder = Settings.U6_Wave})
    
    Unit6:Cheat("Textbox", "Total Units", function(Value)
        Value = tonumber(Value)
        Settings.U6_TotalAmmount = Value
        saveSettings()
    end, {placeholder = Settings.U6_TotalAmmount})
    --[[Unit6:Cheat("Textbox", "Upgrade Priority", function(Value)
        Value = tonumber(Value)
        Settings.U6_UpgPro = Value
        saveSettings()
    end, {placeholder = Settings.U6_UpgPro})]]
    
    Unit6:Cheat("Textbox", "Upgrade from wave", function(Value)
        Value = tonumber(Value)
        Settings.U6_UpgWave = Value
        saveSettings()
    end, {placeholder = Settings.U6_UpgWave})
    
    --[[Unit6:Cheat("Textbox", "Upgrade Cap", function(Value)
        Value = tonumber(Value)
        Settings.U6_UpgCap = Value
        saveSettings()
    end, {placeholder = Settings.U6_UpgCap})]]
    
    Unit6:Cheat("Textbox", "Auto Sell at wave", function(Value)
        Value = tonumber(Value)
        Settings.U6_SellWave = Value
        saveSettings()
    end, {placeholder = Settings.U6_SellWave}) 
end

---------------------------------------------
--resetautofarmUI
local function reFarmconfig()

    reFarmConfig:Cheat("Button", "Reset Farm config", function()
        print(Settings.refarmc)
        refarmcon()
    end)
end
---------------------------------------------

---------------------------------------------
local function LAGGYconfig()
    LG1:Cheat("Label"," Is a BETA Version // Enjoy ")
   --test New Lag
LG1:Cheat("Checkbox","Enable Laggy ", function(bool)
	print(bool)
	Settings.EnableLag = bool
	saveSettings()
end,{enabled = Settings.EnableLag})

task.spawn(function()
	while task.wait() do
		if Settings.EnableLag then
    delaylag = tonumber(Settings.delag or 1.5)
    while wait(tonumber(Settings.delag or 1.5)) do --// don't change it's the best
    game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge * math.huge)
    local function getmaxvalue(val)
       local mainvalueifonetable = 499999
       if type(val) ~= "number" then
           return nil
       end
       local calculateperfectval = (mainvalueifonetable/(val+2))
       return calculateperfectval
    end
     
    --local function bomb(tableincrease, tries)
function bomb(tableincrease, tries)
    local maintable = {}
    local spammedtable = {}
    
    table.insert(spammedtable, {})
    z = spammedtable[1]

    tableincrease = tonumber(Settings.max or 22)
    for i = 1, tableincrease do
        local tableins = {}
        table.insert(z, tableins)
        z = tableins
    end
     
    local calculatemax = getmaxvalue(tableincrease)
    local maximum
     
    if calculatemax then
         maximum = calculatemax
         else
         maximum = 999999
    end
     
    for i = 1, maximum do
         table.insert(maintable, spammedtable)
    end
     
    --tries = tonumber(Settings.mix or 1.5)
    for i = 1, tries do
         game.RobloxReplicatedStorage.SetPlayerBlockList:FireServer(maintable)
    end
end
    
    tableincrease = tonumber(Settings.max or 22)
    --tries = tonumber(Settings.mix or 1.5)

    if Settings.EnableLag then
        bomb(tableincrease, tonumber(Settings.mix))
    elseif not Settings.EnableLag then
        bomb(tableincrease, 0)
    end
    --bomb(tableincrease, tries)
    --repeat task.wait() until not Settings.EnableLag
            end
        end
    end
end)

    --[[LG1:Cheat("Textbox", "LAG Threads", function(Value)
        print("LAG threads.:", Value)
        Settings.max = tonumber(Value)
        saveSettings()
    end, {placeholder = Settings.max or 22})

    LG1:Cheat("Textbox", "LAG Tries ", function(Value)
        print("LAG tries.:", Value)
        Settings.mix = tonumber(Value)
        saveSettings()
    end, {placeholder = Settings.mix or 0})

    LG1:Cheat("Textbox", "Delay ", function(Value)
        print("Delay.:", Value)
        Settings.delag = tonumber(Value)
        saveSettings()
    end, {placeholder = Settings.delag or 1.5})]]

    --LG1:Cheat("Label","LAG Threads : "..tonumber(Settings.max))  
    LG1:Cheat("Slider", "LAG Threads [slide]", function(Value)
        print("LAG Lv.:", Value)
        Settings.max = tonumber(Value)
        saveSettings()
    end, {min = 0, max = 250, suffix = "", default = 22 })

    --LG1:Cheat("Label","LAG Lv : "..tonumber(Settings.mix)) 
    LG1:Cheat("Slider", "LAG Lv. [slide]", function(Value)
        print("LAG Lv.:", Value)
        Settings.mix = tonumber(Value)
        saveSettings()
    end, {min = 1, max = 7, suffix = "", default = 1.2 })

    --LG1:Cheat("Label","Delay : "..tonumber(Settings.delag)) 
    LG1:Cheat("Slider", "Delay [slide]", function(Value)
        print("Delay.:", Value)
        Settings.delag = tonumber(Value)
        saveSettings()
    end, {min = 0.1, max = 10, suffix = "", default = 1.5 })

    LG1:Cheat("Label"," Threads = lower the faster it lags ")
    LG1:Cheat("Label"," Tries = the higher the faster it lags ")
    LG1:Cheat("Label"," Delay = lower the faster it lags")
    LG1:Cheat("Label"," def settings : threads = 250, tries = 1, Delay = 1.5 ")
    LG1:Cheat("Label"," fast-lag settings : threads = 10, tries = 1.5, Delay = 1.5 ")

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
                if v.Name:match("StarFruitsRainbow") then
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
    end, { options = {"None","StarFruit","StarFruitGreen","StarFruitRed", "StarFruitPink","StarFruitBlue","StarFruitEpic"}, default =Settings.ASM_SelectedFruit})
   
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
    
    WebhookSec:Cheat("Textbox", "Baby Webhook Url", function(Value)
        Settings.BabyWebhookUrl = Value
        saveSettings()
    end, {placeholder = Settings.BabyWebhookUrl})

    WebhookSec:Cheat("Textbox", "Snipe Webhook Url", function(Value)
        Settings.SnipeWebhookUrl = Value
        saveSettings()
    end, {placeholder = Settings.SnipeWebhookUrl})
    WebhookSec:Cheat("Checkbox","Enable Webhook", function(bool)
        Settings.WebhookEnabled = bool
        saveSettings()
    end,{enabled = Settings.WebhookEnabled})

    WebhookSec:Cheat("Checkbox","Enable Baby Webhook [BTP,Castle,Tour]", function(bool)
        Settings.BabyWebhookEnabled = bool
        saveSettings()
    end,{enabled = Settings.BabyWebhookEnabled})

    WebhookSec:Cheat("Checkbox","Enable Snipe Webhook [Banner & Shop]", function(bool)
        Settings.snipeWebhookEnabled = bool
        saveSettings()
    end,{enabled = Settings.snipeWebhookEnabled})

    WebhookSec:Cheat("Button", "Test Webhook", function()
        print(Settings.WebhookUrl)
        webhook()
    end)
end

function Webhooksec2()

    WebhookSec:Cheat("Button", "Test Baby Webhook", function()
        print(Settings.WebhookUrl)
        BabyWebhook()
        SnipeShopNew()
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
if Settings.AutoLoadScript then
    autoload()
end

function autoload2()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/ArponAG/Scripts/main/AnimeAdventures_v2__Beta.lua'))()
end

if Settings.refarmc then
    autoload2() end
if Settings.setfarm1 then
    autoload2() end
if Settings.setfarm2 then
    autoload2() end
if Settings.setfarmIC then
    autoload2() end


function others()

    OtherSec:Cheat("Checkbox","🗺️ Delete Map 🗺️", function(bool)
        Settings.deletemap = bool
        saveSettings()
    end,{enabled = Settings.deletemap})

    OtherSec:Cheat("Checkbox"," Place Anywhere", function(bool)
        print(bool)
        Settings.placeany = bool
        saveSettings()
        placeAny()
        placeunittwin()
    end,{enabled = Settings.placeany})

    OtherSec:Cheat("Checkbox","⌛ Auto Load Script ⌛", function(bool)
        Settings.AutoLoadScript = bool
        saveSettings()
        autoload()
    end,{enabled = Settings.AutoLoadScript})

    OtherSec:Cheat("Checkbox","🐱 Hide Name Player 🐱", function(bool)
        Settings.hidenamep = bool
        saveSettings()
        hidename()
    end,{enabled = Settings.hidenamep})

    OtherSec:Cheat("Checkbox","Auto Grab Daily Quest ", function(bool)
        print(Settings.autoDailyquest)
        Settings.autoDailyquest = bool
        saveSettings()
        autoDailyquest()
    end,{enabled = Settings.autoDailyquest})
    
    OtherSec:Cheat("Checkbox","Escanor Infinite Range ", function(bool) -- added by craymel02
        print("Esacanor Infinite Range is set to " .. tostring(bool))
        Settings.escanorIR = bool
        saveSettings()
    end,{enabled = Settings.escanorIR})

    OtherSec:Cheat("Button", "Redeem All Code", function()
        print(Settings.redeemc)
        Reedemcode()
    end)

    OtherSec:Cheat("Button", "Leave To Lobby", function()
        warn("Return to Lobby")
        Teleport()
    end)
    
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
    reFarmconfig()
    LAGGYconfig()
    credits()
    AutoSummon()
    SnipeMerchant()
    Webhooksec()
    Webhooksec2()
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
    reFarmconfig()
    LAGGYconfig()
    credits()
    SnipeMerchant()
    Webhooksec()
    others()
    WebhookSec:Cheat("Label","")
    WebhookSec:Cheat("Label","Test Baby&Shop Webhook Only available in game Lobby!")
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
--test fixportal
function getBorosPortals()
    local portals = {}
    for _, item in pairs(get_inventory_items_unique_items()) do
        if item["item_id"] == "portal_boros_g" then
            table.insert(portals, item)
        end
    end
    return portals
end

function getDemonPortals()
    local portals = {}
    for _, item in pairs(get_inventory_items_unique_items()) do
        if item["item_id"] == "april_portal_item" then
            table.insert(portals, item)
        end
    end
    return portals
end

function getZeldrisPortals()
    local portals = {}
    for _, item in pairs(get_inventory_items_unique_items()) do
        if item["item_id"] == "portal_zeldris" then
            table.insert(portals, item)
        end
    end
    return portals
end
function GetPortals(id)
    local reg = getreg() 
    local portals = {}
    for i,v in next, reg do
        if type(v) == 'function' then 
            if getfenv(v).script then 
                for _, v in pairs(debug.getupvalues(v)) do 
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
    if game.PlaceId == 8304191830 and not Settings.farmprotal and Settings.autostart and Settings.AutoFarm and Settings.teleporting and not Settings.AutoInfinityCastle then
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
    
                pcall(function() 
                    BabyWebhook() 
                    SnipeShopNew()
                
                end)
                print("send Webhook")
                task.wait(1.1)
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
    
                pcall(function() 
                    BabyWebhook() 
                    SnipeShopNew()
                
                end)
                print("send Webhook")
                task.wait(1.1)
                warn("farming")
                task.wait(3)
            end
        elseif cata == "Portals" then
            --aline fixportal
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
                --Demon fixportal		
            elseif level == "april_portal_item" then
                local args = {
                    [1] = GetPortals("april_portal_item")[1]["uuid"],
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
            pcall(function() 
                BabyWebhook()
                SnipeShopNew()
             end)
                print("send Webhook")
                task.wait(1.1)
                warn("Demon farming")
                task.wait(7)
                --7Ds fixportal		
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
                pcall(function() 
                    BabyWebhook() 
                    SnipeShopNew()
                
                end)
                print("send Webhook")
                task.wait(1.1)
                warn("7ds farming")
                task.wait(7)
            end
        elseif cata == "Dungeon" then
            if level == "jjk_finger" then --_lobbytemplate_event222
            getgenv().door = "_lobbytemplate_event222"
            local string_1 = "_lobbytemplate_event222";
            local table_1 = {
                ["selected_key"] = "key_jjk_finger" --key_jjk_finger
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
    
                pcall(function() 
                    BabyWebhook() 
                    SnipeShopNew()
                
                end)
                print("send Webhook")
                task.wait(1.1)
                warn("DUNGEONS jjk_finger farming")
                task.wait(3)
            end
                --ดันเกะโท
        elseif cata == "Dungeon" then
            if level == "jjk_raid" then
                getgenv().door = "_lobbytemplate_event23"
                local string_1 = "_lobbytemplate_event23";
                local table_1 = {
                    ["selected_key"] = "key_jjk_map"
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
        
                    pcall(function() 
                        BabyWebhook() 
                        SnipeShopNew()
                    
                    end)
                    print("send Webhook")
                    task.wait(1.1)
                    warn("DUNGEONS jjk_raid farming")
                    task.wait(3)
                end
                end
            end
        end
    end
end
    -- Start of Auto Ability Function
getgenv().autoabilityerr = false
function autoabilityfunc()
    local player = game.Players.LocalPlayer.Name
    if Settings.AutoAbilities then
        repeat task.wait() until Workspace:WaitForChild("_UNITS")
        local success, err = pcall(function()
            for i, v in ipairs(Workspace["_UNITS"]:GetChildren()) do
                if v:FindFirstChild("_stats") then
                    
                    -- Look for Threat then execute Puchi Skill
                    if v._stats:FindFirstChild("threat") then
                        if v._stats.threat.Value > 0 then
                            UsePuchiSkill()
                        end
                        
                    -- Search Player Units
    				elseif v._stats:FindFirstChild("player") then
    					if tostring(v._stats.player.Value) == player then
    
                            
                            -- Execute Skill if Wendy and recast every 21 seconds
                            if v._stats.id.Value == "wendy" then
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                                task.wait(21)
                            
                            -- Execute Skill if Erwin and recast every 21 seconds
                            elseif v._stats.id.Value == "erwin" then
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                                task.wait(21)
                                
                            -- Execute Skill if Gojo and recast every 60 seconds    
                            elseif v._stats.id.Value == "gojo_evolved" then
                                if v._stats.state.Value == "attack" then
                                    game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                                end
                            
                            -- Execute Skill if Not Wendy, Erwin, Gojo and Puchi    
                            elseif v._stats.id.Value ~= "pucci_heaven" then
                                if v._stats.state.Value == "attack" then
                                    if v._stats.active_attack.Value ~= "nil" then
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
            warn("Can't use Ability")
            getgenv().autoabilityerr = true
            error(err)
        end
    end
end
    -- End of Auto Abilities Function
    
    -- Start of Puchi Skill Function
function UsePuchiSkill()
    local player = game.Players.LocalPlayer.Name
	for i, v in ipairs(Workspace["_UNITS"]:getChildren()) do
		if v:FindFirstChild("_stats") then
			if v._stats:FindFirstChild("player") then
				if tostring(v._stats.player.Value) == player then
					if v._stats.id.Value == "pucci_heaven" then
					    if v._stats.state.Value == "attack" then
					    
					        -- Check if Game Mode is Infinite
						    if GLD()._gamemode == "infinite" then
						        if GetWaveNumber() % 10 == 0 then
						            game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
						        end
						    -- Check if Game Mode is Raid
					        elseif GLD()._gamemode == "raid" then
					            if GetWaveNumber() == 15 or 20 then
						            game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
						        end
						    -- Check if Game mode is Story or Infinite Tower
					        elseif GLD()._gamemode == "story" or "infinite_tower" then
					            if GetWaveNumber() == 15 then
					                game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
					            end
					        end
						end
					end
				end
			end
		end
	end
end
    -- End of Puchi Skill Function

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
                BabyWebhook()
                SnipeShopNew()
            end
        elseif not Settings.AutoInfinityCastle == true then--Infiniy Castle
            if not checkChallenge() then --Challenge_Not_Complete
                if  Settings.AutoChallengeAll then
                    startChallenge() --S_Challenge
                else
                    startfarming()--S_Farming
                end
            elseif checkChallenge() == true then
                startfarming()--S_Farming
                BabyWebhook()
                SnipeShopNew()
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
                BabyWebhook()
                SnipeShopNew()
            end
        end
        if game.PlaceId ~= 8304191830 then
            local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
            if Settings.autoQuit and not Settings.AutoSell and tonumber(Settings.AutoSellWave) <= _wave.Value then
                pcall(function() webhook() end)
                print("send Webhook")
                task.wait(2.1)
                print("Returning to lobby...")
                task.wait(2.1)
                Teleport()
            end
            if Settings.AutoSell and not Settings.autoQuit and tonumber(Settings.AutoSellWave) <= _wave.Value then
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
        
        if Settings.AutoUpgrade and not Settings.unitconfig then
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

        if Settings.unitconfig and not Settings.AutoUpgrade then
            if game.PlaceId ~= 8304191830 then
                pcall(function()
                    upgradeunit(name, min)
                end)
            end
            if  getgenv().autoupgradeerr == true then
                task.wait()
                autoupgradefunc()
                getgenv().autoupgradeerr = false
            end
        end
        if Settings.unitconfig and Settings.AutoUpgrade then
            if game.PlaceId ~= 8304191830 then
                pcall(function()
                    upgradeunit(name, min)
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
------// Auto Leave \\------
--#region Auto Leave 
local PlaceID = 8304191830
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local last
local File = pcall(function()
   AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
   table.insert(AllIDs, actualHour)
   writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
   local Site;
   if foundAnything == "" then
       Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
   else
       Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
   end
   local ID = ""
   if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
       foundAnything = Site.nextPageCursor
   end
   local num = 0;
   local extranum = 0
   for i,v in pairs(Site.data) do
       extranum += 1
       local Possible = true
       ID = tostring(v.id)
       if tonumber(v.maxPlayers) > tonumber(v.playing) then
           if extranum ~= 1 and tonumber(v.playing) < last or extranum == 1 then
               last = tonumber(v.playing)
           elseif extranum ~= 1 then
               continue
           end
           for _,Existing in pairs(AllIDs) do
               if num ~= 0 then
                   if ID == tostring(Existing) then
                       Possible = false
                   end
               else
                   if tonumber(actualHour) ~= tonumber(Existing) then
                       local delFile = pcall(function()
                           delfile("NotSameServers.json")
                           AllIDs = {}
                           table.insert(AllIDs, actualHour)
                       end)
                   end
               end
               num = num + 1
           end
           if Possible == true then
               table.insert(AllIDs, ID)
               wait()
               pcall(function()
                   writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                   wait()
                   game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
               end)
               wait(4)
           end
       end
   end
end
function Teleport()
   while wait() do
       pcall(function()
           TPReturner()
           if foundAnything ~= "" then
               TPReturner()
           end
       end)
   end
end

-------------------------------------------

-------------------------------------------
coroutine.resume(coroutine.create(function()
	
    task.spawn(function()
        local GameFinished = game:GetService("Workspace"):WaitForChild("_DATA"):WaitForChild("GameFinished")
        GameFinished:GetPropertyChangedSignal("Value"):Connect(function()
            print("Changed", GameFinished.Value == true)
            if GameFinished.Value == true then
                repeat task.wait() until  game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Enabled == true
                pcall(function() webhook() end)
                print("Wait next or leave")
                task.wait(2.1)
            if Settings.AutoReplay then
                local a={[1]="replay"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
                local a={[1]="replay"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
                    print("Replay...") 
            elseif Settings.AutoNext then
                local a={[1]="next_story"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
                local a={[1]="next_story"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
                    print("Next Story...") 
            elseif Settings.AutoContinue then
                local a={[1]="NextRetry"} game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer(unpack(a))
                local a={[1]="NextRetry"} game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer(unpack(a))   
                    print("Next Room infint Castle...")              
            elseif Settings.AutoLeave and not Settings.AutoReplay and not Settings.AutoNext and not Settings.AutoContinue then
                   game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
                
                    Teleport()
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
        --local GetLevelData = game.workspace._MAP_CONFIG:WaitForChild("GetLevelData"):InvokeServer()
        x = getgenv().posX; z = getgenv().posZ
        --world = GetLevelData.world or GetLevelData.name
			--print(tostring(world))
            print(map)
        local pos = Settings[map][unit]
        --warn(" ด่าน "..map.." กำลังวางหรืออัพตัว "..name)
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
                    warn("p1")
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
                        [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y2"], pos["z"]) )
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
            end
        end
        return
    end
end

    -- Start of Get Current Wave Number [Added by Craymel02]
function GetWaveNumber()
    return game:GetService("Workspace")["_wave_num"].Value
end
    -- End of Get Current Wave Number

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

--test Upgrade
function upgradeunit(name, min)
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
       if v:FindFirstChild("_stats") and v:FindFirstChild("_hitbox") then
            if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v["_stats"].xp.Value >= 0 then
                --if v.Name == name and v._stats.upgrade.Value <= min then
                if v._stats.id.Value == name and v._stats.upgrade.Value <= min then
                   game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
                end
            end
        end
    end
end

---------------------------------
---------test sell unit----------
---------------------------------
--test
function sellunit(name) 
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v.Name == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v._stats:FindFirstChild("upgrade") then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
            end
        end
    end


--unit1
function sellunit1(name) 
    U1_wave = game:GetService("Workspace"):WaitForChild("_wave_num")
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v.Name == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v._stats:FindFirstChild("upgrade") then
            if tonumber(Settings.U1_SellWave) <= U1_wave.Value then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
            end
        end
    end
end

--unit2
function sellunit2(name) 
    U2_wave = game:GetService("Workspace"):WaitForChild("_wave_num")
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v.Name == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v._stats:FindFirstChild("upgrade") then
            if tonumber(Settings.U2_SellWave) <= U2_wave.Value then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
            end
        end
    end
end

--unit3
function sellunit3(name) 
    U3_wave = game:GetService("Workspace"):WaitForChild("_wave_num")
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v.Name == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v._stats:FindFirstChild("upgrade") then
            if tonumber(Settings.U3_SellWave) <= U3_wave.Value then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
            end
        end
    end
end

--unit4
function sellunit4(name) 
    U4_wave = game:GetService("Workspace"):WaitForChild("_wave_num")
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v.Name == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v._stats:FindFirstChild("upgrade") then
            if tonumber(Settings.U4_SellWave) <= U4_wave.Value then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
            end
        end
    end
end

--unit5
function sellunit5(name) 
    U5_wave = game:GetService("Workspace"):WaitForChild("_wave_num")
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v.Name == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v._stats:FindFirstChild("upgrade") then
            if tonumber(Settings.U5_SellWave) <= U5_wave.Value then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
            end
        end
    end
end

--unit6
function sellunit6(name) 
    U6_wave = game:GetService("Workspace"):WaitForChild("_wave_num")
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v.Name == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v._stats:FindFirstChild("upgrade") then
            if tonumber(Settings.U6_SellWave) <= U6_wave.Value then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
            end
        end
    end
end

---------------------------------
---------------------------------
---------------------------------
function PlaceUnitsTEST(map,name,_uuid,unit)
    local GetLevelData = game.workspace._MAP_CONFIG:WaitForChild("GetLevelData"):InvokeServer()
    world = GetLevelData.world or GetLevelData.name
    current_wave = game:GetService("Workspace")["_wave_num"].Value
    U1_wv, U2_wv, U3_wv, U4_wv, U5_wv, U6_wv = Settings.U1_Wave or 1, Settings.U2_Wave or 1, Settings.U3_Wave or 1, Settings.U4_Wave or 1, Settings.U5_Wave or 1, Settings.U6_Wave or 1
    U1_TAmm, U2_TAmm, U3_TAmm, U4_TAmm, U5_TAmm, U6_TAmm = Settings.U1_TotalAmmount or 6, Settings.U2_TotalAmmount or 6, Settings.U3_TotalAmmount or 6, Settings.U4_TotalAmmount or 6, Settings.U5_TotalAmmount or 6, Settings.U6_TotalAmmount or 6
    U1_upgW, U2_upgW, U3_upgW, U4_upgW, U5_upgW, U6_upgW = Settings.U1_UpgWave or 1, Settings.U2_UpgWave or 1, Settings.U3_UpgWave or 1, Settings.U4_UpgWave or 1, Settings.U5_UpgWave or 1, Settings.U6_UpgWave or 1
    U1_upgCap, U2_upgCap, U3_upgCap, U4_upgCap, U5_upgCap, U6_upgCap = Settings.U1_UpgCap or 99, Settings.U2_UpgCap or 99, Settings.U3_UpgCap or 99, Settings.U4_UpgCap or 99, Settings.U5_UpgCap or 99, Settings.U6_UpgCap or 99
    U1_sellW, U2_sellW, U3_sellW, U4_sellW, U5_sellW, U6_sellW = Settings.U1_SellWave or 999, Settings.U2_SellWave or 999, Settings.U3_SellWave or 999, Settings.U4_SellWave or 999, Settings.U5_SellWave or 999, Settings.U6_SellWave or 999
    U1_upgP, U2_upgP, U3_upgP, U4_upgP, U5_upgP, U6_upgP = Settings.U1_UpgPro or 1, Settings.U2_UpgPro or 1, Settings.U3_UpgPro or 1, Settings.U4_UpgPro or 1, Settings.U5_UpgPro or 1, Settings.U6_UpgPro or 1
    U1_UnP, U2_UnP, U3_UnP, U4_UnP, U5_UnP, U6_UnP = Settings.U1_UnPlace or 1, Settings.U2_UnPlace or 1, Settings.U3_UnPlace or 1, Settings.U4_UnPlace or 1, Settings.U5_UnPlace or 1, Settings.U6_UnPlace or 1
    
    --//Unit 1
    local U1_amm, U1_name, U1_uuid, U1_u = GetUnitInfo("U1")
    if U1_wv <= current_wave and U1_amm <= U1_TAmm then
        if U1_sellW >= current_wave and U1_amm < U1_TAmm then
            print("placing u1.."..U1_name)
            PlacePos(map, U1_name, U1_uuid,"UP1")
        end
        if U1_sellW <= current_wave then
            print("selling u1.."..U1_name)
            sellunit1(U1_name)
        end
        if U1_u < U1_upgCap and U1_upgW <= current_wave and U1_sellW >= current_wave then
            print("upgrading u1.."..U1_name)
            upgradeunit(U1_name, U1_upgCap)
        end
    end
--end
    --//Unit 2
    local U2_amm, U2_name, U2_uuid, U2_u = GetUnitInfo("U2")
    if U2_wv <= current_wave and U2_amm <= U2_TAmm then
        if U2_sellW >= current_wave and U2_amm < U2_TAmm then
            print("placing u2.."..U2_name)
            PlacePos(map, U2_name, U2_uuid,"UP2")
        end
        if U2_sellW <= current_wave then
            print("selling u2.."..U2_name)
            sellunit2(U2_name)
        end
        if U2_u < U2_upgCap and U2_upgW <= current_wave and U2_sellW >= current_wave then
            print("upgrading u2.."..U2_name)
            upgradeunit(U2_name, U2_upgCap)
        end
    end
--end
    --//Unit 3
    local U3_amm, U3_name, U3_uuid, U3_u = GetUnitInfo("U3")
    if U3_wv <= current_wave and U3_amm <= U3_TAmm then
	    if U3_sellW >= current_wave and U3_amm < U3_TAmm then
		    print("placing u3.."..U3_name)
		    PlacePos(map, U3_name, U3_uuid,"UP3")
        end
	    if U3_sellW <= current_wave then
		    print("selling u3.."..U3_name)
		    sellunit3(U3_name)
	    end
        if U3_u < U3_upgCap and U3_upgW <= current_wave then
            print("upgrading u3.."..U3_name)
            upgradeunit(U3_name, U3_upgCap)
        end
    end
--end
    --//Unit 4
    local U4_amm, U4_name, U4_uuid, U4_u = GetUnitInfo("U4")
    if U4_wv <= current_wave and U4_amm <= U4_TAmm then
	    if U4_sellW >= current_wave and U4_amm < U4_TAmm then
		    print("placing u4.."..U4_name)
		    PlacePos(map, U4_name, U4_uuid,"UP4")
        end
	    if U4_sellW <= current_wave then
		    print("selling u4.."..U4_name)
		    sellunit4(U4_name)
	    end
        if U4_u < U4_upgCap and U4_upgW <= current_wave and U4_sellW >= current_wave then
            print("upgrading u4.."..U4_name)
            upgradeunit(U4_name, U4_upgCap)
        end
    end
--end
    --//Unit 5
    local U5_amm, U5_name, U5_uuid, U5_u = GetUnitInfo("U5")
    if U5_wv <= current_wave and U5_amm <= U5_TAmm then
	    if U5_sellW >= current_wave and U5_amm < U5_TAmm then
		    print("placing u5.."..U5_name)
		    PlacePos(map, U5_name, U5_uuid,"UP5")
        end
	    if U5_sellW <= current_wave then
		    print("selling u5.."..U5_name)
		    sellunit5(U5_name)
	    end
        if U5_u < U5_upgCap and U5_upgW <= current_wave and U5_sellW >= current_wave then
            print("upgrading u5.."..U5_name)
            upgradeunit(U5_name, U5_upgCap)
        end
    end
--end
    --//Unit 6
    local U6_amm, U6_name, U6_uuid, U6_u = GetUnitInfo("U6")
    if U6_wv <= current_wave and U6_amm <= U6_TAmm then
	    if U6_sellW >= current_wave and U6_amm < U6_TAmm then
		    print("placing u6.."..U6_name)
		    PlacePos(map, U6_name, U6_uuid,"UP6")
        end
	    if U6_sellW <= current_wave then
		    print("selling u6.."..U6_name)
		    sellunit6(U6_name)
	    end
        if U6_u < U6_upgCap and U6_upgW <= current_wave and U6_sellW >= current_wave then
            print("upgrading u6.."..U6_name)
            upgradeunit(U6_name, U6_upgCap)
            end
        end
    end
--end
--test reset unit config
function reunitcon()
    print("reset unit config ?")
    if Settings.U1_Wave then
        Settings.U1_Wave = 1 end
    if Settings.U2_Wave then
        Settings.U2_Wave = 1 end
    if Settings.U3_Wave then
        Settings.U3_Wave = 1 end
    if Settings.U4_Wave then
        Settings.U4_Wave = 1 end
    if Settings.U5_Wave then
        Settings.U5_Wave = 1 end
    if Settings.U6_Wave then
        Settings.U6_Wave = 1 end
    if Settings.U1_TotalAmmount then
        Settings.U1_TotalAmmount = 6 end
    if Settings.U2_TotalAmmount then
        Settings.U2_TotalAmmount = 6 end
    if Settings.U3_TotalAmmount then
        Settings.U3_TotalAmmount = 6 end
    if Settings.U4_TotalAmmount then
        Settings.U4_TotalAmmount = 6 end
    if Settings.U5_TotalAmmount then
        Settings.U5_TotalAmmount = 6 end
    if Settings.U6_TotalAmmount then
        Settings.U6_TotalAmmount = 6 end
    if Settings.U1_UpgWave then
        Settings.U1_UpgWave = 1 end
    if Settings.U2_UpgWave then
        Settings.U2_UpgWave = 1 end
    if Settings.U3_UpgWave then
        Settings.U3_UpgWave = 1 end
    if Settings.U4_UpgWave then
        Settings.U4_UpgWave = 1 end
    if Settings.U5_UpgWave then
        Settings.U5_UpgWave = 1 end
    if Settings.U6_UpgWave then
        Settings.U6_UpgWave = 1 end
    if Settings.U1_UpgCap then
        Settings.U1_UpgCap = 99 end
    if Settings.U2_UpgCap then
        Settings.U2_UpgCap = 99 end
    if Settings.U3_UpgCap then
        Settings.U3_UpgCap = 99 end
    if Settings.U4_UpgCap then
        Settings.U4_UpgCap = 99 end
    if Settings.U5_UpgCap then
        Settings.U5_UpgCap = 99 end
    if Settings.U6_UpgCap then
        Settings.U6_UpgCap = 99 end
    if Settings.U1_SellWave then
        Settings.U1_SellWave = 99 end
    if Settings.U2_SellWave then
        Settings.U2_SellWave = 99 end
    if Settings.U3_SellWave then
        Settings.U3_SellWave = 99 end
    if Settings.U4_SellWave then
        Settings.U4_SellWave = 99 end
    if Settings.U5_SellWave then
        Settings.U5_SellWave = 99 end
    if Settings.U6_SellWave then
        Settings.U6_SellWave = 99 end
    if Settings.U1_UpgPro then
        Settings.U1_UpgPro = 1 end
    if Settings.U2_UpgPro then
        Settings.U2_UpgPro = 1 end
    if Settings.U3_UpgPro then
        Settings.U3_UpgPro = 1 end
    if Settings.U4_UpgPro then
        Settings.U4_UpgPro = 1 end
    if Settings.U5_UpgPro then
        Settings.U5_UpgPro = 1 end
    if Settings.U6_UpgPro then
        Settings.U6_UpgPro = 1 end
    if Settings.U1_UnPlace then
        Settings.U1_UnPlace = 1 end
    if Settings.U2_UnPlace then
        Settings.U2_UnPlace = 1 end
    if Settings.U3_UnPlace then
        Settings.U3_UnPlace = 1 end
    if Settings.U4_UnPlace then
        Settings.U4_UnPlace = 1 end
    if Settings.U5_UnPlace then
        Settings.U5_UnPlace = 1 end
    if Settings.U6_UnPlace then
        Settings.U6_UnPlace = 1 end
  
end
if Settings.reunitc then
    reunitcon()
end
--fix sell and place spam
function PlaceUnits(map)
    pcall(function()
        if Settings.AutoFarm and not getgenv().disableatuofarm then
            --local GetLevelData = game.workspace._MAP_CONFIG:WaitForChild("GetLevelData"):InvokeServer()
            x = getgenv().posX; z = getgenv().posZ
            --world = GetLevelData.world or GetLevelData.name
			--print(tostring(world))
            print(map)
            for i = 1, 6 do
                local unitinfo = Settings.SelectedUnits["U" .. i]
                if unitinfo ~= nil then
                    local unitinfo_ = unitinfo:split(" #")
                    local pos = Settings[map]["UP" .. i]
                    print(map.." attemp to place "..unitinfo_[1])
    
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
                            [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y2"], pos["z"]) )
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
                            [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y5"], pos["z"]) )
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
            
                        --place units 5
                        local args = {
                            [1] = unitinfo_[2],
                            [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y6"], pos["z"]) )
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                    elseif unitinfo_[1] == "metal_knight_evolved" then
                       
                        task.spawn(function()
                            --place units 0
                            warn("p1" )
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
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"], pos["z"]) )
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


------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
--updatefix fixmap
coroutine.resume(coroutine.create(function()
    while task.wait(1.5) do
        if game.PlaceId ~= 8304191830 and Settings.AutoFarm and Settings.unitconfig and not getgenv().disableatuofarm then
            warn("Enable Unit Config")
            local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
            repeat task.wait() until game:GetService("Workspace"):WaitForChild("_map")
            if game.Workspace._map:FindFirstChild("namek mushroom model") then
                PlaceUnitsTEST("namek")
            elseif game.Workspace._map:FindFirstChild("houses_new") then
                PlaceUnitsTEST("aot")
            elseif game.Workspace._map:FindFirstChild("Snow Particles") then
                PlaceUnitsTEST("demonslayer")
            elseif game.Workspace._map:FindFirstChild("sand_gate") then 
                PlaceUnitsTEST("naruto")
            elseif game.Workspace._map:FindFirstChild("icebergs") then
                PlaceUnitsTEST("marineford")
            elseif game.Workspace._map:FindFirstChild("new buildings") then
                PlaceUnitsTEST("tokyo_ghoul")
            elseif game.Workspace._map:FindFirstChild("Bones/dust") then
                PlaceUnitsTEST("hueco")
            elseif game.Workspace._map:FindFirstChild("light poles") then
                PlaceUnitsTEST("magnolia")
            elseif game.Workspace._map:FindFirstChild("LanternsGround") then
                PlaceUnitsTEST("jjk")
            elseif game.Workspace._map:FindFirstChild("pumpkins") then    
                PlaceUnitsTEST("thriller_park")  
            elseif game.Workspace._map:FindFirstChild("sand_bags") then
                PlaceUnitsTEST("bleach_legend")
            elseif game.Workspace._map:FindFirstChild("vending machines") then
                PlaceUnitsTEST("chainsaw")
            elseif game.Workspace._map:FindFirstChild("SpaceCenter") then
                PlaceUnitsTEST("jojo")
            elseif game.Workspace._map:FindFirstChild("secret") then
                PlaceUnitsTEST("opm")
            elseif game.Workspace._map:FindFirstChild("s") then
                PlaceUnitsTEST("west_city")
            elseif game.Workspace._map:FindFirstChild("bushes and flowers") then
                PlaceUnitsTEST("uchiha")
            elseif game.Workspace._map:FindFirstChild("snow grass") then
                PlaceUnitsTEST("demonslayer_raid_1")
            elseif game.Workspace._map:FindFirstChild("misc nonocollide obstacles") then
                PlaceUnitsTEST("7ds")
            elseif game.Workspace._map:FindFirstChild("bridge nocollide") then
                PlaceUnitsTEST("mha")
            elseif game.Workspace._map:FindFirstChild("benches and barrels") then
                PlaceUnitsTEST("entertain")
            elseif game.Workspace._map:FindFirstChild("Ant Nest") then
                PlaceUnitsTEST("hxhant")
            elseif game.Workspace._map["misc deco"]:FindFirstChild("bushes") then
                PlaceUnitsTEST("clover")
            end
        end
    end
end))

coroutine.resume(coroutine.create(function()
    while task.wait(1.5) do
        if game.PlaceId ~= 8304191830 and Settings.AutoFarm and not Settings.unitconfig and not getgenv().disableatuofarm then
            warn("Disable Unit Config")
            local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
            repeat task.wait() until game:GetService("Workspace"):WaitForChild("_map")
            if game.Workspace._map:FindFirstChild("namek mushroom model") then
                PlaceUnits("namek")
            elseif game.Workspace._map:FindFirstChild("houses_new") then
                PlaceUnits("aot")
            elseif game.Workspace._map:FindFirstChild("Snow Particles") then
                PlaceUnits("demonslayer")
            elseif game.Workspace._map:FindFirstChild("sand_gate") then 
                PlaceUnits("naruto")
            elseif game.Workspace._map:FindFirstChild("icebergs") then
                PlaceUnits("marineford")
            elseif game.Workspace._map:FindFirstChild("new buildings") then
                PlaceUnits("tokyo_ghoul")
            elseif game.Workspace._map:FindFirstChild("Bones/dust") then
                PlaceUnits("hueco")
            elseif game.Workspace._map:FindFirstChild("light poles") then
                PlaceUnits("magnolia")
            elseif game.Workspace._map:FindFirstChild("LanternsGround") then
                PlaceUnits("jjk")
            elseif game.Workspace._map:FindFirstChild("pumpkins") then    
                PlaceUnits("thriller_park")  
            elseif game.Workspace._map:FindFirstChild("sand_bags") then
                PlaceUnits("bleach_legend")
            elseif game.Workspace._map:FindFirstChild("vending machines") then
                PlaceUnits("chainsaw")
            elseif game.Workspace._map:FindFirstChild("SpaceCenter") then
                PlaceUnits("jojo")
            elseif game.Workspace._map:FindFirstChild("secret") then
                PlaceUnits("opm")
            elseif game.Workspace._map:FindFirstChild("s") then
                PlaceUnits("west_city")
            elseif game.Workspace._map:FindFirstChild("bushes and flowers") then
                PlaceUnits("uchiha")
            elseif game.Workspace._map:FindFirstChild("snow grass") then
                PlaceUnits("demonslayer_raid_1")
            elseif game.Workspace._map:FindFirstChild("misc nonocollide obstacles") then
                PlaceUnits("7ds")
            elseif game.Workspace._map:FindFirstChild("bridge nocollide") then
                PlaceUnits("mha")
            elseif game.Workspace._map:FindFirstChild("benches and barrels") then
                PlaceUnits("entertain")
            elseif game.Workspace._map:FindFirstChild("Ant Nest") then
                PlaceUnits("hxhant")
            elseif game.Workspace._map["misc deco"]:FindFirstChild("bushes") then
                PlaceUnits("clover") 
            end
        end
    end
end))

-----------------------------------------------------
--------------------DELETE MAP-----------------------
-----------------------------------------------------
--delete map Map id
--deletet terrain
function DelTer()
	if game.Workspace._terrain:FindFirstChild("terrain") then
    	for i,v in pairs(game:GetService("Workspace")["_terrain"].terrain:GetChildren()) do
			if v.ClassName == "MeshPart" then v:Destroy() end
        	if v.ClassName == "Model" then v:Destroy() end
			if v.ClassName == "Folder" then v:Destroy() end
        end
    end  
end   


function DelMapMain()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end
--Namek

function DelMapnamekmap2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["namek mushroom model"]:GetChildren()) do
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapnamekmap3()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["namek trees model"]:GetChildren()) do
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapnamekmap4()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["namek_details"]:GetChildren()) do
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapnamekmap5()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["vines_model"]:GetChildren()) do
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapnamekmap6()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["namek grass model"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapnamekmap7()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].obstacles:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapnamekmap8()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].obstacles["new houses"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapnamekmap9()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].obstacles.rocks:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

--Titan
function DelMapTitan1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].grass:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapTitan2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["houses_new"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapTitan3()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].obstacles:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapTitan4()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].obstacles.deco:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapTitan5()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].obstacles.trees:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapTitan6()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["river towers"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapTitan7()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["towers_new"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapTitan8()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["hq_new"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

--Snowy
function DelMapSnowy1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["snow grass"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapSnowy1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].obstacles.deco.trees:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapSnowy2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].obstacles.deco.rocks:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "UnionOperation" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapSnowy3()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].obstacles.deco.trunks:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end
--Aline
function DelMapAlinewires()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].wires:GetChildren()) do
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapAlinepaper()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].paper:GetChildren()) do
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapAlinetrees()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].trees:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapAlinefences()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].fences:GetChildren()) do
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapAlinepole()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].pole:GetChildren()) do
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

function DelMapAlinevents()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].vents:GetChildren()) do
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end  
end

--Sand
function DelMapSand1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["market deco"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapSand2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].ropes:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapSand3()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["desert_houses"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapSand4()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].innerterrain:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

--Marine
function DelMapMarine1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].deco:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapMarine2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].grass:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapMarine3()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["ice spikes"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapMarine4()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].icebergs:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapMarine5()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["marine ships"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapMarine6()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["marineford_houses"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapMarine7()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["small ice spikes"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

--Ghoul
function DelMapGhoul1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].Folder.CantPlace:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapGhoul2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["new buildings"]:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapGhoul3()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]:GetChildren()) do
				if v.Name == "obstacles" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapGhoul4()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["rain_floors"]:GetChildren()) do
				if v.Name == "obstacles" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapGhoul5()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].rain:GetChildren()) do
				if v.Name == "obstacles" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

--Hollow
function DelMapHollow1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["Bones/dust"]:GetChildren()) do
				if v.Name == "obstacles" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

--Ant
function DelMapAnt()
	if game.Workspace._terrain:FindFirstChild("terrain") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]:GetChildren()) do
        	if v.ClassName == "Model" then v:Destroy() end
			if v.ClassName == "Folder" then v:Destroy() end
        end
    end  
end 

function DelMapAnt1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].obstacles.deco:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapAnt2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].flowers:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapAnt3()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].stumps:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapAnt4()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].cloth:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapAnt5()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].grass:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapAnt6()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].graves:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapAnt7()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].obstacles.deco.Farms:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapAnt8()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].obstacles.deco.Nature:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapAnt9()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].obstacles.deco["Other Small Stuff"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapAnt10()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].obstacles.deco.Walls:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapAnt11()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].obstacles.deco.trees:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapAnt12()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].obstacles.deco["trees-thin"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end
--Magic
function DelMapMagic1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["barrels, benches"]:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapMagic2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].boats:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapMagic3()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].extras:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapMagic4()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].grass:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapMagic5()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["grass place"]:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapMagic6()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["light poles"]:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapMagic7()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].pillars:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapMagic8()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].streamers:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapMagic9()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].tents:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapMagic10()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].trees:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapMagic11()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].wheelbarrows:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapMagic12()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].docks:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapMagic13()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["wooden stacks"]:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapMagic13()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].dirt:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

--Cursed
function DelMapCursed1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].LanternsGround:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapCursed2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].Nature:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapCursed3()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].Trees:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapCursed4()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].bushes:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapCursed5()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].LanternsSky:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapCursed6()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].deco:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapCursed7()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].dirt:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapCursed8()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].fences:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapCursed9()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].gate:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapCursed10()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].lightning:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapCursed11()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].logs:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapCursed12()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["notice boards and paper"]:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapCursed13()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].sheds:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapCursed14()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].stairs:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapCursed15()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].wheelbarrows:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapCursed16()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].cables:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

--Clover
function DelMapClover1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["misc deco"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapClover2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].dust:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapClover3()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["notice boards"]:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapClover4()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].streetlights:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapClover5()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].grass:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapClover6()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].stumps:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapClover7()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].rocks:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapClover8()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].fences:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapClover9()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].trees:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

--Cape JoJo
function DelMapJoJo1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].SpaceCenter:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapJoJo2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
				if v.Name == "trees" then v:Destroy() end
				if v.Name == "grass" then v:Destroy() end
				if v.Name == "benches" then v:Destroy() end
				if v.Name == "bushes" then v:Destroy() end
				if v.Name == "fences" then v:Destroy() end
				if v.Name == "misc" then v:Destroy() end
				if v.Name == "rockets" then v:Destroy() end
				if v.Name == "background buildings" then v:Destroy() end
				if v.Name == "paper" then v:Destroy() end
				if v.Name == "parking spots" then v:Destroy() end
				if v.Name == "barrels" then v:Destroy() end
				if v.Name == "sand bags" then v:Destroy() end
				if v.Name == "vending_machines" then v:Destroy() end
				if v.Name == "_helicopters" then v:Destroy() end
				if v.Name == "faketerrain" then v:Destroy() end
        end
    end   
end

--Fabled 7ds
function DelMap7ds1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["misc nonocollide obstacles"]:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMap7ds2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
				if v.Name == "trees" then v:Destroy() end
				if v.Name == "grass" then v:Destroy() end
				if v.Name == "Flowers" then v:Destroy() end
				if v.Name == "wood" then v:Destroy() end
				if v.Name == "flag streamers" then v:Destroy() end
				if v.Name == "bushes" then v:Destroy() end
				if v.Name == "misc noncollide no obstacle" then v:Destroy() end
				if v.Name == "fence" then v:Destroy() end
				if v.Name == "_secretthing" then v:Destroy() end
        end
    end   
end

--Hero mha

function DelMapmha1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["bridge nocollide"]:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapmha2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
				if v.Name == "trees" then v:Destroy() end
				if v.Name == "grass" then v:Destroy() end
				if v.Name == "Folder" then v:Destroy() end
				if v.Name == "Graffiti" then v:Destroy() end
				if v.Name == "street_lights" then v:Destroy() end
				if v.Name == "Assets" then v:Destroy() end
				if v.Name == "bushes" then v:Destroy() end
				if v.Name == "bricks" then v:Destroy() end
				if v.Name == "sky bridges" then v:Destroy() end
				if v.Name == "clothing" then v:Destroy() end
				if v.Name == "more" then v:Destroy() end
				if v.Name == "parking_spots" then v:Destroy() end
				if v.Name == "trash" then v:Destroy() end
				if v.Name == "vending" then v:Destroy() end
				if v.Name == "store" then v:Destroy() end
        end
    end   
end
--bleach_legend
function DelMapbleachleg1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["sand_bags"]:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapbleachleg2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
				if v.Name == "trees" then v:Destroy() end
				if v.Name == "grass" then v:Destroy() end
				if v.Name == "Folder" then v:Destroy() end
				if v.Name == "barrels" then v:Destroy() end
				if v.Name == "misc" then v:Destroy() end
				if v.Name == "benches" then v:Destroy() end
				if v.Name == "fences" then v:Destroy() end
				if v.Name == "graves" then v:Destroy() end
				if v.Name == "parking spots" then v:Destroy() end
				if v.Name == "street_lights" then v:Destroy() end
				if v.Name == "trees separatetd" then v:Destroy() end
				if v.Name == "trucks" then v:Destroy() end
        end
    end   
end

--westcity
function DelMapwestcity1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].s:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapwestcity2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
				if v.Name == "deco" then v:Destroy() end
        end
    end   
end

--uchiha
function DelMapuchiha1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["bushes and flowers"]:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapuchiha2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
				if v.Name == "grass" then v:Destroy() end
				if v.Name == "trees" then v:Destroy() end
				if v.Name == "lanterns" then v:Destroy() end
				if v.Name == "logs" then v:Destroy() end
        end
    end   
end

--demonslayer_raid_1
function DelMapdemonraid1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["snow grass"]:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapdemonraid2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
				if v.Name == "grass" then v:Destroy() end
				if v.Name == "trees" then v:Destroy() end
				if v.Name == "obstacles" then v:Destroy() end
				if v.Name == "flowers" then v:Destroy() end
        end
    end   
end

--entertain
function DelMapentertain1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["benches and barrels"]:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapentertain2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
				if v.Name == "grass" then v:Destroy() end
				if v.Name == "trees" then v:Destroy() end
				if v.Name == "Folder" then v:Destroy() end
				if v.Name == "wires" then v:Destroy() end
				if v.Name == "bushes" then v:Destroy() end
				if v.Name == "poles" then v:Destroy() end
				if v.Name == "flowers" then v:Destroy() end
				if v.Name == "gates" then v:Destroy() end
				if v.Name == "lamps" then v:Destroy() end
				if v.Name == "paper textures" then v:Destroy() end
				if v.Name == "notice boards" then v:Destroy() end
				if v.Name == "grass things" then v:Destroy() end
				if v.Name == "lanterns" then v:Destroy() end
				if v.Name == "houses outer (collision)" then v:Destroy() end
				if v.Name == "doors" then v:Destroy() end
				if v.Name == "_secret" then v:Destroy() end
        end
    end   
end
---------------------------------------------------------------------------------------
---------------------------------------------------------------
coroutine.resume(coroutine.create(function()
    while task.wait(1.5) do
        if game.PlaceId ~= 8304191830 and Settings.deletemap then
            warn("Enable Delete map")
            local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
            repeat task.wait() until game:GetService("Workspace"):WaitForChild("_map")
            if game.Workspace._map:FindFirstChild("namek mushroom model") then
				DelTer() 
				DelMapMain()
                DelMapnamekmap2()
				DelMapnamekmap3()
				DelMapnamekmap4()
				DelMapnamekmap5()
				DelMapnamekmap6()
				DelMapnamekmap7()
				DelMapnamekmap8()
				DelMapnamekmap9()
            elseif game.Workspace._map:FindFirstChild("houses_new") then
                DelTer() 
				DelMapMain()
				DelMapTitan1()
		DelMapTitan2()
		DelMapTitan3()
		DelMapTitan4()
		DelMapTitan5()
		DelMapTitan6()
		DelMapTitan7()
		DelMapTitan8()
            elseif game.Workspace._map:FindFirstChild("Snow Particles") then
                DelTer() 
				DelMapMain()
				DelMapSnowy1()
		DelMapSnowy2()
		DelMapSnowy3()
            elseif game.Workspace._map:FindFirstChild("sand_gate") then 
                DelTer() 
				DelMapMain()
				DelMapSand1()
		DelMapSand2()
		DelMapSand3()
		DelMapSand4()
            elseif game.Workspace._map:FindFirstChild("icebergs") then
                DelTer() 
				DelMapMain()
				DelMapMarine1()
		DelMapMarine2()
		DelMapMarine3()
		DelMapMarine4()
		DelMapMarine5()
		DelMapMarine6()
		DelMapMarine7()
            elseif game.Workspace._map:FindFirstChild("new buildings") then
                DelTer() 
				DelMapMain()
				DelMapGhoul1()
		DelMapGhoul2()
		DelMapGhoul3()
		DelMapGhoul4()
		DelMapGhoul5()
            elseif game.Workspace._map:FindFirstChild("Bones/dust") then
                DelTer() 
				DelMapMain()
				DelMapHollow1()
            elseif game.Workspace._map:FindFirstChild("light poles") then
                DelTer() 
				DelMapMain()
				DelMapMagic1()
		DelMapMagic2()
		DelMapMagic3()
		DelMapMagic4()
		DelMapMagic5()
		DelMapMagic6()
		DelMapMagic7()
		DelMapMagic8()
		DelMapMagic9()
		DelMapMagic10()
		DelMapMagic11()
		DelMapMagic12()
		DelMapMagic13()
            elseif game.Workspace._map:FindFirstChild("LanternsGround") then
                DelTer() 
				DelMapMain()
				DelMapCursed1()
		DelMapCursed2()
		DelMapCursed3()
		DelMapCursed4()
		DelMapCursed5()
		DelMapCursed6()
		DelMapCursed7()
		DelMapCursed8()
		DelMapCursed9()
		DelMapCursed10()
		DelMapCursed11()
		DelMapCursed12()
		DelMapCursed13()
		DelMapCursed14()
		DelMapCursed15()
		DelMapCursed16()
            elseif game.Workspace._map:FindFirstChild("pumpkins") then    
                DelTer() 
				DelMapMain() 
            elseif game.Workspace._map:FindFirstChild("sand_bags") then
                DelTer() 
				DelMapMain()
				DelMapbleachleg1()
		DelMapbleachleg2()
            elseif game.Workspace._map:FindFirstChild("vending machines") then
                DelTer() 
				DelMapMain()
            elseif game.Workspace._map:FindFirstChild("SpaceCenter") then
                DelTer() 
				DelMapMain()
				DelMapJoJo1()
		DelMapJoJo2()
            elseif game.Workspace._map:FindFirstChild("secret") then
                DelTer() 
				DelMapMain()
				DelMapAlinewires()
		DelMapAlinepaper()
		DelMapAlinetrees()
		DelMapAlinefences()
		DelMapAlinepole()
		DelMapAlinevents()
            elseif game.Workspace._map:FindFirstChild("s") then
                DelTer() 
				DelMapMain()
				DelMapwestcity1()
		DelMapwestcity2()
            elseif game.Workspace._map:FindFirstChild("bushes and flowers") then
                DelTer() 
				DelMapMain()
				DelMapuchiha1()
		DelMapuchiha2()
            elseif game.Workspace._map:FindFirstChild("snow grass") then
                DelTer() 
				DelMapMain()
				DelMapdemonraid1()
		DelMapdemonraid2()
            elseif game.Workspace._map:FindFirstChild("misc nonocollide obstacles") then
                DelTer() 
				DelMapMain()
				DelMap7ds1()
		DelMap7ds2()
            elseif game.Workspace._map:FindFirstChild("bridge nocollide") then
                DelTer() 
				DelMapMain()
				DelMapmha1()
		DelMapmha2()
            elseif game.Workspace._map:FindFirstChild("benches and barrels") then
                DelTer() 
				DelMapMain()
				DelMapentertain1()
		DelMapentertain2()
        elseif game.Workspace._map:FindFirstChild("Ant Nest") then
                DelTer() 
                DelMapAnt()
				DelMapAnt1()
		DelMapAnt2()
		DelMapAnt3()
		DelMapAnt4()
		DelMapAnt5()
		DelMapAnt6()
		DelMapAnt7()
		DelMapAnt8()
		DelMapAnt9()
		DelMapAnt10()
		DelMapAnt11()
		DelMapAnt12()
            elseif game.Workspace._map["misc deco"]:FindFirstChild("bushes") then
                DelTer() 
				DelMapMain()
				DelMapClover1()
		DelMapClover2()
		DelMapClover3()
		DelMapClover4()
		DelMapClover5()
		DelMapClover6()
		DelMapClover7()
		DelMapClover8()
		DelMapClover9()
            end
        end
    end
end))


--hide name
function hidename()
task.spawn(function()  -- Hides name for yters (not sure if its Fe)
    while task.wait() do
        pcall(function()
            if game.Players.LocalPlayer.Character.Head:FindFirstChild("_overhead") then
                game.Players.LocalPlayer.Character.Head:FindFirstChild("_overhead"):Destroy()
            end
        end)
    end
end)
end
if Settings.hidenamep then
    hidename()
end

--Auto Grab Daily Quest
function autoDailyquest()
    if Settings.autoDailyquest then
         game:GetService("ReplicatedStorage").endpoints.client_to_server.accept_npc_quest:InvokeServer("7ds_daily")
         wait(15)
    end
end

if Settings.autoDailyquest then
    autoDailyquest()
end

-- added by craymel02
function escanorIR()
    if Settings.escanorIR == nil then
        Settings.escanorIR = false
        else
            loadstring(game:HttpGet("https://raw.githubusercontent.com/ArponAG/Scripts/main/dontDelete-IR.lua"))()
    end
end

--placeany
function placeAny()

    local services = require(game.ReplicatedStorage.src.Loader)
    local placement_service = services.load_client_service(script, "PlacementServiceClient")
    
        task.spawn(function()
            while task.wait() do
                placement_service.can_place = true
            end
        end)
    end


function placeunittwin() 
    if game.Workspace:WaitForChild("_UNITS") then
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v.Name == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v.Name:FindFirstChild("_hitbox") then
            v:Destroy() end
            end
        end
    end
    
    if Settings.placeany then
        placeAny()
        placeunittwin() 
    end

--ReedemCode
function Reedemcode()
    codes = {"TWOMILLION","subtomaokuma","CHALLENGEFIX","GINYUFIX","RELEASE","SubToKelvingts","SubToBlamspot","KingLuffy","TOADBOIGAMING","noclypso","FictioNTheFirst","GOLDENSHUTDOWN","GOLDEN"
    ,"SINS2","subtosnowrbx","Cxrsed","subtomaokuma","VIGILANTE","HAPPYEASTER","ENTERTAINMENT"}
        for _, v in pairs(codes) do
        pcall(function() game:GetService("ReplicatedStorage").endpoints["client_to_server"]["redeem_code"]:InvokeServer(v)()    end)
    end
end

if Settings.redeemc then
    Reedemcode()
end

pcall(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
    game:GetService("ReplicatedStorage").endpoints.client_to_server.claim_daily_reward:InvokeServer()
    warn("Anti-AFK Loaded!!!")
end)

--disms
if game.PlaceId ~= 8304191830 then
    game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error.Volume = 0
    game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error_old.Volume = 0
    game.Players.LocalPlayer.PlayerGui.MessageGui.Enabled = false --disables the annoying error messages 

end
--disms
if game.PlaceId == 8304191830 then
    game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error.Volume = 0
    game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error_old.Volume = 0
    game.Players.LocalPlayer.PlayerGui.MessageGui.Enabled = false --disables the annoying error messages 
end
warn("Display Error Hider!!!")
warn("Hider Name Loaded!!!")
warn("AA v2 Loaded!!!")
warn("All Loaded !!!")
escanorIR() -- added by craymel02
