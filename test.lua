repeat wait() until game:IsLoaded()
repeat wait()if game.Players.LocalPlayer.Team==nil and game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Visible==true then if _G.Team=="Pirate"then game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Size=UDim2.new(0,10000,0,10000)game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Position=UDim2.new(-4,0,-5,0)game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.BackgroundTransparency=1;wait(.5)game:service'VirtualInputManager':SendMouseButtonEvent(500,500,0,true,game,1)game:service'VirtualInputManager':SendMouseButtonEvent(500,500,0,false,game,1)elseif _G.Team=="Marine"then game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.Size=UDim2.new(0,10000,0,10000)game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.Position=UDim2.new(-4,0,-5,0)game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.BackgroundTransparency=1;wait(.5)game:service'VirtualInputManager':SendMouseButtonEvent(500,500,0,true,game,1)game:service'VirtualInputManager':SendMouseButtonEvent(500,500,0,false,game,1)else game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Size=UDim2.new(0,10000,0,10000)game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Position=UDim2.new(-4,0,-5,0)game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.BackgroundTransparency=1;wait(.5)game:service'VirtualInputManager':SendMouseButtonEvent(500,500,0,true,game,1)game:service'VirtualInputManager':SendMouseButtonEvent(500,500,0,false,game,1)end end until game.Players.LocalPlayer.Team~=nil and game:IsLoaded()
wait(1)

if _G.Select_Weapon == nil then
    for a,b in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren())do if b.ToolTip=="Melee"then if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(b.Name))then _G.Select_Weapon=tostring(b.Name)end end end
end

if game.PlaceId == 2753915549 then
    World1 = true
end

