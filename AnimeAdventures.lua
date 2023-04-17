  -- Game Version Variable 
  local version = "v2.0.0b32"

  -- Start of Local Global Variables
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")
local plr = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local mouse = game.Players.LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")
  -- End of Local Variables
  
  -- Start of Loading Section
repeat  task.wait() until game:IsLoaded()
if game.PlaceId == 8304191830 then
    repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("collection"):FindFirstChild("grid"):FindFirstChild("List"):FindFirstChild("Outer"):FindFirstChild("UnitFrames")
else
    repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    game:GetService("ReplicatedStorage").endpoints.client_to_server.vote_start:InvokeServer()
    repeat task.wait() until game:GetService("Workspace")["_waves_started"].Value == true
end
  -- End of Loading Section
  
  -- Start of Save and Read Settings Function
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
  -- End of Save and Read Function
  
    -- Start of Get Level Data of Map [Added by craymel02 --newfix]
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

  -- Item Drop Result
local loader = require(game.ReplicatedStorage.src.Loader)
local ItemInventoryServiceClient = loader.load_client_service(script, "ItemInventoryServiceClient")
  
function get_inventory_items_unique_items()
	return ItemInventoryServiceClient["session"]['inventory']['inventory_profile_data']['unique_items']
end

function get_inventory_items()
	return ItemInventoryServiceClient["session"]["inventory"]['inventory_profile_data']['normal_items']
end

function get_Units_Owner()
	return ItemInventoryServiceClient["session"]["collection"]["collection_profile_data"]['owned_units']
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
  -- End of Item Drop Result
  
  -- Start of Comma Value Function
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
  -- End of Webhook Function
  
getgenv().item = "-"
plr.PlayerGui:FindFirstChild("HatchInfo"):FindFirstChild("holder"):FindFirstChild("info1"):FindFirstChild("UnitName").Text = getgenv().item

  -- Start of Webhook Function
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
            levelname = GLD().name
            result = ResultHolder.Title.Text
            else
                levelname, result = "nil","nil"
        end
        
        if result == "VICTORY" then
            result = "VICTORY"
        end
            
        if result == "DEFEAT" then
            result = "DEFEAT"
        end
        
        _map = game:GetService("Workspace")["_BASES"].player.base["fake_unit"]:WaitForChild("HumanoidRootPart")
        cwaves = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.WavesCompleted.Text
	    ctime = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.Timer.Text
        waves = cwaves:split(": ")
        
        if waves ~= nil and waves[2] == "999" then
            waves[2] = "Use [Auto Leave at Wave] or [Test Webhook]"
        end	
        
	    ttime = ctime:split(": ")
        if waves ~= nil and ttime[2] == "22:55" then
            ttime[2] = "Use [Auto Leave at Wave] or [Test Webhook]"
        end
        
        gold = ResultHolder:FindFirstChild("LevelRewards"):FindFirstChild("ScrollingFrame"):FindFirstChild("GoldReward"):FindFirstChild("Main"):FindFirstChild("Amount").Text
        if gold == "+99999" then
            gold = "+0"
        end
        
        gems = ResultHolder:FindFirstChild("LevelRewards"):FindFirstChild("ScrollingFrame"):FindFirstChild("GemReward"):FindFirstChild("Main"):FindFirstChild("Amount").Text
        if gems == "+99999" then
            gems = "+0"
        end
        
        xpx = ResultHolder:FindFirstChild("LevelRewards"):FindFirstChild("ScrollingFrame"):FindFirstChild("XPReward"):FindFirstChild("Main"):FindFirstChild("Amount").Text
        xp = xpx:split(" ")
        if xp[1] == "+99999" then
            xp[1] = "+0"
        end
    
        trophy = ResultHolder:FindFirstChild("LevelRewards"):FindFirstChild("ScrollingFrame"):FindFirstChild("TrophyReward"):FindFirstChild("Main"):FindFirstChild("Amount").Text
        if trophy == "+99999" then
            trophy = "+0"
        end
        
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
                                ["value"] = " ```ini\nWorld : "..GLD().name.. " 🌏\nMap : "..GLD().map.. " 🗺️\nResults : "..result.. " ⚔️\nWave End : " ..tostring(waves[2]).." 🌊\nTime : " ..tostring(ttime[2]).." ⌛```",
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
  -- Endt of Webhook Function
  
  -- Start of Baby Webhook Function
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
    -- Start of Baby Webhook Function
    
    -- Start of Snipe Shop Function
function SnipeShopNew()
    if Settings.snipeWebhookEnabled then
        pcall(function() 
            SpecialSummonSniperWebhook()
            StandardSummonSniperWebhook()
            ShopSniperWebhook()
        end)
    end
end
    -- End of Snipe Shop Function
    
    -- Start of Special Summon Webhook
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
    -- End of Special Summon Webhook Function

    -- Start of Standard Summon Webhook Function
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
            UP1 = units[1].petimage.WorldModel:GetChildren()[1].Name
            UP2 = units[2].petimage.WorldModel:GetChildren()[1].Name
            UP3 = units[3].petimage.WorldModel:GetChildren()[1].Name
            UP4 = units[4].petimage.WorldModel:GetChildren()[1].Name
            UP5 = units[5].petimage.WorldModel:GetChildren()[1].Name
            UP6 = units[6].petimage.WorldModel:GetChildren()[1].Name
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
    -- End of Standard Summon Webhook Function

    -- Start of Bulma Shop Webhook Function
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
    -- End of Bulma Shop Webhook Function

    -- Start of User Interface
if game.CoreGui:FindFirstChild("FinityUI") then
    game.CoreGui["FinityUI"]:Destroy()
end
local dir = "Anime_Adventures/"..game.Players.LocalPlayer.Name
local Uilib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ArponAG/Scripts/main/finitylib"))()
local exec = tostring(identifyexecutor())
local Window = Uilib.new(true, "Anime Adventures "..version.." - "..exec)
Window.ChangeToggleKey(Enum.KeyCode.RightControl)

    -- Start of Script Upgrade Sector
local Script = Window:Category(" Script Update")
local Update = Script:Sector("Script Update")
local asdasd = Script:Sector("")
local ScriptUpdate = Script:Sector("Code Changes by craymel02 ")
    -- End of Script Update Sector
    
    -- Start of Home Sector
local Home = Window:Category(" 📋 Home")
local Developers = Home:Sector("Anime Adventures")
local asdasd = Home:Sector(" ")
local UIUPDT = Home:Sector("UI UPDATE (February 20th)")
    -- End of Home Sector
    
    -- Start of Farm Sector
local Farm = Window:Category(" 🏹 Auto Farm")
local SelectUnits = Farm:Sector("Units Selection")
local SelectWorld = Farm:Sector("World Selection")
local UnitPosition = Farm:Sector("Select Unit Position")
local MoreFarmConfig = Farm:Sector("Infinity Castle Config")
local AutoFarmConfig = Farm:Sector("Auto Farm Config")
local GenerateConfig = Farm:Sector("Generate Default Config")
local AutoFarmEmpty1 = Farm:Sector(" ")
local ChallengeConfig = Farm:Sector("Challenge Config")

    -- End of Farm Sector
    
    -- Start of User Config Sector
local UC = Window:Category(" 👥 Unit Config")
local NDY = UC:Sector("Map Unit Config ")
local NDY2 = UC:Sector("Reset Map Unit Config ")
local emptyxx = UC:Sector(" ")
local emptyxx2 = UC:Sector(" ")
    -- Changed by craymel02 --newfix
local Unit = {}
for i = 1, 6, 1 do
    Unit["Unit" .. i] = UC:Sector("Unit " .. i)
end
    -- End
local empytyxx3 = UC:Sector(" ")
local empytyxx4 = UC:Sector(" ")
local SaveConfig = UC:Sector("Save Map Unit Config")
local NDY3 = UC:Sector("Check Deployed Unit")
    -- End of User Config Sector
    
    -- Start of Misc Sector
local Misc = Window:Category(" 🛠 Misc")
local AutoSummonSec = Misc:Sector("Auto Summon Units")
local AutoSnipeMerchantSec = Misc:Sector("Auto Snipe Merchant")
local WebhookSec = Misc:Sector("Discord Webhook")
    -- End of Misc Sector
    
    -- Start of Lag Sector
local LG = Window:Category("🛠️ OTHER [BETA]")
local LG1 = LG:Sector("Beta LAGGY Config ")
local OtherSec = LG:Sector("Other Options")
local OtherSec2 = LG:Sector("")
local reFarmConfig = LG:Sector("")
    -- End of Lag Sector
    -- End of User Interface

    -- Start of Unit Section Function [Changed by craymel02 --newfix]
local function UnitSec()
    SelectUnits:Cheat("Checkbox","🦸 Auto Save Unit  ", function(bool)
        if Settings.Craymel == nil then
            warn("Generate Preset First!")
            else
                warn("Auto Save Unit set to " .. tostring(bool))
                Settings.AutoSaveUnit = bool
                saveSettings()
        end
    end,{enabled = Settings.AutoSaveUnit })
end
    -- End of Unit Section Function
    
    -- Start of Auto Save Unit Function [Added by craymel02 --newfix]
local function AutoSaveUnit()
    
    -- Generate Selected Unit Parameters
    if Settings.SelectedUnits == nil then
        Settings.SelectedUnits = {}
        for i = 1, 6, 1 do
            Settings.SelectedUnits["UP" .. i] = "nil"
        end
        
        else
            -- Reset Selected Unit List to nil
            for i = 1, 6, 1 do
                Settings.SelectedUnits["UP" .. i] = "nil"
            end
    end
            
    -- Transfer Equipped Units to Selected Unit List and Save to JSON
    for i, v in pairs(getgenv().profile_data.equipped_units) do
        if v.equipped_slot then
            Settings.SelectedUnits["UP" .. tostring(v.equipped_slot)] = tostring(v.unit_id) .. " #" .. tostring(v.uuid)
            print("UP" .. tostring(v.equipped_slot) .. " " .. tostring(v.unit_id) .. " #" .. tostring(v.uuid))
        end
    end
    saveSettings()
end

coroutine.resume(coroutine.create(function()
    while task.wait(1.5) do
        if game.PlaceId == 8304191830 and Settings.AutoSaveUnit then
            
            getgenv().profile_data = { 
                equipped_units = {}
            }
            
            -- Fetch Unit List
            for i, v in pairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "xp") then
                    wait()
                    table.insert(getgenv().profile_data.equipped_units, v)
                end
            end
            
            -- Generate Selected Unit Parameters
            if Settings.SelectedUnits == nil then
                Settings.SelectedUnits = {}
                for i = 1, 6, 1 do
                    Settings.SelectedUnits["UP" .. i] = "nil"
                end
            end

            -- Generate Compare List Parameters
            EquippedList = {}
            table.clear(EquippedList)
            
            for i = 1, 6, 1 do
                EquippedList["UP" .. i] = "nil"
            end
            
            -- Filter Fetched Unit to List Equipped Units Only
            for i, v in pairs(getgenv().profile_data.equipped_units) do
                if v.equipped_slot then
                    EquippedList["UP" .. v.equipped_slot] = tostring(v.unit_id) .. " #" .. tostring(v.uuid)
                end
            end
            
            -- If Equipped Slot in Empty, Put "nil"
            for i = 1, 6, 1 do
				if EquippedList["UP"..i] == nil then
					EquippedList["UP"..i] = "nil"
				end
			end
            
            -- Compared Current List to Saved JSON List if not the same then call AutoSave Function
            for i = 1, 6, 1 do
                if EquippedList["UP"..i] ~= Settings.SelectedUnits["UP"..i] then
                    AutoSaveUnit()
                end
            end
        end
    end
end))
    -- End of Auto Save Unit Function
    
    -- Start of World Section Function
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
            "Ghoul City", "Hollow World", "Ant Kingdom", "Magic Town", "Cursed Academy","Clover Kingdom","Cape Canaveral", "Alien Spaceship","Fabled Kingdom",
            "Hero City"}
        elseif Settings.WorldCategory == "Legend Stages" then
            storylist = {"Clover Kingdom (Elf Invasion)", "Hollow Invasion","Cape Canaveral (Legend)", "Fabled Kingdom (Legend)", "Hero City (Midnight)"}
        elseif Settings.WorldCategory == "Raid Worlds" then
            storylist = {"Storm Hideout","West City", "Infinity Train", "Shiganshinu District - Raid","Hiddel Sand Village - Raid", "Freezo's Invasion"}
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
        
        -- Start of Story Worlds
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
        -- End of Story Worlds
        
        -- Start of Legend World
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
        -- End of Legend World
        
        -- Start of Raid World
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
        -- End of Raid World
        
        -- Start of Portal World
        elseif level == "Alien Portals" then
            levellist = {"portal_boros_g"}
        elseif level == "Demon Portals" then
            levellist = {"april_portal_item"}
        elseif level == "Zeldris Portals" then
            levellist = {"portal_zeldris"}
        -- End of Portal World
        
        -- Start of Dungeon World
        elseif level == "Cursed Womb" then
            levellist = {"jjk_finger"} 
        elseif level == "Crused Parade" then
            levellist = {"jjk_raid"} 
        -- End of Portal World
        
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
        warn("Friends only set to " .. tostring(bool))
        Settings.isFriendOnly = bool
        saveSettings()
    end,{enabled = Settings.isFriendOnly})
end
    -- End of World Section Function
    
    -- Start of Auto Farm Function
