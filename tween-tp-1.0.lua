local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

player.CharacterAdded:Connect(function(newChar)
	character = newChar
end)

if game.CoreGui:FindFirstChild("TweenTP_GUI") then
	game.CoreGui.TweenTP_GUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TweenTP_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

pcall(function()
	StarterGui:SetCore("SendNotification", {
		Title = "Information",
		Text = "Hey! Script creator: @Берн0ва, his channel: @Lunary_Official",
		Duration = 8
	})
end)

local Main = Instance.new("Frame")

local isMobile = UserInputService.TouchEnabled

if isMobile then
	Main.Size = UDim2.new(0, 235, 0, 325)
	Main.Position = UDim2.new(0.5, -117, 0.43, -162)
else
	Main.Size = UDim2.new(0, 255, 0, 350)
	Main.Position = UDim2.new(0.5, -127, 0.48, -175)
end

Main.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
Main.BorderSizePixel = 0
Main.Active = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(55,55,75)
Stroke.Thickness = 1
Stroke.Parent = Main

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 34)
TopBar.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 12)
TopCorner.Parent = TopBar

local Fix = Instance.new("Frame")
Fix.Size = UDim2.new(1,0,0,12)
Fix.Position = UDim2.new(0,0,1,-12)
Fix.BackgroundColor3 = Color3.fromRGB(28,28,40)
Fix.BorderSizePixel = 0
Fix.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-40,1,0)
Title.Position = UDim2.new(0,10,0,0)
Title.BackgroundTransparency = 1
Title.Text = "Tween TP"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0,22,0,22)
Close.Position = UDim2.new(1,-30,0.5,-11)
Close.BackgroundColor3 = Color3.fromRGB(255,70,70)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255,255,255)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 12
Close.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1,0)
CloseCorner.Parent = Close

Close.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

-- DRAG
local dragging = false
local dragStart
local startPos

TopBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPos = Main.Position
	end
end)

TopBar.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then

		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging then
		if input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch then

			local delta = input.Position - dragStart

			Main.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end
end)

local function createSection(y, titleText)
	local Frame = Instance.new("Frame")
	Frame.Size = UDim2.new(1,-16,0,60)
	Frame.Position = UDim2.new(0,8,0,y)
	Frame.BackgroundColor3 = Color3.fromRGB(30,30,42)
	Frame.BorderSizePixel = 0
	Frame.Parent = Main

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0,8)
	Corner.Parent = Frame

	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Size = UDim2.new(1,-70,0,18)
	TitleLabel.Position = UDim2.new(0,8,0,4)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Text = titleText
	TitleLabel.TextColor3 = Color3.fromRGB(170,170,255)
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.TextSize = 11
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Parent = Frame

	local PosLabel = Instance.new("TextLabel")
	PosLabel.Size = UDim2.new(1,-75,0,34)
	PosLabel.Position = UDim2.new(0,8,0,22)
	PosLabel.BackgroundTransparency = 1
	PosLabel.Text = "X:0\nY:0\nZ:0"
	PosLabel.TextColor3 = Color3.fromRGB(255,255,255)
	PosLabel.Font = Enum.Font.Code
	PosLabel.TextSize = 10
	PosLabel.TextXAlignment = Enum.TextXAlignment.Left
	PosLabel.TextYAlignment = Enum.TextYAlignment.Top
	PosLabel.Parent = Frame

	local AddButton = Instance.new("TextButton")
	AddButton.Size = UDim2.new(0,55,0,24)
	AddButton.Position = UDim2.new(1,-63,0.5,-12)
	AddButton.BackgroundColor3 = Color3.fromRGB(90,120,255)
	AddButton.Text = "ADD"
	AddButton.TextColor3 = Color3.fromRGB(255,255,255)
	AddButton.Font = Enum.Font.GothamBold
	AddButton.TextSize = 10
	AddButton.Parent = Frame

	local AddCorner = Instance.new("UICorner")
	AddCorner.CornerRadius = UDim.new(0,7)
	AddCorner.Parent = AddButton

	return PosLabel, AddButton
end

local startLiveLabel, startButton = createSection(45, "Start Position")
local endLiveLabel, endButton = createSection(115, "End Position")

local startPosData
local endPosData

