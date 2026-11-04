 

local v1 = script.Parent:WaitForChild("Character", 5)
if v1 then
    local v2 = v1.Value
    if script.Parent.PrimaryPart == nil then
        repeat
            task.wait()
        until script.Parent.PrimaryPart ~= nil
    end
    script.Parent:WaitForChild("Meshes/PumpkinBossFace")
    local v3 = v2:WaitForChild("Head")
    local v4 = script.Parent:WaitForChild("Meshes/PumpkinBossFace")
    while v2.Parent ~= workspace.Effects do
        v3.Transparency = 0.99
        v3.Eye.Transparency = 0.99
        v3.Mouth.Transparency = 0.99
        v4.Transparency = 1
        task.wait(0.1)
    end
end