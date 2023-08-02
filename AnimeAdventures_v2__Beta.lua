--updatefix
local version = "v2.0.0b31"

---// Loading Section \\---
repeat  task.wait() until game:IsLoaded()
if game.PlaceId == 8304191830 then
    repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("collection"):FindFirstChild("grid"):FindFirstChild("List"):FindFirstChild("Outer"):FindFirstChild("UnitFrames")
    repeat task.wait() until game.ReplicatedStorage.packages:FindFirstChild("assets")
    repeat task.wait() until game.ReplicatedStorage.packages:FindFirstChild("StarterGui")
else
    repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    game:GetService("ReplicatedStorage").endpoints.client_to_server.vote_start:InvokeServer()
    repeat task.wait() until game:GetService("Workspace")["_waves_started"].Value == true
end

------------------------------
local a = 'V2_Anime_Adventures' -- 
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

    -- Start of Get Level Data of Map [Added by HOLYSHz]
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
local ItemInventoryServiceClient = v5.load_client_service(script, "ItemInventoryServiceClient")
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
if game.Players.LocalPlayer._stats:FindFirstChild("_resourceSummerPearls") then
    SummerPearlsOld = game.Players.LocalPlayer._stats._resourceSummerPearls.Value
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
        world = GetLevelData.id or GetLevelData.world or GetLevelData.name
        mapname = game:GetService("Workspace")._MAP_CONFIG.GetLevelData:InvokeServer()["name"]
        
        cwaves = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.WavesCompleted.Text
        ctime = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.Timer.Text
        btp = plr.PlayerGui:FindFirstChild("BattlePass"):FindFirstChild("Main"):FindFirstChild("Level"):FindFirstChild("V").Text
        btp2 = game:GetService("Players").LocalPlayer.PlayerGui.BattlePass.Main.Level.Title.Text
        btpAlllv = game:GetService("Players").LocalPlayer.PlayerGui.BattlePass.Main.Main.Rewards.Frame.Pages.Home.Amount.Text
        btplv = game:GetService("Players").LocalPlayer.PlayerGui.BattlePass.Main.Level.V.Text
        waves = cwaves:split(": ")
        if waves ~= nil and waves[2] == "999" then waves[2] = "Use [Auto Leave at Wave] or [Test Webhook]" end	
        ttime = ctime:split(": ")
        if waves ~= nil and ttime[2] == "22:55" then ttime[2] = "Use [Auto Leave at Wave] or [Test Webhook]" end	
        gold = ResultHolder:FindFirstChild("LevelRewards"):FindFirstChild("ScrollingFrame"):FindFirstChild("GoldReward"):FindFirstChild("Main"):FindFirstChild("Amount").Text
        if gold == "+99999" then gold = "+0" end	 
        gems = ResultHolder:FindFirstChild("LevelRewards"):FindFirstChild("ScrollingFrame"):FindFirstChild("GemReward"):FindFirstChild("Main"):FindFirstChild("Amount").Text
        if gems == "+99999" then gems = "+0" end	 

        if game.Players.LocalPlayer._stats:FindFirstChild("_resourceSummerPearls") then
            SummerPearls = game.Players.LocalPlayer._stats._resourceSummerPearls.Value
        end
        
        xpx = ResultHolder:FindFirstChild("LevelRewards"):FindFirstChild("ScrollingFrame"):FindFirstChild("XPReward"):FindFirstChild("Main"):FindFirstChild("Amount").Text
        xp = xpx:split(" ")
        if xp[1] == "+99999" then xp[1] = "+0" end
        trophy = ResultHolder:FindFirstChild("LevelRewards"):FindFirstChild("ScrollingFrame"):FindFirstChild("TrophyReward"):FindFirstChild("Main"):FindFirstChild("Amount").Text
        if trophy == "+99999" then trophy = "+0" end	 
        
        totaltime =  ResultHolder:FindFirstChild("Middle"):FindFirstChild("Timer").Text
        totalwaves = ResultHolder:FindFirstChild("Middle"):FindFirstChild("WavesCompleted").Text

        ------------------------------------------------
        --Webhook Tier Challenge

        local v5 = require(game.ReplicatedStorage.src.Loader)
        local poratltierS = v5.LevelData._portal_depth
        if poratltierS == nil then poratltierS = " Not Have Tier " end

        local v5 = require(game.ReplicatedStorage.src.Loader)
        local poratChallengeS = v5.LevelData._challenge
        if poratChallengeS == nil then poratChallengeS = " Not Have Challenge " end
        if poratChallengeS == "double_cost" then poratChallengeS = "High Cost" end
        if poratChallengeS == "short_range" then poratChallengeS = "Short Range" end
        if poratChallengeS == "fast_enemies" then poratChallengeS = "Fast Enemies" end
        if poratChallengeS == "regen_enemies" then poratChallengeS = "Regen Enemies" end
        if poratChallengeS == "tank_enemies" then poratChallengeS = "Tank Enemies" end
        if poratChallengeS == "shield_enemies" then poratChallengeS = "Shield Enemies" end
        if poratChallengeS == "triple_cost" then poratChallengeS = "Triple Cost" end
        if poratChallengeS == "hyper_regen_enemies" then poratChallengeS = "Hyper-Regen Enemies" end
        if poratChallengeS == "hyper_shield_enemies" then poratChallengeS = "Steel-Plated Enemies" end
        if poratChallengeS == "godspeed_enemies" then poratChallengeS = "Godspeed Enemies" end
        if poratChallengeS == "flying_enemies" then poratChallengeS = "Flying Enemies" end
        if poratChallengeS == "mini_range" then poratChallengeS = "Mini-Range" end
        
        --------------------------------------------------------------------

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
            ["username"] = "Anime Adventures V2",
            ["avatar_url"] = "https://tr.rbxcdn.com/7b6a3914cac2e93f7e7f27cbefa92280/150/150/Image/Png",
            ["embeds"] = {
                {
                    ["author"] = {
                        ["name"] = "Anime Adventures |  Results V2 ✔️",
                        ["icon_url"] = "https://cdn.discordapp.com/emojis/997123585476927558.webp?size=96&quality=lossless"
                    },
                    ["thumbnail"] = {
                        ['url'] = thumbnails_avatar.data[1].imageUrl,
                    },
                    ["description"] = " Player Name : 🐱 ||**"..game:GetService("Players").LocalPlayer.Name.."**|| 🐱\nExecutors : 🎮 "..exec.." 🎮 ",
                    ["color"] = 110335,
                    ["timestamp"] = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec),
                    ['footer'] = {
                        ['text'] = "// Made by Negative & HOLYSHz", 
                        ['icon_url'] = "https://yt3.ggpht.com/mApbVVD8mT92f50OJuTObnBbc3j7nDCXMJFBk2SCDpSPcaoH9DB9rxVpJhsB5SxAQo1UN2GzyA=s48-c-k-c0x00ffffff-no-rj"
                    },
                    ["fields"] = {
                        {
                            ["name"] ="Current Level ✨ & Gems 💎 & Gold 💰 & Portals 🌀",
                            ["value"] = "```ini\n"
                                        ..tostring(game.Players.LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text)..  " ✨\nCurrent Gold : "
                                        ..tostring(comma_value(game.Players.LocalPlayer._stats.gold_amount.Value)).. " 💰\nCurrent Gems : "
                                        ..tostring(comma_value(game.Players.LocalPlayer._stats.gem_amount.Value)).. " 💎\nCurrent Trophies : "
                                        ..tostring(comma_value(game.Players.LocalPlayer._stats.trophies.Value)).. " 🏆\nCurrent Portal : "
                                        ..tostring(Count_Portal_list) .." 🌀\nSummer Pearls : "
                                        ..tostring(comma_value(game.Players.LocalPlayer._stats._resourceSummerPearls.Value)).. " 🦪```",
                        },
                        {
                            ["name"] ="Results :",
                            ["value"] = "```ini\nWorld : "..mapname.. " 🌏\nMap : "..world.. " 🗺️\nPortal Tier : " ..tostring(poratltierS).." 🌀\nChallenge : " ..tostring(poratChallengeS).." 🌀\nResults : "..result.. " ⚔️\nWave End : " ..tostring(waves[2]).." 🌊\nTime : " ..tostring(ttime[2]).." ⌛\nAll Kill Count : " ..tostring(comma_value(game.Players.LocalPlayer._stats.kills.Value)).. " ⚔️\nDMG Deal : " ..tostring(comma_value(game.Players.LocalPlayer._stats.damage_dealt.Value)).."⚔️```",
                            ["inline"] = true
                        },
                        {
                            ["name"] ="Rewards :",
                            ["value"] = "```ini\n"  
                                            .. comma_value(gold) .." Gold 💰\n"
                                            .. comma_value(gems) .." Gems 💎\n+"
                                            .. comma_value(SummerPearls - SummerPearlsOld) .." Summer Pearls 🦪\n"
                                            .. comma_value(xp[1]) .." XP 🧪\n"
                                            .. trophy .." Trophy 🏆```",
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
        
        local porn = game:GetService("HttpService"):JSONEncode(data)
        local headers = {["content-type"] = "application/json"}
        local request = http_request or request or HttpPost or syn.request or http.request
        local sex = {Url = url, Body = porn, Method = "POST", Headers = headers}
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
                ["avatar_url"] = "https://tr.rbxcdn.com/5c9e29b3953ec061286e76f08f1718b3/150/150/Image/Png",
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
                ["avatar_url"] = "https://tr.rbxcdn.com/5c9e29b3953ec061286e76f08f1718b3/150/150/Image/Png",
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
                ["avatar_url"] = "https://tr.rbxcdn.com/5c9e29b3953ec061286e76f08f1718b3/150/150/Image/Png",
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
                ["avatar_url"] = "https://tr.rbxcdn.com/5c9e29b3953ec061286e76f08f1718b3/150/150/Image/Png",
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
                    ["name"] = "```" .. item["id"].. " ```",
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
if game.Players.LocalPlayer.PlayerGui:FindFirstChild("FinityUI") then
    game.Players.LocalPlayer.PlayerGui["FinityUI"]:Destroy()
end

--[[if game.Players.LocalPlayer:FindFirstChild("FinityUI") then
    game.Players.LocalPlayer["FinityUI"]:Destroy()
end]]

--[[if game.CoreGui:FindFirstChild("FinityUI") then
    game.CoreGui["FinityUI"]:Destroy()
end]]

local dir = "Anime_Adventures/"..game.Players.LocalPlayer.Name
local Uilib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ArponAG/Scripts/main/finitylib"))()
local exec = tostring(identifyexecutor())
local Window = Uilib.new(true, "[Arpon V2] Anime Adventures "..version.." - "..exec)
Window.ChangeToggleKey(Enum.KeyCode.P)

local Home = Window:Category("🏠 Home")
local Developers = Home:Sector("Anime Adventures")
local asdasd = Home:Sector(" ")
local UIUPDT = Home:Sector("⚙️ Challenge Config ⚙️")


local Farm = Window:Category("🤖 Auto Farm")
local SelectUnits = Farm:Sector("🧙‍ Select Units")
local SelectWorld = Farm:Sector("🌏 Select World")
local UnitPosition = Farm:Sector("🧙 Select Unit Position")
local castleconfig = Farm:Sector("🏯 Infinity Castle 🏯")
local AutoFarmConfig = Farm:Sector("⚙️ Auto Farm Config")
local ChallengeConfig = Farm:Sector("⌛ Challenge Config")


local UC = Window:Category("🧙 Unit Config")
local NDY = UC:Sector("Beta Unit Config ")
local NDY2 = UC:Sector(" ")
local emptyxx = UC:Sector(" ")
local emptyxx2 = UC:Sector(" ")
local Unit1 = UC:Sector("Unit 1")
local Unit2 = UC:Sector("Unit 2")
local Unit3 = UC:Sector("Unit 3")
local Unit4 = UC:Sector("Unit 4")
local Unit5 = UC:Sector("Unit 5")
local Unit6 = UC:Sector("Unit 6")

--- Unit AOE
local UA = Window:Category("⚔️ INF Range")

Unit = {}
for i = 1, 6 do
    Unit["AOE"..i] = UA:Sector("Select Unit " .. i .. " INF Range")
end

local UnitAOE = UA:Sector("INF Range Config ")
local UnitAOE1 = UA:Sector("Check Unit ")
--- End of Unit AOE

local LG = Window:Category("🛠️ Misc [BETA]")
local LowCPU2 = LG:Sector("Low CPU Mode")
local LowCPU3 = LG:Sector("")
local LG1 = LG:Sector("Beta LAGGY Config ")
local DELMAP = LG:Sector("🗺️ New Function 🗺️")
local DELMAP1 = LG:Sector(" ")
local OtherSec = LG:Sector("⌛ Auto Load Script ⌛")
local OtherSec1 = LG:Sector("")
local OtherSec3 = LG:Sector("🐱 Hide Name Player 🐱")
local DelMapConfig = LG:Sector("")
local DelMapConfig2 = LG:Sector("⚙️ Other Config ⚙️")
local DelMapConfig3 = LG:Sector("")
local reFarmConfig = LG:Sector("🤖 Reset Farm Config 🤖")

local ETC = Window:Category("🌐 Discord & Shop")
local AutoSummonSec = ETC:Sector("💸 Auto สุ่ม Units 💸")
local AutoSnipeMerchantSec = ETC:Sector("🏪 Auto ชื้อของร้านค้า Bulma 🏪")
local WebhookSec = ETC:Sector("🌐 Discord Webhook 🌐")
local OtherSec2 = ETC:Sector("")

local Summer = Window:Category("🦸🏽 Event & Skin ")
local SummerItem = Summer:Sector("💸 Auto Buy Summer Item 💸")
local SellPortals = Summer:Sector("🌀 Sell Portals 🌀")
local SummerSkin = Summer:Sector("💸 Auto Sell Summer Skin 💸")
local SummerSkin0 = Summer:Sector("")
local SummerEgg = Summer:Sector("🥚 Auto Open Summer Egg 🥚")


----------------------------------------------
---------------- Units Selection -------------
----------------------------------------------
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
    SelectUnits:Cheat("Button", "🧙 Select Units", function() --Selects Currently Equipped Units!
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
    local a = SelectUnits:Cheat("Dropdown", "🧙 Select Team",function(preset)
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

SelectUnits:Cheat("Checkbox","🦸 Auto Save Unit ", function(bool)
    warn("Auto Save Unit set to " .. tostring(bool))
    Settings.AutoSaveUnit = bool
    saveSettings()
end,{enabled = Settings.AutoSaveUnit })

-- End of Unit Section Function

-- Start of Auto Save Unit Function
function AutoSaveUnit()
    if Settings.AutoSaveUnit then
        local function saveUnit()
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

    local function fetchUnit()
        getgenv().profile_data = { 
            equipped_units = {}
        }
        table.clear(getgenv().profile_data.equipped_units)
        
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
                saveUnit()
            end
        end
    end
    
    fetchUnit()
    
    end
end

-- End of Auto Save Unit Function
----------------------------------------------
------------------ World Section -------------updatefix
----------------------------------------------
local function WorldSec()
    SelectWorld:Cheat("Dropdown", "🔱 Select Category",function(value)
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
            "Dungeon",
            "Secret Portals"
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
            "Hero City","Puppet Island","Virtual Dungeon","Windhym"}
        elseif Settings.WorldCategory == "Legend Stages" then
            storylist = {"Clover Kingdom (Elf Invasion)", "Hollow Invasion","Cape Canaveral (Legend)", "Fabled Kingdom (Legend)", "Hero City (Midnight)", "Virtual Dungeon (Bosses)"}
        elseif Settings.WorldCategory == "Raid Worlds" then
            storylist = {"Storm Hideout","West City", "Infinity Train", "Shiganshinu District - Raid","Hiddel Sand Village - Raid", "Freezo's Invasion", "Entertainment District", 
            "Hero City (Hero Slayer)", "Marine's Ford (Buddha)"}
        elseif Settings.WorldCategory == "Portals" then
            storylist = {"Alien Portals","Zeldris Portals","Demon Portals","Dressrosa Portals","The Eclipse","Summer Events"}
        elseif Settings.WorldCategory == "Dungeon" then
            storylist = {"Cursed Womb","Crused Parade","Anniversary Island"}    
        elseif Settings.WorldCategory == "Secret Portals" then
            storylist = {"Dressrosa Secret Portals","The Eclipse Secret","Summer Secret"} 
        end
    
        for i = 1, #storylist do
            selectworld:AddOption(storylist[i])
        end
    end
    local selectlevel = SelectWorld:Cheat("Dropdown", "🎚️ Select Level",function(value)
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
        elseif level == "Puppet Island" then
            levellist = {"dressrosa_infinite","dressrosa_level_1","dressrosa_level_2","dressrosa_level_3","dressrosa_level_4","dressrosa_level_5","dressrosa_level_6",}
        elseif level == "Virtual Dungeon" then
            levellist = {"sao_infinite","sao_level_1","sao_level_2","sao_level_3","sao_level_4","sao_level_5","sao_level_6",}
        elseif level == "Windhym" then
            levellist = {"berserk_infinite","berserk_level_1","berserk_level_2","berserk_level_3","berserk_level_4","berserk_level_5","berserk_level_6",}
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
        elseif level == "Virtual Dungeon (Bosses)" then
            levellist = {"sao_legend_1","sao_legend_2","sao_legend_3"}
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
        elseif level == "Hero City (Hero Slayer)" then
            levellist = {"mha_stain"}
        elseif level == "Marine's Ford (Buddha)" then
            levellist = {"marineford_sengoku"}
        --///Portals\\\---
        elseif level == "Alien Portals" then
            levellist = {"portal_boros_g"}
        elseif level == "Demon Portals" then
            levellist = {"april_portal_item"}
        elseif level == "Zeldris Portals" then
            levellist = {"portal_zeldris"}    
        elseif level == "Dressrosa Portals" then
            levellist = {"portal_item__dressrosa"}
        elseif level == "The Eclipse" then
            levellist = {"portal_item__eclipse"}
        elseif level == "Summer Events" then
            levellist = {"portal_summer"}
        ---///Dungeon\\\---    updatefix
        elseif level == "Cursed Womb" then
            levellist = {"jjk_finger"}    
        elseif level == "Crused Parade" then
            levellist = {"jjk_raid"}     
        elseif level == "Anniversary Island" then
            levellist = {"namek_anniversary"}  
            --///Secret Portals\\\---   
        elseif level == "Dressrosa Secret Portals" then
            levellist = {"portal_item__doflamingo"}
        elseif level == "The Eclipse Secret" then
            levellist = {"portal_item__femto"}
        elseif level == "Summer Secret" then
            levellist = {"portal_poseidon"}
        end
        for i = 1, #levellist do
            selectlevel:AddOption(levellist[i])
        end
    end
    --fixmap
    local selectdiff = SelectWorld:Cheat("Dropdown", "🔫 Difficulty",function(value)
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
        or level == "jojo_infinite" or level == "opm_infinite" or level == "7ds_infinite" or level == "mha_infinite" 
        or level == "sao_infinite" or level == "berserk_infinite" 
        or level == "dressrosa_infinite" or cata == "Legend Stages" or cata == "Raid Worlds"  then
            diff = {"Hard"}
        elseif cata == "Portals" or cata == "Dungeon" or cata == "Secret Portals"  then
            diff = {"Default"}
        else
            diff = {"Normal", "Hard"}
        end
        for i = 1, #diff do
            selectdiff:AddOption(diff[i])
        end
    end

    --[[Table_Tier = {}
    for i = 0,15 do
        table.insert(Table_Tier,i)
    end

    Settings.SelectedTier = Settings.SelectedTier or 0
    local selectlevel = SelectWorld:Cheat("Dropdown", "🎚️ Portal Tier <=",function(value)
        print(value)
        Settings.SelectedTier = value
        saveSettings()
    end, {options = Table_Tier, default = Settings.SelectedTier})]]

    Table_Tier2 = {}
    for i = 0,15 do
        table.insert(Table_Tier2,i)
    end
    Settings.SelectedTier1 = Settings.SelectedTier1 or 0
    local selectlevel = SelectWorld:Cheat("Dropdown", "🎚️ Tier more than >",function(value)
        warn("Change to : "..value)
        Settings.SelectedTier1 = value
        saveSettings()
    end, {options = Table_Tier2, default = Settings.SelectedTier1})

    Table_Tier3 = {}
    for i = 0,15 do
        table.insert(Table_Tier3,i)
    end
    Settings.SelectedTier2 = Settings.SelectedTier2 or 15
    local selectlevel = SelectWorld:Cheat("Dropdown", "🎚️ Tier less <",function(value)
        warn("Change to : "..value)
        Settings.SelectedTier2 = value
        saveSettings()
    end, {options = Table_Tier3, default = Settings.SelectedTier2})

    
    Settings.SelectedChallenge = Settings.SelectedChallenge or "double_cost"
    local selectlevel = SelectWorld:Cheat("Dropdown", "🎚️ Din't use Challenge",function(value)
        Settings.SelectedChallenge = value
        saveSettings()
    end, { options = {"double_cost","short_range","fast_enemies","regen_enemies", "tank_enemies","shield_enemies","triple_cost","hyper_regen_enemies","hyper_shield_enemies",
    "godspeed_enemies","flying_enemies","mini_range"}, default =Settings.SelectedChallenge})

    Settings.SelectedChallenge2 = Settings.SelectedChallenge2 or "double_cost"
    local selectlevel = SelectWorld:Cheat("Dropdown", "🎚️ Din't use Challenge ",function(value)
        warn("Change to : "..value)
        Settings.SelectedChallenge2 = value
        saveSettings()
    end, { options = {"double_cost","short_range","fast_enemies","regen_enemies", "tank_enemies","shield_enemies","triple_cost","hyper_regen_enemies","hyper_shield_enemies",
    "godspeed_enemies","flying_enemies","mini_range"}, default =Settings.SelectedChallenge2})

    Settings.SelectedChallenge3 = Settings.SelectedChallenge3 or "double_cost"
    local selectlevel = SelectWorld:Cheat("Dropdown", "🎚️ Din't use Challenge ",function(value)
        warn("Change to : "..value)
        Settings.SelectedChallenge3 = value
        saveSettings()
    end, { options = {"double_cost","short_range","fast_enemies","regen_enemies", "tank_enemies","shield_enemies","triple_cost","hyper_regen_enemies","hyper_shield_enemies",
    "godspeed_enemies","flying_enemies","mini_range"}, default =Settings.SelectedChallenge3})

    SelectWorld:Cheat("Checkbox","👬 Friends Only", function(bool)
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

    AutoFarmConfig:Cheat("Checkbox","🏃 Auto Replay ", function(bool)
        print(bool)
        Settings.AutoReplay = bool
        saveSettings()
    end,{enabled = Settings.AutoReplay})
    AutoFarmConfig:Cheat("Checkbox","🏃 Auto Pick Portal [Replay] ", function(bool)
        print(bool)
        Settings.AutoPickPortal = bool
        saveSettings()
    end,{enabled = Settings.AutoPickPortal})
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

    AutoFarmConfig:Cheat("Checkbox","⭐️ Auto Upgrade Units  ", function(bool)
        print(bool)
        Settings.AutoUpgrade = bool
        saveSettings()
    end,{enabled = Settings.AutoUpgrade})
    
    AutoFarmConfig:Cheat("Checkbox","🔥 Auto Abilities [When Attack] ", function(bool)
        print(bool)
        Settings.AutoAbilities = bool
        saveSettings()
    end,{enabled = Settings.AutoAbilities})

    AutoFarmConfig:Cheat("Checkbox","🔥 Auto Abilities [Global Cooldown] ", function(bool)
        print(bool)
        Settings.AutoGCDAbilities = bool
        saveSettings()
    end,{enabled = Settings.AutoGCDAbilities})

    AutoFarmConfig:Cheat("Checkbox"," Auto Buff 100% [Erwin] ", function(bool)
        print(bool)
        Settings.EnableBufferwinLoop = bool
        autoabilityerwin()
        saveSettings()
    end,{enabled = Settings.EnableBufferwinLoop})

    AutoFarmConfig:Cheat("Checkbox"," Auto Buff 100% [Wendy] ", function(bool)
        print(bool)
        Settings.EnableBuffwendyLoop = bool
        autoabilitywendy()
        saveSettings()
    end,{enabled = Settings.EnableBuffwendyLoop})

    AutoFarmConfig:Cheat("Checkbox"," Auto Buff 100% [Leafa] ", function(bool)
        print(bool)
        Settings.EnableBuffleafaLoop = bool
        autoabilityleafa()
        saveSettings()
    end,{enabled = Settings.EnableBuffleafaLoop})

    AutoFarmConfig:Cheat("Checkbox","⭐️ Sell Units At Wave ", function(bool)
        print(bool)
        Settings.AutoSell = bool
        saveSettings()
    end,{enabled = Settings.AutoSell})

    AutoFarmConfig:Cheat("Checkbox","⭐️ Leave At Wave  ", function(bool)
        print(bool)
        Settings.autoQuit = bool
        saveSettings()
    end,{enabled = Settings.autoQuit})

    AutoFarmConfig:Cheat("Textbox", " Sell or Leave at Wave ", function(Value)
        Value = tonumber(Value)
        Settings.AutoSellWave = Value
        saveSettings()
    end, {placeholder = Settings.AutoSellWave})
end
----------------------------------------------
--------------- More Farm Config -------------
----------------------------------------------
local function MoreFarmSec()

    castleconfig:Cheat("Checkbox","🏯 Auto Next Level inf castle  ", function(bool)
        print(bool)
        Settings.AutoContinue = bool
        saveSettings()
    end,{enabled = Settings.AutoContinue })

    castleconfig:Cheat("Checkbox","🏰️ Auto Infinity Castle   ", function(bool)
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
----------- Delete Map Config ---------------- 
----------------------------------------------
local function DELMAPNEW()

    DELMAP:Cheat("Checkbox","🗺️ Delete Map 🗺️ ", function(bool)
        print(bool)
        Settings.deletemap = bool
        saveSettings()
        warn("Enable Delete map")
    end,{enabled = Settings.deletemap})

    DELMAP:Cheat("Checkbox"," Place Anywhere ", function(bool)
        print(bool)
        Settings.placeany = bool
        saveSettings()
        placeAny()
        placeunittwin()
    end,{enabled = Settings.placeany})

    DELMAP:Cheat("Button","Activate Place Anywhere ", function()
        placeAny()
        placeunittwin()
    end)

    DELMAP:Cheat("Checkbox"," Delete Hill [Can't place Hill unit]", function(bool)
		print(Settings.deletehill)
        Settings.deletehill = bool
        saveSettings()
        DelHill()
    end,{enabled = Settings.deletehill})

    DELMAP:Cheat("Button","Activate Delete Hill ", function()
        DelHill()
    end)

end

----------------------------------------------
---------------- Other Config ---------------- 
----------------------------------------------
local function DeleteMapSec()

    DelMapConfig2:Cheat("Button", "Redeem All Code", function()
        print(Settings.redeemc)
        Reedemcode()
    end)

    DelMapConfig2:Cheat("Button", "Leave To Lobby", function()
        warn("Return to Lobby")
        Teleport()
        --TPReturner()
    end)

    DelMapConfig2:Cheat("Checkbox","Auto Grab Daily Quest ", function(bool)
        print(Settings.autoDailyquest)
        Settings.autoDailyquest = bool
        saveSettings()
        autoDailyquest()
    end,{enabled = Settings.autoDailyquest})

    DelMapConfig2:Cheat("Checkbox","Auto Grab Daily Mission ", function(bool)
        print(Settings.autoDailyMission)
        Settings.autoDailyMission = bool
        saveSettings()
        autoDailyMission()
    end,{enabled = Settings.autoDailyMission})

    DelMapConfig2:Cheat("Label","")  

end

----------------------------------------------
------------- Unit AOE Config ---------------- 
----------------------------------------------
local function UNITAOEAA()

    UnitAOE1:Cheat("Button", "Check Unit", function()
        for i, v in pairs(game.Workspace._UNITS:getChildren()) do
            if v:FindFirstChild("_stats"):FindFirstChild("player") then
                if tostring(v._stats.player.Value) == game.Players.LocalPlayer.Name then
                    warn(v)
		        end
	        end
        end
    end)

    UnitAOE:Cheat("Checkbox","Enable INF Range Unit [ZicZac] ", function(bool)
        print(bool)
        Settings.blackhole = bool
        saveSettings()
    end,{enabled = Settings.blackhole})

    --Unit1
    task.spawn(function()
        while task.wait() do
            if Settings.blackhole then

                local base = game.Workspace._BASES.player.base.fake_unit.HumanoidRootPart.CFrame
                local player = game.Players.LocalPlayer.Name
                local Unit = game.Workspace._UNITS
                local distanceTable = {}
            
                local function getDistance(toCheck)
                    table.clear(distanceTable)
                    if Unit:getChildren()[1] then
                        for i, v in pairs(Unit:getChildren()) do
                            if v:WaitForChild("_stats"):FindFirstChild("base") then
                                if tostring(v._stats.base.Value) == "pve" then
                                    distance = tostring((base.Position - v.HumanoidRootPart.CFrame.Position).Magnitude)
                                    table.insert(distanceTable, tonumber(distance))
                                    table.sort(distanceTable)
                                    if tonumber(distance) == distanceTable[1] then
                                        enemy = v.HumanoidRootPart.CFrame *
                                            CFrame.new(0, 0, -2)
                                    end
                                end
                            end
                        end
                    end
                    return enemy
                end
                    
        local function followEnemyU1()
            --Settings.unitAOE = "Select Units"
            local base = game.Workspace._BASES.player.base.fake_unit.HumanoidRootPart.CFrame
            local player = game.Players.LocalPlayer.Name
            local Unit = game.Workspace._UNITS
                if Unit:getChildren()[1] then
                    for i, v in pairs(Unit:getChildren()) do
                        if v:WaitForChild("_stats"):FindFirstChild("player") then
                            if tostring(v._stats.player.Value) == player then
                                local success, err = pcall(function()
                                    if tostring(v._stats.player.Value) == player then
                                        if tostring(v._stats.id.Value) == Settings.UnitAOE1 then
                                            --if game.Workspace._wave_time.Value > 0 then

                                            --game.Workspace._UNITS[Settings.UnitAOE1].HumanoidRootPart.CFrame = getDistance("enemyName")
                                            --game.Workspace._UNITS[Settings.UnitAOE1].HumanoidRootPart_Fake.CFrame = getDistance("enemyName")

                                            v.HumanoidRootPart.CFrame = getDistance("enemyName")
                                            v.HumanoidRootPart_Fake.CFrame = getDistance("enemyName")

                                        end
                                    end
                                end)
                                if err then
                                    return
                                    end
                                end
                            end
                        end
                    end
                end
                followEnemyU1()
                end
            end
        end)


    --Unit2
    task.spawn(function()
        while task.wait() do
            if Settings.blackhole then

                local base = game.Workspace._BASES.player.base.fake_unit.HumanoidRootPart.CFrame
                local player = game.Players.LocalPlayer.Name
                local Unit = game.Workspace._UNITS
                local distanceTable = {}
            
                local function getDistance(toCheck)
                    table.clear(distanceTable)
                    if Unit:getChildren()[1] then
                        for i, v in pairs(Unit:getChildren()) do
                            if v:WaitForChild("_stats"):FindFirstChild("base") then
                                if tostring(v._stats.base.Value) == "pve" then
                                    distance = tostring((base.Position - v.HumanoidRootPart.CFrame.Position).Magnitude)
                                    table.insert(distanceTable, tonumber(distance))
                                    table.sort(distanceTable)
                                    if tonumber(distance) == distanceTable[1] then
                                        enemy = v.HumanoidRootPart.CFrame *
                                            CFrame.new(0, 0, -2)
                                    end
                                end
                            end
                        end
                    end
                    return enemy
                end
                    
        local function followEnemyU2()
            --Settings.unitAOE = "Select Units"
            local base = game.Workspace._BASES.player.base.fake_unit.HumanoidRootPart.CFrame
            local player = game.Players.LocalPlayer.Name
            local Unit = game.Workspace._UNITS
                if Unit:getChildren()[1] then
                    for i, v in pairs(Unit:getChildren()) do
                        if v:WaitForChild("_stats"):FindFirstChild("player") then
                            if tostring(v._stats.player.Value) == player then
                                local success, err = pcall(function()
                                    if tostring(v._stats.player.Value) == player then
                                        if tostring(v._stats.id.Value) == Settings.UnitAOE2 then
                                            --if game.Workspace._wave_time.Value > 0 then

                                            --game.Workspace._UNITS[Settings.UnitAOE2].HumanoidRootPart.CFrame = getDistance("enemyName")
                                            --game.Workspace._UNITS[Settings.UnitAOE2].HumanoidRootPart_Fake.CFrame = getDistance("enemyName")

                                            v.HumanoidRootPart.CFrame = getDistance("enemyName")
                                            v.HumanoidRootPart_Fake.CFrame = getDistance("enemyName")

                                        end
                                    end
                                end)
                                if err then
                                    return
                                    end
                                end
                            end
                        end
                    end
                end
                followEnemyU2()
                end
            end
        end)

    --Unit3
    task.spawn(function()
        while task.wait() do
            if Settings.blackhole then

                local base = game.Workspace._BASES.player.base.fake_unit.HumanoidRootPart.CFrame
                local player = game.Players.LocalPlayer.Name
                local Unit = game.Workspace._UNITS
                local distanceTable = {}
            
                local function getDistance(toCheck)
                    table.clear(distanceTable)
                    if Unit:getChildren()[1] then
                        for i, v in pairs(Unit:getChildren()) do
                            if v:WaitForChild("_stats"):FindFirstChild("base") then
                                if tostring(v._stats.base.Value) == "pve" then
                                    distance = tostring((base.Position - v.HumanoidRootPart.CFrame.Position).Magnitude)
                                    table.insert(distanceTable, tonumber(distance))
                                    table.sort(distanceTable)
                                    if tonumber(distance) == distanceTable[1] then
                                        enemy = v.HumanoidRootPart.CFrame *
                                            CFrame.new(0, 0, -2)
                                    end
                                end
                            end
                        end
                    end
                    return enemy
                end
                    
        local function followEnemyU3()
            --Settings.unitAOE = "Select Units"
            local base = game.Workspace._BASES.player.base.fake_unit.HumanoidRootPart.CFrame
            local player = game.Players.LocalPlayer.Name
            local Unit = game.Workspace._UNITS
                if Unit:getChildren()[1] then
                    for i, v in pairs(Unit:getChildren()) do
                        if v:WaitForChild("_stats"):FindFirstChild("player") then
                            if tostring(v._stats.player.Value) == player then
                                local success, err = pcall(function()
                                    if tostring(v._stats.player.Value) == player then
                                        if tostring(v._stats.id.Value) == Settings.UnitAOE3 then
                                            --if game.Workspace._wave_time.Value > 0 then

                                            --game.Workspace._UNITS[Settings.UnitAOE3].HumanoidRootPart.CFrame = getDistance("enemyName")
                                            --game.Workspace._UNITS[Settings.UnitAOE3].HumanoidRootPart_Fake.CFrame = getDistance("enemyName")

                                            v.HumanoidRootPart.CFrame = getDistance("enemyName")
                                            v.HumanoidRootPart_Fake.CFrame = getDistance("enemyName")

                                        end
                                    end
                                end)
                                if err then
                                    return
                                    end
                                end
                            end
                        end
                    end
                end
                followEnemyU3()
                end
            end
        end)

    --Unit4
    task.spawn(function()
        while task.wait() do
            if Settings.blackhole then

                local base = game.Workspace._BASES.player.base.fake_unit.HumanoidRootPart.CFrame
                local player = game.Players.LocalPlayer.Name
                local Unit = game.Workspace._UNITS
                local distanceTable = {}
            
                local function getDistance(toCheck)
                    table.clear(distanceTable)
                    if Unit:getChildren()[1] then
                        for i, v in pairs(Unit:getChildren()) do
                            if v:WaitForChild("_stats"):FindFirstChild("base") then
                                if tostring(v._stats.base.Value) == "pve" then
                                    distance = tostring((base.Position - v.HumanoidRootPart.CFrame.Position).Magnitude)
                                    table.insert(distanceTable, tonumber(distance))
                                    table.sort(distanceTable)
                                    if tonumber(distance) == distanceTable[1] then
                                        enemy = v.HumanoidRootPart.CFrame *
                                            CFrame.new(0, 0, -2)
                                    end
                                end
                            end
                        end
                    end
                    return enemy
                end
                    
        local function followEnemyU4()
            --Settings.unitAOE = "Select Units"
            local base = game.Workspace._BASES.player.base.fake_unit.HumanoidRootPart.CFrame
            local player = game.Players.LocalPlayer.Name
            local Unit = game.Workspace._UNITS
                if Unit:getChildren()[1] then
                    for i, v in pairs(Unit:getChildren()) do
                        if v:WaitForChild("_stats"):FindFirstChild("player") then
                            if tostring(v._stats.player.Value) == player then
                                local success, err = pcall(function()
                                    if tostring(v._stats.player.Value) == player then
                                        if tostring(v._stats.id.Value) == Settings.UnitAOE4 then
                                            --if game.Workspace._wave_time.Value > 0 then

                                            --game.Workspace._UNITS[Settings.UnitAOE4].HumanoidRootPart.CFrame = getDistance("enemyName")
                                            --game.Workspace._UNITS[Settings.UnitAOE4].HumanoidRootPart_Fake.CFrame = getDistance("enemyName")

                                            v.HumanoidRootPart.CFrame = getDistance("enemyName")
                                            v.HumanoidRootPart_Fake.CFrame = getDistance("enemyName")

                                        end
                                    end
                                end)
                                if err then
                                    return
                                    end
                                end
                            end
                        end
                    end
                end
                followEnemyU4()
                end
            end
        end)

    --Unit5
    task.spawn(function()
        while task.wait() do
            if Settings.blackhole then

                local base = game.Workspace._BASES.player.base.fake_unit.HumanoidRootPart.CFrame
                local player = game.Players.LocalPlayer.Name
                local Unit = game.Workspace._UNITS
                local distanceTable = {}
            
                local function getDistance(toCheck)
                    table.clear(distanceTable)
                    if Unit:getChildren()[1] then
                        for i, v in pairs(Unit:getChildren()) do
                            if v:WaitForChild("_stats"):FindFirstChild("base") then
                                if tostring(v._stats.base.Value) == "pve" then
                                    distance = tostring((base.Position - v.HumanoidRootPart.CFrame.Position).Magnitude)
                                    table.insert(distanceTable, tonumber(distance))
                                    table.sort(distanceTable)
                                    if tonumber(distance) == distanceTable[1] then
                                        enemy = v.HumanoidRootPart.CFrame *
                                            CFrame.new(0, 0, -2)
                                    end
                                end
                            end
                        end
                    end
                    return enemy
                end
                    
        local function followEnemyU5()
            --Settings.unitAOE = "Select Units"
            local base = game.Workspace._BASES.player.base.fake_unit.HumanoidRootPart.CFrame
            local player = game.Players.LocalPlayer.Name
            local Unit = game.Workspace._UNITS
                if Unit:getChildren()[1] then
                    for i, v in pairs(Unit:getChildren()) do
                        if v:WaitForChild("_stats"):FindFirstChild("player") then
                            if tostring(v._stats.player.Value) == player then
                                local success, err = pcall(function()
                                    if tostring(v._stats.player.Value) == player then
                                        if tostring(v._stats.id.Value) == Settings.UnitAOE5 then
                                            --if game.Workspace._wave_time.Value > 0 then

                                            --game.Workspace._UNITS[Settings.UnitAOE5].HumanoidRootPart.CFrame = getDistance("enemyName")
                                            --game.Workspace._UNITS[Settings.UnitAOE5].HumanoidRootPart_Fake.CFrame = getDistance("enemyName")

                                            v.HumanoidRootPart.CFrame = getDistance("enemyName")
                                            v.HumanoidRootPart_Fake.CFrame = getDistance("enemyName")

                                        end
                                    end
                                end)
                                if err then
                                    return
                                    end
                                end
                            end
                        end
                    end
                end
                followEnemyU5()
                end
            end
        end)

    --Unit6
    task.spawn(function()
        while task.wait() do
            if Settings.blackhole then

        local base = game.Workspace._BASES.player.base.fake_unit.HumanoidRootPart.CFrame
        local player = game.Players.LocalPlayer.Name
        local Unit = game.Workspace._UNITS
        local distanceTable = {}

        local function getDistance(toCheck)
            table.clear(distanceTable)
            if Unit:getChildren()[1] then
                for i, v in pairs(Unit:getChildren()) do
                    if v:WaitForChild("_stats"):FindFirstChild("base") then
                        if tostring(v._stats.base.Value) == "pve" then
                            distance = tostring((base.Position - v.HumanoidRootPart.CFrame.Position).Magnitude)
                            table.insert(distanceTable, tonumber(distance))
                            table.sort(distanceTable)
                            if tonumber(distance) == distanceTable[1] then
                                enemy = v.HumanoidRootPart.CFrame *
                                            CFrame.new(0, 0, -2)
                            end
                        end
                    end
                end
            end
            return enemy
        end
                        
        local function followEnemyU6()
            --Settings.unitAOE = "Select Units"
            local base = game.Workspace._BASES.player.base.fake_unit.HumanoidRootPart.CFrame
            local player = game.Players.LocalPlayer.Name
            local Unit = game.Workspace._UNITS
                if Unit:getChildren()[1] then
                    for i, v in pairs(Unit:getChildren()) do
                        if v:WaitForChild("_stats"):FindFirstChild("player") then
                            if tostring(v._stats.player.Value) == player then
                                local success, err = pcall(function()
                                    if tostring(v._stats.player.Value) == player then
                                        if tostring(v._stats.id.Value) == Settings.UnitAOE6 then

                                            v.HumanoidRootPart.CFrame = getDistance("enemyName")
                                            v.HumanoidRootPart_Fake.CFrame = getDistance("enemyName")

                                        end
                                    end
                                end)
                                if err then
                                    return
                                    end
                                end
                            end
                        end
                    end
                end
                followEnemyU6()
                end
            end
        end)

        --Unit7
    task.spawn(function()
        while task.wait() do
            if Settings.blackhole then

        local base = game.Workspace._BASES.player.base.fake_unit.HumanoidRootPart.CFrame
        local player = game.Players.LocalPlayer.Name
        local Unit = game.Workspace._UNITS
        local distanceTable = {}

        local function getDistance(toCheck)
            table.clear(distanceTable)
            if Unit:getChildren()[1] then
                for i, v in pairs(Unit:getChildren()) do
                    if v:WaitForChild("_stats"):FindFirstChild("base") then
                        if tostring(v._stats.base.Value) == "pve" then
                            distance = tostring((base.Position - v.HumanoidRootPart.CFrame.Position).Magnitude)
                            table.insert(distanceTable, tonumber(distance))
                            table.sort(distanceTable)
                            if tonumber(distance) == distanceTable[1] then
                                enemy = v.HumanoidRootPart.CFrame *
                                            CFrame.new(0, 0, -2)
                            end
                        end
                    end
                end
            end
            return enemy
        end
                        
        local function followEnemyU7()
            --Settings.unitAOE = "Select Units"
            local base = game.Workspace._BASES.player.base.fake_unit.HumanoidRootPart.CFrame
            local player = game.Players.LocalPlayer.Name
            local Unit = game.Workspace._UNITS
                if Unit:getChildren()[1] then
                    for i, v in pairs(Unit:getChildren()) do
                        if v:WaitForChild("_stats"):FindFirstChild("player") then
                            if tostring(v._stats.player.Value) == player then
                                local success, err = pcall(function()
                                    if tostring(v._stats.player.Value) == player then
                                        if tostring(v._stats.id.Value) == Settings.UnitAOE7 then

                                            v.HumanoidRootPart.CFrame = getDistance("enemyName")
                                            v.HumanoidRootPart_Fake.CFrame = getDistance("enemyName")

                                        end
                                    end
                                end)
                                if err then
                                    return
                                    end
                                end
                            end
                        end
                    end
                end
                followEnemyU7()
                end
            end
        end)

end
--- Fetch Units from Equipped List
if Settings.SelectedUnits ~= nil then
    local names = {}
    for h = 1, 6 do
        Units = Settings.SelectedUnits["U"..h]:split(" #")
        table.insert(names, Units[1])
    end
    --- End of Fetch Unit
    --- Check Slot Unit to Dropdown 
    --Unit1
    for i = 1, 1 do
        Unit["AOE"..i]:Cheat("Dropdown", "Select Unit " .. i .. " Name",function(value)
            Settings.UnitAOE1 = value
            saveSettings()
        end, { options = { "Off", names[i] }, default = Settings.UnitAOE1 or nil})
    end
    --Unit2
    for i = 2, 2 do
        Unit["AOE"..i]:Cheat("Dropdown", "Select Unit " .. i .. " Name",function(value)
            Settings.UnitAOE2 = value
            saveSettings()
        end, { options = { "Off", names[i] }, default = Settings.UnitAOE2 or nil})
    end
    --Unit3
    for i = 3, 3 do
        Unit["AOE"..i]:Cheat("Dropdown", "Select Unit " .. i .. " Name",function(value)
            Settings.UnitAOE3 = value
            saveSettings()
        end, { options = { "Off", names[i] }, default = Settings.UnitAOE3 or nil})
    end
    --Unit4
    for i = 4, 4 do
        Unit["AOE"..i]:Cheat("Dropdown", "Select Unit " .. i .. " Name",function(value)
            Settings.UnitAOE4 = value
            saveSettings()
        end, { options = { "Off", names[i] }, default = Settings.UnitAOE4 or nil})
    end
    --Unit5
    for i = 5, 5 do
        Unit["AOE"..i]:Cheat("Dropdown", "Select Unit " .. i .. " Name",function(value)
            Settings.UnitAOE5 = value
            saveSettings()
        end, { options = { "Off", names[i] }, default = Settings.UnitAOE5 or nil})
    end
    --Unit6
    for i = 6, 6 do
        Unit["AOE"..i]:Cheat("Dropdown", "Select Unit " .. i .. " Name",function(value)
            Settings.UnitAOE6 = value
            saveSettings()
        end, { options = { "Off", names[i] }, default = Settings.UnitAOE6 or nil})
    end
    --- End Check Unit
    Settings.UnitAOE7 = Settings.UnitAOE7 or "femto"
    UnitAOE:Cheat("Dropdown", " Select Griffin Name ",function(value)
        warn("Change to : "..value)
        Settings.UnitAOE7 = value
        saveSettings()
    end, { options = {"None","femto_egg","griffith_reincarnation","femto"}, default =Settings.UnitAOE7})


end
----------------------------------------------
------------------ credits -------------------
----------------------------------------------
local function credits()

    Developers:Cheat("Label","📝 Scripted by: Arpon AG#6612 & Forever4D#0001 & HOLYSHz#3819 ")    
    Developers:Cheat("Label","📝 Also thanks to Trapstar#7845, bytenode#9646 for the help!")    
    Developers:Cheat("Label","📐 UI By: detourious @ v3rmillion.net")    
    Developers:Cheat("Label","🔧 To toggle the script press \" P \"")   
    Developers:Cheat("Button","🔗 Discord Invite", function()
        setclipboard("https://discord.gg/CQJ4Wfvefk")
    end)     
    UIUPDT:Cheat("Label"," \n \n \n \n \n \n \n \n \n \n double_cost = 'High Cost'   \n short_range = 'Short Range'   \n fast_enemies = 'Fast Enemies'  \n regen_enemies = 'Regen Enemies'  \n tank_enemies = 'Tank Enemies'  \n shield_enemies = 'Shield Enemies'  \n triple_cost = 'Triple Cost'   \n hyper_regen_enemies = 'Hyper-Regen Enemies'   \n hyper_shield_enemies = 'Steel-Plated Enemies'   \n godspeed_enemies = 'Godspeed Enemies'   \n flying_enemies = 'Flying Enemies'   \n mini_range = 'Mini-Range'  ")   
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
--updatefix 
function saveposTEST(UnitPos, a,a2,a3,a4,a5,a6)
    local GetLevelData = game.workspace._MAP_CONFIG:WaitForChild("GetLevelData"):InvokeServer()
    world = GetLevelData.world or GetLevelData.name
    if game.workspace._MAP_CONFIG:WaitForChild("GetLevelData") then
        updatepos(world, UnitPos, a,a2,a3,a4,a5,a6)
    end
    warn("savepos test")
end
--fixmap
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
    elseif game.Workspace._map:FindFirstChild("linings") then
        updatepos("OPnew", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("buildingsouter") then
        updatepos("Modako", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("water beams") then
        updatepos("sao", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("swords") then
        updatepos("Berserk", UnitPos, a,a2,a3,a4,a5,a6)
    elseif game.Workspace._map:FindFirstChild("Storm") then
        updatepos("Eclipse", UnitPos, a,a2,a3,a4,a5,a6)
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
    
    UnitPosition:Cheat("Button", " Unit 1 Position", function()
        MouseClick2("UP1")
    end)
    UnitPosition:Cheat("Button", " Unit 2 Position", function()
        MouseClick2("UP2")
    end)
    UnitPosition:Cheat("Button", " Unit 3 Position", function()
        MouseClick2("UP3")
    end)
    UnitPosition:Cheat("Button", " Unit 4 Position", function()
        MouseClick2("UP4")
    end)
    UnitPosition:Cheat("Button", " Unit 5 Position", function()
        MouseClick2("UP5")
    end)
    UnitPosition:Cheat("Button", " Unit 6 Position", function()
        MouseClick2("UP6")
    end)
end
local function unitconfig()

    NDY:Cheat("Checkbox"," Enable Unit Config  ", function(bool)
        print(bool)
        Settings.unitconfig = bool
        saveSettings()
    end,{enabled = Settings.unitconfig })

    NDY2:Cheat("Button", "Reset unit config", function()
        print(Settings.reunitc)
        reunitcon()
    end)

    --//UNIT 1
    
    Settings.U1_Priority = Settings.U1_Priority or "first"
    Unit1:Cheat("Dropdown", "Target Priority ",function(value)
        warn("Change to : "..value)
        Settings.U1_Priority = value
        saveSettings()
    end, { options = {"first","closest","last","farthest", "strongest","weakest","flying"}, default =Settings.U1_Priority})

    Settings.U1_Wave = Settings.U1_Wave or 1
    Unit1:Cheat("Textbox", "Place from wave", function(Value)
        Value = tonumber(Value)
        Settings.U1_Wave = Value
        saveSettings()
    end, {placeholder = Settings.U1_Wave})

    Settings.U1_TotalAmmount = Settings.U1_TotalAmmount or 6
    Unit1:Cheat("Textbox", "Total Units", function(Value)
        Value = tonumber(Value)
        Settings.U1_TotalAmmount = Value
        saveSettings()
    end, {placeholder = Settings.U1_TotalAmmount})


    Settings.U1_UpgWave = Settings.U1_UpgWave or 1
    Unit1:Cheat("Textbox", "Upgrade from wave", function(Value)
        Value = tonumber(Value)
        Settings.U1_UpgWave = Value
        saveSettings()
    end, {placeholder = Settings.U1_UpgWave})

    Settings.U1_UpgCap = Settings.U1_UpgCap or 9
    Unit1:Cheat("Textbox", "Upgrade Cap", function(Value)
        Value = tonumber(Value)
        Settings.U1_UpgCap = Value
        saveSettings()
    end, {placeholder = Settings.U1_UpgCap})

    Settings.U1_SellWave = Settings.U1_SellWave or 999
    Unit1:Cheat("Textbox", "Auto Sell at wave", function(Value)
        Value = tonumber(Value)
        Settings.U1_SellWave = Value
        saveSettings()
    end, {placeholder = Settings.U1_SellWave}) 
    
    --//UNIT 2
    Settings.U2_Priority = Settings.U2_Priority or "first"
    Unit2:Cheat("Dropdown", "Target Priority ",function(value)
        warn("Change to : "..value)
        Settings.U2_Priority = value
        saveSettings()
    end, { options = {"first","closest","last","farthest", "strongest","weakest","flying"}, default =Settings.U2_Priority})

    Settings.U2_Wave = Settings.U2_Wave or 1
    Unit2:Cheat("Textbox", "Place from wave", function(Value)
        Value = tonumber(Value)
        Settings.U2_Wave = Value
        saveSettings()
    end, {placeholder = Settings.U2_Wave})

    Settings.U2_TotalAmmount = Settings.U2_TotalAmmount or 6
    Unit2:Cheat("Textbox", "Total Units", function(Value)
        Value = tonumber(Value)
        Settings.U2_TotalAmmount = Value
        saveSettings()
    end, {placeholder = Settings.U2_TotalAmmount})

    Settings.U2_UpgWave = Settings.U2_UpgWave or 1
    Unit2:Cheat("Textbox", "Upgrade from wave", function(Value)
        Value = tonumber(Value)
        Settings.U2_UpgWave = Value
        saveSettings()
    end, {placeholder = Settings.U2_UpgWave})

    Settings.U2_UpgCap = Settings.U2_UpgCap or 9
    Unit2:Cheat("Textbox", "Upgrade Cap", function(Value)
        Value = tonumber(Value)
        Settings.U2_UpgCap = Value
        saveSettings()
    end, {placeholder = Settings.U2_UpgCap})

    Settings.U2_SellWave = Settings.U2_SellWave or 999
    Unit2:Cheat("Textbox", "Auto Sell at wave", function(Value)
        Value = tonumber(Value)
        Settings.U2_SellWave = Value
        saveSettings()
    end, {placeholder = Settings.U2_SellWave}) 
    
    --//UNIT 3
    Settings.U3_Priority = Settings.U3_Priority or "first"
    Unit3:Cheat("Dropdown", "Target Priority ",function(value)
        warn("Change to : "..value)
        Settings.U3_Priority = value
        saveSettings()
    end, { options = {"first","closest","last","farthest", "strongest","weakest","flying"}, default =Settings.U3_Priority})

    Settings.U3_Wave = Settings.U3_Wave or 1
    Unit3:Cheat("Textbox", "Place from wave", function(Value)
        Value = tonumber(Value)
        Settings.U3_Wave = Value
        saveSettings()
    end, {placeholder = Settings.U3_Wave})

    Settings.U3_TotalAmmount = Settings.U3_TotalAmmount or 6
    Unit3:Cheat("Textbox", "Total Units", function(Value)
        Value = tonumber(Value)
        Settings.U3_TotalAmmount = Value
        saveSettings()
    end, {placeholder = Settings.U3_TotalAmmount})

    Settings.U3_UpgWave = Settings.U3_UpgWave or 1
    Unit3:Cheat("Textbox", "Upgrade from wave", function(Value)
        Value = tonumber(Value)
        Settings.U3_UpgWave = Value
        saveSettings()
    end, {placeholder = Settings.U3_UpgWave})

    Settings.U3_UpgCap = Settings.U3_UpgCap or 9
    Unit3:Cheat("Textbox", "Upgrade Cap", function(Value)
        Value = tonumber(Value)
        Settings.U3_UpgCap = Value
        saveSettings()
    end, {placeholder = Settings.U3_UpgCap})

    Settings.U3_SellWave = Settings.U3_SellWave or 999
    Unit3:Cheat("Textbox", "Auto Sell at wave", function(Value)
        Value = tonumber(Value)
        Settings.U3_SellWave = Value
        saveSettings()
    end, {placeholder = Settings.U3_SellWave})  

    --//UNIT 4
    Settings.U4_Priority = Settings.U4_Priority or "first"
    Unit4:Cheat("Dropdown", "Target Priority ",function(value)
        warn("Change to : "..value)
        Settings.U4_Priority = value
        saveSettings()
    end, { options = {"first","closest","last","farthest", "strongest","weakest","flying"}, default =Settings.U4_Priority})

    Settings.U4_Wave = Settings.U4_Wave or 1
    Unit4:Cheat("Textbox", "Place from wave", function(Value)
        Value = tonumber(Value)
        Settings.U4_Wave = Value
        saveSettings()
    end, {placeholder = Settings.U4_Wave})

    Settings.U4_TotalAmmount = Settings.U4_TotalAmmount or 6
    Unit4:Cheat("Textbox", "Total Units", function(Value)
        Value = tonumber(Value)
        Settings.U4_TotalAmmount = Value
        saveSettings()
    end, {placeholder = Settings.U4_TotalAmmount})

    Settings.U4_UpgWave = Settings.U4_UpgWave or 1
    Unit4:Cheat("Textbox", "Upgrade from wave", function(Value)
        Value = tonumber(Value)
        Settings.U4_UpgWave = Value
        saveSettings()
    end, {placeholder = Settings.U4_UpgWave})

    Settings.U4_UpgCap = Settings.U4_UpgCap or 9
    Unit4:Cheat("Textbox", "Upgrade Cap", function(Value)
        Value = tonumber(Value)
        Settings.U4_UpgCap = Value
        saveSettings()
    end, {placeholder = Settings.U4_UpgCap})

    Settings.U4_SellWave = Settings.U4_SellWave or 999
    Unit4:Cheat("Textbox", "Auto Sell at wave", function(Value)
        Value = tonumber(Value)
        Settings.U4_SellWave = Value
        saveSettings()
    end, {placeholder = Settings.U4_SellWave})   
    
    --//UNIT 5
    Settings.U5_Priority = Settings.U5_Priority or "first"
    Unit5:Cheat("Dropdown", "Target Priority ",function(value)
        warn("Change to : "..value)
        Settings.U5_Priority = value
        saveSettings()
    end, { options = {"first","closest","last","farthest", "strongest","weakest","flying"}, default =Settings.U5_Priority})

    Settings.U5_Wave = Settings.U5_Wave or 1
    Unit5:Cheat("Textbox", "Place from wave", function(Value)
        Value = tonumber(Value)
        Settings.U5_Wave = Value
        saveSettings()
    end, {placeholder = Settings.U5_Wave})

    Settings.U5_TotalAmmount = Settings.U5_TotalAmmount or 6
    Unit5:Cheat("Textbox", "Total Units", function(Value)
        Value = tonumber(Value)
        Settings.U5_TotalAmmount = Value
        saveSettings()
    end, {placeholder = Settings.U5_TotalAmmount})

    Settings.U5_UpgWave = Settings.U5_UpgWave or 1
    Unit5:Cheat("Textbox", "Upgrade from wave", function(Value)
        Value = tonumber(Value)
        Settings.U5_UpgWave = Value
        saveSettings()
    end, {placeholder = Settings.U5_UpgWave})

    Settings.U5_UpgCap = Settings.U5_UpgCap or 9
    Unit5:Cheat("Textbox", "Upgrade Cap", function(Value)
        Value = tonumber(Value)
        Settings.U5_UpgCap = Value
        saveSettings()
    end, {placeholder = Settings.U5_UpgCap})

    Settings.U5_SellWave = Settings.U5_SellWave or 999
    Unit5:Cheat("Textbox", "Auto Sell at wave", function(Value)
        Value = tonumber(Value)
        Settings.U5_SellWave = Value
        saveSettings()
    end, {placeholder = Settings.U5_SellWave})  

    --//UNIT 6
    Settings.U6_Priority = Settings.U6_Priority or "first"
    Unit6:Cheat("Dropdown", "Target Priority ",function(value)
        warn("Change to : "..value)
        Settings.U6_Priority = value
        saveSettings()
    end, { options = {"first","closest","last","farthest", "strongest","weakest","flying"}, default =Settings.U6_Priority})

    Settings.U6_Wave = Settings.U6_Wave or 1
    Unit6:Cheat("Textbox", "Place from wave", function(Value)
        Value = tonumber(Value)
        Settings.U6_Wave = Value
        saveSettings()
    end, {placeholder = Settings.U6_Wave})

    Settings.U6_TotalAmmount = Settings.U6_TotalAmmount or 6
    Unit6:Cheat("Textbox", "Total Units", function(Value)
        Value = tonumber(Value)
        Settings.U6_TotalAmmount = Value
        saveSettings()
    end, {placeholder = Settings.U6_TotalAmmount})

    Settings.U6_UpgWave = Settings.U6_UpgWave or 1
    Unit6:Cheat("Textbox", "Upgrade from wave", function(Value)
        Value = tonumber(Value)
        Settings.U6_UpgWave = Value
        saveSettings()
    end, {placeholder = Settings.U6_UpgWave})

    Settings.U6_UpgCap = Settings.U6_UpgCap or 9
    Unit6:Cheat("Textbox", "Upgrade Cap", function(Value)
        Value = tonumber(Value)
        Settings.U6_UpgCap = Value
        saveSettings()
    end, {placeholder = Settings.U6_UpgCap})

    Settings.U6_SellWave = Settings.U6_SellWave or 999
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
-------------- LOWW CPU Config --------------
---------------------------------------------
local function LowCPUModeT()
    LowCPU2:Cheat("Checkbox","Enable Low CPU Mode ", function(bool)
        print(bool)
        Settings.lowCpuMode = bool
        saveSettings()
    end,{enabled = Settings.lowCpuMode})
    
    task.spawn(function()
        while task.wait() do
            if isrbxactive() ~= true and Settings.lowCpuMode then
                setfpscap(30)
                game:GetService("RunService"):Set3dRenderingEnabled(false)
            else
                setfpscap(1000)
                game:GetService("RunService"):Set3dRenderingEnabled(true)
            end
        end
    end)
    
    LowCPU2:Cheat("Checkbox"," Enable Boost FPS Mode", function(bool)
        print(Settings.fpsboost)
        Settings.fpsboost = bool
        saveSettings()
        FPSBOOST()
    end,{enabled = Settings.fpsboos})
    
    LowCPU2:Cheat("Button","Activate Boost FPS Mode ", function()
        FPSBOOST()
    end)
end

---------------------------------------------
-------------- LAGGY Config -----------------
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
        local l_wave = game:GetService("Workspace"):WaitForChild("_wave_num")
		if Settings.EnableLag and tonumber(Settings.LagatWave) <= l_wave.Value then
    delaylag = tonumber(Settings.delag or 1.5)
    while wait(tonumber(Settings.delag or 1.5)) do --// don't change it's the best
    game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge * math.huge)
    local function getmaxvalue(val)
       --local mainvalueifonetable = 499999
       local mainvalueifonetable = tonumber(Settings.lagimpact or 499999)
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
        --bomb(tableincrease, tonumber(Settings.mix))
        bomb(tonumber(Settings.max), tonumber(Settings.mix))
    elseif not Settings.EnableLag then
        bomb(tableincrease, 0)
    end
    --bomb(tableincrease, tries)
    --repeat task.wait() until not Settings.EnableLag
            end
        end
    end
end)

    LG1:Cheat("Textbox", " Lag At Wave ", function(Value)
        Value = tonumber(Value)
        Settings.LagatWave = Value
        saveSettings()
    end, {placeholder = Settings.LagatWave}) 


    LG1:Cheat("Slider", "LAG IMPACT(S) ", function(Value)
        print("LAG Lv.:", Value)
        Settings.lagimpact = tonumber(Value)
        saveSettings()
    end, {min = 0, max = 499999, suffix = "", default = Settings.lagimpact })
    --LG1:Cheat("Label","LAG IMPACT(S) : "..tonumber(Settings.lagimpact)) 


    LG1:Cheat("Slider", "LAG Threads ", function(Value)
        print("LAG Lv.:", Value)
        Settings.max = tonumber(Value)
        saveSettings()
    end, {min = 0, max = 250, suffix = "", default = Settings.max })
    --LG1:Cheat("Label","LAG Threads : "..tonumber(Settings.max)) 


    LG1:Cheat("Slider", "LAG Lv. ", function(Value)
        print("LAG Lv.:", Value)
        Settings.mix = tonumber(Value)
        saveSettings()
    end, {min = 1, max = 7, suffix = "", default = Settings.mix })
    --LG1:Cheat("Label","LAG Lv. : "..tonumber(Settings.mix)) 


    LG1:Cheat("Slider", "Delay ", function(Value)
        print("Delay.:", Value)
        Settings.delag = tonumber(Value)
        saveSettings()
    end, {min = 0.1, max = 10, suffix = "", default = Settings.delag })
    --LG1:Cheat("Label","LAG Delay :  "..tonumber(Settings.delag)) 

    LG1:Cheat("Label"," How to LAG Setting")
    LG1:Cheat("Label"," Def-Setting")
    LG1:Cheat("Label"," IMPACT(S) = 499k, Threads = 22")
    LG1:Cheat("Label"," LAG Lv. = 1, Delay = 1")
    LG1:Cheat("Label"," Fast-LAG")
    LG1:Cheat("Label"," IMPACT(S) = 499k, Threads = 22")
    LG1:Cheat("Label"," LAG Lv. = 1, Delay = 0.2")


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
    local aaselectbanner = AutoSummonSec:Cheat("Dropdown", "🧙 Select Banner 🧙",function(value)
        getgenv().SelectedBanner = value
    end, { options = {"Special", "Standard"}})

    local aaselectbanner = AutoSummonSec:Cheat("Dropdown", "💸 Select Method 💸",function(value)
        getgenv().SelectedMethod = value
    end, { options = {"ticket", "gems", "gems10"}})

    AutoSummonSec:Cheat("Checkbox","Auto Summon", function(bool)
        getgenv().AutoSummon = bool
    end)
end
----------------------------------------------
------------ Auto Snipe Merchant -------------fixstar 
----------------------------------------------
function buymerchant(item)
    local args = { [1] = item } 
    game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_travelling_merchant_item:InvokeServer(unpack(args))
end
function snipefunc(item)
    if item =="Any StarFruits" then
        if game:GetService("Workspace")["travelling_merchant"]["is_open"].Value == true then
            for i,v in pairs(game:GetService("Workspace")["travelling_merchant"]:FindFirstChild("stand"):FindFirstChild("items"):GetChildren()) do
                if v.Name:match("StarFruitGreen") or v.Name:match("StarFruitRed") or v.Name:match("StarFruitPink") or v.Name:match("StarFruitBlue") or v.Name:match("StarFruitEpic") then
                    buymerchant(v.Name)
                    print(v.Name)
                end   
            end
        end
    elseif item =="StarFruitsyellow" then
        if game:GetService("Workspace")["travelling_merchant"]["is_open"].Value == true then
            for i,v in pairs(game:GetService("Workspace")["travelling_merchant"]:FindFirstChild("stand"):FindFirstChild("items"):GetChildren()) do
                if v.Name:match("StarFruitstar") then
                    buymerchant(v.Name)
                    print(v.Name)
                end   
            end
        end
    elseif item =="StarFruitsRainbow" then
        if game:GetService("Workspace")["travelling_merchant"]["is_open"].Value == true then
            for i,v in pairs(game:GetService("Workspace")["travelling_merchant"]:FindFirstChild("stand"):FindFirstChild("items"):GetChildren()) do
                if v.Name:match("StarFruitEpic") then
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
    AutoSnipeMerchantSec:Cheat("Dropdown", "Select Star Fruit ",function(value)
        Settings.ASM_SelectedFruit = value
        saveSettings()
    end, { options = {"None","StarFruit","StarFruitGreen","StarFruitRed", "StarFruitPink","StarFruitBlue","StarFruitsRainbow"}, default =Settings.ASM_SelectedFruit})
   
    AutoSnipeMerchantSec:Cheat("Dropdown", "Select Other Items",function(value)
        Settings.ASM_SelectedOtherItems = value
        saveSettings()
    end, { options = {"None","Any Items","LuckPotion","star_remnant","summon_ticket"}, default =Settings.ASM_SelectedOtherItems})
    
    AutoSnipeMerchantSec:Cheat("Dropdown", "Select Evo Items ",function(value)
        Settings.ASM_SelectedEvoItems = value
        saveSettings()
    end, { options = {"None"}, default =Settings.ASM_SelectedEvoItems})
    AutoSnipeMerchantSec:Cheat("Checkbox","Enable Auto Snipe", function(bool)
        Settings.AutoSnipeMerchant = bool
        saveSettings()
    end,{enabled = Settings.AutoSnipeMerchant })

    -----------------------------------------------------------------------------
    --AutoBuySummer

    SummerItem:Cheat("Dropdown", "Select Item Summer",function(pornname)
        getgenv().portalnameC = pornname
        saveSettings()
    end, { options = {"summer_portal_item_contract","capsule_summer"}, default = getgenv().portalnameC})

    SummerItem:Cheat("Dropdown", "Select Total Item",function(value)
        Settings.SummerNum = value
        saveSettings()
    end, { options = {"1","10","100"}, default = getgenv().SummerNum})

    SummerItem:Cheat("Button","Buy Item [One Time]", function(bool)
        local args = {
            [1] = getgenv().portalnameC,
            [2] = "event",
            [3] = "event_shop",
            [4] = Settings.SummerNum
        }
        game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_item_generic:InvokeServer(unpack(args))
        warn("Buy Summer Portal !!!")
    end)

    SummerItem:Cheat("Checkbox","Auto Buy Item [Many time]", function(bool)
        print(bool)
        Settings.AutoBuySummer = bool
        saveSettings()
    end,{enabled = Settings.AutoBuySummer})

    task.spawn(function()
        while task.wait() do
            if Settings.AutoBuySummer then
                local args = {
                    [1] = getgenv().portalnameC,
                    [2] = "event",
                    [3] = "event_shop",
                    [4] = Settings.SummerNum
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_item_generic:InvokeServer(unpack(args))
            end
        end
    end)

    ----------------------------------------------------------------
    --Auto Open Egg
-- Script generated by SimpleSpy - credits to exx#9394

Settings.SelecteStars = Settings.SelecteStars or "capsule_summer"
SummerEgg:Cheat("Dropdown", "Select Capsule Star",function(value)
    Settings.SelecteStars = value
    saveSettings()
end, { options = {"capsule_summer","capsule_anniversary"}, default = getgenv().SelecteStars})

SummerEgg:Cheat("Checkbox","Auto Open Summer Egg [1 ea]", function(bool)
    print(bool)
    Settings.AutoOpenSummer1 = bool
    saveSettings()
end,{enabled = Settings.AutoOpenSummer1})

SummerEgg:Cheat("Checkbox","Auto Open Summer Egg [10 ea]", function(bool)
    print(bool)
    Settings.AutoOpenSummer10 = bool
    saveSettings()
end,{enabled = Settings.AutoOpenSummer10})

SummerEgg:Cheat("Checkbox","Webhook Skin", function(bool)
    print(bool)
    Settings.SendWebhookSkin = bool
    saveSettings()
end,{enabled = Settings.SendWebhookSkin})
SummerEgg:Cheat("Textbox", "Send Webhook Skin", function(Value)
    Settings.WebhookUrlSkin = Value
    saveSettings()
end, {placeholder = Settings.WebhookUrlSkin})

-- สร้าง Table ของ สกิน
local SummerSkinTable,TableSeason,WebhookSkin = {},{},{}
for i,v in pairs(game:GetService("ReplicatedStorage").src.Data.Items.UniqueItems.Skins:GetChildren()) do
    Remove_Items_Text = string.gsub(v.Name,"Items_","")
    Remove_Skins_Text = string.gsub(Remove_Items_Text,"Skins","")
    table.insert(TableSeason,Remove_Skins_Text)
    
    for i,v in pairs(require(v)) do
        WebhookSkin[i] = 0
        SummerSkinTable[i] = v
    end
end
-- Add Skin In Inventory
for i,v in pairs(get_inventory_items_unique_items()) do
    if string.find(v['item_id'],"_skin") then
        WebhookSkin[v['item_id']] = WebhookSkin[v['item_id']] + 1
    end
end

task.spawn(function()
    while task.wait() do
        if Settings.AutoOpenSummer1 or Settings.AutoOpenSummer10 then
            local args = {
                --[1] = "capsule_summer",
                [1] = Settings.SelecteStars,
                [2] = {
                    ["use10"] = Settings.AutoOpenSummer1 == false and Settings.AutoOpenSummer10 == true
                }
            }
            game:GetService("ReplicatedStorage").endpoints.client_to_server.use_item:InvokeServer(unpack(args))
            if Settings.SendWebhookSkin and Settings.WebhookUrlSkin ~= nil then
                -- Create Table New Skinb
                local WebhookSkinNew,TextWebhook = {},""
                for i,v in pairs(game:GetService("ReplicatedStorage").src.Data.Items.UniqueItems.Skins:GetChildren()) do
                    for i,v in pairs(require(v)) do
                        WebhookSkinNew[i] = 0
                    end
                end
                for i,v in pairs(get_inventory_items_unique_items()) do
                    if string.find(v['item_id'],"_skin") then
                        WebhookSkinNew[v['item_id']] = WebhookSkinNew[v['item_id']] + 1
                    end
                end

                -- Create Text Output
                SentSkin = false
                for SkinName,Count_OldSkin in pairs(WebhookSkin) do
                    if WebhookSkinNew[SkinName] > Count_OldSkin then
                        local Name = SummerSkinTable[SkinName]['name']:split(" ")
                        TextWebhook = TextWebhook .. "[" .. SummerSkinTable[SkinName].rarity .. "]" .. " " .. Name[3] .. " " .. Name[4] .. " | Count : " .. tostring(WebhookSkinNew[SkinName]) .. "\n"
                        SentSkin = true
                    end 
                end

                CountPortal_list = 0
                for i,v in pairs(get_inventory_items_unique_items()) do
                    if string.find(v['item_id'],"portal") or string.find(v['item_id'],"disc") then
                        CountPortal_list = CountPortal_list + 1
                    end
                end
        
                local thumbnails_avatar = HttpService:JSONDecode(game:HttpGet("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. game:GetService("Players").LocalPlayer.UserId .. "&size=150x150&format=Png&isCircular=true", true))
                local Time = os.date('!*t', OSTime);
                local exec = tostring(identifyexecutor())

                local data = {
                    ["content"] = "",
                    ["username"] = "Anime Adventures V2",
                    ["avatar_url"] = "https://tr.rbxcdn.com/7b6a3914cac2e93f7e7f27cbefa92280/150/150/Image/Png",
                    ["embeds"] = {
                        {
                            ["author"] = {
                                ["name"] = "Anime Adventures | Skin ✔️",
                                ["icon_url"] = "https://cdn.discordapp.com/emojis/997123585476927558.webp?size=96&quality=lossless"
                            },
                            ["thumbnail"] = {
                                ['url'] = thumbnails_avatar.data[1].imageUrl,
                            },
                            ["description"] = " Player Name : 🐱 ||**"..game:GetService("Players").LocalPlayer.Name.."**|| 🐱\nExecutors : 🎮 "..exec.." 🎮 ",
                            ["color"] = 110335,
                            ["timestamp"] = string.format('%d-%d-%dT%02d:%02d:%02dZ', Time.year, Time.month, Time.day, Time.hour, Time.min, Time.sec),
                            ['footer'] = {
                                ['text'] = "// Made by Negative & HOLYSHz", 
                                ['icon_url'] = "https://yt3.ggpht.com/mApbVVD8mT92f50OJuTObnBbc3j7nDCXMJFBk2SCDpSPcaoH9DB9rxVpJhsB5SxAQo1UN2GzyA=s48-c-k-c0x00ffffff-no-rj"
                            },
                            ["fields"] = {
                                {
                                    ["name"] ="Current Level ✨ & Gems 💎 & Gold 💰 & Portals 🌀",
                                    ["value"] = "```ini\n"
                                                ..tostring(game.Players.LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text)..  " ✨\nCurrent Gold : "
                                                ..tostring(comma_value(game.Players.LocalPlayer._stats.gold_amount.Value)).. " 💰\nCurrent Gems : "
                                                ..tostring(comma_value(game.Players.LocalPlayer._stats.gem_amount.Value)).. " 💎\nCurrent Trophies : "
                                                ..tostring(comma_value(game.Players.LocalPlayer._stats.trophies.Value)).. " 🏆\nCurrent Portal : "
                                                ..tostring(CountPortal_list) .." 🌀\nCurrent Summer Pearls : "
                                                ..tostring(comma_value(game.Players.LocalPlayer._stats._resourceSummerPearls.Value)).. " 🦪```",
                                },
                                {
                                    ["name"] ="Skins Drop :",
                                    ["value"] = "```ini\n" .. TextWebhook .. "```",
                                    ["inline"] = false 
                                }
                            }
                        }
                    }
                }
                
                local porn = game:GetService("HttpService"):JSONEncode(data)
                local headers = {["content-type"] = "application/json"}
                local request = http_request or request or HttpPost or syn.request or http.request
                local sex = {Url = Settings.WebhookUrlSkin, Body = porn, Method = "POST", Headers = headers}
                if SentSkin then
                    warn("Sending webhook notification...")
                    request(sex)
                end
            end
        end
    end
end)

    ----------------------------------------------------------------
    --Auto Sell Summer Skin

    Settings.SelectedSellRarity = Settings.SelectedSellRarity or "Rare"
    Settings.SelectedSellSeason = Settings.SelectedSellSeason or "Summer"
    -- Table Of Skin
    local SummerSkinTable,TableSeason = {},{}
    for i,v in pairs(game:GetService("ReplicatedStorage").src.Data.Items.UniqueItems.Skins:GetChildren()) do
        Remove_Items_Text = string.gsub(v.Name,"Items_","")
        Remove_Skins_Text = string.gsub(Remove_Items_Text,"Skins","")
        table.insert(TableSeason,Remove_Skins_Text)

        for i,v in pairs(require(v)) do
            SummerSkinTable[i] = v
        end
    end
    
    SummerSkin:Cheat("Dropdown","🎚️ Select Season", function(bool)
        print(bool)
        Settings.SelectedSellSeason = bool
        saveSettings()
    end,{options = TableSeason, default = Settings.SelectedSellSeason})

    SummerSkin:Cheat("Dropdown", "🎚️ Select Rarity",function(value)
        warn("Change to : "..value)
        Settings.SelectedSellRarity = value
        saveSettings()
    end, { options = {"Rare","Epic","Legendary","Mythic"}, default = Settings.SelectedSellRarity})

    SummerSkin:Cheat("Checkbox","Auto Sell Skins ", function(bool)
        print(bool)
        Settings.AutoSellSskin = bool
        saveSettings()
    end,{enabled = Settings.AutoSellSskin})
    
    task.spawn(function()
        while task.wait() do 
            if Settings.AutoSellSskin then
                for i,v in pairs(get_inventory_items_unique_items()) do
                    if string.find(v['item_id'],"_skin") then
                        if SummerSkinTable[v['item_id']].rarity == Settings.SelectedSellRarity and tring.find(v['item_id'],Settings.SelectedSellSeason:lower()) then
                            local args = {
                                [1] = {
                                    [1] = v["uuid"]
                                }
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.delete_unique_items:InvokeServer(unpack(args))
                            warn("Sell Skin")
                            wait(0.3)
                        end
                    end
                end
            end
        end
    end)
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

    WebhookSec:Cheat("Button", "Test Baby&Shop Webhook", function()
        print(Settings.WebhookUrl)
        BabyWebhook()
        SnipeShopNew()
    end)
end

-----------------------------------------------
------------------Sell Portal------------------
-----------------------------------------------
function Sellportals()

    Settings.SelectedSellPortals = Settings.SelectedSellPortals or "portal_summer"
    SellPortals:Cheat("Dropdown", "🎚️ Select Portal",function(value)
        warn("Change to : "..value)
        Settings.SelectedSellPortals = value
        saveSettings()
    end, { options = {"portal_boros_g","april_portal_item","portal_zeldris","portal_item__dressrosa","portal_item__eclipse","portal_summer"}, default =Settings.SelectedSellPortals})


    Tier_sell = {}
    for i = 0,15 do
        table.insert(Tier_sell,i)
    end

    Settings.SelectedSellTier = Settings.SelectedSellTier or 0
    SellPortals:Cheat("Dropdown", "🎚️ Select Tier Portal <=",function(value)
        warn("Change to : "..value)
        Settings.SelectedSellTier = value
        saveSettings()
    end, {options = Tier_sell, default = Settings.SelectedSellTier})


    Settings.SelectedSellChallenge = Settings.SelectedSellChallenge or "double_cost"
    SellPortals:Cheat("Dropdown", "🎚️ Select Challenge",function(value)
        warn("Change to : "..value)
        Settings.SelectedSellChallenge = value
        saveSettings()
    end, { options = {"double_cost","short_range","fast_enemies","regen_enemies", "tank_enemies","shield_enemies","triple_cost","hyper_regen_enemies","hyper_shield_enemies","godspeed_enemies","flying_enemies","mini_range"}, default =Settings.SelectedSellChallenge})

    SellPortals:Cheat("Checkbox","Auto Sell Portal ", function(bool)
        print(bool)
        Settings.AutoSellPortals = bool
        saveSettings()
    end,{enabled = Settings.AutoSellPortals})

    task.spawn(function()
        while task.wait() do
            if Settings.AutoSellPortals then
                for i,v in pairs(get_inventory_items_unique_items()) do
                    if string.find(v['item_id'],"portal") or string.find(v['item_id'],"disc") then
                        if v['item_id'] == Settings.SelectedSellPortals then
                        if v["_unique_item_data"]["_unique_portal_data"]["portal_depth"] <= Settings.SelectedSellTier then
                            if v["_unique_item_data"]["_unique_portal_data"]["challenge"] == Settings.SelectedSellChallenge then
                                local args = {
                                    [1] = {
                                        [1] = v["uuid"]
                                    }
                                }
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.delete_unique_items:InvokeServer(unpack(args))
                                warn("Sell Selecte Protals")
                            end
                            end
                        end
                    end
                end
            end
        end
    end)

    SellPortals:Cheat("Checkbox","Auto Sell Normal Portal [No Challenge]", function(bool)
        print(bool)
        Settings.AutoSellNRPortals = bool
        saveSettings()
    end,{enabled = Settings.AutoSellNRPortals})

    task.spawn(function()
        while task.wait() do
            if Settings.AutoSellNRPortals then
                for i,v in pairs(get_inventory_items_unique_items()) do
                    if string.find(v['item_id'],"portal") or string.find(v['item_id'],"disc") then

                        if v['item_id'] == Settings.SelectedSellPortals then
                        if v["_unique_item_data"]["_unique_portal_data"]["portal_depth"] <= Settings.SelectedSellTier then
                                local args = {
                                    [1] = {
                                        [1] = v["uuid"]
                                    }
                                }
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.delete_unique_items:InvokeServer(unpack(args))
                                warn("Sell Selecte Protals")

                            end
                        end
                    end
                end
            end
        end
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
    OtherSec:Cheat("Checkbox","Auto Load Script", function(bool)
        Settings.AutoLoadScript = bool
        saveSettings()
        autoload()
    end,{enabled = Settings.AutoLoadScript})
    OtherSec3:Cheat("Checkbox","Hide Name Player", function(bool)
        Settings.hidenamep = bool
        saveSettings()
        hidename()
    end,{enabled = Settings.hidenamep})
end


----------------------------------------------
------------ /\/\/\/\/\/\/\/\/\ --------------
----------------------------------------------
if game.PlaceId == 8304191830 then
    UnitPosition:Cheat("Label","Not available in game lobby!!!")    
    UnitSec()
    WorldSec()
    AutoFarmSec()
    MoreFarmSec()
    ChallengeSec()
    DeleteMapSec()
    unitconfig()
    LowCPUModeT()
    LAGGYconfig()
    reFarmconfig()
    credits()
    AutoSummon()
    SnipeMerchant()
    Webhooksec()
    Webhooksec2()
    Sellportals()
    others()
    DELMAPNEW()
    UNITAOEAA()
else
    SelectUnits:Cheat("Label","Only available in game Lobby!!!")    
    AutoSummonSec:Cheat("Label","Only available in game Lobby!!!")
    WorldSec()
    AutoFarmSec()
    MoreFarmSec()
    ChallengeSec()
    DeleteMapSec()
    UnitPosSec()
    unitconfig()
    LowCPUModeT()
    LAGGYconfig()
    reFarmconfig()
    credits()
    SnipeMerchant()
    Webhooksec()
    Sellportals()
    others()
    DELMAPNEW()
    UNITAOEAA()
    WebhookSec:Cheat("Label","")
    WebhookSec:Cheat("Label","Test Baby & Shop Webhook Only available in game Lobby!!!")
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

function getOPNPortals()
    local portals = {}
    for _, item in pairs(get_inventory_items_unique_items()) do
        if item["item_id"] == "portal_item__dressrosa" then
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


function getberserkPortals()
    local portals = {}
    for _, item in pairs(get_inventory_items_unique_items()) do
        if item["item_id"] == "portal_item__eclipse" then
            table.insert(portals, item)
        end
    end
    return portals
end

function getSummerPortals()
    local portals = {}
    for _, item in pairs(get_inventory_items_unique_items()) do
        if item["item_id"] == "portal_summer" then
            table.insert(portals, item)
        end
    end
    return portals
end

--Secret Portals

function getSecretDoflamingo()
    local portals = {}
    for _, item in pairs(get_inventory_items_unique_items()) do
        if item["item_id"] == "portal_item__doflamingo" then
            table.insert(portals, item)
        end
    end
    return portals
end

function getSecretEclipse()
    local portals = {}
    for _, item in pairs(get_inventory_items_unique_items()) do
        if item["item_id"] == "portal_item__femto" then
            table.insert(portals, item)
        end
    end
    return portals
end

function getPoseidonPortals()
    local portals = {}
    for _, item in pairs(get_inventory_items_unique_items()) do
        if item["item_id"] == "portal_poseidon" then
            table.insert(portals, item)
        end
    end
    return portals
end

--End Fixportal

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

function GetPlayerPortal()
    local PlayerPortal
    if game:GetService("Workspace"):FindFirstChild("_PORTALS") then
        for i,v in pairs(game:GetService("Workspace")["_PORTALS"].Lobbies:GetDescendants()) do
            if v.Name == "Owner" and tostring(v.value) == game.Players.LocalPlayer.Name then
                local PlayerPortal = { [1] = tostring(v.Parent.Name) }
                break;
            end 
        end
        pcall(function() 
            BabyWebhook()
            SnipeShopNew()
        end)
    end
    return PlayerPortal
end

--fixportal

function GetPlayerPortalUse(level)
    local PortalName,PortalUUID,PortalPlayer
    -- Aline fixportal
    if level == "portal_boros_g" then
        PortalName = "Aline farming"
        PortalUUID = GetPortals("portal_boros_g")[1]["uuid"]
        PortalPlayer = GetPlayerPortal()
    -- Demon fixportal		
    elseif level == "april_portal_item" then
        PortalName = "Demon farming"
        PortalUUID = GetPortals("april_portal_item")[1]["uuid"]
        PortalPlayer = GetPlayerPortal()
    --OPN fixportal		
    elseif level == "portal_item__dressrosa" then
        PortalName = "OPNew farming"
        PortalUUID = GetPortals("portal_item__dressrosa")[1]["uuid"]
        PortalPlayer = GetPlayerPortal()
        --7Ds fixportal		
    elseif level == "portal_zeldris" then
        PortalName = "7ds farming"
        PortalUUID = GetPortals("portal_zeldris")[1]["uuid"]
        PortalPlayer = GetPlayerPortal()
                --Berserk fixportal		
    elseif level == "portal_item__eclipse" then
        PortalName = "Berserk farming"
        PortalUUID = GetPortals("portal_item__eclipse")[1]["uuid"]
        PortalPlayer = GetPlayerPortal()

        --Secret Portals
    elseif level == "portal_item__doflamingo" then
        PortalName = "Dofamingo Secret Portals farming"
        PortalUUID = GetPortals("portal_item__doflamingo")[1]["uuid"]
        PortalPlayer = GetPlayerPortal()

    elseif level == "portal_item__femto" then
        PortalName = "The Eclipse Secret Portals farming"
        PortalUUID = GetPortals("portal_item__femto")[1]["uuid"]
        PortalPlayer = GetPlayerPortal()

    elseif level == "portal_poseidon" then
        PortalName = "Summer Secret Portal farming"
        PortalUUID = GetPortals("portal_poseidon")[1]["uuid"]
        PortalPlayer = GetPlayerPortal()
    ------------------------------
    -- [[ Portal Event Portal ]] --

    elseif level == "portal_summer" then
            for i = tonumber(Settings.SelectedTier1) ,tonumber(Settings.SelectedTier2) do
                Settings.SelectedTier = i
            local PortalEvent = GetPortals("portal_summer")
            for i,v in pairs(PortalEvent) do
                if v["_unique_item_data"]["_unique_portal_data"]["portal_depth"] == Settings.SelectedTier then
                if v["_unique_item_data"]["_unique_portal_data"]["challenge"] ~= Settings.SelectedChallenge 
                and v["_unique_item_data"]["_unique_portal_data"]["challenge"] ~= Settings.SelectedChallenge2
                and v["_unique_item_data"]["_unique_portal_data"]["challenge"] ~= Settings.SelectedChallenge3 then
                    PortalEventUse = v

                    PortalName = "Summer farming"
                    PortalUUID = PortalEventUse["uuid"]
                    PortalPlayer = GetPlayerPortal()
                    break
                end
            end
        end
    end


end
    return {PortalName,PortalUUID,PortalPlayer}
end

function StartPortal(input)
    local DataPlayerPortal = GetPlayerPortalUse(input)
    --for i,v in pairs(game:GetService("Workspace")["_PORTALS"].Lobbies:GetDescendants()) do
        --if v.Name == "Owner" and tostring(v.value) == game.Players.LocalPlayer.Name and game.workspace._MAP_CONFIG:WaitForChild("GetLevelData") then
            if game.workspace:FindFirstChild("_MAP_CONFIG") and game.workspace:FindFirstChild("_MAP_CONFIG"):FindFirstChild("GetLevelData") then
                return DataPlayerPortal
            else
                local args = {
                    [1] = DataPlayerPortal[2],
                    [2] = { ["friends_only"] = Settings.isFriendOnly } --getgenv().isFriendOnly 
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.use_portal:InvokeServer(unpack(args))
                task.wait(1)
                for i,v in pairs(game:GetService("Workspace")["_PORTALS"].Lobbies:GetDescendants()) do
                    if v.Name == "Owner" and tostring(v.value) == game.Players.LocalPlayer.Name then
                        local args = { [1] = tostring(v.Parent.Name) }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
                --game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(DataPlayerPortal[3]))
                warn(DataPlayerPortal[1])
                task.wait(1)
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
                task.wait(0.5)
                warn("farming")
                task.wait(1)
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
                task.wait(0.5)
                warn("Raid farming")
                task.wait(1)
            end       
        elseif cata == "Portals" then
            StartPortal(level)
        elseif cata == "Dungeon" then
            if level == "jjk_finger" then --_lobbytemplate_event221
            getgenv().door = "_lobbytemplate_event221"
            local string_1 = "_lobbytemplate_event221";
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
                task.wait(0.5)
                warn("DUNGEONS jjk_finger farming")
                task.wait(1)
            end
                --ดันเกะโท
        elseif cata == "Dungeon" then
            if level == "jjk_raid" then
                getgenv().door = "_lobbytemplate_event22"
                local string_1 = "_lobbytemplate_event22";
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
                    task.wait(0.5)
                    warn("DUNGEONS jjk_raid farming")
                    task.wait(1)
                end
                    --Events Annivesary
        elseif cata == "Dungeon" then
            if level == "namek_anniversary" then
                getgenv().door = "_lobbytemplate_event323"
                local string_1 = "_lobbytemplate_event323";
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
                    task.wait(0.5)
                    warn("DUNGEONS Annivesary farming")
                    task.wait(1)
                end
            end

                end
            end
        end
    end
end
--end fixportal]]

------------------------------------
---- Start Auto Ability Function----
------------------------------------

getgenv().autoabilityerr = false
function autoabilityfunc()
    local player = game.Players.LocalPlayer.Name
    if Settings.AutoAbilities then
        repeat task.wait() until Workspace:WaitForChild("_UNITS")
        local success, err = pcall(function()
            for i, v in ipairs(Workspace["_UNITS"]:GetChildren()) do
                if v:FindFirstChild("_stats") then
                    
                    
                    if v._stats:FindFirstChild("threat") then
                        if v._stats.threat.Value > 0 then
                            UsePuchiSkill()
                            UseErenSkill()
                        end
                        

    				elseif v._stats:FindFirstChild("player") then
    					if tostring(v._stats.player.Value) == player then

                            --AutoSkill

                            if v._stats.id.Value == "gojo_evolved" then
                                if v._stats.state.Value == "attack" then
                                    game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                                    warn("Use Skill Gojo")
                                end
                            end
                            
                            if v._stats.id.Value == "homura_evolved" then
                                if v._stats.state.Value == "attack" then
                                    game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                                    warn("Use Skill Homura")
                                end
                            end

                            if v._stats.id.Value == "law_2_evolved" then
                                if v._stats.state.Value == "attack" then
                                    game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                                    warn("Use Skill Homura")
                                end
                            end

                            if v._stats.id.Value == "shanks_evolved" then
                                if v._stats.state.Value == "attack" then
                                    game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                                    warn("Use Skill Shanks")
                                end
                            end

                            if v._stats.id.Value ~= "pucci_heaven" or v._stats.id.Value ~= "erwin" or v._stats.id.Value ~= "wendy" 
                            or v._stats.id.Value ~= "leafa" or v._stats.id.Value ~= "erwin:shiny" or v._stats.id.Value ~= "erwin_school" 
                            or v._stats.id.Value ~= "erwin_halloween" or v._stats.id.Value ~= "eren_final" then
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
-- End  Auto Abilities Function

    -- Start of Auto Global Cooldown Abilities Function
getgenv().autoGCDabilityerr = false
function autoabilityGCDfunc()
    local player = game.Players.LocalPlayer.Name
    if Settings.AutoGCDAbilities then
        repeat task.wait() until Workspace:WaitForChild("_UNITS")
        local success, errGCD = pcall(function()
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
    
                            -- Execute Skill if Not Wendy, Erwin, Gojo and Puchi    
                            if v._stats.id.Value ~= "pucci_heaven" or v._stats.id.Value ~= "erwin" or v._stats.id.Value ~= "wendy" 
                            or v._stats.id.Value ~= "leafa" or v._stats.id.Value ~= "erwin:shiny" or v._stats.id.Value ~= "erwin_school" 
                            or v._stats.id.Value ~= "erwin_halloween" or v._stats.id.Value ~= "eren_final" then
                               -- if v._stats.state.Value ~= "attack" then
                                    if v._stats.active_attack.Value ~= "nil" then
                                        game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                                end
                            end
                        end
                    end
                end
            end
        end)
        
        if errGCD then
            warn("Can't use Ability")
            getgenv().autoGCDabilityerr = true
            error(errGCD)
        end
    end
end
    -- End of Auto Global Cooldown Abilities Function
    
-- Start  Puchi Skill Function
function UsePuchiSkill()
    local player = game.Players.LocalPlayer.Name
    local LocalPlayer = game.Players.LocalPlayer
	for i, v in ipairs(Workspace["_UNITS"]:getChildren()) do
		if v:FindFirstChild("_stats") then
			if v._stats:FindFirstChild("player") then
				if tostring(v._stats.player.Value) == player then
					if v._stats.id.Value == "pucci_heaven" then
					    if v._stats.state.Value == "attack" then
					    
					        -- Check Infinite
						    if GLD()._gamemode == "infinite" then
						        if GetWaveNumber() % 10 == 0 then
						            game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                                    warn("Use Skill Puchi")
						        end
						    -- Check Raid
					        elseif GLD()._gamemode == "raid" then
					            if GetWaveNumber() == 15 or 20 then
						            game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                                    warn("Use Skill Puchi")
						        end
						    -- Check Story or Infinite Tower
					        elseif GLD()._gamemode == "story" or "infinite_tower" then
					            if GetWaveNumber() == 15 then
					                game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                                    warn("Use Skill Puchi")
					            end
					        end
						end
					end
				end
			end
		end
	end
end
-- End  Puchi Skill Function

-- Start  Eren Skill Function
function UseErenSkill()
    local player = game.Players.LocalPlayer.Name
    local LocalPlayer = game.Players.LocalPlayer
	for i, v in ipairs(Workspace["_UNITS"]:getChildren()) do
		if v:FindFirstChild("_stats") then
			if v._stats:FindFirstChild("player") then
				if tostring(v._stats.player.Value) == player then
					if v._stats.id.Value == "eren_final" then       
					    if v._stats.state.Value ~= "attack" then
					    
					        -- Check Infinite 
						    if GLD()._gamemode == "infinite" then
						        if GetWaveNumber() % 10 == 0 then
						            game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                                    warn("Use Skill Eren")
						        end
						    -- Check Raid
					        elseif GLD()._gamemode == "raid" then
					            if GetWaveNumber() == 15 or 20 then
						            game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                                    warn("Use Skill Eren")
						        end
						    -- Check Story or Infinite Tower
					        elseif GLD()._gamemode == "story" or "infinite_tower" then
					            if GetWaveNumber() == 15 then
					                game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                                    warn("Use Skill Eren")
					            end
					        end
						end
					end
				end
			end
		end
	end
end
-- End  Eren Skill Function

-- Start  Auto Buff 100 Function
--Erwin
function autoabilityerwin()
    if Settings.EnableBufferwinLoop then

        --local GameFinished = game:GetService("Workspace"):WaitForChild("_DATA"):WaitForChild("GameFinished")
        --repeat task.wait() until  GameFinished.Value == true
        repeat task.wait() until game:IsLoaded()
        --repeat task.wait() until  game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Enabled == true
        local LocalPlayer = game.Players.LocalPlayer
        local LPlayer = game.Players.LocalPlayer.Name
        local UnitsE = {'erwin','erwin:shiny','erwin_school','erwin_halloween'}
        local Delay = {
            ['erwin'] = 16.4,
            ['erwin:shiny'] = 16.4,
            ['erwin_school'] = 16.4,
            ['erwin_halloween'] = 16.4,
        }
        _G.Stop = false
        while wait() do
          if _G.Stop then
            break
          end
          local erwin1 = {}
          for _,v in pairs(game:GetService("Workspace")._UNITS:GetChildren()) do
              if table.find(UnitsE,v.Name) and v:FindFirstChild("_stats"):FindFirstChild("player").Value == LocalPlayer then
                  table.insert(erwin1, v)
              end
          end
        
          if #erwin1 == 4 then
            game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("use_active_attack"):InvokeServer(erwin1[1])
            warn("Use Skill " ..erwin1[1].Name .." 1 " )
            wait(Delay[erwin1[1].Name])
            game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("use_active_attack"):InvokeServer(erwin1[3])
            warn("Use Skill " ..erwin1[1].Name .." 2 " )
            wait(Delay[erwin1[1].Name])
            game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("use_active_attack"):InvokeServer(erwin1[2])
            warn("Use Skill " ..erwin1[1].Name .." 3 " )
            wait(Delay[erwin1[1].Name])
            game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("use_active_attack"):InvokeServer(erwin1[4])
            warn("Use Skill " ..erwin1[1].Name .." 4 " )
            wait(Delay[erwin1[1].Name])
          end
        end

    end
end

if Settings.EnableBufferwinLoop then
    autoabilityerwin()
end

--Wendy
function autoabilitywendy()
    if Settings.EnableBuffwendyLoop then

        --local GameFinished = game:GetService("Workspace"):WaitForChild("_DATA"):WaitForChild("GameFinished")
        --repeat task.wait() until  GameFinished.Value == true
        repeat task.wait() until game:IsLoaded()
        --repeat task.wait() until  game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Enabled == true
        local LocalPlayer = game.Players.LocalPlayer
        local LPlayer = game.Players.LocalPlayer.Name
        local UnitsW = {'wendy'}
        local Delay = {
            ['wendy'] = 16.4,
        }
        _G.Stop = false
        while wait() do
            if _G.Stop then
                break
            end
            local wendy1 = {}
            for _,v in pairs(game:GetService("Workspace")._UNITS:GetChildren()) do
                if table.find(UnitsW,v.Name) and v:FindFirstChild("_stats"):FindFirstChild("player").Value == LocalPlayer then
                    table.insert(wendy1, v)
                end
            end
            
            if #wendy1 == 4 then
                game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("use_active_attack"):InvokeServer(wendy1[1])
                warn("Use Skill " ..wendy1[1].Name .." 1 " )
                wait(Delay[wendy1[1].Name])
                game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("use_active_attack"):InvokeServer(wendy1[3])
                warn("Use Skill " ..wendy1[1].Name .." 2 " )
                wait(Delay[wendy1[1].Name])
                game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("use_active_attack"):InvokeServer(wendy1[2])
                warn("Use Skill " ..wendy1[1].Name .." 3 " )
                wait(Delay[wendy1[1].Name])
                game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("use_active_attack"):InvokeServer(wendy1[4])
                warn("Use Skill " ..wendy1[1].Name .." 4 " )
                wait(Delay[wendy1[1].Name])
            end
        end

    end
end

if Settings.EnableBuffwendyLoop then
    autoabilitywendy()
end

--Leafa
function autoabilityleafa()
    if Settings.EnableBuffleafaLoop then

        --local GameFinished = game:GetService("Workspace"):WaitForChild("_DATA"):WaitForChild("GameFinished")
        --repeat task.wait() until  GameFinished.Value == true
        repeat task.wait() until game:IsLoaded()
        --repeat task.wait() until  game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Enabled == true
        local LocalPlayer = game.Players.LocalPlayer
        local LPlayer = game.Players.LocalPlayer.Name
        local UnitsL = {'leafa'}
        local Delay = {
            ['leafa'] = 16.4,
        }
        _G.Stop = false
        while wait() do
          if _G.Stop then
            break
          end
          local leafa1 = {}
          for _,v in pairs(game:GetService("Workspace")._UNITS:GetChildren()) do
              if table.find(UnitsL,v.Name) and v:FindFirstChild("_stats"):FindFirstChild("player").Value == LocalPlayer then
                  table.insert(leafa1, v)
              end
          end
        
          if #leafa1 == 4 then
            game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("use_active_attack"):InvokeServer(leafa1[1])
            warn("Use Skill " ..leafa1[1].Name .." 1 " )
            wait(Delay[leafa1[1].Name])
            game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("use_active_attack"):InvokeServer(leafa1[3])
            warn("Use Skill " ..leafa1[1].Name .." 2 " )
            wait(Delay[leafa1[1].Name])
            game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("use_active_attack"):InvokeServer(leafa1[2])
            warn("Use Skill " ..leafa1[1].Name .." 3 " )
            wait(Delay[leafa1[1].Name])
            game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("use_active_attack"):InvokeServer(leafa1[4])
            warn("Use Skill " ..leafa1[1].Name .." 4 " )
            wait(Delay[leafa1[1].Name])
          end
        end

    end
end

if Settings.EnableBuffleafaLoop then
    autoabilityleafa()
end


-- End  Auto Buff 100 Function
-----------------------------------------------------------

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
            pcall(function() 
                BabyWebhook()
                SnipeShopNew()
             end)
                print("send Webhook")
                task.wait(0.5)
                warn("Infinity Castle Farm")
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

        if Settings.AutoGCDAbilities then
            if game.PlaceId ~= 8304191830 then
                pcall(function()
                    autoabilityGCDfunc()
                end)
            end
            if  getgenv().autoGCDabilityerr == true then
                task.wait()
                autoabilityGCDfunc()
                getgenv().autoGCDabilityerr = false
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
                    upgradeunit1(name)
                    upgradeunit2(name)
                    upgradeunit3(name)
                    upgradeunit4(name)
                    upgradeunit5(name)
                    upgradeunit6(name)
                    --upgradeunitTEST()
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
                    upgradeunit1(name)
                    upgradeunit2(name)
                    upgradeunit3(name)
                    upgradeunit4(name)
                    upgradeunit5(name)
                    upgradeunit6(name)
                    --upgradeunitTEST()
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
                task.wait(1.1)

            cata = Settings.WorldCategory; level = Settings.SelectedLevel;
            if Settings.AutoPickPortal and cata == "Portals"  then
                local DataPortalReplay = GetPlayerPortalUse(level)
                local args = {
                    [1] = "replay",
                    [2] = { ["item_uuid"] = DataPortalReplay[2] }
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(args))
                local args = {
                    [1] = "replay",
                    [2] = { ["item_uuid"] = DataPortalReplay[2] }
                }
                game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(args))
                --game:GetService("ReplicatedStorage"):WaitForChild("endpoints"):WaitForChild("client_to_server"):WaitForChild("set_game_finished_vote"):InvokeServer(unpack(args))
                warn("Pick Portal Replay...") 
            elseif Settings.AutoReplay then
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
            elseif Settings.AutoLeave and not Settings.AutoReplay and not Settings.AutoNext and not Settings.AutoContinue and not Settings.AutoPickPortal then
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

    -- Start of Get Current Wave Number [Added by HOLYSHz]
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

function upgradeunit1(name) 
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v._stats.id.Value == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
            if v._stats.upgrade.Value ~= tonumber(Settings.U1_UpgCap) then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
            end
        end
    end
end

function upgradeunit2(name) 
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v._stats.id.Value == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
            if v._stats.upgrade.Value ~= tonumber(Settings.U2_UpgCap) then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
            end
        end
    end
end

function upgradeunit3(name) 
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v._stats.id.Value == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
            if v._stats.upgrade.Value ~= tonumber(Settings.U3_UpgCap) then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
            end
        end
    end
end

function upgradeunit4(name) 
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v._stats.id.Value == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
            if v._stats.upgrade.Value ~= tonumber(Settings.U4_UpgCap) then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
            end
        end
    end
end

function upgradeunit5(name) 
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v._stats.id.Value == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
            if v._stats.upgrade.Value ~= tonumber(Settings.U5_UpgCap) then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
            end
        end
    end
end

function upgradeunit6(name) 
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v._stats.id.Value == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
            if v._stats.upgrade.Value ~= tonumber(Settings.U6_UpgCap) then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
            end
        end
    end
end

--test Priority

function targetpriority(name)
    for i, v in ipairs(Workspace["_UNITS"]:GetChildren()) do
       if v:FindFirstChild("_stats") and v:FindFirstChild("_hitbox") then
            if tostring(v._stats.player.Value) == game.Players.LocalPlayer.Name then
                if v._stats.id.Value == name and v._stats.priority.Value ~= Settings.U1_Priority then
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.cycle_priority:InvokeServer(v)
                end
            end
        end
    end
end

function Priorityunit1(name) 
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v._stats.id.Value == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
            if v._stats.priority.Value ~= Settings.U1_Priority then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.cycle_priority:InvokeServer(v)
            end
        end
    end
end

function Priorityunit2(name) 
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v._stats.id.Value == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
            if v._stats.priority.Value ~= Settings.U2_Priority then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.cycle_priority:InvokeServer(v)
            end
        end
    end
end

function Priorityunit3(name) 
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v._stats.id.Value == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
            if v._stats.priority.Value ~= Settings.U3_Priority then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.cycle_priority:InvokeServer(v)
            end
        end
    end
end

function Priorityunit4(name) 
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v._stats.id.Value == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
            if v._stats.priority.Value ~= Settings.U4_Priority then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.cycle_priority:InvokeServer(v)
            end
        end
    end
end

function Priorityunit5(name) 
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v._stats.id.Value == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
            if v._stats.priority.Value ~= Settings.U5_Priority then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.cycle_priority:InvokeServer(v)
            end
        end
    end
end

function Priorityunit6(name) 
    repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
    for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
        repeat task.wait() until v:WaitForChild("_stats")
        if v._stats.id.Value == name and tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
            if v._stats.priority.Value ~= Settings.U6_Priority then
            game:GetService("ReplicatedStorage").endpoints.client_to_server.cycle_priority:InvokeServer(v)
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
    U1_sellW, U2_sellW, U3_sellW, U4_sellW, U5_sellW, U6_sellW = Settings.U1_SellWave or 999, Settings.U2_SellWave or 999, Settings.U3_SellWave or 999, Settings.U4_SellWave or 999, Settings.U5_SellWave or 999, Settings.U6_SellWave or 999

    --//Unit 1

    local U1_amm, U1_name, U1_uuid, U1_u = GetUnitInfo("U1")
    if U1_wv <= current_wave and U1_amm <= U1_TAmm then
        if U1_sellW >= current_wave and U1_amm < U1_TAmm then
            print("placing u1.."..U1_name)
            PlacePos(map, U1_name, U1_uuid,"UP1")
        end
        if U1_TAmm > 0 then
            print("Target Priority u1.."..U1_name)
            Priorityunit1(U1_name)
        end
        if U1_sellW <= current_wave then
            print("selling u1.."..U1_name)
            sellunit1(U1_name)
        end
        if U1_upgW <= current_wave and U1_sellW >= current_wave then
            print("upgrading u1.."..U1_name)
            upgradeunit1(U1_name)
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
        if U2_TAmm > 0 then
            print("Target Priority u2.."..U2_name)
            Priorityunit2(U2_name)
        end
        if U2_sellW <= current_wave then
            print("selling u2.."..U2_name)
            sellunit2(U2_name)
        end
        if U2_upgW <= current_wave and U2_sellW >= current_wave then
            print("upgrading u2.."..U2_name)
            upgradeunit2(U2_name)
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
        if U3_TAmm > 0 then
            print("Target Priority u3.."..U3_name)
            Priorityunit3(U3_name)
        end
	    if U3_sellW <= current_wave then
		    print("selling u3.."..U3_name)
		    sellunit3(U3_name)
	    end
        if U3_upgW <= current_wave and U3_sellW >= current_wave then
            print("upgrading u3.."..U3_name)
            upgradeunit3(U3_name)
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
        if U4_TAmm > 0 then
            print("Target Priority u4.."..U4_name)
            Priorityunit4(U4_name)
        end
	    if U4_sellW <= current_wave then
		    print("selling u4.."..U4_name)
		    sellunit4(U4_name)
	    end
        if U4_upgW <= current_wave and U4_sellW >= current_wave then
            print("upgrading u4.."..U4_name)
            upgradeunit4(U4_name)
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
        if U5_TAmm > 0 then
            print("Target Priority u5.."..U5_name)
            Priorityunit5(U5_name)
        end
	    if U5_sellW <= current_wave then
		    print("selling u5.."..U5_name)
		    sellunit5(U5_name)
	    end
        if U5_upgW <= current_wave and U5_sellW >= current_wave then
            print("upgrading u5.."..U5_name)
            upgradeunit5(U5_name)
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
        if U6_TAmm > 0 then
            print("Target Priority u6.."..U6_name)
            Priorityunit6(U6_name)
        end
	    if U6_sellW <= current_wave then
		    print("selling u6.."..U6_name)
		    sellunit6(U6_name)
	    end
        if U6_upgW <= current_wave and U6_sellW >= current_wave then
            print("upgrading u6.."..U6_name)
            upgradeunit6(U6_name)
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
                    print(" World "..map.." attemp to place "..unitinfo_[1])
    
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
    while task.wait(0.5) do
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
            elseif game.Workspace._map:FindFirstChild("linings") then
                PlaceUnitsTEST("OPnew")
            elseif game.Workspace._map:FindFirstChild("buildingsouter") then
                PlaceUnitsTEST("Modako")
            elseif game.Workspace._map:FindFirstChild("water beams") then
                PlaceUnitsTEST("sao")
            elseif game.Workspace._map:FindFirstChild("swords") then
                PlaceUnitsTEST("Berserk")
            elseif game.Workspace._map:FindFirstChild("Storm") then
                PlaceUnitsTEST("Eclipse")
            elseif game.Workspace._map["misc deco"]:FindFirstChild("bushes") then
                PlaceUnitsTEST("clover")
            end
        end
    end
end))

coroutine.resume(coroutine.create(function()
    while task.wait(0.5) do
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
            elseif game.Workspace._map:FindFirstChild("linings") then
                PlaceUnits("OPnew")
            elseif game.Workspace._map:FindFirstChild("buildingsouter") then
                PlaceUnits("Modako")
            elseif game.Workspace._map:FindFirstChild("water beams") then
                PlaceUnits("sao")
            elseif game.Workspace._map:FindFirstChild("swords") then
                PlaceUnits("Berserk")
            elseif game.Workspace._map:FindFirstChild("Storm") then
                PlaceUnits("Eclipse")
            elseif game.Workspace._map["misc deco"]:FindFirstChild("bushes") then
                PlaceUnits("clover") 
            end
        end
    end
end))

-----------------------------------------------------
--------------------FPS BOOST-----------------------
-----------------------------------------------------

function FPSBOOST()
    _G.Settings = {
        Players = {
            ["Ignore Me"] = true, -- Ignore your Character
            ["Ignore Others"] = true -- Ignore other Characters
        },
        Meshes = {
            Destroy = false, -- Destroy Meshes
            LowDetail = true -- Low detail meshes (NOT SURE IT DOES ANYTHING)
        },
        Images = {
            Invisible = false, -- Invisible Images
            LowDetail = false, -- Low detail images (NOT SURE IT DOES ANYTHING)
            Destroy = false, -- Destroy Images
        },
        ["No Particles"] = true, -- Disables all ParticleEmitter, Trail, Smoke, Fire and Sparkles
        ["No Camera Effects"] = true, -- Disables all PostEffect's (Camera/Lighting Effects)
        ["No Explosions"] = true, -- Makes Explosion's invisible
        ["No Clothes"] = true, -- Removes Clothing from the game
        ["Low Water Graphics"] = true, -- Removes Water Quality
        ["No Shadows"] = true, -- Remove Shadows
        ["Low Rendering"] = true, -- Lower Rendering
        ["Low Quality Parts"] = true -- Lower quality parts
    }
    
    if not _G.Ignore then
        _G.Ignore = {} -- Add Instances to this table to ignore them (e.g. _G.Ignore = {workspace.Map, workspace.Map2})
    end
    if not _G.WaitPerAmount then
        _G.WaitPerAmount = 500 -- Set Higher or Lower depending on your computer's performance
    end
    if _G.SendNotifications == nil then
        _G.SendNotifications = false -- Set to false if you don't want notifications
    end
    if _G.ConsoleLogs == nil then
        _G.ConsoleLogs = false -- Set to true if you want console logs (mainly for debugging)
    end
    
    
    
    if not game:IsLoaded() then
        repeat
            task.wait()
        until game:IsLoaded()
    end
    if not _G.Settings then
        _G.Settings = {
            Players = {
                ["Ignore Me"] = true,
                ["Ignore Others"] = true,
                ["Ignore Tools"] = true
            },
            Meshes = {
                NoMesh = false,
                NoTexture = true,
                Destroy = false
            },
            Images = {
                Invisible = false,
                Destroy = false
            },
            Explosions = {
                Smaller = true,
                Invisible = false, -- Not recommended for PVP games
                Destroy = false -- Not recommended for PVP games
            },
            Particles = {
                Invisible = true,
                Destroy = false
            },
            TextLabels = {
                LowerQuality = true,
                Invisible = false,
                Destroy = false
            },
            MeshParts = {
                LowerQuality = true,
                Invisible = false,
                NoTexture = false,
                NoMesh = false,
                Destroy = false
            },
            Other = {
                ["FPS Cap"] = true, -- Set this true to uncap FPS
                ["No Camera Effects"] = true,
                ["No Clothes"] = true,
                ["Low Water Graphics"] = true,
                ["No Shadows"] = true,
                ["Low Rendering"] = true,
                ["Low Quality Parts"] = true,
                ["Low Quality Models"] = true,
                ["Reset Materials"] = true,
                ["Lower Quality MeshParts"] = true
            }
        }
    end
    local Players, Lighting, StarterGui, MaterialService = game:GetService("Players"), game:GetService("Lighting"), game:GetService("StarterGui"), game:GetService("MaterialService")
    local ME, CanBeEnabled = Players.LocalPlayer, {"ParticleEmitter", "Trail", "Smoke", "Fire", "Sparkles"}
    local function PartOfCharacter(Instance)
        for i, v in pairs(Players:GetPlayers()) do
            if v ~= ME and v.Character and Instance:IsDescendantOf(v.Character) then
                return true
            end
        end
        return false
    end
    local function DescendantOfIgnore(Instance)
        for i, v in pairs(_G.Ignore) do
            if Instance:IsDescendantOf(v) then
                return true
            end
        end
        return false
    end
    local function CheckIfBad(Instance)
        if not Instance:IsDescendantOf(Players) and (_G.Settings.Players["Ignore Others"] and not PartOfCharacter(Instance) or not _G.Settings.Players["Ignore Others"]) and (_G.Settings.Players["Ignore Me"] and ME.Character and not Instance:IsDescendantOf(ME.Character) or not _G.Settings.Players["Ignore Me"]) and (_G.Settings.Players["Ignore Tools"] and not Instance:IsA("BackpackItem") and not Instance:FindFirstAncestorWhichIsA("BackpackItem") or not _G.Settings.Players["Ignore Tools"])--[[not PartOfCharacter(Instance)]] and (_G.Ignore and not table.find(_G.Ignore, Instance) and not DescendantOfIgnore(Instance) or (not _G.Ignore or type(_G.Ignore) ~= "table" or #_G.Ignore <= 0)) then
            if Instance:IsA("DataModelMesh") then
                if _G.Settings.Meshes.NoMesh and Instance:IsA("SpecialMesh") then
                    Instance.MeshId = ""
                end
                if _G.Settings.Meshes.NoTexture and Instance:IsA("SpecialMesh") then
                    Instance.TextureId = ""
                end
                if _G.Settings.Meshes.Destroy or _G.Settings["No Meshes"] then
                    Instance:Destroy()
                end
            elseif Instance:IsA("FaceInstance") then
                if _G.Settings.Images.Invisible then
                    Instance.Transparency = 1
                    Instance.Shiny = 1
                end
                if _G.Settings.Images.LowDetail then
                    Instance.Shiny = 1
                end
                if _G.Settings.Images.Destroy then
                    Instance:Destroy()
                end
            elseif Instance:IsA("ShirtGraphic") then
                if _G.Settings.Images.Invisible then
                    Instance.Graphic = ""
                end
                if _G.Settings.Images.Destroy then
                    Instance:Destroy()
                end
            elseif table.find(CanBeEnabled, Instance.ClassName) then
                if _G.Settings["Invisible Particles"] or _G.Settings["No Particles"] or (_G.Settings.Other and _G.Settings.Other["Invisible Particles"]) or (_G.Settings.Particles and _G.Settings.Particles.Invisible) then
                    Instance.Enabled = false
                end
                if (_G.Settings.Other and _G.Settings.Other["No Particles"]) or (_G.Settings.Particles and _G.Settings.Particles.Destroy) then
                    Instance:Destroy()
                end
            elseif Instance:IsA("PostEffect") and (_G.Settings["No Camera Effects"] or (_G.Settings.Other and _G.Settings.Other["No Camera Effects"])) then
                Instance.Enabled = false
            elseif Instance:IsA("Explosion") then
                if _G.Settings["Smaller Explosions"] or (_G.Settings.Other and _G.Settings.Other["Smaller Explosions"]) or (_G.Settings.Explosions and _G.Settings.Explosions.Smaller) then
                    Instance.BlastPressure = 1
                    Instance.BlastRadius = 1
                end
                if _G.Settings["Invisible Explosions"] or (_G.Settings.Other and _G.Settings.Other["Invisible Explosions"]) or (_G.Settings.Explosions and _G.Settings.Explosions.Invisible) then
                    Instance.BlastPressure = 1
                    Instance.BlastRadius = 1
                    Instance.Visible = false
                end
                if _G.Settings["No Explosions"] or (_G.Settings.Other and _G.Settings.Other["No Explosions"]) or (_G.Settings.Explosions and _G.Settings.Explosions.Destroy) then
                    Instance:Destroy()
                end
            elseif Instance:IsA("Clothing") or Instance:IsA("SurfaceAppearance") or Instance:IsA("BaseWrap") then
                if _G.Settings["No Clothes"] or (_G.Settings.Other and _G.Settings.Other["No Clothes"]) then
                    Instance:Destroy()
                end
            elseif Instance:IsA("BasePart") and not Instance:IsA("MeshPart") then
                if _G.Settings["Low Quality Parts"] or (_G.Settings.Other and _G.Settings.Other["Low Quality Parts"]) then
                    Instance.Material = Enum.Material.Plastic
                    Instance.Reflectance = 0
                end
            elseif Instance:IsA("TextLabel") and Instance:IsDescendantOf(workspace) then
                if _G.Settings["Lower Quality TextLabels"] or (_G.Settings.Other and _G.Settings.Other["Lower Quality TextLabels"]) or (_G.Settings.TextLabels and _G.Settings.TextLabels.LowerQuality) then
                    Instance.Font = Enum.Font.SourceSans
                    Instance.TextScaled = false
                    Instance.RichText = false
                    Instance.TextSize = 14
                end
                if _G.Settings["Invisible TextLabels"] or (_G.Settings.Other and _G.Settings.Other["Invisible TextLabels"]) or (_G.Settings.TextLabels and _G.Settings.TextLabels.Invisible) then
                    Instance.Visible = false
                end
                if _G.Settings["No TextLabels"] or (_G.Settings.Other and _G.Settings.Other["No TextLabels"]) or (_G.Settings.TextLabels and _G.Settings.TextLabels.Destroy) then
                    Instance:Destroy()
                end
            elseif Instance:IsA("Model") then
                if _G.Settings["Low Quality Models"] or (_G.Settings.Other and _G.Settings.Other["Low Quality Models"]) then
                    Instance.LevelOfDetail = 1
                end
            elseif Instance:IsA("MeshPart") then
                if _G.Settings["Low Quality MeshParts"] or (_G.Settings.Other and _G.Settings.Other["Low Quality MeshParts"]) or (_G.Settings.MeshParts and _G.Settings.MeshParts.LowerQuality) then
                    Instance.RenderFidelity = 2
                    Instance.Reflectance = 0
                    Instance.Material = Enum.Material.Plastic
                end
                if _G.Settings["Invisible MeshParts"] or (_G.Settings.Other and _G.Settings.Other["Invisible MeshParts"]) or (_G.Settings.MeshParts and _G.Settings.MeshParts.Invisible) then
                    Instance.Transparency = 1
                    Instance.RenderFidelity = 2
                    Instance.Reflectance = 0
                    Instance.Material = Enum.Material.Plastic
                end
                if _G.Settings.MeshParts and _G.Settings.MeshParts.NoTexture then
                    Instance.TextureID = ""
                end
                if _G.Settings.MeshParts and _G.Settings.MeshParts.NoMesh then
                    Instance.MeshId = ""
                end
                if _G.Settings["No MeshParts"] or (_G.Settings.Other and _G.Settings.Other["No MeshParts"]) or (_G.Settings.MeshParts and _G.Settings.MeshParts.Destroy) then
                    Instance:Destroy()
                end
            end
        end
    end
    coroutine.wrap(pcall)(function()
        if (_G.Settings["Low Water Graphics"] or (_G.Settings.Other and _G.Settings.Other["Low Water Graphics"])) then
            if not workspace:FindFirstChildOfClass("Terrain") then
                repeat
                    task.wait()
                until workspace:FindFirstChildOfClass("Terrain")
            end
            workspace:FindFirstChildOfClass("Terrain").WaterWaveSize = 0
            workspace:FindFirstChildOfClass("Terrain").WaterWaveSpeed = 0
            workspace:FindFirstChildOfClass("Terrain").WaterReflectance = 0
            workspace:FindFirstChildOfClass("Terrain").WaterTransparency = 0
            if sethiddenproperty then
                sethiddenproperty(workspace:FindFirstChildOfClass("Terrain"), "Decoration", false)
            else
                StarterGui:SetCore("SendNotification", {
                    Title = "FPS Boost V2",
                    Text = "Your exploit does not support sethiddenproperty, please use a different exploit.",
                    Duration = 5,
                    Button1 = "Okay"
                })
                warn("Your exploit does not support sethiddenproperty, please use a different exploit.")
            end
            if _G.ConsoleLogs then
                warn("Low Water Graphics Enabled")
            end
        end
    end)
    coroutine.wrap(pcall)(function()
        if _G.Settings["No Shadows"] or (_G.Settings.Other and _G.Settings.Other["No Shadows"]) then
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            Lighting.ShadowSoftness = 0
            if sethiddenproperty then
                sethiddenproperty(Lighting, "Technology", 2)
            else
                StarterGui:SetCore("SendNotification", {
                    Title = "FPS Boost V2",
                    Text = "Your exploit does not support sethiddenproperty, please use a different exploit.",
                    Duration = 5,
                    Button1 = "Okay"
                })
                warn("Your exploit does not support sethiddenproperty, please use a different exploit.")
            end
            if _G.ConsoleLogs then
                warn("No Shadows Enabled")
            end
        end
    end)
    coroutine.wrap(pcall)(function()
        if _G.Settings["Low Rendering"] or (_G.Settings.Other and _G.Settings.Other["Low Rendering"]) then
            settings().Rendering.QualityLevel = 1
            settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
            if _G.ConsoleLogs then
                warn("Low Rendering Enabled")
            end
        end
    end)
    coroutine.wrap(pcall)(function()
        if _G.Settings["Reset Materials"] or (_G.Settings.Other and _G.Settings.Other["Reset Materials"]) then
            for i, v in pairs(MaterialService:GetChildren()) do
                v:Destroy()
            end
            MaterialService.Use2022Materials = false
            if _G.ConsoleLogs then
                warn("Reset Materials Enabled")
            end
        end
    end)
    coroutine.wrap(pcall)(function()
        if _G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"]) then
            if setfpscap then
                if type(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])) == "string" or type(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])) == "number" then
                    setfpscap(tonumber(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])))

                    if _G.ConsoleLogs then
                        warn("FPS Capped to " .. tostring(_G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"])))
                    end
                elseif _G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"]) == true then
                    setfpscap(1e6)

                    if _G.ConsoleLogs then
                        warn("FPS Uncapped")
                    end
                end
            else
                StarterGui:SetCore("SendNotification", {
                    Title = "FPS Boost V2",
                    Text = "FPS Cap Failed",
                    Duration = math.huge,
                    Button1 = "Okay"
                })
                warn("FPS Cap Failed")
            end
        end
    end)
    game.DescendantAdded:Connect(function(value)
        wait(_G.LoadedWait or 1)
        CheckIfBad(value)
    end)
    local Descendants = game:GetDescendants()
    local StartNumber = _G.WaitPerAmount or 500
    local WaitNumber = _G.WaitPerAmount or 500

    if _G.ConsoleLogs then
        warn("Checking " .. #Descendants .. " Instances...")
    end
    for i, v in pairs(Descendants) do
        CheckIfBad(v)
        if i == WaitNumber then
            task.wait()
            if _G.ConsoleLogs then
                print("Loaded " .. i .. "/" .. #Descendants)
            end
            WaitNumber = WaitNumber + StartNumber
        end
    end
    warn("FPS Booster Loaded!")
end

if Settings.fpsboost then
    FPSBOOST()
end

-----------------------------------------------------
--------------------DELETE MAP-----------------------
-----------------------------------------------------
--delete map Map id
function DelHill()
	if game.Workspace._terrain:FindFirstChild("terrain") then
    	for i,v in pairs(game:GetService("Workspace")["_terrain"].hill:GetChildren()) do
			if v.ClassName == "MeshPart" then v:Destroy() end
        	if v.ClassName == "Model" then v:Destroy() end
            if v.ClassName == "Part" then v:Destroy() end
			if v.ClassName == "Folder" then v:Destroy() end
			if v.ClassName == "MeshPart" then v:Destroy() end
        end
    end  
end   

if Settings.deletehill then
    DelHill()
end

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
function DelMapnamekmap()
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
                if v.Name == "cakes" then v:Destroy() end
                if v.Name == "balloons" then v:Destroy() end
                if v.Name == "obstacles" then v:Destroy() end
        end
    end   
end

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
function DelMapSnowy0()
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
    	for i,v in pairs(game:GetService("Workspace")["_map"].obstacles.deco:GetChildren()) do
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

function DelMapSand5()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]:GetChildren()) do
				if v.Name == "KazekageMansion" then v:Destroy() end
        end
    end   
end

function DelMapSand6()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]:GetChildren()) do
				if v.Name == "branches" then v:Destroy() end
        end
    end   
end

function DelMapSand7()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]:GetChildren()) do
				if v.Name == "mansion floor" then v:Destroy() end
        end
    end   
end


function DelMapSand8()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].KazekageMansion:GetChildren()) do
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

function DelMapHollow2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].trees:GetChildren()) do
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

function DelMapClover10()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["misc deco"].logs:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapClover11()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["misc deco"].flowers:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapClover12()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["misc deco"].bushes:GetChildren()) do
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapClover13()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["misc deco"].hay:GetChildren()) do
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