local function AutoFarmSec()
    
    AutoFarmConfig:Cheat("Checkbox","🌾 Auto Start  ", function(bool)
        warn("Auto Start set to " .. tostring(bool))
        Settings.autostart = bool
        saveSettings()
    end,{enabled = Settings.autostart })
    
    AutoFarmConfig:Cheat("Checkbox","👨‍🌾 Auto Place unit  ", function(bool)
        warn("Auto Place Unit set to " .. tostring(bool))
        if Settings.unitconfig == true then
            Settings.unitconfig = false
            Settings.AutoFarm = bool
            saveSettings()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/ArponAG/Scripts/main/AnimeAdventures.lua'))()
            else
                Settings.AutoFarm = bool
                saveSettings()  
        end
    end,{enabled = Settings.AutoFarm})
    
    AutoFarmConfig:Cheat("Checkbox","🏃 Auto Replay  ", function(bool)
        warn("Auto Replace set to " .. tostring(bool))
        Settings.AutoReplay = bool
        saveSettings()
    end,{enabled = Settings.AutoReplay})
    
    AutoFarmConfig:Cheat("Checkbox","🏃 Auto Next Story  ", function(bool)
        warn("Auto Next Story is set to" .. tostring(bool))
        Settings.AutoNext = bool
        saveSettings()
    end,{enabled = Settings.AutoNext})
    AutoFarmConfig:Cheat("Checkbox","🏃 Auto Leave  ", function(bool)
        warn("Auto Leave is set to " .. tostring(bool))
        Settings.AutoLeave = bool
        saveSettings()
    end,{enabled = Settings.AutoLeave})
    
    AutoFarmConfig:Cheat("Checkbox","🔥 Auto Abilities  ", function(bool)
        warn("Auto Abilities is set to " .. tostring(bool))
        Settings.AutoAbilities = bool
        saveSettings()
    end,{enabled = Settings.AutoAbilities})
    
    AutoFarmConfig:Cheat("Checkbox","⭐️ Auto Upgrade Units  ", function(bool)
        warn("Auto Upgrade Units is set to " .. tostring(bool))
        if Settings.unitconfig == true then
            Settings.unitconfig = false
            Settings.AutoUpgrade = bool
            saveSettings()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/ArponAG/Scripts/main/AnimeAdventures.lua'))()
            else
                Settings.AutoUpgrade = bool
                saveSettings()
        end
    end,{enabled = Settings.AutoUpgrade})
    
    AutoFarmConfig:Cheat("Checkbox","⭐️ Sell Units At Wave  ", function(bool)
        warn("Sell Units at Wave is set to " .. tostring(bool))
        Settings.AutoSell = bool
        saveSettings()
    end,{enabled = Settings.AutoSell})
    
    AutoFarmConfig:Cheat("Checkbox","⭐️ Leave At Wave  ", function(bool)
        warn("Leave at Wave is set to " .. tostring(bool))
        Settings.autoQuit = bool
        saveSettings()
    end,{enabled = Settings.autoQuit})
    
    AutoFarmConfig:Cheat("Textbox", "Sell or Leave at Wave", function(Value)
        Value = tonumber(Value)
        Settings.AutoSellWave = Value
        saveSettings()
    end, {placeholder = Settings.AutoSellWave})
end
    -- End of Auto Farm Function
    
    -- Start of Generate Default Config Function [Added by craymel02 --newfix] --fixmap updatefix
