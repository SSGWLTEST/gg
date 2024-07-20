local partNameToDelete = "backp"
local modelNameToDelete = "boxing gym"
local function deleteTruckProp()
    local cratetruck2 = game.Workspace:FindFirstChild("cratetruck2")
    if cratetruck2 then
        local truckProp = cratetruck2:FindFirstChild("TruckProp")
        if truckProp then
            truckProp:Destroy()
        else
            warn("Part '" .. partNameToDelete .. "' not found in 'cratetruck2'.")
        end
    else
        warn("Model 'cratetruck2' not found in Workspace.")
    end
end
local function deleteChild(parent, childName)
    local child = parent:FindFirstChild(childName)
    if child then
        child:Destroy()
    else
        warn("Child '" .. childName .. "' not found under parent.")
    end
end
local function deleteBoxingGym()
    local mapFolder = game.Workspace:FindFirstChild("Map")
    if mapFolder then
        local boxJob = mapFolder:FindFirstChild("Box Job")
        if boxJob then
            deleteChild(boxJob, modelNameToDelete)
        else
            warn("Model 'Box Job' not found under 'Map'.")
        end
    else
        warn("Folder 'Map' not found in Workspace.")
    end
end
local function deletePartsByNameUnderParent(parent, parentName, name)
    local children = parent:GetChildren()
    for _, child in ipairs(children) do
        if child:IsA("Model") or child:IsA("BasePart") then
            if child.Name == name and child.Parent.Name == parentName then
                child:Destroy()
            elseif child:IsA("Model") then
                deletePartsByNameUnderParent(child, parentName, name)
            end
        end
    end
end
local function modifyProximityPrompts()
    local trashcan = game.Workspace:FindFirstChild("trashcan")
    if trashcan then
        local prox = trashcan:FindFirstChild("prox")
        if prox then
            local attachment = prox:FindFirstChild("Attachment")
            if attachment then
                local proximityPrompt = attachment:FindFirstChildOfClass("ProximityPrompt")
                if proximityPrompt then
                    proximityPrompt.HoldDuration = 0
                    proximityPrompt.MaxActivationDistance = 10
                else
                    warn("ProximityPrompt not found under 'Attachment' under 'prox'.")
                end
            else
                warn("Attachment not found under 'prox'.")
            end
        else
            warn("Part 'prox' not found under 'Trashcan'.")
        end
    else
        warn("Model 'Trashcan' not found in Workspace.")
    end
    local garbageDumpster = game.Workspace:FindFirstChild("GarbageDumpster")
    if garbageDumpster then
        local attachment = garbageDumpster:FindFirstChild("Attachment")
        if attachment then
            local proximityPrompt = attachment:FindFirstChildOfClass("ProximityPrompt")
            if proximityPrompt then
                proximityPrompt.HoldDuration = 0
                proximityPrompt.MaxActivationDistance = 10
            else
                warn("ProximityPrompt not found under 'Attachment' under 'GarbageDumpster'.")
            end
        else
            warn("Attachment not found under 'GarbageDumpster'.")
        end
    else
        warn("Model 'GarbageDumpster' not found in Workspace.")
    end
end
local function searchAndDelete()
    local map = game.Workspace.Map
    local trashJob = map:FindFirstChild("Trash Job")
    if trashJob then
        deletePartsByNameUnderParent(trashJob, "Trash Job", partNameToDelete)
    else
        warn("Model 'Trash Job' not found under 'Map'.")
    end
end
while true do
    modifyProximityPrompts()
    deleteTruckProp()
    deleteBoxingGym()
    searchAndDelete()
    wait(1)
end
