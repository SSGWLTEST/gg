local GROUP_ID = 34589134
local TEXT_COLOR = Color3.fromRGB(255, 165, 0)
local TEXT_SIZE = 15
local function isInGroup(player)
    local userId = player.UserId
    local inGroup = false
    local success, errorMessage = pcall(function()
        inGroup = player:IsInGroup(GROUP_ID)
    end)
    return inGroup
end
local function updateLabels()
    local localPlayer = game.Players.LocalPlayer
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if isInGroup(player) then
                local humanoidRootPart = player.Character.HumanoidRootPart
                local espLabel = humanoidRootPart:FindFirstChild("ESPLabel")
                if not espLabel then
                    espLabel = Instance.new("BillboardGui")
                    espLabel.Name = "ESPLabel"
                    espLabel.AlwaysOnTop = true
                    espLabel.Size = UDim2.new(0, 10, 0, 4)
                    espLabel.StudsOffset = Vector3.new(0, 10, 0)
                    espLabel.Parent = humanoidRootPart
                    local textLabel = Instance.new("TextLabel")
                    textLabel.Name = "Name"
                    textLabel.BackgroundTransparency = 1
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.TextScaled = false
                    textLabel.TextColor3 = TEXT_COLOR
                    textLabel.TextStrokeTransparency = 0
                    textLabel.Text = "STK User"
                    textLabel.Font = Enum.Font.SourceSansBold
                    textLabel.TextSize = TEXT_SIZE
                    textLabel.Parent = espLabel
                else
                    local textLabel = espLabel:FindFirstChild("Name")
                    if textLabel then
                        textLabel.TextColor3 = TEXT_COLOR
                        textLabel.TextSize = TEXT_SIZE
                    end
                end
            end
        end
    end
end
while true do
    updateLabels()
    wait(1)
end