local function GenerateConfigSec()
    
    -- Button to Generate Presets
    GenerateConfig:Cheat("Button", "Generate Preset", function()
        local List = {
            mapName = { "namek_cartoon", "aot", "aot_raid",  "demonslayer", "demonslayer_raid", "naruto", "naruto_raid", "marineford", "tokyo_ghoul", "hueco", "karakura", "karakura2", "hxhant", "magnolia", "jjk", "jjk_finger", "jjk_movie", "hage", "hage_elf", "hage_elf_night", "space_center", "boros_ship", "boros_ship_portal", "7ds_map", "7ds_map_night", "7ds_map_cube", "mha_city", "mha_city_night", "west_city", "west_city_frieza", "uchiha_hideout" },
            namek_cartoon = { x = { -2946.84326171875, -2952.96630859375, -2956.689208984375, -2949.5947265625, -2950.063720703125, -2925.678466796875 }, y = { 91.80620574951172, 91.80626678466797, 91.80620574951172, 94.418701171875, 94.41859436035156, 91.80626678466797 }, z = { -704.13720703125, -703.6069946289063, -713.2991943359375, -717.70849609375, -722.2648315429688, -708.7808837890625 }, x2 = { -2948.34326171875, -2954.46630859375, -2955.189208984375, -2948.0947265625, -2948.563720703125, -2924.178466796875 }, z2 = { 705.63720703125, -705.1069946289063, -711.7991943359375, -716.20849609375, -720.7648315429688, -707.2808837890625 }, x3 = { 0, 0, -2958.189208984375, -2951.0947265625, -2951.563720703125, -2927.178466796875}, z3 = { -702.63720703125, -702.1069946289063, 0, 0, 0, 0 } },
            aot = { x = { -3017.777587890625, -3031.092529296875, -3007.949462890625, -3015.591552734375, -3025.455810546875, -3002.1298828125 }, y = { 33.741798400878909, 33.741798400878909, 33.741798400878909, 38.415435791015628, 38.415523529052737, 33.741798400878909 }, z = { -685.0457153320313, -680.9754638671875, -689.5368041992188, -689.7804565429688, -677.5512084960938, -689.7681884765625 }, x2 = { -3016.277587890625, -3029.592529296875, -3009.449462890625, -3014.091552734375, -3023.955810546875, -3003.6298828125 }, z2 = { -683.5457153320313, -679.4754638671875, -691.0368041992188, -688.2804565429688, -676.0512084960938, -691.2681884765625 }, x3 = { -3019.277587890625, -3032.592529296875, 0, -3017.091552734375, -3026.955810546875, 0}, z3 = { 0, 0, -688.0368041992188, 0, 0, -688.2681884765625 } },
            aot_raid = { x = { -3017.777587890625, -3031.092529296875, -3007.949462890625, -3015.591552734375, -3025.455810546875, -3002.1298828125 }, y = { 33.741798400878909, 33.741798400878909, 33.741798400878909, 38.415435791015628, 38.415523529052737, 33.741798400878909 }, z = { -685.0457153320313, -680.9754638671875, -689.5368041992188, -689.7804565429688, -677.5512084960938, -689.7681884765625 }, x2 = { -3016.277587890625, -3029.592529296875, -3009.449462890625, -3014.091552734375, -3023.955810546875, -3003.6298828125 }, z2 = { -683.5457153320313, -679.4754638671875, -691.0368041992188, -688.2804565429688, -676.0512084960938, -691.2681884765625 }, x3 = { -3019.277587890625, -3032.592529296875, 0, -3017.091552734375, -3026.955810546875, 0}, z3 = { 0, 0, -688.0368041992188, 0, 0, -688.2681884765625 } },
            demonslayer = { x = { -2876.974365234375, -2866.85400390625, -2885.764404296875, -2878.218017578125, -2872.7646484375, -2863.0634765625 }, y = { 34.34697723388672, 34.34697723388672, 34.34697723388672, 40.14086151123047, 37.249019622802737, 34.34697723388672 }, z = { -141.95619201660157, -129.80557250976563, -136.89683532714845, -123.6778335571289, -150.0395050048828, -139.5249481201172 }, x2 = { -2875.474365234375, -2868.35400390625, -2884.264404296875, -2876.718017578125, -2871.2646484375, -2861.5634765625  }, z2 = { -140.45619201660157, -131.30557250976563, -135.39683532714845, -122.1778335571289, -148.5395050048828, -138.0249481201172  }, x3 = { -2878.474365234375, 0, -2887.264404296875, -2879.718017578125, -2874.2646484375, -2864.5634765625 }, z3 = { 0, 128.30557250976563, 0, 0, 0, 0 } },
            demonslayer_raid = { x = { 9.09304428100586, 20.264118194580079, 15.20931625366211, 1.2340185642242432, 5.172037124633789, 18.899681091308595 }, y = { -15.077808380126954, -15.077808380126954, -15.077808380126954, -10.02004337310791, -10.01991081237793, -15.077808380126954 }, z = { 356.9061279296875, 356.9004821777344, 347.44866943359377, 352.18994140625, 348.19866943359377, 341.4800109863281 }, x2 = { 10.59304428100586, 21.764118194580079, 16.70931625366211, -0.26598143577575686, 3.672037124633789, 20.399681091308595 }, z2 = { 358.4061279296875, 358.4004821777344, 348.94866943359377, 350.68994140625, 346.69866943359377, 342.9800109863281 }, x3 = { 7.593044281005859, 18.764118194580079, 13.70931625366211, 0, 0, 17.399681091308595 }, z3 = { 0, 0, 0, 353.68994140625, 349.69866943359377, 0 } },
            naruto = { x = { -889.2205200195313, -888.6320190429688, -889.1079711914063, -894.744384765625, -878.783447265625, -872.76513671875 }, y = { 25.28095054626465, 25.2810115814209, 25.28095054626465, 29.568687438964845, 31.977264404296876, 25.28095054626465 }, z = { 314.2640380859375, 331.6134033203125, 308.0033874511719, 319.7415771484375, 327.37158203125, 319.4495849609375 }, x2 = { -890.7205200195313, -890.1320190429688, -887.6079711914063, -893.244384765625, -877.283447265625, -871.26513671875 }, z2 = { 312.7640380859375, 330.1134033203125, 309.5033874511719, 321.2415771484375, 328.87158203125, 320.9495849609375 }, x3 = { 0, 0, -890.6079711914063, -896.244384765625, -880.283447265625, -874.26513671875 }, z3 = { 315.7640380859375, 333.1134033203125, 0, 0, 0, 0 } },
            naruto_raid = { x = { -889.2205200195313, -888.6320190429688, -889.1079711914063, -894.744384765625, -878.783447265625, -872.76513671875 }, y = { 25.28095054626465, 25.2810115814209, 25.28095054626465, 29.568687438964845, 31.977264404296876, 25.28095054626465 }, z = { 314.2640380859375, 331.6134033203125, 308.0033874511719, 319.7415771484375, 327.37158203125, 319.4495849609375 }, x2 = { -890.7205200195313, -890.1320190429688, -887.6079711914063, -893.244384765625, -877.283447265625, -871.26513671875 }, z2 = { 312.7640380859375, 330.1134033203125, 309.5033874511719, 321.2415771484375, 328.87158203125, 320.9495849609375 }, x3 = { 0, 0, -890.6079711914063, -896.244384765625, -880.283447265625, -874.26513671875 }, z3 = { 315.7640380859375, 333.1134033203125, 0, 0, 0, 0 } },
            marineford = { x = { -2556.0234375, -2541.921875, -2565.731201171875, -2572.805908203125, -2532.50341796875, -2533.038330078125 }, y = { 25.210872650146486, 25.210433959960939, 25.210872650146486, 29.5009708404541, 28.05718231201172, 25.210681915283204 }, z = { -42.729034423828128, -35.58897399902344, -50.93398666381836, -46.2156982421875, -47.573158264160159, -61.026432037353519 }, x2 = { -2554.5234375, -2540.421875, -2567.231201171875, -2571.305908203125, -2534.00341796875, -2534.538330078125 }, z2 = { -41.229034423828128, -34.08897399902344 -52.43398666381836, -44.7156982421875, -49.073158264160159, -62.526432037353519 }, x3 = { -2557.5234375, -2543.421875, 0, -2574.305908203125, 0 , 0 }, z3 = { 0, 0, -49.43398666381836, 0, -46.073158264160159, -59.526432037353519 } },
            tokyo_ghoul = { x = { -2989.63671875, -2976.4716796875, -2992.599609375, -2984.528564453125, -2986.096923828125, -3012.58837890625 }, y = { 58.58513259887695, 58.58513259887695, 58.58513259887695, 66.70178985595703, 66.70178985595703, 58.58513259887695 }, z = { -44.11449432373047, -43.793792724609378, -38.14506530761719, -55.116825103759769, -58.42613220214844, -41.3155517578125 }, x2 = { -2988.13671875, -2974.9716796875, -2991.099609375, -2983.028564453125, -2987.596923828125, -3011.08837890625 }, z2 = { -42.61449432373047, -42.293792724609378, -36.64506530761719, -53.616825103759769, -59.92613220214844, -39.8155517578125 }, x3 = { -2991.13671875, -2977.9716796875, -2994.099609375, -2986.028564453125, 0, -3014.08837890625 }, z3 = { 0, 0, 0, 0, -56.92613220214844, 0 } },
            hueco = { x = { -189.75897216796876, -196.88162231445313, -190.33316040039063, -184.47911071777345, -182.0676727294922, -202.5495147705078 }, y = { 132.6757354736328, 132.67581176757813, 132.67581176757813, 136.34059143066407, 136.34059143066407, 132.67581176757813 }, z = { -778.08447265625, -778.7015380859375, -770.4833984375, -764.2044677734375, -759.4566040039063, -770.345947265625 }, x2 = { -191.25897216796876, -198.38162231445313, -191.83316040039063, -185.97911071777345, -183.5676727294922, -204.0495147705078 }, z2 = { -779.58447265625, -780.2015380859375, -771.9833984375, -765.7044677734375, -760.9566040039063, -771.845947265625 }, x3 = { 0, 0, 0, 0, 0, 0 }, z3 = { -776.58447265625, -777.2015380859375, -768.9833984375, -762.7044677734375, -757.9566040039063, -768.845947265625 } },
            karakura = { x = { -208.658447265625, -227.95199584960938, -220.17013549804688, -211.65792846679688, -211.9404296875, -159.7929229736328 }, y = { 36.04336166381836, 36.04336166381836, 36.04336166381836, 46.0349006652832, 46.0349006652832, 36.0435791015625 }, z = { 573.4151000976563, 585.2230224609375, 571.9835205078125, 583.6078491210938, 587.3704223632813, 579.3244018554688 }, x2 = { -207.158447265625, -229.45199584960938, -221.67013549804688, -210.15792846679688, -210.4404296875, -158.2929229736328 }, z2 = { 574.9151000976563, 583.7230224609375, 570.4835205078125, 585.1078491210938, 588.8704223632813, 580.8244018554688 }, x3 = { -210.158447265625, 0, 0, -213.15792846679688, -213.4404296875, -161.2929229736328 }, z3 = { 0, 586.7230224609375, 573.4835205078125, 0, 0, 0 } },
            karakura2 = { x = { -208.658447265625, -227.95199584960938, -220.17013549804688, -211.65792846679688, -211.9404296875, -159.7929229736328 }, y = { 36.04336166381836, 36.04336166381836, 36.04336166381836, 46.0349006652832, 46.0349006652832, 36.0435791015625 }, z = { 573.4151000976563, 585.2230224609375, 571.9835205078125, 583.6078491210938, 587.3704223632813, 579.3244018554688 }, x2 = { -207.158447265625, -229.45199584960938, -221.67013549804688, -210.15792846679688, -210.4404296875, -158.2929229736328 }, z2 = { 574.9151000976563, 583.7230224609375, 570.4835205078125, 585.1078491210938, 588.8704223632813, 580.8244018554688 }, x3 = { -210.158447265625, 0, 0, -213.15792846679688, -213.4404296875, -161.2929229736328 }, z3 = { 0, 586.7230224609375, 573.4835205078125, 0, 0, 0 } },
            hxhant = { x = { -183.8934783935547, -197.2936553955078, -176.1630859375, -194.78488159179688, -190.43893432617188, -181.25576782226563 }, y = { 23.01272201538086, 23.01266098022461, 23.01266098022461, 27.207609176635743, 27.20767593383789, 23.01266098022461 }, z = { 2964.96484375, 2967.570068359375, 2961.736083984375, 2952.7900390625, 2952.042724609375, 2955.1962890625 }, x2 = { -182.3934783935547, -195.7936553955078, -174.6630859375, -196.28488159179688, 191.93893432617188, -179.75576782226563 }, z2 = { 2966.46484375, 2963.236083984375, 2969.070068359375, 2951.2900390625, 2950.542724609375, 2956.6962890625 }, x3 = { -185.3934783935547, -198.7936553955078, -177.6630859375, 0, 0, -182.75576782226563 }, z3 = { 0, 0, 0, 2954.2900390625, 2953.542724609375, 0 } },
            magnolia = { x = { -602.307861328125, -586.4151611328125, -605.9909057617188, -588.258056640625, -594.2775268554688, -601.6142578125 }, y = { 6.749922275543213, 6.749922275543213, 6.75148868560791, 15.392382621765137, 15.342145919799805, 6.74130916595459 }, z = { -819.2137451171875, -819.3541259765625, -812.6162109375, -825.6058349609375, -825.56005859375, -858.0172119140625 }, x2 = { -600.807861328125, -584.9151611328125, -604.4909057617188, -586.758056640625, -592.7775268554688, -600.1142578125 }, z2 = { -817.7137451171875, -817.8541259765625, -811.1162109375, -824.1058349609375, -824.06005859375, -856.5172119140625 }, x3 = { -603.807861328125, -587.9151611328125, -607.4909057617188, -589.758056640625, -595.7775268554688, -603.1142578125 }, z3 = { 0, 0, 0, 0, 0, 0 } },
            jjk = { x = { 375.7139892578125, 386.5697937011719, 367.2964782714844, 407.857421875, 403.7784729003906, 374.1256408691406 }, y = { 121.92500305175781, 121.91753387451172, 121.93086242675781, 125.16596221923828, 125.1658935546875, 121.92611694335938 }, z = { -66.64131164550781, -59.928611755371097, -60.130775451660159, -75.4776611328125, -74.64833068847656, -55.56648635864258 }, x2 = { 377.2139892578125, 388.0697937011719, 368.7964782714844, 406.357421875, 402.2784729003906, 375.6256408691406 }, z2 = { -65.14131164550781, -58.428611755371097, -58.630775451660159, -76.9776611328125, -76.14833068847656, -54.06648635864258 }, x3 = { 374.2139892578125, 385.0697937011719, 365.7964782714844, 0, 0, 372.6256408691406 }, z3 = { 0, 0, 0, -73.9776611328125, -73.14833068847656, 0 } },
            jjk_finger = { x = { 375.7139892578125, 386.5697937011719, 367.2964782714844, 407.857421875, 403.7784729003906, 374.1256408691406 }, y = { 121.92500305175781, 121.91753387451172, 121.93086242675781, 125.16596221923828, 125.1658935546875, 121.92611694335938 }, z = { -66.64131164550781, -59.928611755371097, -60.130775451660159, -75.4776611328125, -74.64833068847656, -55.56648635864258 }, x2 = { 377.2139892578125, 388.0697937011719, 368.7964782714844, 406.357421875, 402.2784729003906, 375.6256408691406 }, z2 = { -65.14131164550781, -58.428611755371097, -58.630775451660159, -76.9776611328125, -76.14833068847656, -54.06648635864258 }, x3 = { 374.2139892578125, 385.0697937011719, 365.7964782714844, 0, 0, 372.6256408691406 }, z3 = { 0, 0, 0, -73.9776611328125, -73.14833068847656, 0 } },
            jjk_movie = { x = { 375.7139892578125, 386.5697937011719, 367.2964782714844, 407.857421875, 403.7784729003906, 374.1256408691406 }, y = { 121.92500305175781, 121.91753387451172, 121.93086242675781, 125.16596221923828, 125.1658935546875, 121.92611694335938 }, z = { -66.64131164550781, -59.928611755371097, -60.130775451660159, -75.4776611328125, -74.64833068847656, -55.56648635864258 }, x2 = { 377.2139892578125, 388.0697937011719, 368.7964782714844, 406.357421875, 402.2784729003906, 375.6256408691406 }, z2 = { -65.14131164550781, -58.428611755371097, -58.630775451660159, -76.9776611328125, -76.14833068847656, -54.06648635864258 }, x3 = { 374.2139892578125, 385.0697937011719, 365.7964782714844, 0, 0, 372.6256408691406 }, z3 = { 0, 0, 0, -73.9776611328125, -73.14833068847656, 0 } },
            hage = { x = { -180.36825561523438, -177.1717071533203, -173.03878784179688, -195.64593505859376, -200.85484313964845, -193.666015625 }, y = { 1.2331171035766602, 1.2332146167755128, 1.2332146167755128, 4.4963154792785648, 4.496399402618408, 1.2331171035766602 }, z = { -10.433639526367188, 3.757843017578125, -8.885513305664063, 13.009081840515137, 13.762968063354493, -14.195465087890625 }, x2 = { -181.86825561523438, -178.6717071533203, -174.53878784179688, -197.14593505859376, -202.35484313964845, -192.166015625 }, z2 = { -11.933639526367188, 2.257843017578125, -10.385513305664063, 11.509081840515137, 12.262968063354493, -12.695465087890625 }, x3 = { 0, 0, 0, 0, 0, -195.166015625 }, z3 = { -8.933639526367188, 5.257843017578125, -7.3855133056640629, 14.509081840515137, 15.262968063354493, 0} },
            hage_elf = { x = { -180.36825561523438, -177.1717071533203, -173.03878784179688, -195.64593505859376, -200.85484313964845, -193.666015625 }, y = { 1.2331171035766602, 1.2332146167755128, 1.2332146167755128, 4.4963154792785648, 4.496399402618408, 1.2331171035766602 }, z = { -10.433639526367188, 3.757843017578125, -8.885513305664063, 13.009081840515137, 13.762968063354493, -14.195465087890625 }, x2 = { -181.86825561523438, -178.6717071533203, -174.53878784179688, -197.14593505859376, -202.35484313964845, -192.166015625 }, z2 = { -11.933639526367188, 2.257843017578125, -10.385513305664063, 11.509081840515137, 12.262968063354493, -12.695465087890625 }, x3 = { 0, 0, 0, 0, 0, -195.166015625 }, z3 = { -8.933639526367188, 5.257843017578125, -7.3855133056640629, 14.509081840515137, 15.262968063354493, 0} },
            hage_elf_night = { x = { -180.36825561523438, -177.1717071533203, -173.03878784179688, -195.64593505859376, -200.85484313964845, -193.666015625 }, y = { 1.2331171035766602, 1.2332146167755128, 1.2332146167755128, 4.4963154792785648, 4.496399402618408, 1.2331171035766602 }, z = { -10.433639526367188, 3.757843017578125, -8.885513305664063, 13.009081840515137, 13.762968063354493, -14.195465087890625 }, x2 = { -181.86825561523438, -178.6717071533203, -174.53878784179688, -197.14593505859376, -202.35484313964845, -192.166015625 }, z2 = { -11.933639526367188, 2.257843017578125, -10.385513305664063, 11.509081840515137, 12.262968063354493, -12.695465087890625 }, x3 = { 0, 0, 0, 0, 0, -195.166015625 }, z3 = { -8.933639526367188, 5.257843017578125, -7.3855133056640629, 14.509081840515137, 15.262968063354493, 0} },
            space_center = {  x = { -116.25675201416016, -108.03779602050781, -125.49473571777344, -109.01582336425781, -104.41179656982422, -93.50308990478516 }, y = { 15.177154541015625, 15.175689697265625, 15.178070068359375, 19.621381759643556, 19.621381759643556, 15.173004150390625 }, z = { -523.0143432617188, -518.7552490234375, -522.0540771484375, -528.03857421875, -524.8563842773438, -516.8642578125 }, x2 = { -114.75675201416016, -106.53779602050781, -126.99473571777344, -107.51582336425781, -102.91179656982422, -95.00308990478516 }, z2 = { -521.5143432617188, -517.2552490234375, -523.5540771484375, -526.53857421875, -523.3563842773438, -518.3642578125 }, x3 = { -117.75675201416016, -109.53779602050781, 0, -110.51582336425781, -105.91179656982422, 0, }, z3 = { 0, 0, -520.5540771484375, 0, 0, -515.3642578125 } },
            boros_ship = { x = { -330.565673828125, -342.3744812011719, -320.9187316894531, -332.2988586425781, -337.16668701171877, -363.7180480957031 }, y = { 361.2119445800781, 361.2119445800781, 361.2119445800781, 365.26104736328127, 368.01873779296877, 361.2119445800781 }, z = { 1406.927001953125, 1402.03466796875, 1402.097900390625, 1394.1439208984376, 1412.7432861328126, 1402.365234375 }, x2 = { -329.065673828125, -340.8744812011719, -319.4187316894531, -330.7988586425781, -335.66668701171877, -362.2180480957031 }, z2 = { 1408.427001953125, 1403.53466796875, 1403.597900390625, 1395.6439208984376, 1414.2432861328126, 1403.865234375 }, x3 = { -332.065673828125, -343.8744812011719, -322.4187316894531, -333.7988586425781, -338.66668701171877, -365.2180480957031 }, z3 = { 0, 0, 0, 0, 0, 0 } },
            boros_ship_portal = { x = { -330.565673828125, -342.3744812011719, -320.9187316894531, -332.2988586425781, -337.16668701171877, -363.7180480957031 }, y = { 361.2119445800781, 361.2119445800781, 361.2119445800781, 365.26104736328127, 368.01873779296877, 361.2119445800781 }, z = { 1406.927001953125, 1402.03466796875, 1402.097900390625, 1394.1439208984376, 1412.7432861328126, 1402.365234375 }, x2 = { -329.065673828125, -340.8744812011719, -319.4187316894531, -330.7988586425781, -335.66668701171877, -362.2180480957031 }, z2 = { 1408.427001953125, 1403.53466796875, 1403.597900390625, 1395.6439208984376, 1414.2432861328126, 1403.865234375 }, x3 = { -332.065673828125, -343.8744812011719, -322.4187316894531, -333.7988586425781, -338.66668701171877, -365.2180480957031 }, z3 = { 0, 0, 0, 0, 0, 0 } },
            ["7ds_map"] = {  x = { -100.90078735351563, -107.71892547607422, -103.12113952636719, -112.89239501953125, -103.7119140625, -84.05673217773438 }, y = { 212.96104431152345, 212.9611053466797, 212.9611053466797, 218.582763671875, 219.20982360839845, 212.9611053466797 }, z = { -192.95286560058595, -195.7036590576172, -202.30499267578126, -194.83023071289063, -205.52392578125, -194.9472198486328 }, x2 = { -99.40078735351563, -109.21892547607422, -101.62113952636719, -111.39239501953125, -102.2119140625, -82.55673217773438 }, z2 = { -191.45286560058595, -197.2036590576172, -200.80499267578126, -193.33023071289063, -204.02392578125, -193.4472198486328 }, x3 = { -102.40078735351563, 0, -104.62113952636719, -114.39239501953125, -105.2119140625, -85.55673217773438 }, z3 = { 0, -194.2036590576172, 0, 0, 0, 0 } },
            ["7ds_map_night"] = {  x = { -100.90078735351563, -107.71892547607422, -103.12113952636719, -112.89239501953125, -103.7119140625, -84.05673217773438 }, y = { 212.96104431152345, 212.9611053466797, 212.9611053466797, 218.582763671875, 219.20982360839845, 212.9611053466797 }, z = { -192.95286560058595, -195.7036590576172, -202.30499267578126, -194.83023071289063, -205.52392578125, -194.9472198486328 }, x2 = { -99.40078735351563, -109.21892547607422, -101.62113952636719, -111.39239501953125, -102.2119140625, -82.55673217773438 }, z2 = { -191.45286560058595, -197.2036590576172, -200.80499267578126, -193.33023071289063, -204.02392578125, -193.4472198486328 }, x3 = { -102.40078735351563, 0, -104.62113952636719, -114.39239501953125, -105.2119140625, -85.55673217773438 }, z3 = { 0, -194.2036590576172, 0, 0, 0, 0 } },
            ["7ds_map_cube"] = {  x = { -100.90078735351563, -107.71892547607422, -103.12113952636719, -112.89239501953125, -103.7119140625, -84.05673217773438 }, y = { 212.96104431152345, 212.9611053466797, 212.9611053466797, 218.582763671875, 219.20982360839845, 212.9611053466797 }, z = { -192.95286560058595, -195.7036590576172, -202.30499267578126, -194.83023071289063, -205.52392578125, -194.9472198486328 }, x2 = { -99.40078735351563, -109.21892547607422, -101.62113952636719, -111.39239501953125, -102.2119140625, -82.55673217773438 }, z2 = { -191.45286560058595, -197.2036590576172, -200.80499267578126, -193.33023071289063, -204.02392578125, -193.4472198486328 }, x3 = { -102.40078735351563, 0, -104.62113952636719, -114.39239501953125, -105.2119140625, -85.55673217773438 }, z3 = { 0, -194.2036590576172, 0, 0, 0, 0 } },
            mha_city = { x = { -40.4365348815918, -42.80509948730469, -52.33661651611328, -49.221282958984378, -56.661502838134769, -54.54512023925781 }, y = { -13.242581367492676, -13.243115425109864, -13.245586395263672, -8.898531913757325, -8.898531913757325, -13.245986938476563 }, z = { 7.845829010009766, 18.419816970825197, 7.10341739654541, 2.417248010635376, 2.8484253883361818, -2.1536197662353517 }, x2 = { -38.9365348815918, -44.30509948730469, -50.83661651611328, -47.721282958984378, -55.161502838134769, -53.04512023925781 }, z2 = { 9.345829010009766, 16.919816970825197, 8.60341739654541, 3.917248010635376, 4.348425388336182, -0.6536197662353516 }, x3 = { -41.9365348815918, 0, -53.83661651611328, -50.721282958984378, -58.161502838134769, -56.04512023925781 }, z3 = { 0, 19.919816970825197, 0, 0, 0, 0 } },
            mha_city_night = { x = { -40.4365348815918, -42.80509948730469, -52.33661651611328, -49.221282958984378, -56.661502838134769, -54.54512023925781 }, y = { -13.242581367492676, -13.243115425109864, -13.245586395263672, -8.898531913757325, -8.898531913757325, -13.245986938476563 }, z = { 7.845829010009766, 18.419816970825197, 7.10341739654541, 2.417248010635376, 2.8484253883361818, -2.1536197662353517 }, x2 = { -38.9365348815918, -44.30509948730469, -50.83661651611328, -47.721282958984378, -55.161502838134769, -53.04512023925781 }, z2 = { 9.345829010009766, 16.919816970825197, 8.60341739654541, 3.917248010635376, 4.348425388336182, -0.6536197662353516 }, x3 = { -41.9365348815918, 0, -53.83661651611328, -50.721282958984378, -58.161502838134769, -56.04512023925781 }, z3 = { 0, 19.919816970825197, 0, 0, 0, 0 } },
            west_city = { x = { -2366.043701171875, -2362.55615234375, -2357.416259765625, -2330.9033203125, -2337.23828125, -2348.35302734375 }, y = { 19.763042449951173, 19.763042449951173, 19.763042449951173, 31.40303611755371, 31.40291404724121, 19.763042449951173 }, z = { -100.9094467163086, -66.028564453125, -70.55792236328125, -80.4635238647461, -80.1539306640625, -108.65594482421875 }, x2 = { -2364.543701171875, -2364.05615234375, -2358.916259765625, -2329.4033203125, -2335.73828125, -2346.85302734375 }, z2 = { -99.4094467163086, -67.528564453125, -72.05792236328125, -78.9635238647461, -78.6539306640625, -107.15594482421875 }, x3 = { -2367.543701171875, 0, 0, -2332.4033203125, -2338.73828125, -2349.85302734375 }, z3 = { 0, -64.528564453125, -69.05792236328125, 0, 0, 0 } },
            west_city_frieza = { x = { -2366.043701171875, -2362.55615234375, -2357.416259765625, -2330.9033203125, -2337.23828125, -2348.35302734375 }, y = { 19.763042449951173, 19.763042449951173, 19.763042449951173, 31.40303611755371, 31.40291404724121, 19.763042449951173 }, z = { -100.9094467163086, -66.028564453125, -70.55792236328125, -80.4635238647461, -80.1539306640625, -108.65594482421875 }, x2 = { -2364.543701171875, -2364.05615234375, -2358.916259765625, -2329.4033203125, -2335.73828125, -2346.85302734375 }, z2 = { -99.4094467163086, -67.528564453125, -72.05792236328125, -78.9635238647461, -78.6539306640625, -107.15594482421875 }, x3 = { -2367.543701171875, 0, 0, -2332.4033203125, -2338.73828125, -2349.85302734375 }, z3 = { 0, -64.528564453125, -69.05792236328125, 0, 0, 0 } },
            uchiha_hideout = { x = { 282.5268249511719, 269.29833984375, 275.0011901855469, 271.2455139160156, 265.5224304199219, 298.23797607421877 }, y = { 536.8999633789063, 536.8999633789063, 536.8999633789063, 539.8976440429688, 539.8976440429688, 536.8999633789063 }, z = { -581.7987060546875, -571.810791015625, -577.9029541015625, -561.8075561523438, -560.3048706054688, -609.886474609375 }, x2 = { 284.0268249511719, 270.79833984375, 276.5011901855469, 272.7455139160156, 267.0224304199219, 299.73797607421877 }, z2 = { -580.2987060546875, -570.310791015625, -576.4029541015625, -560.3075561523438, -558.8048706054688, -608.386474609375 }, x3 = { 281.0268249511719, 267.79833984375, 273.5011901855469, 269.7455139160156, 264.0224304199219, 296.73797607421877 }, z3 = { 0, 0, 0, 0, 0, 0 } }, }
        
        -- Reset Settings
        if Settings.Craymel == nil then
            Settings = {
                Craymel = true
            }
        end
        
        -- Generate Preset Position and Unit Config
        for i = 1, #List.mapName do
            if Settings["UnitConfig_" .. List.mapName[i]] == nil then
                Settings["UnitConfig_" .. List.mapName[i]] = { Parameters = {}, Position = {} }
                
                local mapName = List.mapName[i]
                
                for v = 1, 6 do
                    if List[mapName].x3[v] == 0 then xz3 = "z3" xz = xz3 else xz3 = "x3" xz = xz3 end
                        
                    local _default1 = { TotalUnits = 1, PlacementPriority = v, UpgradePriority = v, PlaceAtWave = 1, UpgradeAtWave = 1, SellAtWave = 999, UpgradeCap = 1, TargetPriority = "first" }
                    
                    local _default2 = { x = List[mapName].x[v], y = List[mapName].y[v], z = List[mapName].z[v], x2 = List[mapName].x2[v], z2 = List[mapName].z2[v], [xz] = List[mapName][xz3][v] }
                    
                    Settings["UnitConfig_" .. List.mapName[i]].Parameters["UP" .. v] = _default1
                    Settings["UnitConfig_" .. List.mapName[i]].Position["UP"..v] = _default2
                end
            end
        end
        saveSettings()
    end)
