 

local v1 = script.Parent:WaitForChild("Character", 5)
if v1 then
    local v2 = v1.Value
    if script.Parent.PrimaryPart == nil then
        repeat
            task.wait()
        until script.Parent.PrimaryPart ~= nil
    end
    local v3 = game.ReplicatedStorage:FindFirstChild("Stats" .. v2.Name)
    if v3 then
        local v4 = v3.Customization.BusoColor.Value
        local v5 = script.Parent.PrimaryPart
        if v5.Flames:GetAttribute("CustomTailoredColor") then
            v4 = v5.Flames:GetAttribute("CustomTailoredColor")
        end
        if typeof(v4) == "string" then
            v4 = Color3.fromHex(v4)
        end
        local v6 = script.Parent:GetDescendants()
        for v7 = 1, #v6 do
            if v6[v7]:IsA("BasePart") or v6[v7]:IsA("PointLight") then
                v6[v7].Color = v4
            elseif v6[v7]:IsA("ParticleEmitter") then
                v6[v7].Color = ColorSequence.new(v4)
            end
        end
    end
    script.Parent:WaitForChild("Meshes/PumpkinBossFace")
    while v2.Parent ~= workspace.Effects do
        v2.Head.Transparency = 0.99
        v2.Head.Eye.Transparency = 0.99
        v2.Head.Mouth.Transparency = 0.99
        script.Parent["Meshes/PumpkinBossFace"].Transparency = 1
        task.wait(0.1)
    end
end