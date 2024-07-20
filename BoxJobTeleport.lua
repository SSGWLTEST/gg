local targetPosition = Vector3.new(-520.9241943359375, 3.491988182067871, -82.61454772949219)
local function teleportTo(target)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
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
teleportTo(targetPosition)