end
    -- End of Generate Default Config Function
    
    -- Start of Infinity Castle Function
local function MoreFarmSec()
    MoreFarmConfig:Cheat("Checkbox","🏯 Auto Next Level Inf castle  ", function(bool)
        warn("Auto next Level in Infinity Castle is set to " .. tostring(bool))
        Settings.AutoContinue = bool
        saveSettings()
    end,{enabled = Settings.AutoContinue })
    MoreFarmConfig:Cheat("Checkbox","🏰️ Auto Infinity Castle  ", function(bool)
        warn("Auto Infinity Castle is set to " .. tostring(bool))
        Settings.AutoInfinityCastle = bool
        saveSettings()
    end,{enabled = Settings.AutoInfinityCastle})
end
    -- End of Infinity Castle Function

    -- Start of Reset Farm Config Function
function refarmcon()
    print("reset AutoFarm & find Picoro config ?")

    -- findPicoro
    if Settings.picoHOP then
        Settings.picoHOP = false end
    -- Start
    if Settings.autostart then
        Settings.autostart = false end
    -- Place unit
    if Settings.AutoFarm then
        Settings.AutoFarm = false end
    -- Replay
    if Settings.AutoReplay then
        Settings.AutoReplay = false end
    -- Next Story
    if Settings.AutoNext then
        Settings.AutoNext = false end
    -- Leave
    if Settings.AutoLeave then
        Settings.AutoLeave = false end
    -- Abilities
    if Settings.AutoAbilities then
        Settings.AutoAbilities = false end
    -- Upgrade
    if Settings.AutoUpgrade then
        Settings.AutoUpgrade = false end
    -- AutoSell
    if Settings.AutoSell then
        Settings.AutoSell = false end
    -- autoQuitWave
    if Settings.autoQuit then
        Settings.autoQuit = false end
    -- AutoSellWave
    if Settings.AutoSellWave then
        Settings.AutoSellWave = 0 end
    -- Next Level Infinity Castle
    if Settings.AutoContinue then
        Settings.AutoContinue = false end
    -- Auto Infinity Castle 
    if Settings.AutoInfinityCastle then
        Settings.AutoInfinityCastle = false end
        saveSettings()
        autoload2()
end

if Settings.refarmc then
    refarmcon()
    autoload2()
end
    -- End Reset Farm Config and Find Picoro
    
    -- End of Reset Settings to Farm Story
function setfarm1()
    print("Set AutoFarm Story ?")

    -- Start
    if Settings.autostart then
        Settings.autostart = true end
    -- Place unit
    if Settings.AutoFarm then
        Settings.AutoFarm = true end
    -- Replay
    if Settings.AutoReplay then
        Settings.AutoReplay = false end
    -- Next Story
    if Settings.AutoNext then
        Settings.AutoNext = false end
    -- Leave
    if Settings.AutoLeave then
        Settings.AutoLeave = true end
    -- Abilities
    if Settings.AutoAbilities then
        Settings.AutoAbilities = true end
    -- Upgrade
    if Settings.AutoUpgrade then
        Settings.AutoUpgrade = true end
    -- AutoSell
    if Settings.AutoSell then
        Settings.AutoSell = true end
    -- autoQuitWave
    if Settings.autoQuit then
        Settings.autoQuit = false end
    -- AutoSellWave
    if Settings.AutoSellWave then
        Settings.AutoSellWave = 50 end
    -- Next Level Infinity Castle
    if Settings.AutoContinue then
        Settings.AutoContinue = false end
    -- Auto Infinity Castle 
    if Settings.AutoInfinityCastle then
        Settings.AutoInfinityCastle = false end
        saveSettings()
        autoload2()
end

if Settings.setfarm1 then
    setfarm1()
    autoload2()
end
    -- End of Reset Settings to Farm Story
    
    -- Start of Reset Settings to Farm Story and Next Level
function setfarm2()
    print("Set AutoFarm Story & Replay ?")

    --Start
    if Settings.autostart then
        Settings.autostart = true end
    -- Place unit
    if Settings.AutoFarm then
        Settings.AutoFarm = true end
    -- Replay
    if Settings.AutoReplay then
        Settings.AutoReplay = true end
    -- Next Story
    if Settings.AutoNext then
        Settings.AutoNext = false end
    -- Leave
    if Settings.AutoLeave then
        Settings.AutoLeave = true end
    -- Abilities
    if Settings.AutoAbilities then
        Settings.AutoAbilities = true end
    -- Upgrade
    if Settings.AutoUpgrade then
        Settings.AutoUpgrade = true end
    -- AutoSell
    if Settings.AutoSell then
        Settings.AutoSell = true end
    -- autoQuitWave
    if Settings.autoQuit then
        Settings.autoQuit = false end
    -- AutoSellWave
    if Settings.AutoSellWave then
        Settings.AutoSellWave = 50 end
    -- Next Level Infinity Castle
    if Settings.AutoContinue then
        Settings.AutoContinue = false end
    -- Auto Infinity Castle 
    if Settings.AutoInfinityCastle then
        Settings.AutoInfinityCastle = false end
        saveSettings()
        autoload2()
end

if Settings.setfarm2 then
    setfarm2()
    autoload2()
end
    -- End of Reset Settings to Farm Story and Next Level
    
    -- Start of Reset Settings to Farm Infinity Castle
function setfarmIC()
    print("Set AutoFarm Inf Castle ?")

    -- Start
    if Settings.autostart then
        Settings.autostart = false end
    -- Place unit
    if Settings.AutoFarm then
        Settings.AutoFarm = true end
    -- Replay
    if Settings.AutoReplay then
        Settings.AutoReplay = false end
    -- Next Story
    if Settings.AutoNext then
        Settings.AutoNext = false end
    -- Leave
    if Settings.AutoLeave then
        Settings.AutoLeave = false end
    -- Abilities
    if Settings.AutoAbilities then
        Settings.AutoAbilities = true end
    -- Upgrade
    if Settings.AutoUpgrade then
        Settings.AutoUpgrade = true end
    -- AutoSell
    if Settings.AutoSell then
        Settings.AutoSell = true end
    -- autoQuitWave
    if Settings.autoQuit then
        Settings.autoQuit = false end
    -- AutoSellWave
    if Settings.AutoSellWave then
        Settings.AutoSellWave = 50 end
    -- Next Level Infinity Castle
    if Settings.AutoContinue then
        Settings.AutoContinue = true end
    -- Auto Infinity Castle 
    if Settings.AutoInfinityCastle then
        Settings.AutoInfinityCastle = true end
        saveSettings()
        autoload2()
  
end

if Settings.setfarmIC then
    setfarmIC()
    autoload2()
end
    -- Start of Reset Settings to Farm Infinity Castle
    -- End Reset Farm Config Function
    
    -- Start of Challenge Function
local function ChallengeSec()
    local challengeconfig = ChallengeConfig:Cheat("Dropdown", "🥇 Select Reward",function(value)
        warn(value)
        Settings.SelectedReward = value
        saveSettings()
    end, { options = {"star_fruit_random","star_remnant","gems", "gold"}, default =Settings.SelectedReward})
    ChallengeConfig:Cheat("Checkbox","🎯 Auto Challenge  ", function(bool)
        warn("Auto Challenge is set to " .. tostring(bool))
        Settings.AutoChallenge = bool
        saveSettings()
    end, {enabled =Settings.AutoChallenge})
    ChallengeConfig:Cheat("Checkbox","🏆 Farm Any Rewards  ", function(bool)
        warn("Farm Any Rewards is set to " .. tostring(bool))
       Settings.AutoChallengeAll = bool
        saveSettings()
    end,{enabled =Settings.AutoChallengeAll})
end
    -- End of Challenge Function
    
    -- Start of Credits Section
local function credits()
    Developers:Cheat("Label","📝 Scripted by: Arpon AG#6612 & Forever4D#0001 & HOLYSHz#3819 ")    
    Developers:Cheat("Label","📝 Also thanks to Trapstar#7845, bytenode#9646, ethreia#1036 for the help!")    
    Developers:Cheat("Label","📐 UI By: detourious @ v3rmillion.net")    
    Developers:Cheat("Label","🔧 To toggle the script press \"RightControl\"")   
    Developers:Cheat("Button","🔗 Discord Invite", function()
        setclipboard("https://discord.gg/2ttfCfzxut")
    end)
    UIUPDT:Cheat("Label","[+] idk \n[+]reeeeeeeeeee") 