function CheckQuest() 
    local MyLevel = game.Players.LocalPlayer.Data.Level.Value
    if World1 then 
        if MyLevel==1 or MyLevel<=9 or _G.Select_Mob_Farm=="Bandit [Lv. 5]"then Ms="Bandit [Lv. 5]"NameQuest="BanditQuest1"LevelQuest=1;NameMon="Bandit"CFrameQuest=CFrame.new(1061.66699,16.5166187,1544.52905,-0.942978859,-3.33851502e-09,0.332852632,7.04340497e-09,1,2.99841325e-08,-0.332852632,3.06188177e-08,-0.942978859)CFrameMon=CFrame.new(1052.6585693359375,86.21188354492188,1651.3323974609375)SPAWNPOINT="Default"if _G.Auto_Farm_Level and(CFrameMon.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameMon;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==10 or MyLevel<=14 or _G.Select_Mob_Farm=="Monkey [Lv. 14]"then Ms="Monkey [Lv. 14]"NameQuest="JungleQuest"LevelQuest=1;NameMon="Monkey"CFrameQuest=CFrame.new(-1604.12012,36.8521118,154.23732,0.0648873374,-4.70858913e-06,-0.997892559,1.41431883e-07,1,-4.70933674e-06,0.997892559,1.64442184e-07,0.0648873374)CFrameMon=CFrame.new(-1502.74609,98.5633316,90.6417007,0.836947978,0,0.547282517,-0,1,-0,-0.547282517,0,0.836947978)SPAWNPOINT="Jungle"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()wait(2)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==15 or MyLevel<=29 or _G.Select_Mob_Farm=="Gorilla [Lv. 20]"then Ms="Gorilla [Lv. 20]"NameQuest="JungleQuest"LevelQuest=2;NameMon="Gorilla"CFrameQuest=CFrame.new(-1604.12012,36.8521118,154.23732,0.0648873374,-4.70858913e-06,-0.997892559,1.41431883e-07,1,-4.70933674e-06,0.997892559,1.64442184e-07,0.0648873374)CFrameMon=CFrame.new(-1223.52808,6.27936459,-502.292664,0.310949147,-5.66602516e-08,0.950426519,-3.37275488e-08,1,7.06501808e-08,-0.950426519,-5.40241736e-08,0.310949147)SPAWNPOINT="Jungle"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()wait(2)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==30 or MyLevel<=39 or _G.Select_Mob_Farm=="Pirate [Lv. 35]"then Ms="Pirate [Lv. 35]"NameQuest="BuggyQuest1"LevelQuest=1;NameMon="Pirate"CFrameQuest=CFrame.new(-1139.59717,4.75205183,3825.16211,-0.959730506,-7.5857054e-09,0.280922383,-4.06310328e-08,1,-1.11807175e-07,-0.280922383,-1.18718916e-07,-0.959730506)CFrameMon=CFrame.new(-1219.32324,4.75205183,3915.63452,-0.966492832,-6.91238853e-08,0.25669381,-5.21195496e-08,1,7.3047012e-08,-0.25669381,5.72206496e-08,-0.966492832)SPAWNPOINT="Pirate"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()wait(2)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==48 or MyLevel<=59 or _G.Select_Mob_Farm=="Brute [Lv. 45]"then Ms="Brute [Lv. 45]"NameQuest="BuggyQuest1"LevelQuest=2;NameMon="Brute"CFrameQuest=CFrame.new(-1139.59717,4.75205183,3825.16211,-0.959730506,-7.5857054e-09,0.280922383,-4.06310328e-08,1,-1.11807175e-07,-0.280922383,-1.18718916e-07,-0.959730506)CFrameMon=CFrame.new(-1146.49646,96.0936813,4312.1333,-0.978175163,-1.53222057e-08,0.207781896,-3.33316912e-08,1,-8.31738873e-08,-0.207781896,-8.82843523e-08,-0.978175163)SPAWNPOINT="Pirate"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()wait(2)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==60 or MyLevel<=74 or _G.Select_Mob_Farm=="Desert Bandit [Lv. 60]"then Ms="Desert Bandit [Lv. 60]"NameQuest="DesertQuest"LevelQuest=1;NameMon="Desert Bandit"CFrameQuest=CFrame.new(897.031128,6.43846416,4388.97168,-0.804044724,3.68233266e-08,0.594568789,6.97835176e-08,1,3.24365246e-08,-0.594568789,6.75715199e-08,-0.804044724)CFrameMon=CFrame.new(932.788818,6.4503746,4488.24609,-0.998625934,3.08948351e-08,0.0524050146,2.79967303e-08,1,-5.60361286e-08,-0.0524050146,-5.44919629e-08,-0.998625934)SPAWNPOINT="Desert"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()wait(2)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==75 or MyLevel<=89 or _G.Select_Mob_Farm=="Desert Officer [Lv. 70]"then Ms="Desert Officer [Lv. 70]"NameQuest="DesertQuest"LevelQuest=2;NameMon="Desert Officer"CFrameQuest=CFrame.new(897.031128,6.43846416,4388.97168,-0.804044724,3.68233266e-08,0.594568789,6.97835176e-08,1,3.24365246e-08,-0.594568789,6.75715199e-08,-0.804044724)CFrameMon=CFrame.new(1580.03198,4.61375761,4366.86426,0.135744005,-6.44280718e-08,-0.990743816,4.35738308e-08,1,-5.90598574e-08,0.990743816,-3.51534837e-08,0.135744005)SPAWNPOINT="Desert"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()wait(2)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==90 or MyLevel<=99 or _G.Select_Mob_Farm=="Snow Bandit [Lv. 90]"then Ms="Snow Bandit [Lv. 90]"NameQuest="SnowQuest"LevelQuest=1;NameMon="Snow Bandits"CFrameQuest=CFrame.new(1384.14001,87.272789,-1297.06482,0.348555952,-2.53947841e-09,-0.937287986,1.49860568e-08,1,2.86358204e-09,0.937287986,-1.50443711e-08,0.348555952)CFrameMon=CFrame.new(1370.24316,102.403511,-1411.52905,0.980274439,-1.12995728e-08,0.197641045,-9.57343449e-09,1,1.04655214e-07,-0.197641045,-1.04482936e-07,0.980274439)SPAWNPOINT="Ice"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()wait(2)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==100 or MyLevel<=119 or _G.Select_Mob_Farm=="Snowman [Lv. 100]"then Ms="Snowman [Lv. 100]"NameQuest="SnowQuest"LevelQuest=2;NameMon="Snowman"CFrameQuest=CFrame.new(1384.14001,87.272789,-1297.06482,0.348555952,-2.53947841e-09,-0.937287986,1.49860568e-08,1,2.86358204e-09,0.937287986,-1.50443711e-08,0.348555952)CFrameMon=CFrame.new(1384.14001,87.272789,-1297.06482,0.348555952,-2.53947841e-09,-0.937287986,1.49860568e-08,1,2.86358204e-09,0.937287986,-1.50443711e-08,0.348555952)SPAWNPOINT="Ice"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()wait(2)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==120 or MyLevel<=123 or _G.Select_Mob_Farm=="Chief Petty Officer [Lv. 120]"then Ms="Chief Petty Officer [Lv. 120]"NameQuest="MarineQuest2"LevelQuest=1;NameMon="Chief Petty Officer"CFrameQuest=CFrame.new(-5035.0835,28.6520386,4325.29443,0.0243340395,-7.08064647e-08,0.999703884,-6.36926814e-08,1,7.23777944e-08,-0.999703884,-6.54350671e-08,0.0243340395)CFrameMon=CFrame.new(-4882.8623,22.6520386,4255.53516,0.273695946,-5.40380647e-08,-0.96181643,4.37720793e-08,1,-4.37274998e-08,0.96181643,-3.01326679e-08,0.273695946)SPAWNPOINT="MarineBase"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==124 or MyLevel<=149 then Ms="Chief Petty Officer [Lv. 120]"NameQuest="MarineQuest2"LevelQuest=1;NameMon="Chief Petty Officer"CFrameQuest=CFrame.new(-5035.0835,28.6520386,4325.29443,0.0243340395,-7.08064647e-08,0.999703884,-6.36926814e-08,1,7.23777944e-08,-0.999703884,-6.54350671e-08,0.0243340395)CFrameMon=CFrame.new(-4744.7763671875,63.474491119384766,4459.0234375)SPAWNPOINT="MarineBase"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==150 or MyLevel<=174 or _G.Select_Mob_Farm=="Sky Bandit [Lv. 150]"then Ms="Sky Bandit [Lv. 150]"NameQuest="SkyQuest"LevelQuest=1;NameMon="Sky Bandit"CFrameQuest=CFrame.new(-4841.83447,717.669617,-2623.96436,-0.875942111,5.59710216e-08,-0.482416272,3.04023082e-08,1,6.08195947e-08,0.482416272,3.86078725e-08,-0.875942111)CFrameMon=CFrame.new(-4970.74219,294.544342,-2890.11353,-0.994874597,-8.61311236e-08,-0.101116329,-9.10836206e-08,1,4.43614923e-08,0.101116329,5.33441664e-08,-0.994874597)SPAWNPOINT="Sky"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==175 or MyLevel<=189 or _G.Select_Mob_Farm=="Dark Master [Lv. 175]"then Ms="Dark Master [Lv. 175]"NameQuest="SkyQuest"LevelQuest=2;NameMon="Dark Master"CFrameQuest=CFrame.new(-4841.83447,717.669617,-2623.96436,-0.875942111,5.59710216e-08,-0.482416272,3.04023082e-08,1,6.08195947e-08,0.482416272,3.86078725e-08,-0.875942111)CFrameMon=CFrame.new(-5220.58594,430.693298,-2278.17456,-0.925375521,1.12086873e-08,0.379051805,-1.05115507e-08,1,-5.52320891e-08,-0.379051805,-5.50948407e-08,-0.925375521)SPAWNPOINT="Sky"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==190 or MyLevel<=209 or _G.Select_Mob_Farm=="Prisoner [Lv. 190]"then Ms="Prisoner [Lv. 190]"NameQuest="PrisonerQuest"LevelQuest=1;NameMon="Prisoner"CFrameQuest=CFrame.new(5308.93115,1.65517521,475.120514,-0.0894274712,-5.00292918e-09,-0.995993316,1.60817859e-09,1,-5.16744869e-09,0.995993316,-2.06384709e-09,-0.0894274712)CFrameMon=CFrame.new(5433.39307,88.678093,514.986877,0.879988372,0,-0.474995494,0,1,0,0.474995494,0,0.879988372)SPAWNPOINT="Prison"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==210 or MyLevel<=249 or _G.Select_Mob_Farm=="Dangerous Prisoner [Lv. 210]"then Ms="Dangerous Prisoner [Lv. 210]"NameQuest="PrisonerQuest"LevelQuest=2;NameMon="Dangerous Prisoner"CFrameQuest=CFrame.new(5308.93115,1.65517521,475.120514,-0.0894274712,-5.00292918e-09,-0.995993316,1.60817859e-09,1,-5.16744869e-09,0.995993316,-2.06384709e-09,-0.0894274712)CFrameMon=CFrame.new(5433.39307,88.678093,514.986877,0.879988372,0,-0.474995494,0,1,0,0.474995494,0,0.879988372)SPAWNPOINT="Prison"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==250 or MyLevel<=299 or _G.Select_Mob_Farm=="Toga Warrior [Lv. 225]"then Ms="Toga Warrior [Lv. 250]"NameQuest="ColosseumQuest"LevelQuest=1;NameMon="Toga Warrior"CFrameQuest=CFrame.new(-1576.11743,7.38933945,-2983.30762,0.576966345,1.22114863e-09,0.816767931,-3.58496594e-10,1,-1.24185606e-09,-0.816767931,4.2370063e-10,0.576966345)CFrameMon=CFrame.new(-1779.97583,44.6077499,-2736.35474,0.984437346,4.10396339e-08,0.175734788,-3.62286876e-08,1,-3.05844168e-08,-0.175734788,2.3741821e-08,0.984437346)SPAWNPOINT="Colosseum"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==300 or MyLevel<=364 or _G.Select_Mob_Farm=="Military Soldier [Lv. 300]"then Ms="Military Soldier [Lv. 300]"NameQuest="MagmaQuest"LevelQuest=1;NameMon="Military Soldier"CFrameQuest=CFrame.new(-5316.55859,12.2370615,8517.2998,0.588437557,-1.37880001e-08,-0.808542669,-2.10116209e-08,1,-3.23446478e-08,0.808542669,3.60215964e-08,0.588437557)CFrameMon=CFrame.new(-5363.01123,41.5056877,8548.47266,-0.578253984,-3.29503091e-10,0.815856814,9.11209668e-08,1,6.498761e-08,-0.815856814,1.11920997e-07,-0.578253984)SPAWNPOINT="Magma"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()wait(2)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==365 or MyLevel<=374 or _G.Select_Mob_Farm=="Military Spy [Lv. 330]"then Ms="Military Spy [Lv. 325]"NameQuest="MagmaQuest"LevelQuest=2;NameMon="Military Spy"CFrameQuest=CFrame.new(-5316.55859,12.2370615,8517.2998,0.588437557,-1.37880001e-08,-0.808542669,-2.10116209e-08,1,-3.23446478e-08,0.808542669,3.60215964e-08,0.588437557)CFrameMon=CFrame.new(-5787.99023,120.864456,8762.25293,-0.188358366,-1.84706277e-08,0.982100308,-1.23782129e-07,1,-4.93306951e-09,-0.982100308,-1.22495649e-07,-0.188358366)SPAWNPOINT="Magma"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()wait(2)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==375 or MyLevel<=399 or _G.Select_Mob_Farm=="Fishman Warrior [Lv. 375]"then Ms="Fishman Warrior [Lv. 375]"NameQuest="FishmanQuest"LevelQuest=1;NameMon="Fishman Warrior"CFrameQuest=CFrame.new(61122.5625,18.4716396,1568.16504,0.893533468,3.95251609e-09,0.448996574,-2.34327455e-08,1,3.78297464e-08,-0.448996574,-4.43233645e-08,0.893533468)CFrameMon=CFrame.new(60946.6094,48.6735229,1525.91687,-0.0817126185,8.90751153e-08,0.996655822,2.00889794e-08,1,-8.77269599e-08,-0.996655822,1.28533992e-08,-0.0817126185)SPAWNPOINT="Fountain"if _G.Auto_Farm_Level and(CFrameMon.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625,11.6796875,1819.7841796875))end elseif MyLevel==400 or MyLevel<=449 or _G.Select_Mob_Farm=="Fishman Commando [Lv. 400]"then Ms="Fishman Commando [Lv. 400]"NameQuest="FishmanQuest"LevelQuest=2;NameMon="Fishman Commando"CFrameQuest=CFrame.new(61122.5625,18.4716396,1568.16504,0.893533468,3.95251609e-09,0.448996574,-2.34327455e-08,1,3.78297464e-08,-0.448996574,-4.43233645e-08,0.893533468)CFrameMon=CFrame.new(61885.5039,18.4828243,1504.17896,0.577502489,0,-0.816389024,-0,1.00000012,-0,0.816389024,0,0.577502489)SPAWNPOINT="Fountain"if _G.Auto_Farm_Level and(CFrameMon.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625,11.6796875,1819.7841796875))end elseif MyLevel==450 or MyLevel<=474 or _G.Select_Mob_Farm=="God's Guard [Lv. 450]"then Ms="God's Guard [Lv. 450]"NameQuest="SkyExp1Quest"LevelQuest=1;NameMon="God's Guards"CFrameQuest=CFrame.new(-4721.71436,845.277161,-1954.20105,-0.999277651,-5.56969759e-09,0.0380011722,-4.14751478e-09,1,3.75035256e-08,-0.0380011722,3.73188307e-08,-0.999277651)CFrameMon=CFrame.new(-4716.95703,853.089722,-1933.92542,-0.93441087,-6.77488776e-09,-0.356197298,1.12145182e-08,1,-4.84390199e-08,0.356197298,-4.92565206e-08,-0.93441087)SPAWNPOINT="Sky"if _G.Auto_Farm_Level and(CFrameMon.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275,872.54248,-1667.55688))end elseif MyLevel==475 or MyLevel<=524 or _G.Select_Mob_Farm=="Shanda [Lv. 475]"then sky=false;Ms="Shanda [Lv. 475]"NameQuest="SkyExp1Quest"LevelQuest=2;NameMon="Shandas"CFrameQuest=CFrame.new(-7863.63672,5545.49316,-379.826324,0.362120807,-1.98046344e-08,-0.93213129,4.05822291e-08,1,-5.48095125e-09,0.93213129,-3.58431969e-08,0.362120807)CFrameMon=CFrame.new(-7685.12354,5601.05127,-443.171509,0.150056243,1.79768236e-08,-0.988677442,6.67798661e-09,1,1.91962481e-08,0.988677442,-9.48289181e-09,0.150056243)SPAWNPOINT="Sky"if _G.Auto_Farm_Level and(CFrameMon.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813,5547.1416015625,-380.29119873047))end elseif MyLevel==525 or MyLevel<=549 or _G.Select_Mob_Farm=="Royal Squad [Lv. 525]"then sky=true;Ms="Royal Squad [Lv. 525]"NameQuest="SkyExp2Quest"LevelQuest=1;NameMon="Royal Squad"CFrameQuest=CFrame.new(-7902.66895,5635.96387,-1411.71802,0.0504222959,2.5710392e-08,0.998727977,1.12541557e-07,1,-3.14249675e-08,-0.998727977,1.13982921e-07,0.0504222959)CFrameMon=CFrame.new(-7685.02051,5606.87842,-1442.729,0.561947823,7.69527464e-09,-0.827172697,-4.24974544e-09,1,6.41599973e-09,0.827172697,-9.01838604e-11,0.561947823)SPAWNPOINT="Sky2"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()wait(2)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==550 or MyLevel<=624 or _G.Select_Mob_Farm=="Royal Soldier [Lv. 550]"then Dis=240;sky=true;Ms="Royal Soldier [Lv. 550]"NameQuest="SkyExp2Quest"LevelQuest=2;NameMon="Royal Soldier"CFrameQuest=CFrame.new(-7902.66895,5635.96387,-1411.71802,0.0504222959,2.5710392e-08,0.998727977,1.12541557e-07,1,-3.14249675e-08,-0.998727977,1.13982921e-07,0.0504222959)CFrameMon=CFrame.new(-7864.44775,5661.94092,-1708.22351,0.998389959,2.28686137e-09,-0.0567218624,1.99431383e-09,1,7.54200258e-08,0.0567218624,-7.54117195e-08,0.998389959)SPAWNPOINT="Sky2"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()wait(2)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel==625 or MyLevel<=649 or _G.Select_Mob_Farm=="Galley Pirate [Lv. 625]"then Dis=240;sky=false;Ms="Galley Pirate [Lv. 625]"NameQuest="FountainQuest"LevelQuest=1;NameMon="Galley Pirate"CFrameQuest=CFrame.new(5254.60156,38.5011406,4049.69678,-0.0504891425,-3.62066501e-08,-0.998724639,-9.87921389e-09,1,-3.57534553e-08,0.998724639,8.06145284e-09,-0.0504891425)CFrameMon=CFrame.new(5595.06982,41.5013695,3961.47095,-0.992138803,-2.11610267e-08,-0.125142589,-1.34249509e-08,1,-6.26613996e-08,0.125142589,-6.04887518e-08,-0.992138803)SPAWNPOINT="Fountain"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()wait(2)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end elseif MyLevel>=650 or _G.Select_Mob_Farm=="Galley Captain [Lv. 650]"then Dis=240;Ms="Galley Captain [Lv. 650]"NameQuest="FountainQuest"LevelQuest=2;NameMon="Galley Captain"CFrameQuest=CFrame.new(5254.60156,38.5011406,4049.69678,-0.0504891425,-3.62066501e-08,-0.998724639,-9.87921389e-09,1,-3.57534553e-08,0.998724639,8.06145284e-09,-0.0504891425)CFrameMon=CFrame.new(5658.5752,38.5361786,4928.93506,-0.996873081,2.12391046e-06,-0.0790185928,2.16989656e-06,1,-4.96097414e-07,0.0790185928,-6.66008248e-07,-0.996873081)SPAWNPOINT="Fountain"if _G.Auto_Farm_Level and(CFrameQuest.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude>3000 then game.Players.LocalPlayer.Character.Head:Destroy()wait(2)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrameQuest;wait(1)game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")end end 
     end    
end
 
function EquipWeapon(ToolSe)
    if not _G.NotAutoEquip then
        if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then Tool=game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) wait(.1) game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool) end
    end
