local version = "v2.0.0"

------------------------------
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace") 
local plr = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local mouse = game.Players.LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")
------------------------------

if game.CoreGui:FindFirstChild("FinityUI") then
    game.CoreGui["FinityUI"]:Destroy()
end

local dir = "Anime_Adventures/"..game.Players.LocalPlayer.Name
local Uilib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ArponAG/Scripts/main/finitylib"))()
local exec = tostring(identifyexecutor())

local Window = Uilib.new(true, "[👹UPD 9] Anime Adventures "..version.." - "..exec)
Window.ChangeToggleKey(Enum.KeyCode.RightShift)

local Home = Window:Category(" 📋 Home")
local Farm = Window:Category(" 🏹 Auto Farm")
local UC = Window:Category(" 👥 Unit Config")
local Misc = Window:Category(" 🛠 Misc")

local Developers = Home:Sector("Anime Adventures")
local asdasd = Home:Sector(" ")
local UIUPDT = Home:Sector("UI UPDATE (January 20th)")

local SelectUnits = Farm:Sector("Units Selection")
local SelectWorld = Farm:Sector("World Selection")
local UnitPosition = Farm:Sector("Select Unit Position")
local MoreFarmConfig = Farm:Sector("More Farming Config")
local AutoFarmConfig = Farm:Sector("Auto Farm Config")
local ChallengeConfig = Farm:Sector("Challenge Config")

local Unit1 = UC:Sector("Unit 1")
local Unit2 = UC:Sector("Unit 2")
local Unit3 = UC:Sector("Unit 3")
local Unit4 = UC:Sector("Unit 4")
local Unit5 = UC:Sector("Unit 5")
local Unit6 = UC:Sector("Unit 6")

function setGlobalValues()
    local config = HttpService:JSONDecode(readfile(dir.."/config.json"))
    local preset = HttpService:JSONDecode(readfile(dir.."/presets.json"))

    --Global Values
    getgenv().SelectedUnits = config.SelectedUnits
    getgenv().SelectedPreset = config.SelectedPreset
    getgenv().WorldCategory = config.WorldCategory
    getgenv().SelectedWorld = config.SelectedWorld
    getgenv().SelectedLevel = config.SelectedLevel
    getgenv().Difficulty = config.Difficulty
    getgenv().isFriendOnly = config.isFriendOnly

    --AutoFarmConfigs
    getgenv().AutoFarm = config.AutoFarm
    getgenv().AutoLeave = config.AutoLeave
    getgenv().AutoInfinityCastle = config.AutoInfinityCastle
    getgenv().AutoEventFarm = config.AutoEventFarm
    getgenv().AutoAbilities = config.AutoAbilities
    getgenv().AutoUpgrade = config.AutoUpgrade
    getgenv().AutoSell = config.AutoSell
    getgenv().AutoSellWave = config.AutoSellWave
    getgenv().AutoChallenge = config.AutoChallenge
    getgenv().SelectedReward = config.SelectedReward
    getgenv().AutoChallengeAll = config.AutoChallengeAll
    getgenv().SpawnUnitPos = config.xspawnUnitPos

    --loading presets
    getgenv().preset1 = preset.preset1
    getgenv().preset2 = preset.preset2
    getgenv().preset3 = preset.preset3
    getgenv().preset4 = preset.preset4
    getgenv().preset5 = preset.preset5
    getgenv().preset6 = preset.preset6
end

function updatejson()
    local xdata = {
        SelectedUnits = getgenv().SelectedUnits,
        SelectedPreset = getgenv().SelectedPreset,
        WorldCategory = getgenv().WorldCategory,
        SelectedWorld = getgenv().SelectedWorld,
        SelectedLevel = getgenv().SelectedLevel,
        Difficulty = getgenv().Difficulty,
        isFriendOnly = getgenv().isFriendOnly,
        AutoFarm = getgenv().AutoFarm,
        AutoLeave = getgenv().AutoLeave,
        AutoInfinityCastle = getgenv().AutoInfinityCastle,
        AutoEventFarm = getgenv().AutoEventFarm,
        AutoAbilities = getgenv().AutoAbilities,
        AutoUpgrade = getgenv().AutoUpgrade,
        AutoSell = getgenv().AutoSell,
        AutoSellWave = getgenv().AutoSellWave,
        AutoChallenge = getgenv().AutoChallenge,
        SelectedReward = getgenv().SelectedReward,
        AutoChallengeAll = getgenv().AutoChallengeAll,
        xspawnUnitPos = getgenv().SpawnUnitPos
    }
    local config = HttpService:JSONEncode(xdata)
    writefile(dir.."/config.json", config) 