end
    -- End of Credits Section

    -- Start of Generate Map Parameters in Settings [Changed by craymel02 --newfix]
local function initMapUnitSettings(unitPrefix, unitCount)

    local map = GLD().map

    if Settings["UnitConfig_" .. tostring(map)] == nil then
        Settings["UnitConfig_" .. tostring(map)] = {
            Position = {}
        }
    elseif Settings["UnitConfig_" .. tostring(map)].Position == nil then
        Settings["UnitConfig_" .. tostring(map)].Position = {}
    end
    
    for i = 1, unitCount, 1 do
        local UnitPos = unitPrefix..i
        if Settings["UnitConfig_" .. tostring(map)].Position[UnitPos] == nil then
            Settings["UnitConfig_" .. tostring(map)].Position[UnitPos] = {}
        end
    end
    
    saveSettings()
    return map
end
    -- End of Generate Map Paramenters in Settings
  
    -- Start of Horizontal Position to Save in Settings [Changed by craymel02 --newfix]
local function horPos(UnitPos, a)
    local x = getgenv().posX
    local z = getgenv().posZ
    local coordinates = {
        x = a.Position.X,
        y = a.Position.Y,
        z = a.Position.Z,
        x2 = a.Position.X + x,
        z2 = a.Position.Z + z,
        x3 = a.Position.X - x
    }
    local map = initMapUnitSettings("UP", 6)
    Settings["UnitConfig_" .. tostring(map)].Position[UnitPos] = coordinates
    saveSettings()
end
    -- End of Horizontal Position to Save in Settings

    -- Start of Horizontal Position to Save in Settings [Changed by craymel02 --newfix]
local function verPos(UnitPos, a)
    local x = getgenv().posX
    local z = getgenv().posZ
    local coordinates = {
        x = a.Position.X,
        y = a.Position.Y,
        z = a.Position.Z,
        x2 = a.Position.X - x,
        z2 = a.Position.Z - z,
        z3 = a.Position.Z + z
    }
    local map = initMapUnitSettings("UP", 6)
    Settings["UnitConfig_" .. tostring(map)].Position[UnitPos] = coordinates
    saveSettings()
end
    -- End of Upgrade Unit Position to Save in Settings
    
    -- Start MobileGUI to get Unit Coordinates [Changed by craymel02 --newfix]
function hormobilegui(UnitPos, a)
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
		horPos(UnitPos, a)
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

function vermobilegui(UnitPos, a)
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
		verPos(UnitPos, a)
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
    -- End MobileGUI to get Unit Coordinates
  
    -- Start Default Position to get Unit Coordinates [Changeed by craymel02 --newfix]
    
getgenv().posX = 1.5
getgenv().posZ = 1.5

function DefaultPosition(UnitPos)

    -- Position Variables
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Whitelist
	raycastParams.FilterDescendantsInstances = {game:GetService("Workspace")["_terrain"]}
	
    _G.gg = true
	task.wait(0.5)
	
	local x = getgenv().posX
	local z = getgenv().posZ
    
    local a = {}
    for i = 1, 6, 1 do
        a["Box" .. i] = Instance.new("Part", game.Workspace)
        a["Box" .. i].Size = Vector3.new(1, 1, 1)
        a["Box" .. i].Material = Enum.Material.Neon
    end
    
    warn("Choose Orientation")
    warn("Press Q for Horizontal")
    warn("Press R for Vertical")
    
    local function HorizontalPosition(UnitPos)
    
        local xPos = {}
        local zPos = {}
        local rayOrigin = {}
        local rayDestination = {}
        local rayDirection = {}
        local raycastResult = {}
        local xOffSet = { 0, 1.5, 0, -1.5, 1.5, -1.5 }
        local zOffSet = { 0, 0, 1.5, 0, 1.5, 1.5 }
    
    	if UserInputService.TouchEnabled then
    	    mobile = true
    	    else
    	        mobile = false
    	end
    	
    	warn("Choose Coordinates")
    	
    	game:GetService("RunService").RenderStepped:Connect(function()
    	    pcall(function()
    	        if _G.gg and not mobile then

    	            for i = 1, 6, 1 do
    	                xPos["Unit" .. i] = mouse.Hit.Position.X + xOffSet[i]
    	                zPos["Unit" .. i] = mouse.Hit.Position.Z + zOffSet[i]
    	                rayOrigin["Unit" .. i] = CFrame.new(xPos["Unit" .. i], 1000, zPos["Unit" .. i]).p
    	                rayDestination["Unit" .. i] = CFrame.new(xPos["Unit" .. i], -500, zPos["Unit" .. i]).p
    	                rayDirection["Unit" .. i] = (rayDestination["Unit" .. i] - rayOrigin["Unit" .. i])
    	                raycastResult["Unit" .. i] = workspace:Raycast(rayOrigin["Unit" .. i], rayDirection["Unit" .. i], raycastParams)
    	                a["Box" .. i].CFrame = CFrame.new(raycastResult["Unit" .. i].Position) * CFrame.Angles(0, -0, -0)
    	            end

    	        elseif _G.gg and mobile then
    	            
    	            warn("Mobile Detected")
    	            
    	            UserInputService.TouchLongPress:Connect(function()
    	                
    	                for i = 1, 6, 1 do
    	                    xPos["Unit" .. i] = mouse.Hit.Position.X + xOffSet[i]
    	                    zPos["Unit" .. i] = mouse.Hit.Position.Z + zOffSet[i]
    	                    rayOrigin["Unit" .. i] = CFrame.new(xPos["Unit" .. i], 1000, zPos["Unit" .. i]).p
    	                    rayDestination["Unit" .. i] = CFrame.new(xPos["Unit" .. i], -500, zPos["Unit" .. i]).p
    	                    rayDirection["Unit" .. i] = (rayDestination["Unit" .. i] - rayOrigin["Unit" .. i])
    	                    raycastResult["Unit" .. i] = workspace:Raycast(rayOrigin["Unit" .. i], rayDirection["Unit" .. i], raycastParams)
    	                    a["Box" .. i].CFrame = CFrame.new(raycastResult["Unit" .. i].Position) * CFrame.Angles(0, -0, -0)
    	                end
    	            end)
    	        end
    	    end)
    	end)
    	
	    task.wait()
        
        for i = 1, 6, 1 do
            a["Box" .. i ].Anchored = true
            a["Box" .. i].CanCollide = false
        end
        
	    if _G.gg and not mobile then
	        kjqhwe = mouse.Button1Down:Connect(function()
			    kjqhwe:Disconnect()
			    warn("Coordinate Set")
			    horPos(UnitPos, a.Box1)
			    _G.gg = false 
			
			    for i = 1, 6, 1 do
			    	a["Box" .. i].Transparency = 0
			    	task.wait()
			    	a["Box" .. i]:Destroy()
	    		end
	        end)
    	elseif _G.gg and mobile then
	    	hormobilegui(UnitPos, a.Box1)
    	end
    end
    
    local function VerticalPosition(UnitPos)

        local xPos = {}
        local zPos = {}
        local rayOrigin = {}
        local rayDestination = {}
        local rayDirection = {}
        local raycastResult = {}
        local xOffSet = { 0, -1.5, 0, 0, -1.5, -1.5 }
        local zOffSet = { 0, 0, -1.5, 1.5, -1.5, 1.5 }
        
    	if UserInputService.TouchEnabled then
    	    mobile = true
    	    else
    	        mobile = false
    	end
    	
    	warn("Choose Coordinates")
    	
    	game:GetService("RunService").RenderStepped:Connect(function()
    	    pcall(function()
    	        if _G.gg and not mobile then
    	            
    	            for i = 1, 6, 1 do
    	                xPos["Unit" .. i] = mouse.Hit.Position.X + xOffSet[i]
    	                zPos["Unit" .. i] = mouse.Hit.Position.Z + zOffSet[i]
    	                rayOrigin["Unit" .. i] = CFrame.new(xPos["Unit" .. i], 1000, zPos["Unit" .. i]).p
    	                rayDestination["Unit" .. i] = CFrame.new(xPos["Unit" .. i], -500, zPos["Unit" .. i]).p
    	                rayDirection["Unit" .. i] = (rayDestination["Unit" .. i] - rayOrigin["Unit" .. i])
    	                raycastResult["Unit" .. i] = workspace:Raycast(rayOrigin["Unit" .. i], rayDirection["Unit" .. i], raycastParams)
    	                a["Box" .. i].CFrame = CFrame.new(raycastResult["Unit" .. i].Position) * CFrame.Angles(0, -0, -0)
    	            end
        			
    	        elseif _G.gg and mobile then
    	            
    	            warn("Mobile Detected")
    	            
    	            UserInputService.TouchLongPress:Connect(function()
    	                
    	                for i = 1, 6, 1 do
    	                    xPos["Unit" .. i] = mouse.Hit.Position.X + xOffSet[i]
    	                    zPos["Unit" .. i] = mouse.Hit.Position.Z + zOffSet[i]
    	                    rayOrigin["Unit" .. i] = CFrame.new(xPos["Unit" .. i], 1000, zPos["Unit" .. i]).p
    	                    rayDestination["Unit" .. i] = CFrame.new(xPos["Unit" .. i], -500, zPos["Unit" .. i]).p
    	                    rayDirection["Unit" .. i] = (rayDestination["Unit" .. i] - rayOrigin["Unit" .. i])
    	                    raycastResult["Unit" .. i] = workspace:Raycast(rayOrigin["Unit" .. i], rayDirection["Unit" .. i], raycastParams)
    	                    a["Box" .. i].CFrame = CFrame.new(raycastResult["Unit" .. i].Position) * CFrame.Angles(0, -0, -0)
    	                end
    	            end)
    	        end
    	    end)
    	end)
    	
        for i = 1, 6, 1 do
            a["Box" .. i ].Anchored = true
            a["Box" .. i].CanCollide = false
        end
	    
	    if _G.gg and not mobile then
	        kjqhwe = mouse.Button1Down:Connect(function()
			    kjqhwe:Disconnect()
			    warn("Coordinate Set")
			    verPos(UnitPos, a.Box1)
			    _G.gg = false 
			
			    for i = 1, 6, 1 do
			    	a["Box" .. i].Transparency = 0
			    	task.wait()
			    	a["Box" .. i]:Destroy()
	    		end
    		end)
    	elseif _G.gg  and mobile then
	    	vermobilegui(UnitPos, a.Box1)
    	end
    end
    
    keytopress = game:GetService("UserInputService").InputBegan:connect(function(inputObject, gameProcessedEvent)
        if inputObject.KeyCode == Enum.KeyCode.Q then
            keytopress:Disconnect()
            HorizontalPosition(UnitPos)
        elseif inputObject.KeyCode == Enum.KeyCode.R then
            keytopress:Disconnect()
            VerticalPosition(UnitPos)
        end
    end)
    return
end
    -- End of Default Position to get Unit Coordinates
    
    -- Start of Unit Position Section [Changed by craymel02 --newfix]
local function UnitPosSec()
    for i = 1, 6, 1 do
        UnitPosition:Cheat("Button", "Set Unit " .. i .. " Position", function()
            DefaultPosition("UP" .. i )
        end)
    end
end
    -- End of Unit Position Section
    
    -- Start of Script Section [Added by craymel02 --newfix]
local function scriptupdate()
    Update:Cheat("Label", "📝 Script Update April 16th")
    
    Notes = {
        "[+] Changes in Auto Farm Menu",
        "      1. Added Generate Preset Config.",
        "         - Press Button to Generate Preset Position for all Maps Excluding Highschool DxD",
        "             Portals. It also Generate Preset Unit Config as well.",
        "         - Generate Preset will also Reset Settings.JSON to avoid conflict with New Codings",
        "         - Preset Position follows.",
        "             a. Unit 1 to 3 is for Ground Units.",
        "             b. Unit 4 to 5 is for Air / Hill or Hybrid Units.",
        "             c. Unit 6 is for Farmers 'Speedcart' or 'Bulma'",
        "         - Preset Unit Config follows.",
        "             a. All Total Unit is set to 1.",
        "             b. Placement and Upgrade Priority is equal to Unit Position '1 to 6'.",
        "             c. All Upgrade Cap is set to 1.",
        "             d. All Place from Wave and Upgrade from Wave is set to 1.",
        "             e. All Target Priority is set to 'first'.",
        "      2. Set Unit Position can now do Horizontal or Vertical Position.",
        "         - After Clicking Button, Press Q for Horizontal Position or Press R for Vertical",
        "             Position.",
        "      3. Added Auto Save Selected Units when Current Unit Lineup Changed.",
        "         - Must Generate Preset First to enable.",
        "      4. For Replay, Next Story, Next Room in Infinity or Leave.",
        "         - Choose only 1 of the button to Enabled to avoid not Teleporting.",
        "[+] Added fail safe when Next, Replay fails after 3 minutes you get Teleport",
        "      Back to Lobby.",
        "[+] Shorten Long Codes, Added Auto Reconnect Function when get Disconnected.",
        "      1. Won't work if Disconnected before the game fully Load.",
        "[+] Changes in Unit Config Menu",
        "      1. Can now Set Different Settings based on Map and is Not Available in Game Lobby.",
        "      2. If Unit Config Settings on current Map is not Set, Script will disable Unit",
        "          Config then Generate Default Parameters to Avoid Error and reload UI.",
        "      2. If Position Settings on current Map is not Set, Script will disable Unit Config",
        "          and reload UI to let you Set Unit Position and avoid Script Error.",
        "      3. Reset Map Unit Config will only reset current Map and will not affect other",
        "          Map Settings.",
        "      4. You need to Set Position in Portal and Unit Config as well due to Portal",
        "          and Normal Maps have different ID's.",
        "      5. Check Unit Button is added to check all current deployed Unit in Roblox Log 'F9'.",
        "[+] Fixed Unit Config Placement Priority, Upgrade Priority, Upgrade Cap, Upgrade",
        "      from Wave and Sell from Wave and Added Target Priority with default target 'first'.",
        "      1. Recode Unit Config to make Placement Priority and Upgrade Priority Works.",
        "      2. Placement Priority and Upgrade Priority must be different per Unit or it'll",
        "          cause error on the script. Priority 1 is first, 6 is last.",
        "      3. Target Priority must be 'first', 'closest', 'last', 'farthest', 'strongest','weakest' or",
        "          'flying' without '' symbol.",
        "      4. If a Unit reached his 'Upgrade at Wave' while haven't placed other Unit due",
        "          to lack of Yen, Script will do both Placing and Upgrading based on Priority.",
        "      5. Dedicate Upgrade Priority '6' for Farmers that if detected with Bulma, Nami",
        "          or Speedwagon is to Upgrade them simultaneously with Upgrade Priority 1",
        "          to yield more yen along with it's 'Upgrade At Wave'.",
        "      6. If Other Unit won't Upgrade or Place, double check Total Units or Upgrade Cap",
        "            if it match the Units Max Placement or Max Upgrade.",
        "            Example: Metal Knight Max Placement is 2 but input 3 on Total Units then will",
        "            cause an error that won't proceed unless correction is made.",
        "      7. Must always bring 6 Units to Avoid Possible Error, Put 0 on 'Total Units' if",
        "          you want the script skip on them and ALWAYS PUT DIFFERENT",
        "          PRIORITY NUMBER! (1 ~ 6)",
        "[+] Added auto disable of Auto Upgrade and Auto Place Unit in Auto Farm when Unit",
        "      Config is On and Vice-Versa to avoid conflict with one another.",
        "[+] Recode Auto Use Abilities to fix issue with skill rotation, Abilities will be used if",
        "      Enemies are within their Range. Except for Wendy and Erwin while Puchi will only",
        "      use Skill on Boss Wave."}

    for i = 1, #Notes, 1 do
        ScriptUpdate:Cheat("label", Notes[i])
    end