end

getgenv().ToTarget = function (Pos)
    Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    if game.Players.LocalPlayer.Character.Humanoid.Sit == true then game.Players.LocalPlayer.Character.Humanoid.Sit = false end
    pcall(function() tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance/210, Enum.EasingStyle.Linear),{CFrame = Pos}) end)
    tween:Play()
    if Distance <= 400 then
        tween:Cancel()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Pos
    end
    if _G.StopTween == true then
        tween:Cancel()
        _G.Clip = false
    end
end

function StopTween(target)
    if not target then
        _G.StopTween=true;wait()getgenv().ToTarget(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)wait()if game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip")then game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()end;_G.StopTween=false;_G.Clip=false
    end
end

local plr = game.Players.LocalPlayer
local CbFw = debug.getupvalues(require(plr.PlayerScripts.CombatFramework))
local CbFw2 = CbFw[2]

function GetCurrentBlade() 
    local a=CbFw2.activeController;local b=a.blades[1]if not b then return end;while b.Parent~=game.Players.LocalPlayer.Character do b=b.Parent end
    return ret
end

local LocalPlayer = game:GetService'Players'.LocalPlayer
---------------------------------------------------------------
spawn(function()
    while wait() do
        repeat wait() until game.CoreGui:FindFirstChild('RobloxPromptGui')
        local lp,po,ts = game:GetService('Players').LocalPlayer,game.CoreGui.RobloxPromptGui.promptOverlay,game:GetService('TeleportService')							
        po.ChildAdded:connect(function(a)
            if a.Name == 'ErrorPrompt' then
                repeat
                    ts:Teleport(game.PlaceId)
                    wait(2)
                until false
            end
        end)
    end
end)

spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
              if _G.Auto_Farm_Level or _G.Fast_Farm or _G.Auto_Farm_Mastery_Fruit or _G.Auto_Kill_Player_Sea_1 or _G.Auto_New_World or _G.Auto_Third_World or _G.Auto_Farm_Chest or _G.Auto_Farm_Boss or _G.Auto_Elite_Hunter or _G.Auto_Cake_Prince or _G.Auto_Farm_All_Boss or _G.Auto_Saber or _G.Auto_Pole or _G.Auto_Farm_Scrap_and_Leather or _G.Auto_Farm_Angel_Wing or _G.Auto_Factory_Farm or _G.Auto_Farm_Ectoplasm or _G.Auto_Bartilo_Quest or _G.Auto_Rengoku or _G.Auto_Farm_Radioactive or _G.Auto_Farm_Vampire_Fang or _G.Auto_Farm_Mystic_Droplet or _G.Auto_Farm_GunPowder or _G.Auto_Farm_Dragon_Scales or _G.Auto_Evo_Race_V2 or _G.Auto_Swan_Glasses or _G.Auto_Dragon_Trident or _G.Auto_Soul_Reaper or _G.Auto_Farm_Fish_Tail or _G.Auto_Farm_Mini_Tusk or _G.Auto_Farm_Magma_Ore or _G.Auto_Farm_Bone or _G.Auto_Farm_Conjured_Cocoa or _G.Auto_Open_Dough_Dungeon or _G.Auto_Rainbow_Haki or _G.Auto_Musketeer_Hat or _G.Auto_Holy_Torch or _G.Auto_Canvander or _G.Auto_Twin_Hook or _G.Auto_Serpent_Bow or _G.Auto_Fully_Death_Step or _G.Auto_Fully_SharkMan_Karate or _G.Teleport_to_Player or _G.Auto_Kill_Player_Melee or _G.Auto_Kill_Player_Gun or _G.Start_Tween_Island or _G.Auto_Next_Island or _G.Auto_Kill_Law then
                 if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                    local Noclip = Instance.new("BodyVelocity")
                    Noclip.Name = "BodyClip"
                    Noclip.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
                    Noclip.MaxForce = Vector3.new(100000,100000,100000)
                    Noclip.Velocity = Vector3.new(0,0,0)
                 end
              else	
                 if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
                 end
              end
        end)
    end)