RunService.RenderStepped:Connect(function()
	if character and character:FindFirstChild("HumanoidRootPart") then
		local pos = character.HumanoidRootPart.Position

		if not startPosData then
			startLiveLabel.Text = string.format(
				"X: %.1f\nY: %.1f\nZ: %.1f",
				pos.X,
				pos.Y,
				pos.Z
			)
		end

		if not endPosData then
			endLiveLabel.Text = string.format(
				"X: %.1f\nY: %.1f\nZ: %.1f",
				pos.X,
				pos.Y,
				pos.Z
			)
		end
	end
end)

startButton.MouseButton1Click:Connect(function()
	if character and character:FindFirstChild("HumanoidRootPart") then
		local pos = character.HumanoidRootPart.Position

		startPosData = Vector3.new(pos.X, pos.Y, pos.Z)

		startLiveLabel.Text = string.format(
			"X: %.1f\nY: %.1f\nZ: %.1f",
			pos.X,
			pos.Y,
			pos.Z
		)
	end
end)

endButton.MouseButton1Click:Connect(function()
	if character and character:FindFirstChild("HumanoidRootPart") then
		local pos = character.HumanoidRootPart.Position

		endPosData = Vector3.new(pos.X, pos.Y, pos.Z)

		endLiveLabel.Text = string.format(
			"X: %.1f\nY: %.1f\nZ: %.1f",
			pos.X,
			pos.Y,
			pos.Z
		)
	end
end)

local SettingsFrame = Instance.new("Frame")
SettingsFrame.Size = UDim2.new(1,-16,0,70)
SettingsFrame.Position = UDim2.new(0,8,0,185)
SettingsFrame.BackgroundColor3 = Color3.fromRGB(30,30,42)
SettingsFrame.BorderSizePixel = 0
SettingsFrame.Parent = Main

local SettingsCorner = Instance.new("UICorner")
SettingsCorner.CornerRadius = UDim.new(0,8)
SettingsCorner.Parent = SettingsFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.5,0,0,18)
SpeedLabel.Position = UDim2.new(0,8,0,8)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.Text = "Time (ms)"
SpeedLabel.TextColor3 = Color3.fromRGB(255,255,255)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 10
SpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
SpeedLabel.Parent = SettingsFrame

local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(0,70,0,22)
SpeedBox.Position = UDim2.new(1,-78,0,6)
SpeedBox.BackgroundColor3 = Color3.fromRGB(40,40,55)
SpeedBox.Text = "1000"
SpeedBox.TextColor3 = Color3.fromRGB(255,255,255)
SpeedBox.Font = Enum.Font.GothamBold
SpeedBox.TextSize = 10
SpeedBox.ClearTextOnFocus = false
SpeedBox.Parent = SettingsFrame

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0,6)
SpeedCorner.Parent = SpeedBox

local SmoothLabel = Instance.new("TextLabel")
SmoothLabel.Size = UDim2.new(0.5,0,0,18)
SmoothLabel.Position = UDim2.new(0,8,0,40)
SmoothLabel.BackgroundTransparency = 1
SmoothLabel.Text = "Smooth"
SmoothLabel.TextColor3 = Color3.fromRGB(255,255,255)
SmoothLabel.Font = Enum.Font.Gotham
SmoothLabel.TextSize = 10
SmoothLabel.TextXAlignment = Enum.TextXAlignment.Left
SmoothLabel.Parent = SettingsFrame

local SmoothButton = Instance.new("TextButton")
SmoothButton.Size = UDim2.new(0,70,0,22)
SmoothButton.Position = UDim2.new(1,-78,0,38)
SmoothButton.BackgroundColor3 = Color3.fromRGB(80,200,120)
SmoothButton.Text = "ON"
SmoothButton.TextColor3 = Color3.fromRGB(255,255,255)
SmoothButton.Font = Enum.Font.GothamBold
SmoothButton.TextSize = 10
SmoothButton.Parent = SettingsFrame

local SmoothCorner = Instance.new("UICorner")
SmoothCorner.CornerRadius = UDim.new(0,6)
SmoothCorner.Parent = SmoothButton

local smoothEnabled = true

SmoothButton.MouseButton1Click:Connect(function()
	smoothEnabled = not smoothEnabled

	if smoothEnabled then
		SmoothButton.Text = "ON"
		SmoothButton.BackgroundColor3 = Color3.fromRGB(80,200,120)
	else
		SmoothButton.Text = "OFF"
		SmoothButton.BackgroundColor3 = Color3.fromRGB(255,80,80)
	end
end)