function DelMapmha0()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["mha_city_night_rain"]:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

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

--OPnew

function DelMapOPnew()
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

function DelMapOPnew1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].cloth:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapOPnew2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].hay:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapOPnew3()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].paper:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapOPnew4()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["wood stacks"]:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapOPnew5()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["tables and tents"]:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapOPnew6()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].linings:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

--Modako
function DelMapmodako()
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

function DelMapmodako1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].debrisouter:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapmodako2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].buildingsouter:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapmodako3()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].fence:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapmodako4()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["fire p"]:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapmodako5()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].paper:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapmodako6()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["road lines"]:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapmodako7()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].roadtreethings:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapmodako8()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].telepoles:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapmodako9()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].watertanks:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapmodako10()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].sparks:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

--SAO
function DelMapsao()
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

function DelMapsao1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].light:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapsao2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].fish:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapsao3()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"]["water beams"]:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapsao4()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].fireflies:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapsao5()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].torches:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

--Berserk
function DelMapBerserk()
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

function DelMapBerserk1()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].swords:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapBerserk2()
	if game.Workspace:FindFirstChild("_terrain") then
    	for i,v in pairs(game:GetService("Workspace")["_terrain"].terrain:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

--Eclipse
function DelMapEclipse()
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

function DelMapEclipse2()
	if game.Workspace:FindFirstChild("_map") then
    	for i,v in pairs(game:GetService("Workspace")["_map"].Storm:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

function DelMapEclipse3()
	if game.Workspace:FindFirstChild("_terrain") then
    	for i,v in pairs(game:GetService("Workspace")["_terrain"].terrain:GetChildren()) do
				if v.ClassName == "Folder" then v:Destroy() end
				if v.ClassName == "MeshPart" then v:Destroy() end
				if v.ClassName == "Model" then v:Destroy() end
				if v.ClassName == "Part" then v:Destroy() end
        end
    end   
end

--fixmap
---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

coroutine.resume(coroutine.create(function()
    while task.wait(1.5) do
        if game.PlaceId ~= 8304191830 and Settings.deletemap then
            local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
            repeat task.wait() until game:GetService("Workspace"):WaitForChild("_map")
            if game.Workspace._map:FindFirstChild("namek mushroom model") then
				DelTer() 
				DelMapMain()
                DelMapnamekmap()
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
				DelMapSnowy0()
				DelMapSnowy1()
            elseif game.Workspace._map:FindFirstChild("sand_gate") then  
                DelTer() 
				DelMapSand1()
		DelMapSand2()
		DelMapSand3()
		DelMapSand4()
        DelMapSand5()
        DelMapSand6()
        DelMapSand7()
        DelMapSand8()
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
                DelMapHollow2()
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
                DelMapmha0()
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
    elseif game.Workspace._map:FindFirstChild("linings") then
        DelTer() 
        DelMapMain()
        DelMapOPnew()
        DelMapOPnew1()
        DelMapOPnew2()
        DelMapOPnew3()
        DelMapOPnew4()
        DelMapOPnew5()
        DelMapOPnew6()
    elseif game.Workspace._map:FindFirstChild("buildingsouter") then
        DelTer() 
        DelMapmodako()
        DelMapmodako1()
        DelMapmodako2()
        DelMapmodako3()
        DelMapmodako4()
        DelMapmodako5()
        DelMapmodako6()
        DelMapmodako7()
        DelMapmodako8()
        DelMapmodako9()
        DelMapmodako10()
    elseif game.Workspace._map:FindFirstChild("water beams") then
        DelTer() 
		DelMapMain()
        DelMapsao()
		DelMapsao1()
		DelMapsao2()
		DelMapsao3()
		DelMapsao4()
		DelMapsao5()
    elseif game.Workspace._map:FindFirstChild("swords") then
        DelTer() 
		DelMapMain()
        DelMapBerserk()
		DelMapBerserk1()
		DelMapBerserk2()
    elseif game.Workspace._map:FindFirstChild("Storm") then
        DelTer() 
		DelMapMain()
        DelMapEclipse()
		DelMapEclipse2()
		DelMapEclipse3()
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
        DelMapClover10()
        DelMapClover11()
        DelMapClover12()
        DelMapClover13()
            end
        end
    end
end))

--fixmap end

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



--Auto Grab Daily Quest --updatefix
--game:GetService("ReplicatedStorage").src.Data.QuestsEvent
function autoDailyquest()
    if Settings.autoDailyquest then
        game:GetService("ReplicatedStorage").endpoints.client_to_server.accept_npc_quest:InvokeServer("berserk_daily")
        wait(15)
    end
end

if Settings.autoDailyquest then
    autoDailyquest()
end

function autoDailyMission()
    if Settings.autoDailyMission then
        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_claim_dailymission:InvokeServer("mha 12.0.0_dailymission_bleach2_daily")
        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_claim_dailymission:InvokeServer("mha 12.0.0_dailymission_dressrosa_daily")
        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_claim_dailymission:InvokeServer("mha 12.0.0_dailymission_clover_daily")
        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_claim_dailymission:InvokeServer("mha 12.0.0_dailymission_7ds_daily")
        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_claim_dailymission:InvokeServer("mha 12.0.0_dailymission_mha_daily")
        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_claim_dailymission:InvokeServer("mha 12.0.0_dailymission_jojo_daily")
        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_claim_dailymission:InvokeServer("mha 12.0.0_dailymission_opm_daily")
        wait(15)
    end
end

if Settings.autoDailyMission then
    autoDailyMission()
end

-- Start of Check Connection
function checkInterNet()
    warn("Auto Reconnect Loaded")
    while task.wait(5) do
        game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(a)
            if a.Name == 'ErrorPrompt' then
                task.wait(10)
                warn("Trying to Reconnect")
                TPReturner()
            end
        end)
    end
end
-- End of Check Connection

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

--ReedemCode updatefix
function Reedemcode()
    codes = {"TWOMILLION","subtomaokuma","CHALLENGEFIX","GINYUFIX","RELEASE","SubToKelvingts","SubToBlamspot","KingLuffy","TOADBOIGAMING","noclypso","FictioNTheFirst","GOLDENSHUTDOWN","GOLDEN"
    ,"SINS2","subtosnowrbx","Cxrsed","subtomaokuma","VIGILANTE","HAPPYEASTER","ENTERTAINMENT","DRESSROSA","BILLION","MADOKA","AINCRAD","ANNIVERSARY"}
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
        wait(1)
    game:GetService("ReplicatedStorage").endpoints.client_to_server.claim_christmas_calendar_reward:InvokeServer()
end)

pcall(function()
    game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error.Volume = 0
    game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error_old.Volume = 0
    game.Players.LocalPlayer.PlayerGui.MessageGui.Enabled = false
    warn("TEST Display Error Hider!!!")
end)

--start function mute Error
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

--End of function mute Error

warn("Arpon Anti-AFK Loaded!!!")
warn("Arpon Hider Name Loaded!!!")
warn("Arpon AA v2 Loaded!!!")
warn("All Loaded !!!")

if game.PlaceId == 8304191830 then
    repeat task.wait(0.5) until Workspace:WaitForChild(game.Players.LocalPlayer.Name)
    checkInterNet()
elseif game.PlaceId ~= 8304191830 then
    repeat task.wait(0.5) until Workspace:WaitForChild("_terrain")
    checkInterNet()
end