end

function updatepreset()
    local PresetData = {
        preset1 = getgenv().preset1,
        preset2 = getgenv().preset2,
        preset3 = getgenv().preset3,
        preset4 = getgenv().preset4,
        preset5 = getgenv().preset5
    }        
    
    local presets = HttpService:JSONEncode(PresetData)
    writefile(dir.."/presets.json", presets)
end

function setDefaultData()
    local xdata = {
        SelectedUnits = {
            U1 = "nil",
            U2 = "nil",
            U3 = "nil",
            U4 = "nil",
            U5 = "nil",
            U6 = "nil"
        },
        SelectedPreset = "...",
        WorldCategory = "...",
        SelectedWorld = "...",
        SelectedLevel = "...",
        Difficulty = "...",
        isFriendOnly = true,
        AutoFarm = false,
        AutoLeave = false,
        AutoInfinityCastle = false,
        AutoEventFarm = false,
        AutoAbilities = false,
        AutoUpgrade = false,
        AutoSell = false,
        AutoSellWave = "Wave_Number",
        AutoChallenge = false,
        SelectedReward = "star_fruit_random",
        AutoChallengeAll = false,

        xspawnUnitPos = {
            black_clover = {
                UP1 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP3 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP2 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP6 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP5 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP4 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                }
            },
            opm = {
                UP1 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP3 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP2 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP6 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP5 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP4 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                }
            },
            hollow_leg = {
                UP1 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP3 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP2 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP6 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP5 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP4 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                }
            },
            Cursed = {
                UP1 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP3 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP2 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP6 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP5 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP4 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                }
            },
            Sand = {
                UP1 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP3 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP2 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP6 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP5 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP4 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                }
            },
            Namak = {
                UP1 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,

                    x = 0,
                    z = 0

                },
                UP3 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,

                    x = 0,
                    z = 0
                },
                UP2 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,

                    x = 0,
                    z = 0
                },
                UP6 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,

                    x = 0,
                    z = 0
                },
                UP5 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,

                    x = 0,
                    z = 0
                },
                UP4 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,

                    x = 0,
                    z = 0
                }
            },
            Hollow = {
                UP1 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP3 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP2 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP6 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP5 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP4 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                }
            },
            Ant = {
                UP1 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP3 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP2 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP6 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP5 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP4 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                }
            },
            Aot = {
                UP1 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP3 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP2 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP6 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP5 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP4 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                }
            },
            Snowy = {
                UP1 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP3 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP2 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP6 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP5 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP4 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                }
            },
            Ghoul = {
                UP1 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP3 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP2 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP6 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP5 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP4 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                }
            },
            Magic = {
                UP1 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP3 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP2 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP6 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP5 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP4 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                }
            },
            Marine = {
                UP1 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP3 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP2 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP6 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP5 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP4 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                }
            },
            thriller_park = {
                UP1 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP3 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP2 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP6 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP5 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP4 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                }
            },
            chainsaw = {
                UP1 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP3 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP2 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP6 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP5 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP4 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                }
            },
            jojo = {
                UP1 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP3 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP2 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP6 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP5 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                },
                UP4 = {
                    y = 0,
					y2 = 0,
					y3 = 0,
					y4 = 0,
					y5 = 0,
					y6 = 0,
                    x = 0,
                    z = 0
                }
            }
        }
    }
   
    local PresetData = {
        preset1 = {
            U1 = "nil",
            U2 = "nil",
            U3 = "nil",
            U4 = "nil",
            U5 = "nil",
            U6 = "nil"
        },
        preset2 = {
            U1 = "nil",
            U2 = "nil",
            U3 = "nil",
            U4 = "nil",
            U5 = "nil",
            U6 = "nil"
        },
        preset3 = {
            U1 = "nil",
            U2 = "nil",
            U3 = "nil",
            U4 = "nil",
            U5 = "nil",
            U6 = "nil"
        },
        preset4 = {
            U1 = "nil",
            U2 = "nil",
            U3 = "nil",
            U4 = "nil",
            U5 = "nil",
            U6 = "nil"
        },
        preset5 = {
            U1 = "nil",
            U2 = "nil",
            U3 = "nil",
            U4 = "nil",
            U5 = "nil",
            U6 = "nil"
        }

	}

    local config = HttpService:JSONEncode(xdata)
    local preset = HttpService:JSONEncode(PresetData)
    makefolder("Anime_Adventures")
    makefolder(dir)
    writefile(dir.."/config.json", config)
    writefile(dir.."/presets.json", preset)