end
    -- End of Script Section
    
    -- Start of Unit Config Section [Changed by craymel02 --newfix]
local function unitconfig()

    -- Start of Use Unit Config
    NDY:Cheat("Checkbox","Use Map Unit Config ", function(bool)
        warn("Unit Config set to " .. tostring(bool))
        if Settings.AutoUpgrade == true and Settings.AutoFarm == true then
            Settings.AutoUpgrade = false
            Settings.AutoFarm = false
            Settings.unitconfig = bool
            saveSettings()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/ArponAG/Scripts/main/AnimeAdventures.lua'))()
        elseif Settings.AutoUpgrade == true then
            Settings.AutoUpgrade = false
            Settings.unitconfig = bool
            saveSettings()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/ArponAG/Scripts/main/AnimeAdventures.lua'))()
        elseif Settings.AutoFarm == true then
            Settings.AutoFarm = false
            Settings.unitconfig = bool
            saveSettings()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/ArponAG/Scripts/main/AnimeAdventures.lua'))()   
            else
                Settings.unitconfig = bool
                saveSettings()
        end
    end,{enabled = Settings.unitconfig})
    -- End of Use Unit Config

    -- Start of Reset Unit Config
    NDY2:Cheat("Button", "Reset Map Unit Config", function()
        reunitcon()
    end)
    -- End of Reset Unit Config
    
    -- Start of Check Deployed Unit
    NDY3:Cheat("Button", "Check Unit", function()
        for i, v in pairs(game.Workspace._UNITS:getChildren()) do
            if v:FindFirstChild("_stats"):FindFirstChild("player") then
                if tostring(v._stats.player.Value) == game.Players.LocalPlayer.Name then
                    warn(v)
		        end
	        end
        end
    end)
    -- End of Check Deployed Unit
    
    -- Start Variable for Unit Config
    local map = GLD().map
    local target = "first"
    local value = {}
    -- End Variable for Unit Config

    -- Start of Generate Unit 1 to 6 Unit Config UI
    for i = 1, 6, 1 do
        Unit["Unit" .. i]:Cheat("Textbox", "Total Units", function(Value)
            value["TotalUnits" .. i] = tonumber(Value)
        end, {placeholder = Settings["UnitConfig_" .. tostring(map)] and Settings["UnitConfig_" .. tostring(map)].Parameters and Settings["UnitConfig_" .. tostring(map)].Parameters["UP" .. i].TotalUnits or nil})
        
        Unit["Unit" .. i]:Cheat("Textbox", "Placement Priority", function(Value)
            value["PlacementPriority" .. i] = tonumber(Value)
        end, {placeholder = Settings["UnitConfig_" .. tostring(map)] and Settings["UnitConfig_" .. tostring(map)].Parameters and Settings["UnitConfig_" .. tostring(map)].Parameters["UP" .. i].PlacementPriority or nil})
    
        Unit["Unit" .. i]:Cheat("Textbox", "Upgrade Priority", function(Value)
            value["UpgradePriority" .. i] = tonumber(Value)
        end, {placeholder = Settings["UnitConfig_" .. tostring(map)] and Settings["UnitConfig_" .. tostring(map)].Parameters and Settings["UnitConfig_" .. tostring(map)].Parameters["UP" .. i].UpgradePriority or nil})
        
        Unit["Unit" .. i]:Cheat("Textbox", "Place from wave", function(Value)
            value["PlaceFromWave" .. i] = tonumber(Value)
        end, {placeholder = Settings["UnitConfig_" .. tostring(map)] and Settings["UnitConfig_" .. tostring(map)].Parameters and Settings["UnitConfig_" .. tostring(map)].Parameters["UP" .. i].PlaceAtWave or nil})
        
        Unit["Unit" .. i]:Cheat("Textbox", "Upgrade from wave", function(Value)
            value["UpgradeFromWave" .. i] = tonumber(Value)
        end, {placeholder = Settings["UnitConfig_" .. tostring(map)] and Settings["UnitConfig_" .. tostring(map)].Parameters and Settings["UnitConfig_" .. tostring(map)].Parameters["UP" .. i].UpgradeAtWave or nil})
        
        Unit["Unit" .. i]:Cheat("Textbox", "Auto Sell from wave", function(Value)
            value["SellAtWave" .. i] = tonumber(Value)
        end, {placeholder = Settings["UnitConfig_" .. tostring(map)] and Settings["UnitConfig_" .. tostring(map)].Parameters and Settings["UnitConfig_" .. tostring(map)].Parameters["UP" .. i].SellAtWave or nil})
        
        Unit["Unit" .. i]:Cheat("Textbox", "Upgrade Cap", function(Value)
            value["UpgradeCap" .. i] = tonumber(Value)
        end, {placeholder = Settings["UnitConfig_" .. tostring(map)] and Settings["UnitConfig_" .. tostring(map)].Parameters and Settings["UnitConfig_" .. tostring(map)].Parameters["UP" .. i].UpgradeCap or nil})
        
        Unit["Unit" .. i]:Cheat("Textbox", "Target Priority", function(Value)
            value["TargetPriority" .. i] = tostring(Value)
        end, {placeholder = Settings["UnitConfig_" .. tostring(map)] and Settings["UnitConfig_" .. tostring(map)].Parameters and Settings["UnitConfig_" .. tostring(map)].Parameters["UP" .. i].TargetPriority or target})
    end
    -- End of Generate Unit 1 to 6 Unit Config UI

    -- Start of Save Button
    SaveConfig:Cheat("Button", "Save Map Unit Config", function()
        
        local map = initUnitConfigMapSettings("UP", 6)
        
        -- Save Fetched Parameters to JSON
        for i = 1, 6, 1 do
            Settings["UnitConfig_" .. tostring(map)].Parameters["UP" .. i] = {
                TotalUnits = value["TotalUnits" .. i] or Settings["UnitConfig_" .. tostring(map)].Parameters["UP" .. i].TotalUnits,
                PlacementPriority = value["PlacementPriority" .. i] or Settings["UnitConfig_" .. tostring(map)].Parameters["UP" .. i].PlacementPriority,
                UpgradePriority = value["UpgradePriority" .. i] or Settings["UnitConfig_" .. tostring(map)].Parameters["UP" .. i].UpgradePriority,
                PlaceAtWave = value["PlaceFromWave" .. i] or Settings["UnitConfig_" .. tostring(map)].Parameters["UP" .. i].PlaceAtWave,
                UpgradeAtWave = value["UpgradeFromWave" .. i] or Settings["UnitConfig_" .. tostring(map)].Parameters["UP" .. i].UpgradeAtWave,
                SellAtWave = value["SellFromWave" .. i] or Settings["UnitConfig_" .. tostring(map)].Parameters["UP" .. i].SellAtWave,
                UpgradeCap = value["UpgradeCap" .. i] or Settings["UnitConfig_" .. tostring(map)].Parameters["UP" .. i].UpgradeCap,
                TargetPriority = value["TargetPriority" .. i] or Settings["UnitConfig_" .. tostring(map)].Parameters["UP" .. i].TargetPriority
            }
        end
        saveSettings()
    end)
    -- End of Save Button
end
    -- End of Unit Config Area
    
    -- Start of Generate Unit Config Map Settings Parameters [Added by craymel02 --newfix]
function initUnitConfigMapSettings(unitPos, unitCount)

    local map = GLD().map
    
    if Settings["UnitConfig_" .. tostring(map)] == nil then
        Settings["UnitConfig_" .. tostring(map)] = {
            Parameters = {}
        }
    elseif Settings["UnitConfig_" .. tostring(map)].Parameters == nil then
        Settings["UnitConfig_" .. tostring(map)].Parameters = {}
    end

    for i = 1, unitCount, 1 do
        
        local _default = {
        PlacementPriority = i,
        PlaceAtWave = 1,
        TotalUnits = 1,
        UpgradePriority = i,
        UpgradeAtWave = 1,
        UpgradeCap = 1,
        SellAtWave = 999,
        TargetPriority = "first"
        }
        
        local UnitPos = unitPos..i
        
        if Settings["UnitConfig_" .. tostring(map)].Parameters[UnitPos] == nil then
            Settings["UnitConfig_" .. tostring(map)].Parameters[UnitPos] = _default
        end
    end
    
    saveSettings()
    return map
end
    -- End of Generate Unit Config Map Settings Parameters
  
    -- Start of Laggy Function
local function LAGGYconfig()
    LG1:Cheat("Label"," Is a BETA Version // Enjoy ")

    LG1:Cheat("Textbox", "LAG Threads", function(Value)
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
    end, {placeholder = Settings.delag or 1.5})

    LG1:Cheat("Slider", "LAG Lv. [slide]", function(Value)
        print("LAG Lv.:", Value)
        Settings.mix = tonumber(Value)
        saveSettings()
    end, {min = 0, max = 7, suffix = "", default = 0 })

    LG1:Cheat("Slider", "Delay [slide]", function(Value)
        print("Delay.:", Value)
        Settings.delag = tonumber(Value)
        saveSettings()
    end, {min = 0, max = 10, suffix = "", default = 1.5 })


    LG1:Cheat("Label","  ")
    LG1:Cheat("Label"," Set Tries to 0 for close LAG ")
    LG1:Cheat("Label"," Threads = lower the faster it lags ")
    LG1:Cheat("Label"," Tries = the higher the faster it lags ")
    LG1:Cheat("Label"," Delay = lower the faster it lags")
    LG1:Cheat("Label"," def settings : threads = 250, tries = 1, Delay = 1.5 ")
    LG1:Cheat("Label"," fast-lag settings: threads = 10, tries = 1.5, Delay = 1.5 ")

end
    -- End of Laggy Function

    -- Start of Auto Summon
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
    -- End of Auto Summon

    -- Start of Snipe Shop
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
    -- End of Snipe Shop

    -- Start of Discord Webhook
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
    -- End of Discord Webhook

    -- Start of Auto Load Function
function autoload()
    pcall(function()
        local exec = tostring(identifyexecutor())
        if exec == "Synapse X" and Settings.AutoLoadScript then
            syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/ArponAG/Scripts/main/AnimeAdventures.lua'))()")
        elseif exec ~= "Synapse X" and Settings.AutoLoadScript then
            queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/ArponAG/Scripts/main/AnimeAdventures.lua'))()")
        end
    end)
end

function autoload2()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ArponAG/Scripts/main/AnimeAdventures.lua"))()
end
    -- End of Auto Load Function
    
    -- Start of Others Section
function others()

    OtherSec:Cheat("Checkbox","⌛ Auto Load Script ⌛", function(bool)
        warn("Auto Load Script is set to " .. tostring(bool))
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
        warn("Auto Grab Daily Quest is set to " .. tostring(bool))
        Settings.autoDailyquest = bool
        saveSettings()
        autoDailyquest()
    end,{enabled = Settings.autoDailyquest})

    OtherSec:Cheat("Checkbox","🗺️ Delete Map 🗺️", function(bool)
        warn("Delete Map is set to " .. tostring(bool))
        Settings.deletemap = bool
        saveSettings()
        DelTer()
        DelMap()
    end,{enabled = Settings.deletemap})
    
    OtherSec:Cheat("Checkbox","Find Picoro [HOP]", function(bool)
        print(bool)
        Settings.picoHOP = bool
        saveSettings()
        TeleportHOP()
    end,{enabled = Settings.picoHOP})
    
    OtherSec:Cheat("Button", "Leave To Lobby", function()
        warn("Return to Lobby")
        Teleport()
    end)

    OtherSec:Cheat("Button", "Redeem All Code", function()
        warn("Redeeming All Code")
        Reedemcode()
    end)
end
    -- End of Others Section
    
    -- Start of Arrange UI Based on Location
if game.PlaceId == 8304191830 then
    scriptupdate()
    credits()
    UnitSec()
    UnitPosition:Cheat("Label","Not available in game Lobby!")
    WorldSec()
    AutoFarmSec()
    MoreFarmSec()
    GenerateConfigSec()
    ChallengeSec()
    NDY:Cheat("Label", "Not available in game Lobby!")
    NDY2:Cheat("Label", "Not available in game Lobby!")
    NDY3:Cheat("Label", "Not available in game Lobby!")
    for i = 1, 6, 1 do
        Unit["Unit" .. i]:Cheat("Label", "Not available in game Lobby!")
    end
    SaveConfig:Cheat(Label, "Not available in game Lobby!")
    AutoSummon()
    SnipeMerchant()
    Webhooksec()
    Webhooksec2()
    LAGGYconfig()
    others()
