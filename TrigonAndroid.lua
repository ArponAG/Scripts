

local ss = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
local UICorner = Instance.new("UICorner")
local Bottom = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local Execute = Instance.new("TextButton")
local UICorner_3 = Instance.new("UICorner")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
local Clear = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
local Paste = Instance.new("TextButton")
local UICorner_5 = Instance.new("UICorner")
local UITextSizeConstraint_3 = Instance.new("UITextSizeConstraint")
local Top = Instance.new("Frame")
local UICorner_6 = Instance.new("UICorner")
local min = Instance.new("ImageButton")
local ImageLabel = Instance.new("ImageLabel")
local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
local TextLabel = Instance.new("TextLabel")
local UITextSizeConstraint_4 = Instance.new("UITextSizeConstraint")
local Pattern = Instance.new("ImageLabel")
local TextBox = Instance.new("TextBox")
local UITextSizeConstraint_5 = Instance.new("UITextSizeConstraint")
local Frame = Instance.new("Frame")
local Dock = Instance.new("ImageButton")
local UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint")
local UICorner_7 = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local ImageLabel_2 = Instance.new("ImageLabel")
local UIAspectRatioConstraint_4 = Instance.new("UIAspectRatioConstraint")
local UIAspectRatioConstraint_5 = Instance.new("UIAspectRatioConstraint")

--Properties:

ss.Name = "ss"
ss.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ss.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ss
MainFrame.BackgroundColor3 = Color3.fromRGB(5, 17, 35)
MainFrame.BackgroundTransparency = 0.350
MainFrame.Position = UDim2.new(0.210015878, 0, 0.236277997, 0)
MainFrame.Size = UDim2.new(0.722236872, 0, 0.50758332, 0)

UIAspectRatioConstraint.Parent = MainFrame
UIAspectRatioConstraint.AspectRatio = 1.885

UICorner.Parent = MainFrame

Bottom.Name = "Bottom"
Bottom.Parent = MainFrame
Bottom.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
Bottom.BackgroundTransparency = 0.500
Bottom.BorderColor3 = Color3.fromRGB(27, 42, 53)
Bottom.Position = UDim2.new(0, 0, 0.881780386, 0)
Bottom.Size = UDim2.new(0.999734521, 0, 0.118243285, 0)
Bottom.ZIndex = -1

UICorner_2.Parent = Bottom

Execute.Name = "Execute"
Execute.Parent = Bottom
Execute.BackgroundColor3 = Color3.fromRGB(4, 6, 18)
Execute.BackgroundTransparency = 0.800
Execute.Position = UDim2.new(0.00686454028, 0, 0.103255518, 0)
Execute.Size = UDim2.new(0.154794529, 0, 0.774187684, 0)
Execute.Font = Enum.Font.SourceSans
Execute.Text = "Execute"
Execute.TextColor3 = Color3.fromRGB(255, 255, 255)
Execute.TextScaled = true
Execute.TextSize = 27.000
Execute.TextWrapped = true

UICorner_3.Parent = Execute

UITextSizeConstraint.Parent = Execute
UITextSizeConstraint.MaxTextSize = 20

Clear.Name = "Clear"
Clear.Parent = Bottom
Clear.BackgroundColor3 = Color3.fromRGB(4, 6, 18)
Clear.BackgroundTransparency = 0.800
Clear.Position = UDim2.new(0.173759758, 0, 0.103255518, 0)
Clear.Size = UDim2.new(0.154794529, 0, 0.774187684, 0)
Clear.Font = Enum.Font.SourceSans
Clear.Text = "Clear"
Clear.TextColor3 = Color3.fromRGB(255, 255, 255)
Clear.TextScaled = true
Clear.TextSize = 27.000
Clear.TextWrapped = true

UICorner_4.Parent = Clear

UITextSizeConstraint_2.Parent = Clear
UITextSizeConstraint_2.MaxTextSize = 20

Paste.Name = "Paste"
Paste.Parent = Bottom
Paste.BackgroundColor3 = Color3.fromRGB(4, 6, 18)
Paste.BackgroundTransparency = 0.800
Paste.Position = UDim2.new(0.338714361, 0, 0.103255518, 0)
Paste.Size = UDim2.new(0.154794529, 0, 0.774187684, 0)
Paste.Visible = false
Paste.Font = Enum.Font.SourceSans
Paste.Text = "Paste"
Paste.TextColor3 = Color3.fromRGB(255, 255, 255)
Paste.TextScaled = true
Paste.TextSize = 27.000
Paste.TextWrapped = true

UICorner_5.Parent = Paste

UITextSizeConstraint_3.Parent = Paste
UITextSizeConstraint_3.MaxTextSize = 14

Top.Name = "Top"
Top.Parent = MainFrame
Top.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
Top.BackgroundTransparency = 0.500
Top.BorderColor3 = Color3.fromRGB(27, 42, 53)
Top.Size = UDim2.new(0.999734521, 0, 0.11824324, 0)
Top.ZIndex = -1

UICorner_6.Parent = Top

min.Name = "min"
min.Parent = Top
min.BackgroundTransparency = 1.000
min.Position = UDim2.new(0.938210845, 0, 0.119917944, 0)
min.Size = UDim2.new(0.0463413782, 0, 0.738617837, 0)
min.ZIndex = 2
min.Image = "rbxassetid://6764432408"
min.ImageRectOffset = Vector2.new(50, 550)
min.ImageRectSize = Vector2.new(50, 50)
min.ImageTransparency = 0.150

