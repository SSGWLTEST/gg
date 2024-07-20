local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local backpack = player.Backpack
local coordinates = {
    Vector3.new(698.394287109375, 3.5371994972229004, 170.7313232421875),
    Vector3.new(729.8390502929688, 3.4121947288513184, 211.96453857421875)
}
local stopScript = false
local function HoldEFor2Seconds()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
    wait(1)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game)
end
local function MoveBackAndForth()
    while not stopScript do
        for i = 1, #coordinates do
            local coord = coordinates[i]
            humanoid.WalkSpeed = 22
            humanoid:MoveTo(coord)
            humanoid.MoveToFinished:Wait()
            if stopScript then
                return
            end
            if backpack then
                local crate = backpack:FindFirstChild("TrashBag")
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
