local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

player.CharacterAdded:Connect(function(newChar)
    character = newChar
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TeleportGUI"
ScreenGui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 300, 0, 350)
frame.Position = UDim2.new(0.5, -150, 0.5, -175)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
frame.Active = true
frame.Draggable = true
frame.Parent = ScreenGui

local touchStartPos
local touchStartFramePos
local isDragging = false

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        touchStartPos = input.Position
        touchStartFramePos = frame.Position
        isDragging = true
    end
end)

frame.InputChanged:Connect(function(input)
    if isDragging and input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - touchStartPos

        frame.Position = UDim2.new(
            touchStartFramePos.X.Scale,
            touchStartFramePos.X.Offset + delta.X,
            touchStartFramePos.Y.Scale,
            touchStartFramePos.Y.Offset + delta.Y
        )
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        isDragging = false
    end
end)

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Text = "Teleport GUI"
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = title

local currentFrame = Instance.new("Frame")
currentFrame.Name = "CurrentPosition"
currentFrame.Size = UDim2.new(0.9, 0, 0, 120)
currentFrame.Position = UDim2.new(0.05, 0, 0, 50)
currentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
currentFrame.Parent = frame

local currentCorner = Instance.new("UICorner")
currentCorner.CornerRadius = UDim.new(0, 6)
currentCorner.Parent = currentFrame

local currentTitle = Instance.new("TextLabel")
currentTitle.Name = "CurrentTitle"
currentTitle.Text = "Current Position"
currentTitle.Size = UDim2.new(1, 0, 0, 30)
currentTitle.BackgroundTransparency = 1
currentTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
currentTitle.Font = Enum.Font.Gotham
currentTitle.TextSize = 14
currentTitle.Parent = currentFrame

local labels = {}
local labelNames = {"X:", "Y:", "Z:"}

for i = 1, 3 do
    local labelFrame = Instance.new("Frame")
    labelFrame.Size = UDim2.new(1, 0, 0, 30)
    labelFrame.Position = UDim2.new(0, 0, 0, 30 + (i - 1) * 30)
    labelFrame.BackgroundTransparency = 1
    labelFrame.Parent = currentFrame

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Text = labelNames[i]
    nameLabel.Size = UDim2.new(0.3, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(150, 150, 255)
    nameLabel.Font = Enum.Font.Gotham
    nameLabel.TextSize = 14
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = labelFrame

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Text = "0"
    valueLabel.Size = UDim2.new(0.7, 0, 1, 0)
    valueLabel.Position = UDim2.new(0.3, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    valueLabel.Font = Enum.Font.GothamMedium
    valueLabel.TextSize = 14
    valueLabel.TextXAlignment = Enum.TextXAlignment.Left
    valueLabel.Parent = labelFrame

    labels[i] = valueLabel
end

local saveButton = Instance.new("TextButton")
saveButton.Name = "SaveButton"
saveButton.Text = "SAVE POSITION"
saveButton.Size = UDim2.new(0.9, 0, 0, 40)
saveButton.Position = UDim2.new(0.05, 0, 0, 180)
saveButton.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
saveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
saveButton.Font = Enum.Font.GothamBold
saveButton.TextSize = 16
saveButton.Parent = frame

local saveCorner = Instance.new("UICorner")
saveCorner.CornerRadius = UDim.new(0, 6)
saveCorner.Parent = saveButton

local savedFrame = Instance.new("Frame")
savedFrame.Name = "SavedPositions"
savedFrame.Size = UDim2.new(0.9, 0, 0, 100)
savedFrame.Position = UDim2.new(0.05, 0, 0, 230)
savedFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
savedFrame.Parent = frame

local savedCorner = Instance.new("UICorner")
savedCorner.CornerRadius = UDim.new(0, 6)
savedCorner.Parent = savedFrame

local savedTitle = Instance.new("TextLabel")
savedTitle.Text = "Saved Positions"
savedTitle.Size = UDim2.new(1, 0, 0, 30)
savedTitle.BackgroundTransparency = 1
savedTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
savedTitle.Font = Enum.Font.Gotham
savedTitle.TextSize = 14
savedTitle.Parent = savedFrame

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -30)
scrollFrame.Position = UDim2.new(0, 0, 0, 30)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 4
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.Parent = savedFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 5)
listLayout.Parent = scrollFrame

local config = {
    savedPositions = {}
}

if isfile("TeleportConfig.json") then
    local success, loaded = pcall(function()
        return HttpService:JSONDecode(readfile("TeleportConfig.json"))
    end)

    if success then
        config = loaded
    end
end

local function updatePosition()
    if character and character:FindFirstChild("HumanoidRootPart") then
        local pos = character.HumanoidRootPart.Position

        labels[1].Text = string.format("%.2f", pos.X)
        labels[2].Text = string.format("%.2f", pos.Y)
        labels[3].Text = string.format("%.2f", pos.Z)
    end
end

local function saveConfig()
    writefile("TeleportConfig.json", HttpService:JSONEncode(config))