end

function sex()
    setGlobalValues()

    ----------------------------------------------
    ---------------- Units Selection -------------
    ----------------------------------------------
    local function UnitSec()

        function Check(x, y)
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

        function selectunits()
            for i, v in ipairs(game:GetService("Players").LocalPlayer.PlayerGui["spawn_units"].Lives.Frame.Units:GetChildren()) do
                if v:IsA("ImageButton") then
                    local unitxx = v.Main.petimage.WorldModel:GetChildren()[1]
                    if unitxx ~= nil then
                        if Check(unitxx.Name, v) then
                            print(unitxx, v)
                        end
                    end
                end
            end
        end

        SelectUnits:Cheat("Button", "🦸 Select Current Units", function() --Selects Currently Equipped Units!
            getgenv().SelectedUnits = {
                U1 = "nil",
                U2 = "nil",
                U3 = "nil",
                U4 = "nil",
                U5 = "nil",
                U6 = "nil"
            }
            selectunits()
            updatejson()
        end)

        local a = SelectUnits:Cheat("Dropdown", "👥 Units Preset",function(preset)
        getgenv().SelectedPreset = preset
        print(preset)
        end, { 
            options = { "Preset 1", "Preset 2", "Preset 3", "Preset 4","Preset 5" }, 
            default = getgenv().SelectedPreset
        })

        SelectUnits:Cheat("Button", "💾 Save Units Preset", function() --Saves to preset
            preset = getgenv().SelectedPreset
            if preset == "Preset 1" then
                getgenv().preset1 = getgenv().SelectedUnits
            elseif preset == "Preset 2" then
                getgenv().preset2 = getgenv().SelectedUnits
            elseif preset == "Preset 3" then
                getgenv().preset3 = getgenv().SelectedUnits
            elseif preset == "Preset 4" then
                getgenv().preset4 = getgenv().SelectedUnits
            elseif preset == "Preset 5" then
                getgenv().preset5 = getgenv().SelectedUnits
            end
            print(preset)
            updatepreset() 
        end)

        SelectUnits:Cheat("Button", "⌛ Load Units Preset", function() --loads preset
            preset = getgenv().SelectedPreset
            if preset == "Preset 1" then
                loadpreset = getgenv().preset1
            elseif preset == "Preset 2" then
                loadpreset = getgenv().preset2
            elseif preset == "Preset 3" then
                loadpreset = getgenv().preset3
            elseif preset == "Preset 4" then
                loadpreset = getgenv().preset4
            elseif preset == "Preset 5" then
                loadpreset = getgenv().preset5
            elseif preset == "Preset 6" then
                loadpreset = getgenv().preset6
            end
            print(preset)

            game:GetService("ReplicatedStorage").endpoints.client_to_server.unequip_all:InvokeServer()
                
            for i = 1, 6 do
                local unitinfo = loadpreset["U" .. i]
                warn(unitinfo)
                if unitinfo ~= nil then
                    local unitinfo_ = unitinfo:split(" #")
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.equip_unit:InvokeServer(unitinfo_[2])
                end
            end
        end)

    end

    ----------------------------------------------
    ------------------ World Section -------------
    ----------------------------------------------
    local function WorldSec()
        SelectWorld:Cheat("Dropdown", "🌟 Select Category",function(value)
            print(value)
            getgenv().WorldCategory = value
            getgenv().updateworld()
            getgenv().updatelevel()
            getgenv().updatedifficulty()
            updatejson()
        end, {
            options = {
                "Story World",
                "Legend Stages",
                "Devil City"
            },
            default = getgenv().WorldCategory
        })

        local selectworld = SelectWorld:Cheat("Dropdown", "🌏 Select World",function(value)
            print(value)
            getgenv().SelectedWorld = value
            getgenv().updatelevel()
            getgenv().updatedifficulty()
            updatejson()
        end, {options = { }, default = getgenv().SelectedWorld })

        getgenv().updateworld = function()
            selectworld:ClearDrop() local storylist;
            if getgenv().WorldCategory == "Story World" then
                storylist = {"Planet Namak", "Shiganshinu District", "Snowy Town","Hidden Sand Village", "Marine's Ford",
                "Ghoul City", "Hollow World", "Ant Kingdom", "Magic Town", "Cursed Academy","Clover Kingdom","Cape Canaveral", "Alien Spaceship"}
            elseif getgenv().WorldCategory == "Legend Stages" then
                storylist = {"Clover Kingdom", "Hollow Invasion"}
            elseif getgenv().WorldCategory == "Devil City" then
                storylist = "Portals"
            end
        
            for i = 1, #storylist do
                selectworld:AddOption(storylist[i])
            end
        end

        local selectlevel = SelectWorld:Cheat("Dropdown", "✨ Select Level",function(value)
            print(value)
            getgenv().SelectedLevel = value
            getgenv().updatedifficulty()
            updatejson()
        end, {options = { }, default = getgenv().SelectedLevel})

        getgenv().updatelevel = function()
            selectlevel:ClearDrop() local levellist; local level = getgenv().SelectedWorld;

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
            end

            for i = 1, #levellist do
                selectlevel:AddOption(levellist[i])
            end
        end

        local selectdiff = SelectWorld:Cheat("Dropdown", "💦 Difficulty",function(value)
            print(value, " Selected")
            getgenv().Difficulty = value
            updatejson()
        end, {
            options = {}, default = getgenv().Difficulty
        })

        getgenv().updatedifficulty = function()
            selectdiff:ClearDrop() local level = getgenv().SelectedLevel; cata = getgenv().WorldCategory; local diff;
            if level == "namek_infinite" or level == "aot_infinite" or level == "demonslayer_infinite" 
            or level == "naruto_infinite" or level == "marineford_infinite" or level == "tokyoghoul_infinite" or level == "hueco_infinite" 
            or level == "hxhant_infinite" or level == "magnolia_infinite" or level == "jjk_infinite" or level == "clover_infinite" 
            or level == "jojo_infinite" or level == "opm_infinite" or cata == "Legend Stages" then
                diff = {"Hard"}
            else
                diff = {"Normal", "Hard"}
            end
            for i = 1, #diff do
                selectdiff:AddOption(diff[i])
            end
        end
        
        SelectWorld:Cheat("Checkbox","🙋️ Friends Only  ", function(bool)
            print(bool)
            getgenv().isFriendOnly = bool
            updatejson()
        end,{enabled = getgenv().isFriendOnly})
    end
    
    ----------------------------------------------
    ---------------- AutoFarm Config -------------
    ----------------------------------------------
    local function AutoFarmSec()
        AutoFarmConfig:Cheat("Checkbox","🌾 Auto Farm  ", function(bool)
            print(bool)
            getgenv().AutoFarm = bool
            updatejson()
        end,{enabled = getgenv().AutoFarm })

        AutoFarmConfig:Cheat("Checkbox","🏃 Auto Leave  ", function(bool)
            print(bool)
            getgenv().AutoLeave = bool
            updatejson()
        end,{enabled = getgenv().AutoLeave})
        


        AutoFarmConfig:Cheat("Checkbox","🔥 Auto Abilities  ", function(bool)
            print(bool)
            getgenv().AutoAbilities = bool
            updatejson()
        end,{enabled = getgenv().AutoAbilities})

        AutoFarmConfig:Cheat("Checkbox","⭐️ Auto Upgrade Units  ", function(bool)
            print(bool)
            getgenv().AutoUpgrade = bool
            updatejson()
        end,{enabled = getgenv().AutoUpgrade})

        AutoFarmConfig:Cheat("Checkbox","⭐️ Auto Sell Units  ", function(bool)
            print(bool)
            getgenv().AutoSell = bool
            updatejson()
        end,{enabled = getgenv().AutoSell})

        AutoFarmConfig:Cheat("Textbox", "💸 Auto Sell Wave", function(Value)
            Value = tonumber(Value)
            getgenv().AutoSellWave = Value
            updatejson()
        end, {placeholder = getgenv().AutoSellWave})
    end

    ----------------------------------------------
    --------------- More Farm Config -------------
    ----------------------------------------------
    local function MoreFarmSec()
        MoreFarmConfig:Cheat("Checkbox","🏰️ Auto Infinity Castle  ", function(bool)
            print(bool)
            getgenv().AutoInfinityCastle = bool
            updatejson()
        end,{enabled = getgenv().AutoInfinityCastle})

        MoreFarmConfig:Cheat("Checkbox","⚡️ Auto Event Farm  ", function(bool)
            print(bool)
            getgenv().AutoEventFarm = bool
            updatejson()
        end,{enabled = getgenv().AutoEventFarm})
    end

    ----------------------------------------------
    ----------------- Challenge ------------------
    ----------------------------------------------
    local function ChallengeSec()
        local challengeconfig = ChallengeConfig:Cheat("Dropdown", "🥇 Select Reward",function(value)
            print(value)
        end, { options = {"star_fruit_random","star_remnant","gems", "gold"}, default = getgenv().SelectedReward})

        ChallengeConfig:Cheat("Checkbox","🎯 Auto Challenge  ", function(bool)
            print(bool)
            getgenv().AutoChallenge = bool
            updatejson()
        end, {enabled = getgenv().AutoChallenge})

        ChallengeConfig:Cheat("Checkbox","🏆 Farm Any Rewards  ", function(bool)
            print(bool)
            getgenv().AutoChallengeAll = bool
            updatejson()
        end,{enabled = getgenv().AutoChallengeAll})
    end

    ----------------------------------------------
    ------------------ credits -------------------
    ----------------------------------------------
    local function credits()
        Developers:Cheat("Label","📝 Scripted by: Arpon AG#6612 & Forever4D#0001 ")    
        Developers:Cheat("Label","📐 UI By: detourious @ v3rmillion.net")    
        Developers:Cheat("Label","🔧 To toggle the script press \"RightShift\"")   
        Developers:Cheat("Button","🔗 Copy Discord Invite", function()
        end)    
        UIUPDT:Cheat("Label","[+] idk \n[+]reeeeeeeeeee")    
    end
    
    getgenv().posX = 1.5
    getgenv().posZ = 1.5

    ----------------------------------------------
    ---------------- Unit Config -----------------
    ----------------------------------------------
    function updatepos(map, UnitPos, a,a2,a3,a4,a5,a6)
        --warn(map)		
        SpawnUnitPos[map][UnitPos]["x"] = a.Position.X
        SpawnUnitPos[map][UnitPos]["z"] = a.Position.Z

		SpawnUnitPos[map][UnitPos]["y"] = a.Position.Y
		SpawnUnitPos[map][UnitPos]["y2"] = a2.Position.Y
		SpawnUnitPos[map][UnitPos]["y3"] = a3.Position.Y
		SpawnUnitPos[map][UnitPos]["y4"] = a4.Position.Y
		SpawnUnitPos[map][UnitPos]["y5"] = a5.Position.Y
		SpawnUnitPos[map][UnitPos]["y6"] = a6.Position.Y

        updatejson()
    end

	function MouseClick2(UnitPos)
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
			if _G.gg then
				pcall(function()
					mouse.TargetFilter  = a
					
					local xPos = mouse.Hit.Position.X --x position of unit
					local zPos = mouse.Hit.Position.Z --z position of unit
					local rayOrigin = CFrame.new(xPos, 100, zPos).p
					local rayDestination = CFrame.new(xPos, -50, zPos).p
					local rayDirection = (rayDestination - rayOrigin)
					local raycastResult = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
					a.CFrame = CFrame.new(raycastResult.Position) * CFrame.Angles(0, -0, -0)
					
					
					local xPos2 = a.Position.X --x position of unit
					local zPos2 = a.Position.Z + z --z position of unit
					local rayOrigin2 = CFrame.new(xPos2, 100, zPos2).p
					local rayDestination2 = CFrame.new(xPos2, -50, zPos2).p
					local rayDirection2 = (rayDestination2 - rayOrigin2)
					local raycastResult2 = workspace:Raycast(rayOrigin2, rayDirection2, raycastParams)
					a2.CFrame = CFrame.new(raycastResult2.Position) * CFrame.Angles(0, -0, -0)
					
					local xPos3 = a.Position.X + x --x position of unit
					local zPos3 = a.Position.Z  --z position of unit
					local rayOrigin3 = CFrame.new(xPos3, 100, zPos3).p
					local rayDestination3 = CFrame.new(xPos3, -50, zPos3).p
					local rayDirection3 = (rayDestination3 - rayOrigin3)
					local raycastResult3 = workspace:Raycast(rayOrigin3, rayDirection3, raycastParams)
					a3.CFrame = CFrame.new(raycastResult3.Position) * CFrame.Angles(0, -0, -0)
					
					local xPos4 = a.Position.X - x --x position of unit
					local zPos4 = a.Position.Z  --z position of unit
					local rayOrigin4 = CFrame.new(xPos4, 100, zPos4).p
					local rayDestination4 = CFrame.new(xPos4, -50, zPos4).p
					local rayDirection4 = (rayDestination4 - rayOrigin4)
					local raycastResult4 = workspace:Raycast(rayOrigin4, rayDirection4, raycastParams)
					a4.CFrame = CFrame.new(raycastResult4.Position) * CFrame.Angles(0, -0, -0)

					local xPos5 = a.Position.X + x--x position of unit
					local zPos5 = a.Position.Z + z --z position of unit
					local rayOrigin5 = CFrame.new(xPos5, 100, zPos5).p
					local rayDestination5 = CFrame.new(xPos5, -50, zPos5).p
					local rayDirection5 = (rayDestination5 - rayOrigin5)
					local raycastResult5 = workspace:Raycast(rayOrigin5, rayDirection5, raycastParams)
					a5.CFrame = CFrame.new(raycastResult5.Position) * CFrame.Angles(0, -0, -0)

					local xPos6 = a.Position.X - x --x position of unit
					local zPos6 = a.Position.Z + z --z position of unit
					local rayOrigin6 = CFrame.new(xPos6, 100, zPos6).p
					local rayDestination6 = CFrame.new(xPos6, -50, zPos6).p
					local rayDirection6 = (rayDestination6 - rayOrigin6)
					local raycastResult6 = workspace:Raycast(rayOrigin6, rayDirection6, raycastParams)
					a6.CFrame = CFrame.new(raycastResult6.Position) * CFrame.Angles(0, -0, -0)
				end)
			end
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
        kjqhwe = mouse.Button1Down:Connect(function()
            kjqhwe:Disconnect()
			print("b")
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
            end
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

        --//UNIT 1
        Unit1:Cheat("Textbox", "Place from wave", function(Value)
            Value = tonumber(Value)
        end, {placeholder = 0})

        Unit1:Cheat("Textbox", "Upgrade from wave", function(Value)
            Value = tonumber(Value)
        end, {placeholder = 0})

        Unit1:Cheat("Textbox", "Upgrade Cap", function(Value)
            Value = tonumber(Value)
        end, {placeholder = 999})

        Unit1:Cheat("Textbox", "Auto Sell at wave", function(Value)
            Value = tonumber(Value)
        end, {placeholder = 999}) 


        --//UNIT 2
        Unit2:Cheat("Textbox", "Place from wave", function(Value)
            Value = tonumber(Value)
        end, {placeholder = 0})

        Unit2:Cheat("Textbox", "Upgrade from wave", function(Value)
            Value = tonumber(Value)
        end, {placeholder = 0})

        Unit2:Cheat("Textbox", "Upgrade Cap", function(Value)
            Value = tonumber(Value)
        end, {placeholder = 0})
        Unit2:Cheat("Textbox", "Auto Sell at wave", function(Value)
            Value = tonumber(Value)
        end, {placeholder = 999}) 
        
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


    if game.PlaceId == 8304191830 then
        UnitPosition:Cheat("Label","Not available in game Lobby!")    
        UnitSec()
        WorldSec()
        AutoFarmSec()
        MoreFarmSec()
        ChallengeSec()
        unitconfig()
        credits()
    else
        SelectUnits:Cheat("Label","Only available in game Lobby!")    
        WorldSec()
        AutoFarmSec()
        MoreFarmSec()
        ChallengeSec()
        UnitPosSec()
        unitconfig()
        credits()
    end
end -- end of sex


if isfolder("Anime_Adventures") and isfolder(dir) and isfile(dir.."/config.json") 
    and isfile(dir.."/presets.json") then

    local jsonData = readfile("Anime_Adventures/"..game.Players.LocalPlayer.Name.."/config.json")
    local data = HttpService:JSONDecode(jsonData)
    sex()
else
    setDefaultData()
    sex()
end


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
        if getgenv().SelectedReward == game:GetService("Workspace")["_LOBBIES"]["_DATA"]["_CHALLENGE"]["current_reward"].Value then
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

local function startChallenge()
    if game.PlaceId == 8304191830 then
        local cpos = plr.Character.HumanoidRootPart.CFrame
        if getgenv().AutoChallenge and getgenv().AutoFarm  and checkReward() == true then
            for i, v in pairs(game:GetService("Workspace")["_CHALLENGES"].Challenges:GetDescendants()) do
                if v.Name == "Owner" and v.Value == nil then
                    --print(v.Parent.Name.." "..v.Parent:GetFullName())
                    local args = {  [1] = tostring(v.Parent.Name) }
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

getgenv().teleporting = true
getgenv().door = "_lobbytemplategreen1"

local function startfarming()

    if getgenv().farmprotal ~= true and getgenv().AutoFarm and getgenv().teleporting 
                           and getgenv().AutoInfinityCastle == false then

        if game.PlaceId == 8304191830 then
            local cpos = plr.Character.HumanoidRootPart.CFrame

            if tostring(game.Workspace._LOBBIES.Story[getgenv().door].Owner.Value) ~= plr.Name then
                for i, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
                    if v.Name == "Owner" and v.Value == nil then
                        local args = { [1] = tostring(v.Parent.Name) }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))

                        task.wait()
                    
                        local args = {
                            [1] = tostring(v.Parent.Name), -- Lobby 
                            [2] = getgenv().SelectedLevel, -- World/Level
                            [3] = getgenv().isFriendOnly, -- Friends Only or not
                            [4] = getgenv().Difficulty }

                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))

                        local args = { [1] =tostring(v.Parent.Name) }
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
        end
    elseif getgenv().AutoFarm and getgenv().teleporting 
                           and getgenv().AutoFarmTP == false and getgenv().AutoInfinityCastle == false and getgenv().farmprotal 
                           or getgenv().farmprotal then

        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.items.grid.List.Outer.ItemFrames:GetChildren()) do
            if v.Name == "portal_csm" or v.Name == "portal_csm1" or v.Name == "portal_csm2" or v.Name == "portal_csm3" or v.Name == "portal_csm4" or v.Name == "portal_csm5"  then
                print(v._uuid_or_id.value)
                getgenv().PortalID = v._uuid_or_id.value
                break;
            end
        end
          task.wait(1.5)

          local args = {
            [1] = tostring(getgenv().PortalID),
            [2] = { ["friends_only"] = getgenv().isFriendOnly }
        }
        
        game:GetService("ReplicatedStorage").endpoints.client_to_server.use_portal:InvokeServer(unpack(args))

        task.wait(1.5)

        for i,v in pairs(game:GetService("Workspace")["_PORTALS"].Lobbies:GetDescendants()) do
            if v.Name == "Owner" then
                if tostring(v.value) == game.Players.LocalPlayer.Name then
                    local args = {
                        [1] = tostring(v.Parent.Name)
                    }
                    
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
                    break;
                end
            end 
        end
        task.wait(7)
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