end)
spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if _G.Auto_Farm_Level or _G.Fast_Farm or _G.Auto_Farm_Mastery_Fruit or _G.Auto_Kill_Player_Sea_1 or _G.Auto_New_World or _G.Auto_Third_World or _G.Auto_Farm_Chest or _G.Auto_Farm_Boss or _G.Auto_Elite_Hunter or _G.Auto_Cake_Prince or _G.Auto_Farm_All_Boss or _G.Auto_Saber or _G.Auto_Pole or _G.Auto_Farm_Scrap_and_Leather or _G.Auto_Farm_Angel_Wing or _G.Auto_Factory_Farm or _G.Auto_Farm_Ectoplasm or _G.Auto_Bartilo_Quest or _G.Auto_Rengoku or _G.Auto_Farm_Radioactive or _G.Auto_Farm_Vampire_Fang or _G.Auto_Farm_Mystic_Droplet or _G.Auto_Farm_GunPowder or _G.Auto_Farm_Dragon_Scales or _G.Auto_Evo_Race_V2 or _G.Auto_Swan_Glasses or _G.Auto_Dragon_Trident or _G.Auto_Soul_Reaper or _G.Auto_Farm_Fish_Tail or _G.Auto_Farm_Mini_Tusk or _G.Auto_Farm_Magma_Ore or _G.Auto_Farm_Bone or _G.Auto_Farm_Conjured_Cocoa or _G.Auto_Open_Dough_Dungeon or _G.Auto_Rainbow_Haki or _G.Auto_Musketeer_Hat or _G.Auto_Holy_Torch or _G.Auto_Canvander or _G.Auto_Twin_Hook or _G.Auto_Serpent_Bow or _G.Auto_Fully_Death_Step or _G.Auto_Fully_SharkMan_Karate or _G.Teleport_to_Player or _G.Auto_Kill_Player_Melee or _G.Auto_Kill_Player_Gun or _G.Start_Tween_Island or _G.Auto_Next_Island or _G.Auto_Kill_Law then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false    
                    end
                end
            end
        end)
    end)