else
    scriptupdate()
    credits()
    SelectUnits:Cheat("Label", "Available only in Game Lobby!")  
    UnitPosSec()
    WorldSec()
    AutoFarmSec()
    MoreFarmSec()
    GenerateConfig:Cheat("Label", "Only available in game Lobby!")
    ChallengeSec()
    unitconfig()
    AutoSummonSec:Cheat("Label", "Only available in game Lobby!")
    SnipeMerchant()
    Webhooksec()
    LAGGYconfig()
    others()
    WebhookSec:Cheat("Label", "")
    WebhookSec:Cheat("Label", "Test Baby&Shop Webhook Only available in game Lobby!")
end
    -- End of Arrange UI Based on Location
    
    -- Start of Check Challenge
local function checkChallenge()
    for i,v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
        if v:IsA("SurfaceGui") then
            if v:FindFirstChild("ChallengeCleared") then
                return v.ChallengeCleared.Visible
            end
        end
    end
end
    -- End of Check Challenge
    
    -- Start of Check Reward
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
    -- End of Check Reward
    
    -- Start of Start Challenge
local function startChallenge()
    if game.PlaceId == 8304191830 then
        local cpos = plr.Character.HumanoidRootPart.CFrame
        if Settings.AutoChallenge and Settings.AutoFarm or Settings.unitconfig and checkReward() == true then
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
    -- End of Start Challenge
    
    -- Start of Get Boros Portal
function getBorosPortals()
    local portals = {}
    for _, item in pairs(get_inventory_items_unique_items()) do
        if item["item_id"] == "portal_boros_g" then
            table.insert(portals, item)
        end
    end
    return portals
end
    -- End of Get Boros Portal
    
    -- Start of Get CSM Portal
function getCSMPortals()
    local portals = {}
    for _, item in pairs(get_inventory_items_unique_items()) do
        if item["item_id"] == "portal_csm" or "portal_csm1" or "portal_csm2" or "portal_csm3" or "portal_csm4" or "portal_csm5" then
            table.insert(portals, item)
        end
    end
    return portals
end
    -- End of Get CSM Porta
    
    -- Start of Get Zeldris Portal
function getZeldrisPortals()
    local portals = {}
    for _, item in pairs(get_inventory_items_unique_items()) do
        if item["item_id"] == "portal_zeldris" then
            table.insert(portals, item)
        end
    end
    return portals
end
    -- End of Get Zeldris Portal
    
    -- Start of Get Portals
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
    -- End of Get Portals
    
    -- Start of Auto Start Farm Function
Settings.teleporting = true
getgenv().door = "_lobbytemplategreen1"
local function startfarming()
    if game.PlaceId == 8304191830 and Settings.autostart and Settings.teleporting and not Settings.AutoInfinityCastle then
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
                    [2] = { ["friends_only"] = true } }
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
                --Devil fixportal		
            elseif level == "portal_csm" then
                local args = {
                    [1] = GetPortals("portal_csm")[1]["uuid"],
                    [2] = { ["friends_only"] = true } }
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
                warn("Devil farming")
                task.wait(7)
                --7Ds fixportal		
            elseif level == "portal_zeldris" then
                local args = {
                    [1] = GetPortals("portal_zeldris")[1]["uuid"],
                    [2] = { ["friends_only"] = true } }
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
    -- End of Auto Start Farm Function
    
    -- Start of Auto Ability Function [Changed by craymel02 --newfix] autoskill
getgenv().autoabilityerr = false
function autoabilityfunc()
    local player = game.Players.LocalPlayer.Name
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
                        if v._stats.id.Value == "wendy" or v._stats.id.Value == "erwin" then
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
    
    -- Start of Auto Upgrade Function
function autoupgradefunc()
    local success, err = pcall(function() --///
        repeat task.wait() until Workspace:WaitForChild("_UNITS")
        for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
           if v:FindFirstChild("_stats") then
                if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
                end
            end
        end
    end)
    if err then
        warn("Can't Upgrade Unit")
        getgenv().autoupgradeerr = true
        error(err)
    end
end
    -- End of Auto Upgrade Function
    
    -- Start of Auto Farm Infinity Castle Function
local function FarmInfinityCastle()
    if Settings.AutoInfinityCastle and Settings.AutoFarm or Settings.unitconfig then
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
    -- End of Auto Farm Infinity Castle Function

    -- Start of Coroutine for Infinity Castle, Challenge and Normal Farming
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
                getgenv().disableautofarm = true
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
    -- Start of Coroutine for Infinity Castle, Challenge and Normal Farming
    
    -- Start of Coroutine for Auto Ability and Auto Upgrade
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
    -- Start of Coroutine for Auto Ability and Auto Upgrade
    
    -- Start of Auto Leave Function
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
   
    local success, err = pcall(function()
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
            else
                Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end
        
        local ID = ""
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
    end)
   
    if err then
        wait(10)
        TPReturner()
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
    -- End of Auto Leave Function

    -- Start of Server Hop to Find Piccoro
Time = 3 -- seconds
repeat wait() until game:IsLoaded()
wait(Time)
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
function HopServer()
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
   for i,v in pairs(Site.data) do
       local Possible = true
       ID = tostring(v.id)
       if tonumber(v.maxPlayers) > tonumber(v.playing) then
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

function TeleportHOP()
    while wait() do
     warn("Teleport HOP")
        pcall(function()
            HopServer()
            if game.ReplicatedStorage.LOBBY_ASSETS._EVENT_NPCS:FindFirstChild("piccolo_npc") then
                wait(3)
                HopServer()
            elseif game.Workspace._npcs:FindFirstChild("piccolo_npc") then
                local a={[1]="veku_jacket"} game:GetService("ReplicatedStorage").endpoints.client_to_server.try_purchase_april_item:InvokeServer(unpack(a))
                local a={[1]="veku_jacket"} game:GetService("ReplicatedStorage").endpoints.client_to_server.try_purchase_april_item:InvokeServer(unpack(a))
            end
        end)
    end
 end 

if Settings.picoHOP and game.ReplicatedStorage.LOBBY_ASSETS._EVENT_NPCS:FindFirstChild("piccolo_npc") then
    TeleportHOP()
end
    -- End of Server Hop to Find Piccoro
    -- Start of Coroutine to check if Game is Finished, Auto Summon, Snipe Shop