end

local function addPositionToScroll(position, index)
    local posFrame = Instance.new("Frame")
    posFrame.Name = "Position" .. index
    posFrame.Size = UDim2.new(1, 0, 0, 35)
    posFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    posFrame.Parent = scrollFrame

    local posCorner = Instance.new("UICorner")
    posCorner.CornerRadius = UDim.new(0, 4)
    posCorner.Parent = posFrame

    local posText = Instance.new("TextLabel")
    posText.Text = string.format("X:%.1f Y:%.1f Z:%.1f", position.X, position.Y, position.Z)
    posText.Size = UDim2.new(0.45, 0, 1, 0)
    posText.Position = UDim2.new(0, 5, 0, 0)
    posText.BackgroundTransparency = 1
    posText.TextColor3 = Color3.fromRGB(255, 255, 255)
    posText.Font = Enum.Font.Gotham
    posText.TextSize = 11
    posText.TextXAlignment = Enum.TextXAlignment.Left
    posText.Parent = posFrame

    local teleportButton = Instance.new("TextButton")
    teleportButton.Text = "TP"
    teleportButton.Size = UDim2.new(0.18, 0, 0.7, 0)
    teleportButton.Position = UDim2.new(0.48, 0, 0.15, 0)
    teleportButton.BackgroundColor3 = Color3.fromRGB(70, 120, 70)
    teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    teleportButton.Font = Enum.Font.GothamBold
    teleportButton.TextSize = 12
    teleportButton.Parent = posFrame

    local tpCorner = Instance.new("UICorner")
    tpCorner.CornerRadius = UDim.new(0, 4)
    tpCorner.Parent = teleportButton

    teleportButton.MouseButton1Click:Connect(function()
        if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(position.X, position.Y, position.Z)
        end
    end)

    -- COPY TP BUTTON
    local copyButton = Instance.new("TextButton")
    copyButton.Text = "COPY"
    copyButton.Size = UDim2.new(0.22, 0, 0.7, 0)
    copyButton.Position = UDim2.new(0.68, 0, 0.15, 0)
    copyButton.BackgroundColor3 = Color3.fromRGB(70, 90, 140)
    copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyButton.Font = Enum.Font.GothamBold
    copyButton.TextSize = 11
    copyButton.Parent = posFrame

    local copyCorner = Instance.new("UICorner")
    copyCorner.CornerRadius = UDim.new(0, 4)
    copyCorner.Parent = copyButton

    copyButton.MouseButton1Click:Connect(function()
        local scriptText = string.format([[
local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(%f, %f, %f)
]], position.X, position.Y, position.Z)

        if setclipboard then
            setclipboard(scriptText)

            copyButton.Text = "COPIED"

            task.wait(1)

            copyButton.Text = "COPY"
        end
    end)

    local deleteButton = Instance.new("TextButton")
    deleteButton.Text = "DEL"
    deleteButton.Size = UDim2.new(0.18, 0, 0.7, 0)
    deleteButton.Position = UDim2.new(0.48, 0, 0.15, 0)
    deleteButton.BackgroundColor3 = Color3.fromRGB(120, 70, 70)
    deleteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    deleteButton.Font = Enum.Font.GothamBold
    deleteButton.TextSize = 12
    deleteButton.Visible = false
    deleteButton.Parent = posFrame

    local delCorner = Instance.new("UICorner")
    delCorner.CornerRadius = UDim.new(0, 4)
    delCorner.Parent = deleteButton

    posFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then

            teleportButton.Visible = not teleportButton.Visible
            deleteButton.Visible = not deleteButton.Visible
        end
    end)

    deleteButton.MouseButton1Click:Connect(function()
        table.remove(config.savedPositions, index)
        saveConfig()
        posFrame:Destroy()
    end)

    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
end

for i, pos in ipairs(config.savedPositions) do
    addPositionToScroll(pos, i)
end

saveButton.MouseButton1Click:Connect(function()
    if character and character:FindFirstChild("HumanoidRootPart") then
        local pos = character.HumanoidRootPart.Position

        table.insert(config.savedPositions, {
            X = pos.X,
            Y = pos.Y,
            Z = pos.Z
        })

        saveConfig()

        addPositionToScroll(config.savedPositions[#config.savedPositions], #config.savedPositions)

        local tween = TweenService:Create(
            saveButton,
            TweenInfo.new(0.2),
            {
                BackgroundColor3 = Color3.fromRGB(100, 150, 100)
            }
        )

        tween:Play()

        tween.Completed:Connect(function()
            TweenService:Create(
                saveButton,
                TweenInfo.new(0.2),
                {
                    BackgroundColor3 = Color3.fromRGB(80, 80, 120)
                }
            ):Play()
        end)
    end
end)

game:GetService("RunService").RenderStepped:Connect(updatePosition)

local closeButton = Instance.new("TextButton")
closeButton.Text = "X"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 16
closeButton.Parent = frame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 8)
closeCorner.Parent = closeButton

closeButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