end)

local Client = game.Players.LocalPlayer
local STOP = require(Client.PlayerScripts.CombatFramework.Particle)
local STOPRL = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
spawn(function()
    while task.wait() do
        pcall(function()
            if not shared.orl then shared.orl = STOPRL.wrapAttackAnimationAsync end
            if not shared.cpc then shared.cpc = STOP.play end
                STOPRL.wrapAttackAnimationAsync = function(a,b,c,d,func)
                local Hits = STOPRL.getBladeHits(b,c,d)
                if Hits then
                    if _G.Auto_Farm_Level or _G.Fast_Farm or _G.Auto_Farm_Mastery_Fruit or _G.Auto_New_World or _G.Auto_Third_World or _G.Auto_Farm_Boss or _G.Auto_Elite_Hunter or _G.Auto_Cake_Prince or _G.Auto_Farm_All_Boss or _G.Auto_Saber or _G.Auto_Pole or _G.Auto_Farm_Scrap_and_Leather or _G.Auto_Farm_Angel_Wing or _G.Auto_Factory_Farm or _G.Auto_Farm_Ectoplasm or _G.Auto_Bartilo_Quest or _G.Auto_Rengoku or _G.Auto_Farm_Radioactive or _G.Auto_Farm_Vampire_Fang or _G.Auto_Farm_Mystic_Droplet or _G.Auto_Farm_GunPowder or _G.Auto_Farm_Dragon_Scales or _G.Auto_Evo_Race_V2 or _G.Auto_Swan_Glasses or _G.Auto_Dragon_Trident or _G.Auto_Soul_Reaper or _G.Auto_Farm_Fish_Tail or _G.Auto_Farm_Mini_Tusk or _G.Auto_Farm_Magma_Ore or _G.Auto_Farm_Bone or _G.Auto_Farm_Conjured_Cocoa or _G.Auto_Open_Dough_Dungeon or _G.Auto_Rainbow_Haki or _G.Auto_Musketeer_Hat or _G.Auto_Holy_Torch or _G.Auto_Canvander or _G.Auto_Twin_Hook or _G.Auto_Serpent_Bow or _G.Auto_Fully_Death_Step or _G.Auto_Fully_SharkMan_Karate then
                        STOP.play = function() end
                        a:Play(0.01,0.01,0.01)
                        func(Hits)
                        STOP.play = shared.cpc
                        wait(a.length * 0.5)
                        a:Stop()
                    else
                        a:Play()
                    end
                end
            end
        end)
    end
end)