local TPStartButton = Instance.new("TextButton")
TPStartButton.Size = UDim2.new(0.44,0,0,26)
TPStartButton.Position = UDim2.new(0.04,0,1,-72)
TPStartButton.BackgroundColor3 = Color3.fromRGB(90,120,255)
TPStartButton.Text = "TP START"
TPStartButton.TextColor3 = Color3.fromRGB(255,255,255)
TPStartButton.Font = Enum.Font.GothamBold
TPStartButton.TextSize = 10
TPStartButton.Parent = Main

local TPStartCorner = Instance.new("UICorner")
TPStartCorner.CornerRadius = UDim.new(0,8)
TPStartCorner.Parent = TPStartButton

local KillButton = Instance.new("TextButton")
KillButton.Size = UDim2.new(0.44,0,0,26)
KillButton.Position = UDim2.new(0.52,0,1,-72)
KillButton.BackgroundColor3 = Color3.fromRGB(170,60,60)
KillButton.Text = "KILL ME"
KillButton.TextColor3 = Color3.fromRGB(255,255,255)
KillButton.Font = Enum.Font.GothamBold
KillButton.TextSize = 10
KillButton.Parent = Main

local KillCorner = Instance.new("UICorner")
KillCorner.CornerRadius = UDim.new(0,8)
KillCorner.Parent = KillButton

local StartButton = Instance.new("TextButton")
StartButton.Size = UDim2.new(0.44,0,0,30)
StartButton.Position = UDim2.new(0.04,0,1,-38)
StartButton.BackgroundColor3 = Color3.fromRGB(80,200,120)
StartButton.Text = "START"
StartButton.TextColor3 = Color3.fromRGB(255,255,255)
StartButton.Font = Enum.Font.GothamBold
StartButton.TextSize = 11
StartButton.Parent = Main

local StartCorner = Instance.new("UICorner")
StartCorner.CornerRadius = UDim.new(0,8)
StartCorner.Parent = StartButton

local StopButton = Instance.new("TextButton")
StopButton.Size = UDim2.new(0.44,0,0,30)
StopButton.Position = UDim2.new(0.52,0,1,-38)
StopButton.BackgroundColor3 = Color3.fromRGB(255,80,80)
StopButton.Text = "STOP"
StopButton.TextColor3 = Color3.fromRGB(255,255,255)
StopButton.Font = Enum.Font.GothamBold
StopButton.TextSize = 11
StopButton.Parent = Main

local StopCorner = Instance.new("UICorner")
StopCorner.CornerRadius = UDim.new(0,8)
StopCorner.Parent = StopButton

local activeTween

StartButton.MouseButton1Click:Connect(function()
	if not startPosData or not endPosData then
		return
	end

	if not character or not character:FindFirstChild("HumanoidRootPart") then
		return
	end

	local hrp = character.HumanoidRootPart

	hrp.CFrame = CFrame.new(startPosData)

	local time = tonumber(SpeedBox.Text) or 1000
	time = math.clamp(time, 100, 600000)
	time = time / 1000

	local tweenInfo

	if smoothEnabled then
		tweenInfo = TweenInfo.new(
			time,
			Enum.EasingStyle.Sine,
			Enum.EasingDirection.InOut
		)
	else
		tweenInfo = TweenInfo.new(
			time,
			Enum.EasingStyle.Linear,
			Enum.EasingDirection.Out
		)
	end

	activeTween = TweenService:Create(
		hrp,
		tweenInfo,
		{
			CFrame = CFrame.new(endPosData)
		}
	)

	activeTween:Play()
end)

StopButton.MouseButton1Click:Connect(function()
	if activeTween then
		activeTween:Cancel()
	end
end)

TPStartButton.MouseButton1Click:Connect(function()
	if startPosData and character and character:FindFirstChild("HumanoidRootPart") then
		character.HumanoidRootPart.CFrame = CFrame.new(startPosData)
	end
end)

KillButton.MouseButton1Click:Connect(function()
	if character and character:FindFirstChildOfClass("Humanoid") then
		character:FindFirstChildOfClass("Humanoid").Health = 0
	end
end)