coroutine.resume(coroutine.create(function()
    while task.wait() do
        if getgenv().AutoInfinityCastle == false then
            if checkChallenge() == false  then --Challenge_Not_Complete
                if  getgenv().AutoChallenge and checkReward() == true then
                    startChallenge() --S_Challenge
                else
                    startfarming()--S_Farming
                end
            elseif checkChallenge() == true then
                startfarming()--S_Farming
            end
        elseif getgenv().AutoInfinityCastle == true then--Infiniy Castle
            if checkChallenge() == false  then --Challenge_Not_Complete
                if  getgenv().AutoChallenge and checkReward() == true then
                    startChallenge() --S_Challenge
                else
                    FarmCastlePark()--S_Farming
                end
            elseif checkChallenge() == true then
                FarmCastlePark()--S_Farming
            end
        end

        local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
        if getgenv().AutoSell and tonumber(getgenv().AutoSellWave) <= _wave.Value then
            getgenv().disableatuofarm = true
            if game.PlaceId ~= 8304191830 then
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

        if getgenv().AutoAbilities then
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
        
        if getgenv().AutoUpgrade then
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

        if getgenv().UnitSellTog then

            for i, v in pairs(game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.collection.grid.List.Outer.UnitFrames:GetChildren()) do
                if v.Name == "CollectionUnitFrame" then
                    repeat task.wait() until v:FindFirstChild("name")
                    for _, Info in next, getgenv().UnitCache do
                        if Info.name == v.name.Text and Info.rarity == getgenv().UnitToSell then
                            local args = {[1] = { [1] = tostring(v._uuid.Value) }}
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_units:InvokeServer(unpack(args))
                         end
                    end
                end
            end
        end

    end
end))