spawn(function()
    local gg = getrawmetatable(game)
    local old = gg.__namecall
    setreadonly(gg,false)
    gg.__namecall = newcclosure(function(...)
        local method = getnamecallmethod()
        local args = {...}
        if tostring(method) == "FireServer" then
            if tostring(args[1]) == "RemoteEvent" then
                if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                    if UseSkillMasteryDevilFruit then
                        args[2] = PositionSkillMasteryDevilFruit
                        return old(unpack(args))
                    elseif AimSkillNearest then
                        args[2] = AimBotSkillPosition
                        return old(unpack(args))
                    end
                end
            end
        end
        return old(...)
    end)
end)
------------------------------------------------------------------------------------------------------------
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/NiceBBMBThai12/NBTScript/main/UI-Library-Robloxx"))()
local window = library:Win()
local Main_Tab = window:addtap("Main")
local Main = Main_Tab:addpage()
Main:Ti("Farm")
WeaponList = {}
for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
    if v:IsA("Tool") then
        table.insert(WeaponList ,v.Name)
    end
end

Main:DropDown("Select Weapon","Weapon",WeaponList,function(Value)
    _G.Select_Weapon = Value
end)

Main:Button1("Refresh Weapon",function(Value)
    table.clear(WeaponList)
    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do  
        if v:IsA("Tool") then table.insert(WeaponList ,v.Name) end
    end
end)

Main:Toggle("Auto Farm Level",false,function(Value)
    _G.Auto_Farm_Level = Value
    StopTween(_G.Auto_Farm_Level)
end)

