

local http_request = http_request or request or HttpPost or syn.request or http.request
if syn then
    http_request = syn.request
end



	local UIS = game:GetService("UserInputService")
	function dragify(Frame)
		local dragToggle = nil
		local dragSpeed = 0
		local dragInput = nil
		local dragStart = nil
		local dragPos = nil
		local function updateInput(input)
			local Delta = input.Position - dragStart
			local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
			game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.25), {Position = Position}):Play()
		end
		Frame.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
				dragToggle = true
				dragStart = input.Position
				startPos = Frame.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragToggle = false
					end
				end)
			end
		end)
		Frame.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)
		game:GetService("UserInputService").InputChanged:Connect(function(input)
			if input == dragInput and dragToggle then
				updateInput(input)
			end
		end)
	end
	
	local Lib = {}
	
	function Lib:Window(title)
		local GUI = Instance.new("ScreenGui")
		local Main = Instance.new("ImageLabel")
		local TabList = Instance.new("ImageLabel")
		local tab_Container = Instance.new("ScrollingFrame")
		local UIListLayout_tab = Instance.new("UIListLayout")
	
		local TopBar = Instance.new("ImageLabel")
		local TopIcon = Instance.new("ImageLabel")
		local Title_top = Instance.new("TextLabel")
		local UICorner_Main = Instance.new("UICorner")
		local Containers = Instance.new("Folder")
	
		GUI.Name = "GUI"
		GUI.Parent = game.CoreGui
		GUI.ResetOnSpawn = false
	
		Main.Name = "Main"
		Main.Parent = GUI
		Main.BackgroundColor3 = Color3.fromRGB(39, 41, 46)
		Main.Position = UDim2.new(0.1113168, 0, 0.0669878125, 0)
		Main.Size = UDim2.new(0, 511, 0, 428)
		Main.Image = "rbxassetid://2151741365"
		Main.ImageColor3 = Color3.fromRGB(33, 35, 40)
		Main.ImageTransparency = 0.900
		Main.ScaleType = Enum.ScaleType.Tile
		Main.SliceCenter = Rect.new(4, 4, 296, 296)
		Main.TileSize = UDim2.new(0, 250, 0, 250)
	
		TabList.Name = "TabList"
		TabList.Parent = Main
		TabList.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		TabList.BackgroundTransparency = 1
		TabList.ClipsDescendants = true
		TabList.Position = UDim2.new(0, 0, 0, 38)
		TabList.Size = UDim2.new(0.106938727, 126, 1, -38)
		TabList.ZIndex = 3
		TabList.Image = "rbxassetid://5012534273"
		TabList.ImageColor3 = Color3.fromRGB(37, 39, 44)
		TabList.ScaleType = Enum.ScaleType.Slice
		TabList.SliceCenter = Rect.new(4, 4, 296, 296)
	
		tab_Container.Name = "tab_Container"
		tab_Container.Parent = TabList
		tab_Container.Active = true
		tab_Container.BackgroundTransparency = 1.000
		tab_Container.Position = UDim2.new(0, 0, 0, 10)
		tab_Container.Size = UDim2.new(1, 0, 1, -20)
		tab_Container.CanvasSize = UDim2.new(0, 0, 0, 314)
		tab_Container.ScrollBarThickness = 0
	
		UIListLayout_tab.Name = "UIListLayout_tab"
		UIListLayout_tab.Parent = tab_Container
		UIListLayout_tab.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_tab.Padding = UDim.new(0, 1)
	
	
		TopBar.Name = "TopBar"
		TopBar.Parent = Main
		TopBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		TopBar.BackgroundTransparency = 1.000
		TopBar.ClipsDescendants = true
		TopBar.Size = UDim2.new(1, 0, 0, 38)
		TopBar.ZIndex = 5
		TopBar.Image = "rbxassetid://4595286933"
		TopBar.ImageColor3 = Color3.fromRGB(37, 39, 44)
		TopBar.ScaleType = Enum.ScaleType.Slice
		TopBar.SliceCenter = Rect.new(4, 4, 296, 296)
	
		TopIcon.Name = "TopIcon"
		TopIcon.Parent = TopBar
		TopIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TopIcon.BackgroundTransparency = 1.000
		TopIcon.BorderSizePixel = 0
		TopIcon.Position = UDim2.new(0, 0, 0.157894731, 0)
		TopIcon.Size = UDim2.new(0, 49, 0, 32)
		TopIcon.ZIndex = 5
		TopIcon.Image = "rbxassetid://7628278821"
		TopIcon.ScaleType = Enum.ScaleType.Fit
	
		Title_top.Name = "Title_top"
		Title_top.Parent = TopBar
		Title_top.AnchorPoint = Vector2.new(0, 0.5)
		Title_top.BackgroundTransparency = 1.000
		Title_top.Position = UDim2.new(0.0313111544, 40, 0.578947365, 0)
		Title_top.Size = UDim2.new(0.1095891, 76, 0.842105269, 0)
		Title_top.ZIndex = 5
		Title_top.Font = Enum.Font.FredokaOne
		Title_top.Text = title
		Title_top.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title_top.TextSize = 15.000
		Title_top.TextXAlignment = Enum.TextXAlignment.Left
	
		UICorner_Main.CornerRadius = UDim.new(0.0199999996, 0)
		UICorner_Main.Name = "UICorner_Main"
		UICorner_Main.Parent = Main
	
		Containers.Name = "Containers"
		Containers.Parent = Main
	
		dragify(Main)
	
		local TabLib = {}
	
		function TabLib:Tab(name, bool, opacity, id)
	
			local ContainerTab = Instance.new("ScrollingFrame")
			local UIListLayout_ContainerTab = Instance.new("UIListLayout")
	
			local TabButton = Instance.new("Frame")
			local UIGradient_tab = Instance.new("UIGradient")
			local tab_Icon = Instance.new("ImageLabel")
			local tab_Title = Instance.new("TextLabel")
	
	
			TabButton.Name = name.."TButton"
			TabButton.Parent = tab_Container
			TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TabButton.BorderSizePixel = 0
			TabButton.Position = UDim2.new(0, 0, 0.0972972959, 0)
			TabButton.Size = UDim2.new(0, 180, 0, 37)
			TabButton.ZIndex = 3
	
			UIGradient_tab.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(46, 49, 56)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(37, 39, 44))}
			UIGradient_tab.Name = name.."UIGradient_tab"
			UIGradient_tab.Offset = Vector2.new(-1, 0)
			UIGradient_tab.Parent = TabButton
	
			tab_Icon.Name = "tab_Icon"
			tab_Icon.Parent = TabButton
			tab_Icon.AnchorPoint = Vector2.new(0, 0.5)
			tab_Icon.BackgroundTransparency = 1.000
			tab_Icon.Position = UDim2.new(0, 12, 0.5, 0)
			tab_Icon.Size = UDim2.new(0, 16, 0, 16)
			tab_Icon.ZIndex = 3
			tab_Icon.Image = "rbxassetid://"..id
			tab_Icon.ScaleType = Enum.ScaleType.Fit
			tab_Icon.ImageTransparency = opacity
	
			tab_Title.Name = "tab_Title"
			tab_Title.Parent = TabButton
			tab_Title.AnchorPoint = Vector2.new(0, 0.5)
			tab_Title.BackgroundTransparency = 1.000
			tab_Title.Position = UDim2.new(0, 40, 0.5, 0)
			tab_Title.Size = UDim2.new(0, 76, 1, 0)
			tab_Title.ZIndex = 3
			tab_Title.Font = Enum.Font.FredokaOne
			tab_Title.Text = name	
			tab_Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			tab_Title.TextSize = 12.000
			tab_Title.TextXAlignment = Enum.TextXAlignment.Left
			tab_Title.TextTransparency = opacity
	
			ContainerTab.Name = name.."ContainerTab"
			ContainerTab.Parent = Containers
			ContainerTab.Active = true
			ContainerTab.Visible = bool
			ContainerTab.BackgroundTransparency = 1.000
			ContainerTab.BorderSizePixel = 0
			ContainerTab.Position = UDim2.new(0, 188, 0, 46)
			ContainerTab.Size = UDim2.new(0.891466737, -142, 1, -56)
			ContainerTab.CanvasSize = UDim2.new(0, 0, 0, 342)
			ContainerTab.ScrollBarThickness = 3
			ContainerTab.ScrollBarImageTransparency = 0.7
			ContainerTab.ScrollBarImageColor3 = Color3.fromRGB(18, 18, 18)
	
			UIListLayout_ContainerTab.Name = name.."UIListLayout_ContainerTab"
			UIListLayout_ContainerTab.Parent = ContainerTab
			UIListLayout_ContainerTab.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_ContainerTab.Padding = UDim.new(0, 10)
	
			ContainerTab.ChildAdded:Connect(function()
				ContainerTab.CanvasSize = ContainerTab.CanvasSize + UDim2.fromOffset(0, 80)
			end)
	
			local offset1 = {Offset = Vector2.new(0, 0)} 
			local offset2 = {Offset = Vector2.new(-1, 0)} 
			local ti = TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
			local create1 = game:GetService("TweenService"):Create(UIGradient_tab, ti, offset1)
			local create2 = game:GetService("TweenService"):Create(UIGradient_tab, ti, offset2)
			local hover = 1
	
			TabButton.MouseEnter:Connect(function()
				create1:Play() 
			end)
	
			TabButton.MouseLeave:Connect(function()
	
				create2:Play()
				hover = hover + 1
	
			end)
	
			TabButton.InputBegan:Connect(function(InputObject)
				if InputObject.UserInputType == Enum.UserInputType.MouseButton1 then
	
					for i,v in next, Containers:GetChildren() do					
						v.Visible = false
					end
	
					for i, v in next, tab_Container:GetChildren() do
						if v:IsA("Frame") then
							v.tab_Icon.ImageTransparency = 0.5
							v.tab_Title.TextTransparency = 0.5
						end
					end
					ContainerTab.Visible = true
					TabButton.tab_Title.TextTransparency = 0
					TabButton.tab_Icon.ImageTransparency = 0 
	
				end
			end)
	
			local sec = {}
	
			function sec:Section(sname)
				local Section = Instance.new("ImageLabel")
				local Section_Items = Instance.new("Frame")
				local section_Title = Instance.new("TextLabel")
				local UIListLayout_section = Instance.new("UIListLayout")
	
				Section.Name = sname.."Section"
				Section.Parent = ContainerTab
				Section.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				Section.BackgroundTransparency = 1.000
				Section.ClipsDescendants = true
				Section.Size = UDim2.new(1.015, -10 , -0.09, 104)
				Section.ZIndex = 2
				Section.Image = "rbxassetid://5028857472"
				Section.ImageColor3 = Color3.fromRGB(36, 38, 43)
				Section.ScaleType = Enum.ScaleType.Slice
				Section.SliceCenter = Rect.new(4, 4, 296, 296)
	
				Section_Items.Name = sname.."Section_Items"
				Section_Items.Parent = Section
				Section_Items.Active = true
				Section_Items.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				Section_Items.BackgroundTransparency = 1.000
				Section_Items.BorderSizePixel = 0
				Section_Items.Position = UDim2.new(0, 8, 0, 8)
				Section_Items.Size = UDim2.new(1, -16, 1, -16)
	
				section_Title.Name = sname.."section_Title"
				section_Title.Parent = Section_Items
				section_Title.BackgroundTransparency = 1.000
				section_Title.Size = UDim2.new(1, 0, 0, 20)
				section_Title.ZIndex = 2
				section_Title.Font = Enum.Font.FredokaOne
				section_Title.Text = "  "..sname
				section_Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				section_Title.TextSize = 12.000
				section_Title.TextXAlignment = Enum.TextXAlignment.Left
	
				UIListLayout_section.Name = sname.."UIListLayout_section"
				UIListLayout_section.Parent = Section_Items
				UIListLayout_section.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout_section.Padding = UDim.new(0, 4)
	
				Section.ChildAdded:Connect(function()
					Section.Parent.CanvasSize = ContainerTab.CanvasSize + UDim2.fromOffset(0, 50)
				end)
	
				Section_Items.ChildAdded:Connect(function()
					--print("Added")
					local count = Section_Items:GetChildren()
	
					if #count >= 4 then
						--(#count)
						--Section.Size.Y.Scale = Section.Size.Y.Scale + 0.09
						Section.Size = Section.Size + UDim2.new(0, 0, 0.09, 0)
					end
				end)
	
	
				local itemslib = {}
	
				function itemslib:Toggle(name, callback)
	
					local Toggle = Instance.new("ImageButton")
					local Toggle_Title = Instance.new("TextLabel")
					local ToggleButton = Instance.new("ImageButton")
					local ToggleKey = Instance.new("ImageButton")
					local UIGradient_toggleKey = Instance.new("UIGradient")
	
					local toggle = {}
					toggle.cb = callback
	
					Toggle.Name = name.."Toggle"
					Toggle.Parent = Section_Items
					Toggle.BackgroundTransparency = 1.000
					Toggle.BorderSizePixel = 0
					Toggle.Size = UDim2.new(1, 0, 0, 30)
					Toggle.ZIndex = 2
					Toggle.Image = "rbxassetid://5028857472"
					Toggle.ImageColor3 = Color3.fromRGB(41, 43, 49)
					Toggle.ScaleType = Enum.ScaleType.Slice
					Toggle.SliceCenter = Rect.new(2, 2, 298, 298)
	
					Toggle_Title.Name = name.."Toggle_Title"
					Toggle_Title.Parent = Toggle
					Toggle_Title.AnchorPoint = Vector2.new(0, 0.5)
					Toggle_Title.BackgroundTransparency = 1.000
					Toggle_Title.Position = UDim2.new(0, 10, 0.5, 1)
					Toggle_Title.Size = UDim2.new(0.5, 0, 1, 0)
					Toggle_Title.ZIndex = 3
					Toggle_Title.Font = Enum.Font.Gotham
					Toggle_Title.Text = name
					Toggle_Title.TextColor3 = Color3.fromRGB(255, 255, 255)
					Toggle_Title.TextSize = 12.000
					Toggle_Title.TextTransparency = 0.100
					Toggle_Title.TextXAlignment = Enum.TextXAlignment.Left
	
					ToggleButton.Name = name.."ToggleButton"
					ToggleButton.Parent = Toggle
					ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ToggleButton.BackgroundTransparency = 1.000
					ToggleButton.BorderSizePixel = 0
					ToggleButton.Position = UDim2.new(0.828832507, 0, 0, 0)
					ToggleButton.Size = UDim2.new(0.171167538, 0, 1.13333273, 0)
					ToggleButton.ZIndex = 2
					ToggleButton.Image = "rbxassetid://7648804720"
					ToggleButton.ImageColor3 = Color3.fromRGB(33, 33, 39)
					ToggleButton.ScaleType = Enum.ScaleType.Fit
	
					ToggleKey.Name = name.."ToggleKey"
					ToggleKey.Parent = ToggleButton
					ToggleKey.BackgroundColor3 = Color3.fromRGB(170, 170, 170)
					ToggleKey.BackgroundTransparency = 1.000
					ToggleKey.BorderSizePixel = 0
					ToggleKey.Position = UDim2.new(0.119999997, 0, 0.25, 0)
					ToggleKey.Size = UDim2.new(0.319999993, 0, 0.449999988, 0)
					ToggleKey.ZIndex = 2
					ToggleKey.Image = "rbxassetid://6872700230"
	
					UIGradient_toggleKey.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(121, 130, 148)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(165, 176, 199))}
					UIGradient_toggleKey.Name = "UIGradient_toggleKey"
					UIGradient_toggleKey.Parent = ToggleKey
	
					local deb = false
	
					local function LTDRHSA_fake_script() -- ToggleButton.ToggleButton 
						local script = Instance.new('LocalScript', ToggleKey)
						local anim = false
	
						script.Parent.MouseButton1Click:Connect(function()
							if deb == false and anim == false then
								anim = true
								script.Parent.UIGradient_toggleKey.Color = ColorSequence.new({
									ColorSequenceKeypoint.new(0, Color3.new(1, 0.368627, 1)),
									ColorSequenceKeypoint.new(1, Color3.new(0.321569, 0.188235, 1))
								})
	
								script.Parent:TweenSizeAndPosition(UDim2.new(0.688, 0,0.45, 0), UDim2.new(0.156, 0,0.25, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.1)
								wait(0.1)
								script.Parent:TweenSizeAndPosition(UDim2.new(0.18, 0,0.45, 0), UDim2.new(0.664, 0,0.25, 0), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.1)
								wait(0.11)
								script.Parent:TweenSizeAndPosition(UDim2.new(0.32, 0,0.45, 0), UDim2.new(0.5, 0,0.25, 0), Enum.EasingDirection.In, Enum.EasingStyle.Linear, 0.2)
								wait(0.2)
	
								deb	= true
								pcall(callback, deb)
	
	
							elseif deb == true and anim == true then
								anim = false
								script.Parent.UIGradient_toggleKey.Color = ColorSequence.new({
									ColorSequenceKeypoint.new(0, Color3.new(0.47451, 0.509804, 0.580392)),
									ColorSequenceKeypoint.new(1, Color3.new(0.647059, 0.690196, 0.780392))
								})
	
								script.Parent:TweenSizeAndPosition(UDim2.new(0.688, 0,0.45, 0), UDim2.new(0.156, 0,0.25, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.1)
								wait(0.1)
								script.Parent:TweenSizeAndPosition(UDim2.new(0.204, 0,0.45, 0), UDim2.new(0.156, 0,0.25, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.1)
								wait(0.11)
								script.Parent:TweenSizeAndPosition(UDim2.new(0.32, 0,0.45, 0), UDim2.new(0.12, 0,0.25, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.2)
								wait(0.2)
								deb = false
								pcall(callback, deb)
	
							end
						end)
	
	
					end
					coroutine.wrap(LTDRHSA_fake_script)()
	
	
	
				end
	
				function itemslib:TextBox(text, callback)
	
					local TextBox = Instance.new("TextBox")
	
					TextBox.Parent = Section_Items
					TextBox.BackgroundColor3 = Color3.fromRGB(41, 43, 49)
					TextBox.BorderSizePixel = 0
					TextBox.ClipsDescendants = true
					TextBox.Size = UDim2.new(1, 0, 0, 30)
					TextBox.ZIndex = 2
					TextBox.Font = Enum.Font.Gotham
					TextBox.Text = ""
					TextBox.PlaceholderText = text
					TextBox.TextColor3 = Color3.fromRGB(235, 235, 235)
					TextBox.TextSize = 14.000
	
					TextBox.FocusLost:Connect(function()
						pcall(callback, TextBox.Text)
					end)
				end
	
				function itemslib:CheckBox(name, callback)
					local CheckBox = Instance.new("ImageButton")
					local CheckBoxName = Instance.new("TextLabel")
					local check_box = Instance.new("ImageButton")
					local UIGradient_Checkbox = Instance.new("UIGradient")
	
					CheckBox.Name = name.."CheckBox"
					CheckBox.Parent = Section_Items
					CheckBox.BackgroundTransparency = 1.000
					CheckBox.BorderSizePixel = 0
					CheckBox.Size = UDim2.new(1, 0, 0, 30)
					CheckBox.ZIndex = 2
					CheckBox.Image = "rbxassetid://5028857472"
					CheckBox.ImageColor3 = Color3.fromRGB(41, 43, 49)
					CheckBox.ScaleType = Enum.ScaleType.Slice
					CheckBox.SliceCenter = Rect.new(2, 2, 298, 298)
	
					CheckBoxName.Name = name.."CheckBoxName"
					CheckBoxName.Parent = CheckBox
					CheckBoxName.AnchorPoint = Vector2.new(0, 0.5)
					CheckBoxName.BackgroundTransparency = 1.000
					CheckBoxName.Position = UDim2.new(0, 10, 0.5, 1)
					CheckBoxName.Size = UDim2.new(0.5, 0, 1, 0)
					CheckBoxName.ZIndex = 3
					CheckBoxName.Font = Enum.Font.Gotham
					CheckBoxName.Text = name
					CheckBoxName.TextColor3 = Color3.fromRGB(255, 255, 255)
					CheckBoxName.TextSize = 12.000
					CheckBoxName.TextTransparency = 0.100
					CheckBoxName.TextXAlignment = Enum.TextXAlignment.Left
	
					check_box.Name = name.."check_box"
					check_box.Parent = CheckBox
					check_box.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					check_box.BackgroundTransparency = 1.000
					check_box.LayoutOrder = 1
					check_box.Position = UDim2.new(0.876999974, 0, 0.133000001, 0)
					check_box.Size = UDim2.new(0.0700000003, 0, 0.699999988, 0)
					check_box.ZIndex = 2
					check_box.Image = "rbxassetid://3926311105"
					check_box.ImageRectOffset = Vector2.new(940, 784)
					check_box.ImageRectSize = Vector2.new(48, 48)
	
					UIGradient_Checkbox.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(121, 130, 148)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(165, 176, 199))}
					UIGradient_Checkbox.Name = "UIGradient_Checkbox"
					UIGradient_Checkbox.Parent = check_box
					local active = false
	
					local function CTMIFK_fake_script() -- check_box.LocalScript 
						local script = Instance.new('LocalScript', check_box)
						local anim = false
						local cc = script.Parent
	
						script.Parent.MouseButton1Click:Connect(function()
							if not active and not anim then
								anim =  true
								cc.Position = UDim2.fromScale(0.884, 0.2)
								cc.Size = UDim2.fromScale(0.06, 0.6)
								cc.ImageRectOffset = Vector2.new(4, 836)
	
								script.Parent.UIGradient_Checkbox.Color = ColorSequence.new({
									ColorSequenceKeypoint.new(0, Color3.new(1, 0.368627, 1)),
									ColorSequenceKeypoint.new(1, Color3.new(0.490196, 0.192157, 1))
								})
	
								wait(0.1)
								cc:TweenSizeAndPosition(UDim2.new(0.07, 0,0.7, 0),UDim2.new(0.877, 0,0.133, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Back, 0.2) wait(0.2) -- default
								active = true
								pcall(callback, active)
							elseif active and anim then
								anim = false
								cc.ImageRectOffset = Vector2.new(940, 784)
	
								script.Parent.UIGradient_Checkbox.Color = ColorSequence.new({
									ColorSequenceKeypoint.new(0, Color3.new(0.47451, 0.509804, 0.580392)),
									ColorSequenceKeypoint.new(1, Color3.new(0.647059, 0.690196, 0.780392))
								})
	
								active = false
								pcall(callback, active)
							end
						end)
					end
					coroutine.wrap(CTMIFK_fake_script)()
				end
	
				function itemslib:Button(name, callback)
	
					local Button = Instance.new("ImageButton")
					local Circle = Instance.new("ImageLabel")
					local ButtonName = Instance.new("TextLabel")
	
	
					local btn = {}
					btn.cb = callback
	
					local buttonT = {}
	
	
					Button.Name = name.."Button"
					Button.Parent = Section_Items
					Button.BackgroundTransparency = 1.000
					Button.BorderSizePixel = 0
					Button.Size = UDim2.new(1, 0, 0, 30)
					Button.ZIndex = 2
					Button.Image = "rbxassetid://5028857472"
					Button.ImageColor3 = Color3.fromRGB(41, 43, 49)
					Button.ScaleType = Enum.ScaleType.Slice
					Button.SliceCenter = Rect.new(2, 2, 298, 298)
	
	
					ButtonName.Name = name.."ButtonName"
					ButtonName.Parent = Button
					ButtonName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ButtonName.BackgroundTransparency = 1.000
					ButtonName.Position = UDim2.new(0.0342333987, 0, 0.233333334, 0)
					ButtonName.Size = UDim2.new(0, 276, 0, 17)
					ButtonName.ZIndex = 5
					ButtonName.Font = Enum.Font.FredokaOne
					ButtonName.Text = name
					ButtonName.TextColor3 = Color3.fromRGB(255, 255, 255)
					ButtonName.TextSize = 14.000
					ButtonName.TextXAlignment = Enum.TextXAlignment.Left
	
	
					Button.MouseButton1Click:Connect(function()
						pcall(btn.cb)
					end)
	
					local function CDEQJ_fake_script() 
						local Circle = Instance.new("ImageLabel")
						local script = Instance.new('LocalScript', Button)
	
						Circle.Name = "Circle"
						Circle.Parent = script
						Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						Circle.BackgroundTransparency = 1.000
						Circle.ZIndex = 3
						Circle.Image = "rbxassetid://266543268"
						Circle.ImageColor3 = Color3.fromRGB(65, 68, 79)
						Circle.ImageTransparency = 0.300
	
						local m = game.Players.LocalPlayer:GetMouse()
						local guiObject = script.Parent
						local function CircleClick(Button, X, Y)
							coroutine.resume(coroutine.create(function()
								Button.ClipsDescendants = true
								local Circle = script:WaitForChild("Circle"):Clone()
								Circle.Parent = Button
								local NewX = X - Circle.AbsolutePosition.X
								local NewY = Y - Circle.AbsolutePosition.Y
								Circle.Position = UDim2.new(0, NewX, 0, NewY)
								local Size = 0
								if Button.AbsoluteSize.X > Button.AbsoluteSize.Y then
									Size = Button.AbsoluteSize.X*1.5
								elseif Button.AbsoluteSize.X < Button.AbsoluteSize.Y then
									Size = Button.AbsoluteSize.Y*1.5
								elseif Button.AbsoluteSize.X == Button.AbsoluteSize.Y then																																																																														
									Size = Button.AbsoluteSize.X*1.5
								end
								local Time = 0.5
								Circle:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, -Size/2, 0.5, -Size/2), "Out", "Quad", Time, false, nil)
								for i = 1,10 do
									Circle.ImageTransparency = Circle.ImageTransparency + 0.01
									wait(Time/10)
								end
								for i = .5, 1, .1 do
									Circle.ImageTransparency = i
									wait()
								end
								wait(1)
								Circle:Destroy()
							end))
						end
	
						guiObject.MouseButton1Down:connect(function()
							CircleClick(guiObject, m.X, m.Y) 
						end)
					end
					coroutine.wrap(CDEQJ_fake_script)()
	
				end
	
				function itemslib:Label(text)
					local Label = Instance.new("TextLabel")
	
	
					Label.Name = "Label"
					Label.Text = text
					Label.Parent = Section_Items
					Label.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Label.BackgroundTransparency = 1
					Label.BorderSizePixel = 0
					Label.ClipsDescendants = true
					Label.Size = UDim2.new(1, 0, 0, 30)
					Label.ZIndex = 2
					Label.Font = Enum.Font.Gotham
					Label.TextColor3 = Color3.fromRGB(239, 239, 239)
					Label.TextSize = 13
					Label.TextWrapped = true
					Label.TextXAlignment = Enum.TextXAlignment.Left
				end
	
	
				function itemslib:Slider(text, min, max, callback)
	
					local Slider = Instance.new("TextButton")
					local Title = Instance.new("TextLabel")
					local SliderFrame = Instance.new("Frame")
					local SliderFrameCorner = Instance.new("UICorner")
					local SliderIndicator = Instance.new("Frame")
					local SliderIndicatorCorner = Instance.new("UICorner")
					local UIGradient = Instance.new("UIGradient")
					local SliderCorner = Instance.new("UICorner")
					local Value = Instance.new("TextLabel")
	
	
					Slider.Name = "Slider"
					Slider.Parent = Section_Items
					Slider.BackgroundColor3 = Color3.fromRGB(41, 43, 49)
					Slider.Position = UDim2.new(0, 0, 0.438881785, 0)
					Slider.Size = UDim2.new(0, 292, 0, 38)
					Slider.ZIndex = 5
					Slider.AutoButtonColor = false
					Slider.Font = Enum.Font.Gotham
					Slider.Text = ""
					Slider.TextColor3 = Color3.fromRGB(255, 255, 255)
					Slider.TextSize = 14.000
	
					Title.Name = "Title"
					Title.Parent = Slider
					Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Title.BackgroundTransparency = 1.000
					Title.Position = UDim2.new(0.0342465751, 0, 0.105263159, 0)
					Title.Size = UDim2.new(0, 122, 0, 11)
					Title.ZIndex = 5
					Title.Font = Enum.Font.Gotham
					Title.Text = text
					Title.TextColor3 = Color3.fromRGB(255, 255, 255)
					Title.TextScaled = true
					Title.TextSize = 14.000
					Title.TextWrapped = true
					Title.TextXAlignment = Enum.TextXAlignment.Left
	
					SliderFrame.Name = "SliderFrame"
					SliderFrame.Parent = Slider
					SliderFrame.BackgroundColor3 = Color3.fromRGB(33, 33, 39)
					SliderFrame.Position = UDim2.new(0.0223324038, 0, 0.563265979, 0)
					SliderFrame.Size = UDim2.new(0, 276, 0, 11)
					SliderFrame.ZIndex = 5
	
					SliderFrameCorner.Name = "SliderFrameCorner"
					SliderFrameCorner.Parent = SliderFrame
	
					SliderIndicator.Name = "SliderIndicator"
					SliderIndicator.Parent = SliderFrame
					SliderIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					SliderIndicator.BorderSizePixel = 0
					SliderIndicator.Position = UDim2.new(-0.00260408712, 0, 0.0363603085, 0)
					SliderIndicator.Size = UDim2.new(0, 0, 0, 11)
					SliderIndicator.ZIndex = 5
	
					SliderIndicatorCorner.Name = "SliderIndicatorCorner"
					SliderIndicatorCorner.Parent = SliderIndicator
	
					UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 94, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(82, 48, 255))}
					UIGradient.Parent = SliderIndicator
	
					SliderCorner.CornerRadius = UDim.new(0, 6)
					SliderCorner.Name = "SliderCorner"
					SliderCorner.Parent = Slider
	
					Value.Name = "Value"
					Value.Parent = Slider
					Value.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Value.BackgroundTransparency = 1.000
					Value.Position = UDim2.new(0.455182016, 0, 0, 0)
					Value.Size = UDim2.new(0, 149, 0, 20)
					Value.ZIndex = 5
					Value.Font = Enum.Font.Gotham
					Value.Text = "0"
					Value.TextColor3 = Color3.fromRGB(255, 255, 255)
					Value.TextSize = 14.000
					Value.TextXAlignment = Enum.TextXAlignment.Right
	
	
	
					local function ALNWI_fake_script() -- SliderFrame.LocalScript 
						local script = Instance.new('LocalScript', SliderFrame)
	
						local SliderFrame = script.Parent
						local max = max
						local min = min
						local SliderIndicator = script.Parent.SliderIndicator
						local Value = script.Parent.Parent.Value
						local UserInputService = game:GetService("UserInputService")
						local dragging = false
	
						local function slide(input)
							local pos =
								UDim2.new(
									math.clamp((input.Position.X - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1),
									0,
									0,
									11
								)
							SliderIndicator:TweenSize(pos, Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.3, true)
							local val = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
							Value.Text = tostring(val)
							pcall(callback, val)
						end
	
						SliderFrame.InputBegan:Connect(
							function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 then
									slide(input)
									dragging = true
								end
							end
						)
	
						SliderFrame.InputEnded:Connect(
							function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 then
									dragging = false
								end
							end
						)
	
						UserInputService.InputChanged:Connect(
							function(input)
								if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
									slide(input)
								end
							end
						)
					end
					coroutine.wrap(ALNWI_fake_script)()
	
	
				end
	
	
				return itemslib;	
			end
			return sec;
	
		end
		return TabLib;
	
	end
	
	
	----------------------------------------------------------
	
	local main = Lib:Window("GPO - DevilFruit Notifier")
	local tab1 = main:Tab("Devil Fruit ESP",true,0,6912528951)
	local  sec1t1 = tab1:Section("DF ESP Options")
	
	
	sec1t1:Toggle("Devil Fruit ESP (Spawned)", function(te)
		getgenv().DFESP = te
	
		local function makeESP(obj, name)
			local RunService = game:GetService("RunService")
			local Dtext = Drawing.new("Text")
			local Tracer = Drawing.new("Line")
			Dtext.OutlineColor = Color3.fromRGB(55,0,0)
			Dtext.Color = Color3.fromRGB(255, 84, 5)
	
			coroutine.wrap(function()
				while RunService.RenderStepped:Wait() do
					local part = obj.Position
					local Camera = game:GetService("Workspace").CurrentCamera
	
					local function getWSP(pos)
						local vector, onScreen = Camera:WorldToScreenPoint(pos)
						return {vector, onScreen}
					end
	
					if obj:IsDescendantOf(game.Workspace) then
						if getWSP(part)[2] then
							Dtext.Visible = true
							Dtext.Size = 20
							Dtext.Center = true
							Dtext.Outline = true
							Dtext.Text = name
							Dtext.Position = Vector2.new(getWSP(part)[1].X, getWSP(part)[1].Y)
	
							Tracer.Color = Color3.fromRGB(255, 84, 5)
							Tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
							Tracer.To = Vector2.new(getWSP(part)[1].X, getWSP(part)[1].Y) - Vector2.new(0, -20)
							Tracer.Thickness = 2
							Tracer.Visible = true
	
	
	
						else
							Dtext.Visible = false
							Tracer.Visible = false
						end
					else
						Dtext:Remove()
						Tracer:Remove()
					end
				end
				
			end)()
			
			coroutine.wrap(function()
				while RunService.RenderStepped:Wait() do
					
					if obj:IsDescendantOf(game.Workspace) then
					local Data = {
						["content"] = "@everyone NEW FRUIT SPAWNED!!! ",
						["embeds"] = {{
							["author"] = {
								["name"] = name,
								["icon_url"] = "https://cdn.discordapp.com/attachments/885585545038798858/892874252070551562/355d1bd4d0a50a086b6f36ebb49b954f.jpg",
							},
							["description"] = " ",
							["color"] = ffffff,
	
							["thumbnail"] = {
								['url'] = "https://cdn.discordapp.com/attachments/885585545038798858/892874252070551562/355d1bd4d0a50a086b6f36ebb49b954f.jpg",
							},
	
							["fields"] = {
								{
									["name"] = "Player",
									["value"] = "||"..game.Players.LocalPlayer.Name.."||",
									["inline"] = false
								}
							}
						}},
					}
					local response = http_request(
						{
							Url =  getgenv().Url,
							Method = 'POST',
							Headers = {
								['Content-Type'] = 'application/json'
							},
							Body = game:GetService('HttpService'):JSONEncode(Data)
						} 
					);
					end
					wait(7)
				end
				
			end)()
		end
	
	
		game:GetService("Workspace").Env.Settings.ChildAdded:Connect(function()
			wait(1)
	
			--print("Found a Fruit!!")
			for _, v in ipairs(game:GetService("Workspace").Env.Settings:GetDescendants()) do
				if v:IsA("ProximityPrompt") then
					makeESP(v.Parent, v.ObjectText)
				end
			end
		end)
	
	end)

	sec1t1:Label("Spawned fruits are only visible if you are near them!(300m - 500m)")
	
	sec1t1:TextBox("{Put Discord Webhook Here}",function(t)
		getgenv().Url = t
	end)
	
	sec1t1:Button("Test Webook", function()
		
						local Data = {
						["content"] = "@everyone NEW FRUIT SPAWNED!!! ",
						["embeds"] = {{
							["author"] = {
								["name"] = "TEST FRUIT",
								["icon_url"] = "https://cdn.discordapp.com/attachments/885585545038798858/892874252070551562/355d1bd4d0a50a086b6f36ebb49b954f.jpg",
							},
							["description"] = " ",
							["color"] = ffffff,
	
							["thumbnail"] = {
								['url'] = "https://cdn.discordapp.com/attachments/885585545038798858/892874252070551562/355d1bd4d0a50a086b6f36ebb49b954f.jpg",
							},
	
							["fields"] = {
								{
									["name"] = "Player",
									["value"] = "||"..game.Players.LocalPlayer.Name.."||",
									["inline"] = false
								}
							}
						}},
					}
					local response = http_request(
						{
							Url =  getgenv().Url,
							Method = 'POST',
							Headers = {
								['Content-Type'] = 'application/json'
							},
							Body = game:GetService('HttpService'):JSONEncode(Data)
						} 
					);
					
					
	end)
	
	
	--local  sec1t11 = tab1:Section("Auto Walk")
	
	sec1t1:Toggle("AutoWalk Colosseum 2nd Sea (Risky)", function(te)
		getgenv().AutoWalk = te
		--warn(getgenv().AutoWalk)
		while getgenv().AutoWalk do
		
		wait()
		if getgenv().AutoWalk then
			--warn("RUNNING TO PATH!")
			function createPaths()
				local partsWithId = {}
				local awaitRef = {}
	
				local root = {
					ID = 0;
					Type = "Model";
					Properties = {
						Name = "PartsToWalk";
					};
					Children = {
						{
							ID = 1;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2413.6606445313,61.988525390625,6184.6245117188,1,0,0,0,1,0,0,0,0.99999988079071);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(2413.6606445313,61.988525390625,6184.6245117188);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part5";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 2;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2413.7490234375,12.988525390625,6097.1845703125,1,0,0,0,1,0,0,0,0.99999988079071);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(2413.7490234375,12.988525390625,6097.1845703125);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part4";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 3;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(1,89/255,89/255);
								CFrame = CFrame.new(2413.0515136719,12.988525390625,5860.267578125,1,0,0,0,1,0,0,0,0.99999970197678);
								BrickColor = BrickColor.new(1,89/255,89/255);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(1,89/255,89/255);
								Position = Vector3.new(2413.0515136719,12.988525390625,5860.267578125);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part1";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 4;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2412.681640625,12.988525390625,6013.4643554688,1,0,0,0,1,0,0,0,0.99999988079071);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(2412.681640625,12.988525390625,6013.4643554688);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part3";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 5;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2412.603515625,12.988525390625,5936.123046875,1,0,0,0,1,0,0,0,0.99999988079071);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(2412.603515625,12.988525390625,5936.123046875);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part2";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 6;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2414.5415039063,114.48852539063,6261.802734375,1,0,0,0,1,0,0,0,0.99999988079071);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(2414.5415039063,114.48852539063,6261.802734375);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part6";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 7;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2382.9692382813,114.48852539063,6261.8706054688,1,0,0,0,1,0,0,0,0.99999988079071);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(2382.9692382813,114.48852539063,6261.8706054688);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part7";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 8;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2342.8740234375,86.488525390625,6278.4409179688,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(2342.8740234375,86.488525390625,6278.4409179688);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part8";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 9;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2279.7111816406,64.488555908203,6275.099609375,1,0,0,0,1,0,0,0,0.99999952316284);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(2279.7111816406,64.488555908203,6275.099609375);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part9";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 10;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2264.0422363281,64.488555908203,6369.24609375,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(2264.0422363281,64.488555908203,6369.24609375);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part11";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 11;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2191.1843261719,64.488555908203,6460.3876953125,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(2191.1843261719,64.488555908203,6460.3876953125);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part13";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 12;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2108.423828125,64.488555908203,6495.0786132813,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(2108.423828125,64.488555908203,6495.0786132813);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part15";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 13;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2145.9272460938,64.488555908203,6483.666015625,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(2145.9272460938,64.488555908203,6483.666015625);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part14";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 14;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2067.1638183594,64.488555908203,6495.4790039063,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(2067.1638183594,64.488555908203,6495.4790039063);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part16";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 15;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2016.6026611328,64.488555908203,6489.23828125,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(2016.6026611328,64.488555908203,6489.23828125);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part17";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 16;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(1960.8807373047,64.488555908203,6465.4140625,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(1960.8807373047,64.488555908203,6465.4140625);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part18";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 17;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2278.763671875,64.488555908203,6324.1630859375,1,0,0,0,1,0,0,0,0.99999952316284);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(2278.763671875,64.488555908203,6324.1630859375);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part10";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 18;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(1893.2996826172,64.488555908203,6276.3461914063,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(1893.2996826172,64.488555908203,6276.3461914063);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part22";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 19;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(1861.3096923828,64.488555908203,6276.3461914063,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(1861.3096923828,64.488555908203,6276.3461914063);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part21";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 20;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(1877.154296875,64.488555908203,6369.1328125,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(1877.154296875,64.488555908203,6369.1328125);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part20";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 21;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(1911.3502197266,64.488555908203,6423.09375,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(1911.3502197266,64.488555908203,6423.09375);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part19";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 22;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2232.0849609375,64.488555908203,6421.2993164063,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(2232.0849609375,64.488555908203,6421.2993164063);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part12";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 23;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(1914.5474853516,2.4851455688477,6231.3413085938,1,0,0,0,1,0,0,0,0.99999952316284);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(1914.5474853516,2.4851455688477,6231.3413085938);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part24";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 24;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(1915.0876464844,2.4851455688477,6277.267578125,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(1915.0876464844,2.4851455688477,6277.267578125);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part23";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 25;
							Type = "Part";
							Properties = {
								BrickColor = BrickColor.new(1,1,0);
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(1,1,0);
								CFrame = CFrame.new(1904.3818359375,3.797492980957,6152.5302734375,0.76606518030167,0,-0.64276278018951,0,1,0,0.6427628993988,0,0.76606494188309);
								Anchored = true;
								Size = Vector3.new(1,1,1);
								Rotation = Vector3.new(0,-40,0);
								Transparency = 1;
								brickColor = BrickColor.new(1,1,0);
								Position = Vector3.new(1904.3818359375,3.797492980957,6152.5302734375);
								Orientation = Vector3.new(0,-40,0);
								Material = Enum.Material.Neon;
								Name = "Part25";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 26;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(1,1,0);
								CFrame = CFrame.new(1878.8991699219,0.23828125,6089.88671875,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(1,1,0);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(1,1,0);
								Position = Vector3.new(1878.8991699219,0.23828125,6089.88671875);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part26";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 27;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(1,0,191/255);
								CFrame = CFrame.new(1404.8653564453,10.988525390625,6091.4711914063,0.99999994039536,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(1,0,191/255);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(1,0,191/255);
								Position = Vector3.new(1404.8653564453,10.988525390625,6091.4711914063);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part28";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 28;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								CanCollide = false;
								Color = Color3.new(1,0,191/255);
								CFrame = CFrame.new(1682.58984375,0.23828125,6087.9814453125,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(1,0,191/255);
								Size = Vector3.new(1,1,1);
								Transparency = 1;
								brickColor = BrickColor.new(1,0,191/255);
								Position = Vector3.new(1682.58984375,0.23828125,6087.9814453125);
								Anchored = true;
								Material = Enum.Material.Neon;
								Name = "Part27";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 29;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								Color = Color3.new(1,0,0);
								CFrame = CFrame.new(1388.7299804688,14.988525390625,6181.7041015625,0.99999988079071,0,0,0,1,0,0,0,0.99999952316284);
								BrickColor = BrickColor.new(1,0,0);
								Transparency = 1;
								Anchored = true;
								brickColor = BrickColor.new(1,0,0);
								Position = Vector3.new(1388.7299804688,14.988525390625,6181.7041015625);
								Size = Vector3.new(1,1,1);
								Material = Enum.Material.Neon;
								Name = "Part29";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 30;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								Color = Color3.new(0,1,0);
								Anchored = true;
								CFrame = CFrame.new(1504.5646972656,14.988525390625,6178.5463867188,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Transparency = 1;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(1504.5646972656,14.988525390625,6178.5463867188);
								Size = Vector3.new(1,1,1);
								Material = Enum.Material.Neon;
								Name = "Part31";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 31;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(1446.4737548828,14.988525390625,6179.8354492188,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Transparency = 1;
								Anchored = true;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(1446.4737548828,14.988525390625,6179.8354492188);
								Size = Vector3.new(1,1,1);
								Material = Enum.Material.Neon;
								Name = "Part30";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 32;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(1552.5487060547,14.988525390625,6185.1157226563,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Transparency = 1;
								Anchored = true;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(1552.5487060547,14.988525390625,6185.1157226563);
								Size = Vector3.new(1,1,1);
								Material = Enum.Material.Neon;
								Name = "Part32";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 33;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								Color = Color3.new(229/255,76/85,223/255);
								CFrame = CFrame.new(1553.3673095703,29.988525390625,6315.5063476563,1,0,0,0,1,0,0,0,0.99999904632568);
								BrickColor = BrickColor.new(229/255,76/85,223/255);
								Transparency = 1;
								Anchored = true;
								brickColor = BrickColor.new(229/255,76/85,223/255);
								Position = Vector3.new(1553.3673095703,29.988525390625,6315.5063476563);
								Size = Vector3.new(1,1,1);
								Material = Enum.Material.Neon;
								Name = "Part34";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 34;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								Color = Color3.new(229/255,76/85,223/255);
								CFrame = CFrame.new(1558.9254150391,14.988525390625,6243.1499023438,1,0,0,0,1,0,0,0,0.99999952316284);
								BrickColor = BrickColor.new(229/255,76/85,223/255);
								Transparency = 1;
								brickColor = BrickColor.new(229/255,76/85,223/255);
								Position = Vector3.new(1558.9254150391,14.988525390625,6243.1499023438);
								Size = Vector3.new(1,1,1);
								Material = Enum.Material.Neon;
								Name = "Part33";
								Anchored = true;
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 35;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								Color = Color3.new(91/255,31/85,7/17);
								CFrame = CFrame.new(1845.1964111328,36.688621520996,6731.5864257813,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(91/255,31/85,7/17);
								Transparency = 1;
								brickColor = BrickColor.new(91/255,31/85,7/17);
								Position = Vector3.new(1845.1964111328,36.688621520996,6731.5864257813);
								Size = Vector3.new(1,1,1);
								Material = Enum.Material.Neon;
								Name = "Part36";
								Anchored = true;
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 36;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								Color = Color3.new(91/255,31/85,7/17);
								CFrame = CFrame.new(1522.1646728516,29.988525390625,6387.4633789063,1,0,0,0,1,0,0,0,0.99999952316284);
								BrickColor = BrickColor.new(91/255,31/85,7/17);
								Transparency = 1;
								Anchored = true;
								brickColor = BrickColor.new(91/255,31/85,7/17);
								Position = Vector3.new(1522.1646728516,29.988525390625,6387.4633789063);
								Size = Vector3.new(1,1,1);
								Material = Enum.Material.Neon;
								Name = "Part35";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 37;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2306.6745605469,36.688621520996,6737.4169921875,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Transparency = 1;
								Anchored = true;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(2306.6745605469,36.688621520996,6737.4169921875);
								Size = Vector3.new(1,1,1);
								Material = Enum.Material.Neon;
								Name = "Part38";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 38;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2083.5463867188,36.688621520996,6721.171875,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Transparency = 1;
								Anchored = true;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(2083.5463867188,36.688621520996,6721.171875);
								Size = Vector3.new(1,1,1);
								Material = Enum.Material.Neon;
								Name = "Part37";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 39;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								Color = Color3.new(4/255,35/51,236/255);
								CFrame = CFrame.new(2420.5651855469,12.988525390625,5860.4619140625,-1.0000011920929,0,0,0,1,0,0,0,-1.0000011920929);
								BrickColor = BrickColor.new(4/255,35/51,236/255);
								Size = Vector3.new(1,1,1);
								Rotation = Vector3.new(-180,0,-180);
								Transparency = 1;
								Anchored = true;
								Name = "Part46";
								Position = Vector3.new(2420.5651855469,12.988525390625,5860.4619140625);
								Orientation = Vector3.new(0,180,0);
								Material = Enum.Material.Neon;
								brickColor = BrickColor.new(4/255,35/51,236/255);
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 40;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2641.2924804688,12.488525390625,6451.4809570313,-0.96592998504639,0,0.25880473852158,0,1,0,-0.25880473852158,0,-0.96592998504639);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Rotation = Vector3.new(-180,15,-180);
								Transparency = 1;
								Anchored = true;
								Name = "Part41";
								Position = Vector3.new(2641.2924804688,12.488525390625,6451.4809570313);
								Orientation = Vector3.new(0,165,0);
								Material = Enum.Material.Neon;
								brickColor = BrickColor.new(0,1,0);
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 41;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2384.6079101563,36.688621520996,6663.9794921875,1,0,0,0,1,0,0,0,0.99999976158142);
								BrickColor = BrickColor.new(0,1,0);
								Transparency = 1;
								Anchored = true;
								brickColor = BrickColor.new(0,1,0);
								Position = Vector3.new(2384.6079101563,36.688621520996,6663.9794921875);
								Size = Vector3.new(1,1,1);
								Material = Enum.Material.Neon;
								Name = "Part39";
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 42;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								Color = Color3.new(6/85,14/15,212/255);
								CFrame = CFrame.new(2586.5671386719,8.488525390625,5974.8984375,-1.0000002384186,0,0,0,1,0,0,0,-1.0000002384186);
								BrickColor = BrickColor.new(6/85,14/15,212/255);
								Size = Vector3.new(1,1,1);
								Rotation = Vector3.new(-180,0,-180);
								Transparency = 1;
								Name = "Part45";
								Anchored = true;
								Position = Vector3.new(2586.5671386719,8.488525390625,5974.8984375);
								Orientation = Vector3.new(0,180,0);
								Material = Enum.Material.Neon;
								brickColor = BrickColor.new(6/85,14/15,212/255);
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 43;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2524.9645996094,20.488525390625,6593.5668945313,0.96591347455978,0,0.25886505842209,0,1,0,-0.25886511802673,0,0.9659132361412);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Rotation = Vector3.new(0,15,0);
								Transparency = 1;
								Name = "Part40";
								Anchored = true;
								Position = Vector3.new(2524.9645996094,20.488525390625,6593.5668945313);
								Orientation = Vector3.new(0,15,0);
								Material = Enum.Material.Neon;
								brickColor = BrickColor.new(0,1,0);
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 44;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2583.3383789063,8.488525390625,6048.2651367188,-1.0000002384186,0,0,0,1,0,0,0,-1.0000002384186);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Rotation = Vector3.new(-180,0,-180);
								Transparency = 1;
								Name = "Part44";
								Position = Vector3.new(2583.3383789063,8.488525390625,6048.2651367188);
								Orientation = Vector3.new(0,180,0);
								Material = Enum.Material.Neon;
								Anchored = true;
								brickColor = BrickColor.new(0,1,0);
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 45;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2638.8764648438,8.488525390625,6112.3413085938,-1.0000002384186,0,0,0,1,0,0,0,-1.0000002384186);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Rotation = Vector3.new(-180,0,-180);
								Transparency = 1;
								Anchored = true;
								Name = "Part43";
								Position = Vector3.new(2638.8764648438,8.488525390625,6112.3413085938);
								Orientation = Vector3.new(0,180,0);
								Material = Enum.Material.Neon;
								brickColor = BrickColor.new(0,1,0);
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 46;
							Type = "Part";
							Properties = {
								BottomSurface = Enum.SurfaceType.Smooth;
								Color = Color3.new(0,1,0);
								CFrame = CFrame.new(2632.8666992188,12.488525390625,6239.0229492188,-0.96592992544174,0,0.258804500103,0,1,0,-0.258804500103,0,-0.96592992544174);
								BrickColor = BrickColor.new(0,1,0);
								Size = Vector3.new(1,1,1);
								Rotation = Vector3.new(-180,15,-180);
								Transparency = 1;
								Anchored = true;
								Name = "Part42";
								Position = Vector3.new(2632.8666992188,12.488525390625,6239.0229492188);
								Orientation = Vector3.new(0,165,0);
								Material = Enum.Material.Neon;
								brickColor = BrickColor.new(0,1,0);
								TopSurface = Enum.SurfaceType.Smooth;
							};
							Children = {};
						};
						{
							ID = 47;
							Type = "Model";
							Properties = {
								Name = "Part99";
							};
							Children = {
								{
									ID = 48;
									Type = "WedgePart";
									Properties = {
										Transparency = 1;
										Anchored = true;
										BottomSurface = Enum.SurfaceType.Smooth;
										Position = Vector3.new(1553.2431640625,18.485660552979,6261.23828125);
										CFrame = CFrame.new(1553.2431640625,18.485660552979,6261.23828125,1,0,0,0,1,0,0,0,1);
										Size = Vector3.new(55.994262695313,7.9942684173584,19.37744140625);
									};
									Children = {};
								};
								{
									ID = 49;
									Type = "WedgePart";
									Properties = {
										Transparency = 1;
										Anchored = true;
										BottomSurface = Enum.SurfaceType.Smooth;
										Position = Vector3.new(1554.5583496094,26.024658203125,6286.2880859375);
										CFrame = CFrame.new(1554.5583496094,26.024658203125,6286.2880859375,1,0,0,0,1,0,0,0,1);
										Size = Vector3.new(57.218872070313,7.0722675323486,20.99609375);
									};
									Children = {};
								};
							};
						};
					};
				};
	
				local function Scan(item, parent)
					local obj = Instance.new(item.Type)
					if (item.ID) then
						local awaiting = awaitRef[item.ID]
						if (awaiting) then
							awaiting[1][awaiting[2]] = obj
							awaitRef[item.ID] = nil
						else
							partsWithId[item.ID] = obj
						end
					end
					for p,v in pairs(item.Properties) do
						if (type(v) == "string") then
							local id = tonumber(v:match("^_R:(%w+)_$"))
							if (id) then
								if (partsWithId[id]) then
									v = partsWithId[id]
								else
									awaitRef[id] = {obj, p}
									v = nil
								end
							end
						end
						obj[p] = v
					end
					for _,c in pairs(item.Children) do
						Scan(c, obj)
					end
					obj.Parent = parent
					return obj
				end
	
				Scan(root, game.Workspace)
			end
	
	
			createPaths()
	
			local PS = game:GetService("PathfindingService")
			local plr = game.Players.LocalPlayer
			local hum = plr.Character.Humanoid
			local rootPart = plr.Character.HumanoidRootPart
			getgenv().AutoWalk = true
			local controls = require(game:GetService("Players").LocalPlayer.PlayerScripts.PlayerModule):GetControls()
			controls:Disable()
	
			function PFS(p1, p2)
				local path = PS:CreatePath()
	
				path:ComputeAsync(p1, p2)
	
				local wp = path:GetWaypoints()
	
				for i, v in ipairs(wp) do
					if getgenv().AutoWalk then
						if wp[i].Action == Enum.PathWaypointAction.Jump then
							hum:ChangeState(Enum.HumanoidStateType.Jumping)
						end
						local a = Instance.new("Part", workspace)
						a.Size = Vector3.new(0.5, 0.5, 0.5)
						a.CanCollide = false
						a.Anchored = true
						a.Color = Color3.fromRGB(255, 255, 0)
						a.Material = Enum.Material.Neon
						a.Position = wp[i].Position
						hum:MoveTo(wp[i].Position)
						hum.MoveToFinished:Wait()
						a:Destroy()
					end
				end
			end
	
			for i = 1, 25 do
				if getgenv().AutoWalk then
					game.Workspace.PartsToWalk["Part"..i].Transparency = 0
					hum:MoveTo(game.Workspace.PartsToWalk["Part"..i].Position)
					hum.MoveToFinished:Wait()
					game.Workspace.PartsToWalk["Part"..i].Transparency = 1
				end
			end
	
			if getgenv().AutoWalk then
				PFS(game.Workspace.PartsToWalk.Part25.Position, game.Workspace.PartsToWalk.Part26.Position)
	
				hum:MoveTo(game.Workspace.PartsToWalk.Part27.Position)
				hum.MoveToFinished:Wait()
	
				PFS(game.Workspace.PartsToWalk.Part27.Position, game.Workspace.PartsToWalk.Part28.Position)
				PFS(game.Workspace.PartsToWalk.Part28.Position, game.Workspace.PartsToWalk.Part29.Position)
			end
	
			for i = 30, 34 do
				if getgenv().AutoWalk then
					game.Workspace.PartsToWalk["Part"..i].Transparency = 0
					hum:MoveTo(game.Workspace.PartsToWalk["Part"..i].Position)
					hum.MoveToFinished:Wait()
					game.Workspace.PartsToWalk["Part"..i].Transparency = 1
				end
			end
	
			if getgenv().AutoWalk then
				PFS(game.Workspace.PartsToWalk.Part35.Position, game.Workspace.PartsToWalk.Part36.Position)
			end
	
	
			for i = 37, 45 do
				if getgenv().AutoWalk then
					game.Workspace.PartsToWalk["Part"..i].Transparency = 0
					hum:MoveTo(game.Workspace.PartsToWalk["Part"..i].Position)
					hum.MoveToFinished:Wait()
					game.Workspace.PartsToWalk["Part"..i].Transparency = 1
				end
			end
	
			if getgenv().AutoWalk then
				PFS(game.Workspace.PartsToWalk.Part45.Position, game.Workspace.PartsToWalk.Part46.Position)
			end
	
			wait()
			controls:Enable(true)
	
			coroutine.wrap(function()
				while wait() do
					if not getgenv().AutoWalk then
						--warn("TURNED OFF WALKING")
						controls:Enable(true)
						wait()
						if game.Workspace:FindFirstChild("PartsToWalk") then
							game.Workspace.PartsToWalk:Destroy()
						end
					end
				end
			end)()
		end
	end
	end)
	
	sec1t1:Label("Auto Walk is Risky!, Use TinyTask to walk around the Colosseum to be more safe.")
	
	
	--local  sec1t2 = tab1:Section("ESP Dropped")
	sec1t1:Toggle("Devil Fruit ESP (Dropped)", function(td)
		getgenv().DFESP00 = td
	
		pcall(function()
			Camera = game:GetService("Workspace").CurrentCamera
			RunService = game:GetService("RunService")
			camera = workspace.CurrentCamera
			Bottom = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
	
			function GetPoint(vector3)
				local vector, onScreen = camera:WorldToViewportPoint(vector3)
				return {Vector2.new(vector.X,vector.Y),onScreen,vector.Z}
			end
	
			function MakeESPd(model)
	
				local Display = Drawing.new("Text")
				local Tracer = Drawing.new("Line")
				local CurrentParent = model.Parent
				local GetP = GetPoint(model.Position)
	
				coroutine.resume(coroutine.create(function()
	
					local Distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - model.Position).Magnitude
					local modelCF = model.CFrame
	
					if getgenv().DFESP00 and GetP[2] then
						Display.Visible = true
						Display.Size = 20
						Display.Position = GetPoint(modelCF.p + Vector3.new(0,3,0))[1]
						Display.Center = true
						Display.Outline = true
						Display.OutlineColor = Color3.fromRGB(55,0,0)
						Display.Color = Color3.fromRGB(255, 84, 5)
	
						Tracer.Color = Color3.fromRGB(255, 84, 5)
						Tracer.From = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
						Tracer.To = GetPoint(modelCF.p)[1]
						Tracer.Thickness = 2
						Tracer.Visible = true
	
						Display.Text = model.Parent.Name.. " [" .. math.floor((model.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) .. "]"
	
					else
						Display.Visible = false
						Tracer.Visible = false
					end
					RunService.RenderStepped:Wait()
					Display:Remove()
					Tracer:Remove()
				end))
			end
	
			while RunService.RenderStepped:Wait() do
				for _, v in  ipairs(game:GetService("Workspace"):GetChildren()) do
					if v:IsA("Tool") then
						MakeESPd(v.preHandle)
						v.ChildAdded:Connect(function()
							delay(0.5, function()
								MakeESPd(v.preHandle)
							end) 
						end)
					end
				end
			end
	
		end)
	end)
	
	sec1t1:Label("Note: Player Dropped Fruits Only (Good For Trade HUB)")
	
	
	----------------------------------------------------------
	local tab133 = main:Tab("Misc",false,0.5,6896084251)
	
	local  sec1t333 = tab133:Section("Misc")
	
	sec1t333:Button("Join New Server",function()
		local amount = {}
		for _, v in ipairs(game:GetService("HttpService"):JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
			if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= game.JobId then
				amount[#amount + 1] = v.id
			end
		end
		if #amount > 0 then
			-- print'Joinning new server'
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, amount[math.random(1, #amount)])
		else
			-- print("No server found")
		end
	end)
	
	sec1t333:Button("Anti AFK",function()
		local bb = game:service "VirtualUser"
		game:service "Players".LocalPlayer.Idled:connect(function()
			bb:CaptureController()
			bb:ClickButton2(Vector2.new())
	
		end)
	end)
	
	----------------------------------------------------------
	local tab3 = main:Tab("Local Player | RISKY ",false,0.5,6886981585)
	local  sec1t33 = tab3:Section("Local Player")
	
	
	sec1t33:Toggle("Walk On Water",function(t)
		getgenv().tt1 = t
		local part = Instance.new("Part", game:GetService("Workspace"))
		part.Size = Vector3.new(25.795, 0.001, 25.86)
		part.Name = "Particles83"
		part.Anchored = true
		while wait() do
			if getgenv().tt1 then
				local humP= game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				part.Transparency = 1
				part.Position = Vector3.new(humP.X, -3, humP.Z)
			elseif game.Workspace:FindFirstChild("Particles83") then
				game.Workspace.Particles83:Destroy()
			end
		end
	end)
	
	sec1t33:Slider("WalkSpeed", 16, 100, function(t)

		getgenv().Speed = 70;
		local mt = getrawmetatable(game)
		local old = mt.__newindex
		setreadonly(mt, false)
		mt.__newindex = newcclosure(function(t,k,v)
			pcall(function()
				if t == game:GetService("Players").LocalPlayer.Character.Humanoid and k == "WalkSpeed" then
					v = getgenv().Speed;
				end
			end)
			return old(t,k,v)
		end)
	end)	
	sec1t33:Slider("JumpPower", 50, 200, function(t)

		getgenv().Speed = 70;
		local mt = getrawmetatable(game)
		local old = mt.__newindex
		setreadonly(mt, false)
		mt.__newindex = newcclosure(function(t,k,v)
			pcall(function()
				if t == game:GetService("Players").LocalPlayer.Character.Humanoid and k == "JumpPower" then
					v = getgenv().Speed;
				end
			end)
			return old(t,k,v)
		end)
	end)
	sec1t33:Label("This functions might be risky, use at your own risk.")
	
	----------------------------------------------------------
	
	local tab2 = main:Tab("Islands",false,0.5,6922493144)
	local  sec1t2 = tab2:Section("Islands")
	
	sec1t2:Toggle("Island ESP (First Sea)", function(ti)
	
		getgenv().IslandESP = ti
	
		pcall(function()
			Camera = game:GetService("Workspace").CurrentCamera
			RunService = game:GetService("RunService")
			camera = workspace.CurrentCamera
			Bottom = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
		
			function GetPoint(vector3)
				local vector, onScreen = camera:WorldToViewportPoint(vector3)
				return {Vector2.new(vector.X,vector.Y),onScreen,vector.Z}
			end
		
			function MakeESPi(name, pos)
				local Displayi = Drawing.new("Text")
				local GetPi = GetPoint(pos)
				coroutine.resume(coroutine.create(function()
					local Distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - pos).Magnitude
					if getgenv().IslandESP and GetPi[2] then
						Displayi.Visible = true
						Displayi.Size = 16
						Displayi.Position = GetPoint(pos + Vector3.new(0,3,0))[1]
						Displayi.Center = true
						Displayi.Outline = true
						Displayi.OutlineColor = Color3.fromRGB(0, 31, 10)
						Displayi.Color = Color3.fromRGB(93, 255, 28)
						Displayi.Text = name.. " [" .. math.floor((pos - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) .. "]"
					else
						Displayi.Visible = false
					end
					RunService.RenderStepped:Wait()
					Displayi:Remove()
				end))
			end
		
			local locations = {
				{
					"Town of Beginnings", Vector3.new(965.813, 9.3792, 1193.66)
				},
				{
					"Marine Fort F-1", Vector3.new(2903.81, 19.8525, -992.64)
				},
				{
					"Sandora", Vector3.new(-1312.52, 11.2798, 1159.75)
				},
				{
					"Shells Town", Vector3.new(-555.405, 8.31007, -4444.5)
				},
				{
					"Island Of Zou", Vector3.new(-4350.31, 8.35266, -2552.52)
				},
				{
					"Baratie", Vector3.new(-3902.05, 7.71404, -5515.66)
				},
				{
					"Orange Town", Vector3.new(-6919.07, 8.03144, -5349.92)
				},
				{
					"Mysterious Cliff", Vector3.new(2200.65, 8.35073, -8593.66)
				},
				{
					"Roca Island", Vector3.new(5112.48, 5.67623, -4893.96)
				},
				{
					"Colosseum", Vector3.new(-2019.94, 8.17096, -7672.47)
				},
				{
					"Sphinx Island", Vector3.new(-6561.8, 43.4117, -9933.17)
				},
				{
					"Arlong Park", Vector3.new( 476.883, 14.2324, -13084.8)
				},
				{
					"Land of the Sky", Vector3.new(8116.27, 8.9139, -9818.94)
				},
				{
					"Gravitos Fort", Vector3.new(2609, 9.14529, -15366.6)
				},
				{
					"Fishman Cave ", Vector3.new(5682.35, 5.62546, -16459.9)
				},
				{
					"Marine Base G-1", Vector3.new(-9772.59, 18.8261, -14688.4)
				},
				{
					"Coco Island ", Vector3.new(-4253.72, 9.13279, -15532.2)
				},
				{
					"Shrine", Vector3.new(-12186, -10.6763, -18545.9)
				},
				{
					"Kori Island", Vector3.new(-6702.16, 7.48236, 1841.65)
				},
				{
					"Reverse Mountain", Vector3.new(-14313.3, 10.8181, -9464.9)
				}
			}
			
			while RunService.RenderStepped:Wait() do
				for i, v in ipairs(locations) do
					MakeESPi(locations[i][1], locations[i][2])
				end
			end
		end)
		
	end)
	
	sec1t2:Toggle("Island ESP (2nd Sea)", function(tt)
		getgenv().IslandESP2 = tt
	
		pcall(function()
			Camera = game:GetService("Workspace").CurrentCamera
			RunService = game:GetService("RunService")
			camera = workspace.CurrentCamera
			Bottom = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
		
			function GetPoint(vector3)
				local vector, onScreen = camera:WorldToViewportPoint(vector3)
				return {Vector2.new(vector.X,vector.Y),onScreen,vector.Z}
			end
		
			function MakeESPi2(name, pos)
				local Displayi = Drawing.new("Text")
				local GetPi = GetPoint(pos)
				coroutine.resume(coroutine.create(function()
					local Distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - pos).Magnitude
					if getgenv().IslandESP2 and GetPi[2] then
						Displayi.Visible = true
						Displayi.Size = 16
						Displayi.Position = GetPoint(pos + Vector3.new(0,3,0))[1]
						Displayi.Center = true
						Displayi.Outline = true
						Displayi.OutlineColor = Color3.fromRGB(0, 31, 10)
						Displayi.Color = Color3.fromRGB(93, 255, 28)
						Displayi.Text = name.. " [" .. math.floor((pos - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude) .. "]"
					else
						Displayi.Visible = false
					end
					RunService.RenderStepped:Wait()
					Displayi:Remove()
				end))
			end
		
			local locations = {
				{
					"Desert", Vector3.new(-3670.83, 19.6683, 405.271)
				},
				{
					"Colosseum", Vector3.new(2221.6, 5.05852, 6061.15)
				},
				{
					"Reverse Mountain", Vector3.new(-8231.47, 37.6684, 458.083)
				},
				{
					"Rovo island", Vector3.new(-6343.65, 128.317, 409.608)
				},
				{
					"Transylvania", Vector3.new(-7025.88, 41.9608, 4531.99)
				},
				{
					"Sashi Island", Vector3.new(-1558.91, 32.3633, -5722.24)
				},
				{
					"Spirit Island", Vector3.new(-1484.85, 19.8954, 9842.6)
				},
				{
					"The Abyss", Vector3.new(-8288.31, 6560.34, 5390.64)
				}
			}
			
			while RunService.RenderStepped:Wait() do
				for i, v in ipairs(locations) do
					MakeESPi2(locations[i][1], locations[i][2])
				end
			end
		end)
		
	end)

	sec1t2:Button("Island Teleport (Comming Soon..)",function(t)
	end)
	
	
	----------------------------------------------------------
	
	
	local tab4 = main:Tab("Credits", false,0.5,7618724768)
	local sec1t4 = tab4:Section("Script Credits")
	
	sec1t4:Button("Arpon AG#6612")
	sec1t4:Button("Forever4D#6933")
	sec1t4:Button("s3ps#6702")
	