ImageLabel.Parent = Top
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.BackgroundTransparency = 1.000
ImageLabel.Position = UDim2.new(0.0131871216, 0, 0.160596654, 0)
ImageLabel.Size = UDim2.new(0.0408218578, 0, 0.650644302, 0)
ImageLabel.Image = "http://www.roblox.com/asset/?id=7628229268"

UIAspectRatioConstraint_2.Parent = ImageLabel

TextLabel.Parent = Top
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.Position = UDim2.new(0.0670763254, 0, 0.0986866057, 0)
TextLabel.Size = UDim2.new(0.405553967, 0, 0.740149558, 0)
TextLabel.Font = Enum.Font.Gotham
TextLabel.Text = "Trigon Evo - Powered by FluxTeam"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true

UITextSizeConstraint_4.Parent = TextLabel
UITextSizeConstraint_4.MaxTextSize = 24

Pattern.Name = "Pattern"
Pattern.Parent = MainFrame
Pattern.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Pattern.BackgroundTransparency = 1.000
Pattern.Position = UDim2.new(-0.000710405875, 0, 0.118742272, 0)
Pattern.Size = UDim2.new(0.999638915, 0, 0.764195025, 0)
Pattern.ZIndex = 9
Pattern.Image = "rbxassetid://2151741365"
Pattern.ImageTransparency = 0.830
Pattern.ScaleType = Enum.ScaleType.Tile
Pattern.SliceCenter = Rect.new(0, 256, 0, 256)
Pattern.TileSize = UDim2.new(0, 250, 0, 250)

TextBox.Parent = MainFrame
TextBox.BackgroundColor3 = Color3.fromRGB(5, 12, 33)
TextBox.BackgroundTransparency = 1.000
TextBox.Position = UDim2.new(0.0147824641, 0, 0.136246353, 0)
TextBox.Size = UDim2.new(0.9782148, 0, 0.723532259, 0)
TextBox.ClearTextOnFocus = false
TextBox.Font = Enum.Font.SourceSans
TextBox.MultiLine = true
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.TextScaled = true
TextBox.TextSize = 14.000
TextBox.TextTransparency = 0.330
TextBox.TextWrapped = true
TextBox.TextXAlignment = Enum.TextXAlignment.Left
TextBox.TextYAlignment = Enum.TextYAlignment.Top

UITextSizeConstraint_5.Parent = TextBox

Frame.Parent = ss
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 0.950
Frame.BorderColor3 = Color3.fromRGB(27, 42, 53)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0, 0, 0.051258944, 0)
Frame.Size = UDim2.new(0.0597728603, 0, 0.108839333, 0)

Dock.Name = "Dock"
Dock.Parent = Frame
Dock.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Dock.BackgroundTransparency = 1.000
Dock.Position = UDim2.new(0.208529666, 0, 0.209815755, 0)
Dock.Size = UDim2.new(0.571447849, 0, 0.571447909, 0)
Dock.Visible = false
Dock.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"

UIAspectRatioConstraint_3.Parent = Dock
UIAspectRatioConstraint_3.AspectRatio = 1.000

UICorner_7.CornerRadius = UDim.new(100, 0)
UICorner_7.Parent = Dock

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(34, 9, 84)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(10, 46, 88))}
UIGradient.Parent = Dock

ImageLabel_2.Parent = Dock
ImageLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel_2.BackgroundTransparency = 1.000
ImageLabel_2.Position = UDim2.new(0.210112125, 0, 0.186582327, 0)
ImageLabel_2.Size = UDim2.new(0.650644362, 0, 0.650644302, 0)
ImageLabel_2.Image = "http://www.roblox.com/asset/?id=7628229268"

UIAspectRatioConstraint_4.Parent = ImageLabel_2

UIAspectRatioConstraint_5.Parent = Frame

-- Scripts:

local function VNXORJP_fake_script() -- min.LocalScript 
	local script = Instance.new('LocalScript', min)

	local MainFrame = script.Parent.Parent.Parent
	local Dock = script.Parent.Parent.Parent.Parent.Frame.Dock
	
	
	script.Parent.Activated:Connect(function()
		if MainFrame.Visible then
			MainFrame.Visible = false
			Dock.Visible = true
		end
	end)
	
end
coroutine.wrap(VNXORJP_fake_script)()
local function NVGBFX_fake_script() -- MainFrame.LocalScript 
	local script = Instance.new('LocalScript', MainFrame)

	local frame = script.Parent
	frame.Draggable = true
	frame.Active = true
	frame.Selectable = true
end
coroutine.wrap(NVGBFX_fake_script)()
local function LZTH_fake_script() -- Dock.LocalScript 
	local script = Instance.new('LocalScript', Dock)

	local Dock = script.Parent.Parent.Dock
	local MainFrame = script.Parent.Parent.Parent.MainFrame
	
	local frame = script.Parent.Parent
	frame.Draggable = true
	frame.Active = true
	frame.Selectable = true
	
	
	
	script.Parent.Activated:Connect(function()
		
		print("A")
		if MainFrame.Visible == false then
			Dock.Visible = false
			MainFrame.Visible = true
		end
	end)
	
	
end
coroutine.wrap(LZTH_fake_script)()


Clear.Activated:Connect(function()
	TextBox.Text = " "
end)



local execute_script = readclipboard_hideenv
getgenv().readclipboard_hideenv = nil

Execute.Activated:Connect(function()
	execute_script(TextBox.Text)
end)