spawn(function()
    while wait() do
        if _G.Auto_Farm_Level then
            pcall(function()
                if not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                    StartMagnet = false
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                end
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                    StartMagnet = false
                    CheckQuest()
                    repeat wait() getgenv().ToTarget(CFrameQuest) until (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.Auto_Farm_Level
                    if (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 then
                        wait(1.2)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest",NameQuest,LevelQuest)
                        wait(0.5)
                    end
                elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
                    CheckQuest()
                    if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                                if v.Name == Ms then
                                    repeat wait()
                                        if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
                                            EquipWeapon(_G.Select_Weapon)
                                            PosMon = v.HumanoidRootPart.CFrame
                                            v.HumanoidRootPart.CanCollide = false
                                            v.Humanoid.WalkSpeed = 0
                                            v.Head.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(5,5,5)
                                            StartMagnet = true
                                            getgenv().ToTarget(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                            game:GetService'VirtualUser':CaptureController()
                                            game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
                                        else
                                            StartMagnet = false
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                                        end
                                    until not _G.Auto_Farm_Level or v.Humanoid.Health <= 0 or not v.Parent or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                end
                            end
                        end
                    else
                        StartMagnet = false
                        if game:GetService("ReplicatedStorage"):FindFirstChild(Ms) then
                            getgenv().ToTarget(game:GetService("ReplicatedStorage"):FindFirstChild(Ms).HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                        else	
                            getgenv().ToTarget(CFrameMon)
                        end
                    end
                end
            end)            
		end
    end
end)

Main:Toggle("Bring Mob",true,function(Value)
    _G.Bring_Mob = Value
end)

spawn(function()
    game:GetService("RunService").Heartbeat:Connect(function() CheckQuest()
        pcall(function()
            if _G.Bring_Mob then
                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
					if _G.Auto_Farm_Level and StartMagnet and v.Name == Ms and (v.HumanoidRootPart.Position - PosMon.Position).magnitude <= 350 then
                        v.HumanoidRootPart.CFrame = PosMon
                        v.HumanoidRootPart.CanCollide = false
                        v.HumanoidRootPart.Size = Vector3.new(5,5,5)
                        if v.Humanoid:FindFirstChild("Animator") then
                            v.Humanoid.Animator:Destroy()
                        end
                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
                    end
                end
            end
        end)
    end)
end)

spawn(function()
    game:GetService("RunService").Heartbeat:Connect(function() CheckQuest()
		pcall(function()
			for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
				if MasteryBFMagnetActive and v.Name == Ms and (v.HumanoidRootPart.Position - PosMonMasteryFruit.Position).magnitude <= 350 then
					v.HumanoidRootPart.CFrame = PosMonMasteryFruit
					v.HumanoidRootPart.CanCollide = false
					v.HumanoidRootPart.Size = Vector3.new(50,50,50)
					if v.Humanoid:FindFirstChild("Animator") then
						v.Humanoid.Animator:Destroy()
					end
					sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  math.huge)
				end
			end
		end)
    end)
end)

Main:Toggle("Fast Attack",true,function(Value)
    _G.Fast_Attack = Value
end)

local CameraShaker = require(game.ReplicatedStorage.Util.CameraShaker)

for i,v in pairs(getreg()) do
    if typeof(v) == "function" and getfenv(v).script == game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework then
        for x,w in pairs(debug.getupvalues(v)) do
             if typeof(w) == "table" then
                spawn(function()
                    game:GetService("RunService").RenderStepped:Connect(function()
                        if _G.Fast_Attack then
                            pcall(function()
								if game.Players.LocalPlayer.Character:FindFirstChild("Combat") or game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") or game.Players.LocalPlayer.Character:FindFirstChild("Electro") or game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") or game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") or game.Players.LocalPlayer.Character:FindFirstChild("Superhuman") or game.Players.LocalPlayer.Character:FindFirstChild("Sharkman Karate") then
									w.activeController.increment = 3
								else
									w.activeController.increment = 4
								end
                                CameraShaker:Stop()
                                w.activeController.timeToNextAttack = 0
                                w.activeController.attacking = false
								w.activeController.timeToNextBlock = 0
                                w.activeController.blocking = false                            
                                w.activeController.hitboxMagnitude = 50
    		                    w.activeController.humanoid.AutoRotate = true
    	                      	w.activeController.focusStart = 0
                            end)
                        end
                    end)
                end)
            end
        end
    end
end

Main:Toggle("Improve Attack",true,function(Value)
    _G.Improve_Attack = Value
end)

spawn(function()
	while task.wait() do
        if _G.Improve_Attack then
			pcall(function()
				wait(0.1)
				local AC = CbFw2.activeController
				for i = 1,1 do 
					local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
						plr.Character,
						{plr.Character.HumanoidRootPart},
						60
					)
					local cac = {}
					local hash = {}
					for k, v in pairs(bladehit) do
						if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
							table.insert(cac, v.Parent.HumanoidRootPart)
							hash[v.Parent] = true
						end
					end
					bladehit = cac
					if #bladehit > 0 then
						local u8 = debug.getupvalue(AC.attack, 5)
						local u9 = debug.getupvalue(AC.attack, 6)
						local u7 = debug.getupvalue(AC.attack, 4)
						local u10 = debug.getupvalue(AC.attack, 7)
						local u12 = (u8 * 798405 + u7 * 727595) % u9
						local u13 = u7 * 798405
						(function()
							u12 = (u12 * u9 + u13) % 1099511627776
							u8 = math.floor(u12 / u9)
							u7 = u12 - u8 * u9
						end)()
						u10 = u10 + 1
						debug.setupvalue(AC.attack, 5, u8)
						debug.setupvalue(AC.attack, 6, u9)
						debug.setupvalue(AC.attack, 4, u7)
						debug.setupvalue(AC.attack, 7, u10)
						if plr.Character:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] then 
                            game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(GetCurrentBlade()))
							game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
							game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, i, "")
                            game:GetService("ReplicatedStorage").Assets.GUI.DamageCounter.Enabled = false
						end
					end
				end
			end)
        end
	end
end)

if game:GetService("ReplicatedStorage").Assets:FindFirstChild('SlashHit') then
	game:GetService("ReplicatedStorage").Assets:FindFirstChild('SlashHit'):Destroy()
end






