coroutine.resume(coroutine.create(function()
    task.spawn(function()
        local GameFinished = game:GetService("Workspace"):WaitForChild("_DATA"):WaitForChild("GameFinished")
        GameFinished:GetPropertyChangedSignal("Value"):Connect(function()
            print("Changed", GameFinished.Value == true)
            if GameFinished.Value == true then
                repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Enabled == true
                pcall(function() webhook() end)
                warn("Wait next or leave")
                task.wait(2.1)
                if Settings.AutoNext then
                    local a={[1]="next_story"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
                    task.wait(1)
                    local a={[1]="next_story"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
                    warn("Next Story...") 
                elseif Settings.AutoReplay then
                    local a={[1]="replay"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
                    task.wait(1)
                    local a={[1]="replay"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
                    print("Replay...") 
                elseif Settings.AutoContinue then
                    local a={[1]="NextRetry"} game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer(unpack(a))
                    task.wait(1)
                    local a={[1]="NextRetry"} game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower_from_game:InvokeServer(unpack(a))   
                    print("Next Room infint Castle...")              
                elseif Settings.AutoLeave then
                    Teleport()
                    print("Returning to lobby...")
                end
                task.wait(10)
                -- Teleport back to Lobby if Next, Replay, Continue fails after 3 minutes
                for i = 1, 180, 1 do
                    task.wait(1)
                    timer = 180 -i
                    warn("Fail Safe Timer to Teleport: " .. timer)
                    if i == 180 then
                        if game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Enabled == true then
                            Teleport()
                        end
                    end
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
    -- End of Coroutine to check if Game is Finished, Auto Summon, Snipe Shop
    
    -- Start of Placing Unit to Position Function [Changed by craymel02 --newfix]
function PlacePos(map, name, _uuid, unit)
    if Settings["UnitConfig_" .. tostring(map)].Position == nil then
        warn("Unit Position for " .. map .. " not found, Set Unit Position First")
        Settings.unitconfig = false
        saveSettings()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/ArponAG/Scripts/main/AnimeAdventures.lua'))()
    end
    if Settings.unitconfig then
        local pos = Settings["UnitConfig_" .. tostring(map)].Position[unit]
        if name ~= "metal_knight_evolved" then
            local i = math.random(1,6)
            if i == 1 then
                    local args = {
                    [1] = _uuid,
                    [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"]))
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                return
            elseif i == 2 then
                    local args = {
                    [1] = _uuid,
                    [2] = CFrame.new(Vector3.new(pos["x2"], pos["y"], pos["z"]))
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                return
            elseif i == 3 then
                    local args = {
                    [1] = _uuid,
                    [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z2"]))
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                return
            elseif i == 4 then
                    local args = {
                    [1] = _uuid,
                    [2] = CFrame.new(Vector3.new(pos["x3"] or pos["x"], pos["y"], pos["z3"] or pos["z"]))
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                return
            elseif i == 5 then
                    local args = {
                    [1] = _uuid,
                    [2] = CFrame.new(Vector3.new(pos["x2"], pos["y"], pos["z2"]))
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                return
            elseif i == 6 then
                    local args = {
                    [1] = _uuid,
                    [2] = CFrame.new(Vector3.new(pos["x3"] or pos["x2"], pos["y"], pos["z3"] or pos["z2"]))
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                return
            end
        elseif name == "metal_knight_evolved" then
            local i = math.random(1,6)
            if i == 1 then
                task.spawn(function()
                    --place units 0
                    local args = {
                        [1] = _uuid,
                        [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"]))
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
                        [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z2"]))
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
                        [2] = CFrame.new(Vector3.new(pos["x2"], pos["y"], pos["z"]))
                    }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                end)
            end
        end
        return
    end
end
    -- End of Placing Unit to Position Function

    -- Start of Get Current Wave Number [Added by craymel02 --newfix]
function GetWaveNumber()
    return game:GetService("Workspace")["_wave_num"].Value
end
    -- End of Get Current Wave Number
  
    -- Start of Get Unit Info Function
function GetUnitInfo(Unit)
    local unitinfo = Settings.SelectedUnits[Unit]
    local unitinfo_ = unitinfo:split(" #")
    local _units = {}
    local uu = {}
    table.clear(_units)
    table.clear(uu)
    local min;
    for i, v in pairs(Workspace["_UNITS"]:GetChildren()) do 
        for i, v in pairs(v:GetChildren()) do 
            if v.Name == "_stats" then
                if v:FindFirstChild("uuid") then
                    if v.id.Value == unitinfo_[1] then
                        table.insert(_units,v.Parent.Name)
                    end
                end
                if v:FindFirstChild("id") and v:FindFirstChild("uuid") then
                    if v.id.Value == unitinfo_[1] and v.uuid.Value == unitinfo_[2] then
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
    -- End of Get Unit Info Function
    
    -- Start of Upgrade Unit Function
function upgradeunit(name, min)
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
       if v:FindFirstChild("_stats") and v:FindFirstChild("_hitbox") then
            if tostring(v._stats.player.Value) == game.Players.LocalPlayer.Name then
                --[[changes v.Name to match result with variable Name]]
                if v._stats.id.Value == name and v._stats.upgrade.Value < min then
                   game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
                end
            end
        end
    end
end
    -- End of Upgrade Unit Function
    
    -- Start of Unit Config Target Priority [Added by craymel02 --newfix]
function targetpriority(name, priority)
    for i, v in ipairs(Workspace["_UNITS"]:GetChildren()) do
       if v:FindFirstChild("_stats") and v:FindFirstChild("_hitbox") then
            if tostring(v._stats.player.Value) == game.Players.LocalPlayer.Name then
                if v._stats.id.Value == name and v._stats.priority.Value ~= priority then
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.cycle_priority:InvokeServer(v)
                end
            end
        end
    end
end
    -- End of Unit Config Target Priority
  
    -- Start of Auto Farm Sell Unit
function sellunit(name) 
    repeat task.wait() until Workspace:WaitForChild("_UNITS")
    for i, v in ipairs(Workspace["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v._stats.id.value == name and tostring(v._stats.player.Value) == game.Players.LocalPlayer.Name and v._stats:FindFirstChild("upgrade") then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
        end
    end
end
    -- End of Auto Farm Sell Unit
 
    -- Start of Unit Config Sell Unit [Changed by craymel02 --newfix]
function sellunitConfig(name, wave)
    for i, v in ipairs(Workspace["_UNITS"]:GetChildren()) do
       if v:FindFirstChild("_stats") and v:FindFirstChild("_hitbox") then
            if tostring(v._stats.player.Value) == game.Players.LocalPlayer.Name then
                if v._stats.id.Value == name and wave <= GetWaveNumber() then
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
                end
            end
        end
    end
end
    -- End of Unit Config Sell Unit

    -- Start of Getting Unit Config Settings based on current Map [Added by craymel02 --newfix]
function GetUnitSettings(map, unit)
    return Settings["UnitConfig_" .. tostring(map)].Parameters[unit]
end
    -- End of Getting Unit Config Settings based on Current Map

    -- Start of Unit Config Place Unit [Changed by craymel02 --newfix]
function UnitConfigPlaceUnits()
    
    local toPlace = {}
    local toUpgrade = {}
    local map = GLD().map
    
    -- Start of Sort via Priority Function
    local sortRoutine = coroutine.create(function()

        local sortplacement = {}
        local sortupgrade = {}
            
        -- Check if Current Map Index is not Null
        while task.wait(0.5) do
            if Settings.unitconfig == true then
                if Settings["UnitConfig_" .. tostring(map)] == nil then
                    warn(map.." attemp to place "..name)
                    warn("Config for " .. tostring(map) .. " not found, Generating Default Settings")
                    Settings.unitconfig = false
                    reunitcon()
                    else
                        -- Sort Units via Priority
                        for i = 1, 6, 1 do
                            sortplacement[i] = Settings["UnitConfig_" .. tostring(map)].Parameters["UP" .. i].PlacementPriority
                            sortupgrade[i] = Settings["UnitConfig_" .. tostring(map)].Parameters["UP" .. i].UpgradePriority
                        end
                        
                        for i, v in pairs(sortplacement) do
                        	toPlace[v] = tostring("UP" .. i)
                        end
                        
                        for i, v in pairs(sortupgrade) do
                        	toUpgrade[v] = tostring("UP" .. i)
                        end
                end
            end
        end
    end)
    -- End of Sort via Priority Function
    
    -- Start of Place and Upgrade Unit via Priority Order Function
    local UnitviaPriority = coroutine.create(function()
        local priority = {}
        local amount = {}
        local name = {}
        local uuid = {}
        local upgrade = {}
        local _units = {}
        local player = game.Players.LocalPlayer.Name
        
        while task.wait(1.5) do
            if Settings.unitconfig == true then
                
                -- Start of Count Units in Workspace Function
                table.clear(_units)
                for i, v in pairs(Workspace["_UNITS"]:GetChildren()) do 
                    if v:FindFirstChild("_stats") then
                        if v._stats:FindFirstChild("player") then
                            if tostring(v._stats.player.Value) == player then
                                table.insert(_units, v._stats.Parent.Name)
                            end
                        end
                    end
                end
                -- End of Count Units in Workspace Function

                -- Get Unit Information
                for i = 1, 6, 1 do
                    priority["U" .. i] = GetUnitSettings(map, toUpgrade[i])
                    priority["P" .. i] = GetUnitSettings(map, toPlace[i])
                    amount["U" .. i], name["U" .. i], uuid["U" .. i], upgrade["U" .. i] = GetUnitInfo(toUpgrade[i])
                    amount["P" .. i], name["P" .. i], uuid["P" .. i] = GetUnitInfo(toPlace[i])
                end
    
                -- Tally Total Units
                local totalUnits = priority.P1.TotalUnits + priority.P2.TotalUnits + priority.P3.TotalUnits + priority.P4.TotalUnits + priority.P5.TotalUnits + priority.P6.TotalUnits
                
                -- Start of Sell Unit and Set Target Priority Function
                local function SellandTarget()
                    
                    -- Get Unit Information
                    for i = 1, 6, 1 do
                        -- Sell Unit Function
                        if GetWaveNumber() >= priority["P" .. i].SellAtWave and amount["P" .. i] > 0 then
                            sellunitConfig(name["P" .. i], priority["P" .. i].SellAtWave)
                        end
                        
                        -- Set Target Priority Function
                        targetpriority(name["P" .. i], priority["P" .. i].TargetPriority)
                    end
                end
                -- End of Sell Unit and Set Target Priority Function
                
                -- Start of Upgrade Unit Function
                local function upgradeUnit()
            
                    -- If Unit 6 is Bulma or Speedcart, Upgrade them with Priority 1 together
                    if name.U6 == "bulma" or name.U6 == "speedwagon" or name.U6 == "nami_evolved" then
                        if GetWaveNumber() >= priority.U6.UpgradeAtWave then
                           upgradeunit(name.U6, priority.U6.UpgradeCap)
                        end
                    end
                    
                    -- Upgrade Unit via Priority
                    for i = 1, 6, 1 do
                        if i == 1 then
                            if GetWaveNumber() < priority["U" .. i].SellAtWave and GetWaveNumber() >= priority["U" .. i].UpgradeAtWave then
                                if upgrade["U" .. i] < priority["U" .. i].UpgradeCap then
                                    upgradeunit(name["U" .. i], priority["U" .. i].UpgradeCap)
                                end
                            end
                        end
                        
                        if i == 2 or i == 3 or i == 4 or i == 5 or i == 6 then
                            if upgrade["U" .. i - 1] == priority["U" .. i - 1].UpgradeCap then
                                if GetWaveNumber() < priority["U" .. i].SellAtWave and GetWaveNumber() >= priority["U" .. i].UpgradeAtWave then
                                    if upgrade["U" .. i] < priority["U" .. i].UpgradeCap then
                                        upgradeunit(name["U" .. i], priority["U" .. i].UpgradeCap)
                                    end
                                end
                            end
                        end
                    end
                end
                -- End of Upgrade Unit Function
                
                -- Start of Place Unit Function
                local function placeUnit(map)
            
                    -- Place Unit via Priority
                    for i = 1, 6, 1 do
                        if i == 1 then
                            if GetWaveNumber() < priority["P" .. i].SellAtWave and GetWaveNumber() >= priority["P" .. i].PlaceAtWave then
                                if amount["P" .. i] < priority["P" .. i].TotalUnits then
                                    PlacePos(map, name["P" .. i], uuid["P" .. i], toPlace[i])
                                elseif amount["P" .. i] > priority["P" .. i].TotalUnits then
                                    sellunitConfig(name["P" .. i], GetWaveNumber())
                                end
                            end
                        end
                        
                        if i == 2 or i == 3 or i == 4 or i == 5 or i == 6 then
                            if amount["P" .. i - 1] == priority["P" .. i - 1].TotalUnits then
                                if GetWaveNumber() < priority["P" .. i].SellAtWave and GetWaveNumber() >= priority["P" .. i].PlaceAtWave then
                                    if amount["P" .. i] < priority["P" .. i].TotalUnits then
                                        PlacePos(map, name["P" .. i], uuid["P" .. i], toPlace[i])
                                    elseif amount["P" .. i] > priority["P" .. i].TotalUnits then
                                        sellunitConfig(name["P" .. i], GetWaveNumber())
                                    end
                                end
                            end
                        end
                    end
                end
                -- End of Place Unit Function
                
                upgradeUnit()
                SellandTarget()
                
                if #_units ~= totalUnits then
                    placeUnit(map)
                end
            end
        end
    end)
    -- End of Place and Upgrade Unit via Priority Order Function
    
    -- Start Coroutine
    coroutine.resume(sortRoutine)
    coroutine.resume(UnitviaPriority)
    -- End Coroutine
    
end
    -- End of Unit Config Place Unit
    
    -- Start of Reset Unit Config for Current Map [Changed by craymel02 --newfix]
function reunitcon()
    local map = GLD().map
    if game.PlaceId ~= 8304191830 then
        warn("Unit Config for " .. tostring(map) .. " Resetted")
        if Settings["UnitConfig_" .. tostring(map)] == nil then
            Settings["UnitConfig_" .. tostring(map)] = {
                Parameters = {}
            }
        elseif Settings["UnitConfig_" .. tostring(map)].Parameters == nil then
            Settings["UnitConfig_" .. tostring(map)].Parameters = {}
        end
        
            
        for i = 1, 6, 1 do
            
            local _default = {
            PlacementPriority = i,
            PlaceAtWave = 1,
            TotalUnits = 1,
            UpgradePriority = i,
            UpgradeAtWave = 1,
            UpgradeCap = 1,
            SellAtWave = 999,
            TargetPriority = "first"
            }
            
            local UnitPos = "UP"..i
            
            if Settings["UnitConfig_" .. tostring(map)].Parameters[UnitPos] ~= nil then
                Settings["UnitConfig_" .. tostring(map)].Parameters[UnitPos] = _default
            else
                Settings["UnitConfig_" .. tostring(map)].Parameters[UnitPos] = _default
            end
        end
        saveSettings()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/ArponAG/Scripts/main/AnimeAdventures.lua'))()
    end
end
    -- End of Reset Unit Config for Current Map
  
    -- Start of Place Units Function for Auto Farm [Changed by craymel02 --newfix]
function PlaceUnits()
    pcall(function()
        if Settings.AutoFarm and not getgenv().disableautofarm then
            local map = GLD().map
            for i = 1, 6 do
                local unitinfo = Settings.SelectedUnits["UP" .. i]
                if unitinfo ~= nil then
                    local unitinfo_ = unitinfo:split(" #")
                    local pos = Settings["UnitConfig_" .. tostring(map)].Position["UP" .. i]
                    print(map.." attemp to place "..unitinfo_[1])

                    if unitinfo_[1] ~= "metal_knight_evolved" then
                        local args = {
                            [1] = unitinfo_[2],
                            [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"]))
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        local args = {
                            [1] = unitinfo_[2],
                            [2] = CFrame.new(Vector3.new(pos["x2"], pos["y"], pos["z"]))
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        local args = {
                            [1] = unitinfo_[2],
                            [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z2"]))
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        local args = {
                            [1] = unitinfo_[2],
                            [2] = CFrame.new(Vector3.new(pos["x3"] or pos["x"], pos["y"], pos["z3"] or pos["z"]))
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        local args = {
                            [1] = unitinfo_[2],
                            [2] = CFrame.new(Vector3.new(pos["x2"], pos["y"], pos["z2"]))
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        local args = {
                            [1] = unitinfo_[2],
                            [2] = CFrame.new(Vector3.new(pos["x3"] or pos["x2"], pos["y"], pos["z3"] or pos["z2"]))
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                    elseif unitinfo_[1] == "metal_knight_evolved" then
                        task.spawn(function()
                            warn(map .. " attempt to place " .. unitinfo_[1])
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z"]))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end)
                        task.spawn(function()
                            task.wait(2)
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x2"], pos["y"], pos["z"]))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end)
                        task.spawn(function()
                            task.wait(3)
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"], pos["z2"]))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end)
                    end
                end
            end
        end
    end)
end
    -- Start of Place Units Function for Auto Farm
    
    -- Start of Coroutine for Unit Config Auto Farming [Changed by craymel02 --newfix]
    -- Removed Unnecessary if else statements that are not needed for it to work
if game.PlaceId ~= 8304191830 then
    repeat task.wait() until Workspace:WaitForChild("_terrain")
    UnitConfigPlaceUnits()
end
    -- End of Coroutine for Unit Config Auto Farming

    -- Start of Coroutine for Auto Farming [Changed by craymel02 --newfix]
    -- Removed Unnecessary if else statements that are not needed for it to work
coroutine.resume(coroutine.create(function()
    while task.wait(1.5) do
        if game.PlaceId ~= 8304191830 and Settings.AutoFarm and not Settings.unitconfig then
        repeat task.wait() until Workspace:WaitForChild("_map")
            PlaceUnits()
        end
    end
end))
    -- End of Coroutine for Auto Farming

    -- Start of Anti AFK Function
pcall(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
    game:GetService("ReplicatedStorage").endpoints.client_to_server.claim_daily_reward:InvokeServer()
    warn("Anti-AFK has been Loaded!")
end)
    -- End of Anti AFK Function
    
warn("AA v2 Loaded - craymel02 Edition")
warn("Auto Reconnect Loaded")

    -- Start of Auto Reconnect Function [Added by craymel02 --newfix]
coroutine.resume(coroutine.create(function()
    while task.wait(5) do
        game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(a)
            if a.Name == 'ErrorPrompt' then
                task.wait(10)
				warn("Trying to Reconnect")
				TPReturner()
            end
        end)
    end
end))
    -- End of Auto Reconnect Function
    
    -- Start of Auto Load Script Function
if Settings.AutoLoadScript then
    autoload()
end
    -- End of Auto Load Script Function
    
    -- Start of Disabling Annoying Errors
if game.PlaceId ~= 8304191830 then
    game.Players.LocalPlayer.PlayerGui.MessageGui.Enabled = false
    else
        game.Players.LocalPlayer.PlayerGui.MessageGui.Enabled = false
end
    -- End of Disabling Annoying Errors

    -- Start of Hide Name Function
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
    warn("Name Hider has been Loaded!")
end
    -- End of Hide Name Function
    
    -- Start of Delete Map Function
function DelMap()
	task.spawn(function()
		while task.wait() do
			pcall(function()
				if game.Workspace:FindFirstChild("_map") then
					game.Workspace:FindFirstChild("_map"):Destroy()
					warn("Delete Map")
				end
			end)
		end
	end)
end

function DelTer()
	if game.Workspace._terrain:FindFirstChild("terrain") then
    	for i,v in pairs(game:GetService("Workspace")["_terrain"].terrain:GetChildren()) do
        	if v.ClassName == "Model" then v:Destroy() end
			if v.ClassName == "Folder" then v:Destroy() end
			warn("Delete Terrain")
        end
    end  
end

if Settings.deletemap then
    if game.PlaceId ~= 8304191830 then
        DelMap()
        DelTer()
    end
end
    -- End of Delete Map Function
    
    -- Start of Auto Daily Quest Function
function autoDailyquest()
    if Settings.autoDailyquest then
         game:GetService("ReplicatedStorage").endpoints.client_to_server.accept_npc_quest:InvokeServer("7ds_daily")
         wait(15)
    end
end

if Settings.autoDailyquest then
    autoDailyquest()
end
    -- End of Auto Daily Quest Function
    
    -- Start of Redeem Code Function
function Reedemcode()
    codes = {"TWOMILLION","subtomaokuma","CHALLENGEFIX","GINYUFIX","RELEASE","SubToKelvingts","SubToBlamspot","KingLuffy","TOADBOIGAMING","noclypso","FictioNTheFirst","GOLDENSHUTDOWN","GOLDEN"
    ,"SINS2","subtosnowrbx","Cxrsed","subtomaokuma","VIGILANTE"}
        for _, v in pairs(codes) do
        pcall(function() game:GetService("ReplicatedStorage").endpoints["client_to_server"]["redeem_code"]:InvokeServer(v)()end)
    end
end

if Settings.redeemc then
    Reedemcode()
end
    -- Start of Redeem Code Function
    
    -- Start of Laggy Function [Version of HOLYSHz]
function Laggy()
    
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
        
        local function bomb(tableincrease, tries)
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
            
            tries = tonumber(Settings.mix or 0)
            for i = 1, tries do
                game.RobloxReplicatedStorage.SetPlayerBlockList:FireServer(maintable)
            end
        end
        tableincrease = tonumber(Settings.max or 22)
        tries = tonumber(Settings.mix or 0)
        bomb(tableincrease, tries)
    end
end

if Laggy() == false then
    Laggy() 
end

if Laggy() == true then
    notLaggy()
end
    -- End of Laggy Function [Version of HOLYSHz]
