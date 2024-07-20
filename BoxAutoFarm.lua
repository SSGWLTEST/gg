local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local backpack = player.Backpack
local coordinates = {
    Vector3.new(-547.0848388671875, 3.412132740020752, -85.62256622314453),
    Vector3.new(-403.59765625, 3.4121932983398438, -66.5368881225586)
}
local stopScript = false
local function HoldEFor2Seconds()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
    wait(.8)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game)
end
local function teleportTo(target)
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local currentPosition = humanoidRootPart.Position
    local distanceThreshold = 0.1
    while (target - currentPosition).magnitude > distanceThreshold do
        local direction = (target - currentPosition).unit
        local newPosition = currentPosition + direction * 3.4
        if (newPosition - target).magnitude < (currentPosition - target).magnitude then
            humanoidRootPart.CFrame = CFrame.new(newPosition)
        else
            humanoidRootPart.CFrame = CFrame.new(target)
            break
        end
        wait(0.1)
        currentPosition = humanoidRootPart.Position
    end
    print("Teleportation to target position completed!")
end
local function MoveBackAndForth()
    while not stopScript do
        for i = 1, #coordinates do
            local coord = coordinates[i]
            teleportTo(coord)
            if stopScript then
                return
            end
            humanoid.WalkSpeed = 22
            humanoid:MoveTo(coord)
            humanoid.MoveToFinished:Wait()
            if stopScript then
                return
            end
            if backpack then
                local crate = backpack:FindFirstChild("Crate")
                if crate then
                    crate.Parent = character
                end
            end

            HoldEFor2Seconds()
        end
    end
end
local function OnKeyPress(input)
    if input.KeyCode == Enum.KeyCode.F1 then
        stopScript = true
        humanoid.WalkSpeed = 16
    end
end
game:GetService("UserInputService").InputBegan:Connect(OnKeyPress)
MoveBackAndForth()