function PlacePos(_uuid)
    --place 0
    local args = {
        [1] = _uuid,
        [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]) )
    }
    game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

    --place 1
    local args = {
        [1] = _uuid,
        [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]) )
    }
    game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

    --place 2 
    local args = {
        [1] = _uuid,
        [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z) )
    }
    game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

    --place 3 
    local args = {
        [1] = _uuid,
        [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z) )
    }
    game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

    --place 4
    local args = {
        [1] = _uuid,
        [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z) )
    }
    game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

    --place 5
    local args = {
        [1] = _uuid,
        [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]) )
    }
    game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

end


function PlaceUnitsTEST(map)
    x = getgenv().posX; y = getgenv().posY; z = getgenv().posZ
    print("SEXXXXXXXXXXXXXXXXXXXXXXXXXXXX")

    U1wave = 1
    U1ammount = 3
    U1upgrade = 4
    
    if current_wave <= U1wave then
        if #current_ammount <= U1ammount then
            local unitinfo = getgenv().SelectedUnits["U1"] --Unit _uuid
            if unitinfo ~= nil then
                local unitinfo_ = unitinfo:split(" #")
                local pos = getgenv().SpawnUnitPos[map]["UP1"]
                PlacePos(unitinfo_[2])
            end
        end
    end
    
end


function PlaceUnits(map)
    if getgenv().AutoFarm and not getgenv().disableatuofarm then
        x = getgenv().posX; z = getgenv().posZ
        for i = 1, 6 do
            local unitinfo = getgenv().SelectedUnits["U" .. i]
            if unitinfo ~= nil then
                local unitinfo_ = unitinfo:split(" #")
                local pos = getgenv().SpawnUnitPos[map]["UP" .. i]
                print(map.." attempt to place "..unitinfo_[1])

                if unitinfo_[1] ~= "Metal Knight (Arsenal)" then

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

                elseif unitinfo_[1] == "Metal Knight (Arsenal)" then
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
end

coroutine.resume(coroutine.create(function()
    while task.wait(1.5) do
        if getgenv().AutoFarm and not getgenv().disableatuofarm then
            local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
            repeat task.wait() until game:GetService("Workspace"):WaitForChild("_map")
           
            if game.PlaceId ~= 8304191830 then
                if game.Workspace._map:FindFirstChild("namek mushroom model") then
                    PlaceUnits("Namak")
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
                end
            end
        end
    end
end))
