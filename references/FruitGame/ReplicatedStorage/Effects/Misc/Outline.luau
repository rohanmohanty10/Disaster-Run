 

local v1 = {}
local u2 = {
    ["Transparency"] = 1
}
function v1.start(_, p3, p4, p5, p6, p7, p8) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p3.Parent == nil then
        return
    elseif p3.PrimaryPart == nil then
        return
    elseif (workspace.CurrentCamera.CFrame.Position - p3.PrimaryPart.Position).Magnitude < 300 then
        local v9 = p3:GetChildren()
        local u10 = {}
        for v11 = 1, #v9 do
            if v9[v11]:IsA("BasePart") and v9[v11].Transparency ~= 1 then
                if v9[v11]:FindFirstChild("Outline") then
                    v9[v11].Outline:Destroy()
                end
                local v12 = v9[v11]:Clone()
                if v12.Name == "Head" then
                    v12 = script.head:Clone()
                    v12.Size = v12.Size * p3.Humanoid.HeadScale.Value
                end
                v12:ClearAllChildren()
                v12.Parent = workspace.Effects
                v12.Anchored = false
                v12.Size = v12.Size * 1.001
                v12.CanCollide = false
                v12.Massless = true
                v12.CastShadow = false
                v12.Material = Enum.Material.Neon
                v12.Color = Color3.fromRGB(190, 104, 98)
                if p4 then
                    v12.Color = p4
                end
                v12.Name = "Outline"
                v12.Transparency = 0
                if p6 then
                    v12.Transparency = p6
                end
                local v13 = Instance.new("Weld")
                v13.Parent = v12
                v13.Part0 = v9[v11]
                v13.Part1 = v12
                if p7 == nil then
                    local v14 = TweenInfo.new(p5, Enum.EasingStyle.Quart, Enum.EasingDirection.In, 0, false, 0)
                    game:GetService("TweenService"):Create(v12, v14, u2):Play()
                    _G.destroy(v12, p5)
                else
                    local v15 = TweenInfo.new(p5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out, -1, true, 0)
                    game:GetService("TweenService"):Create(v12, v15, {
                        ["Transparency"] = 1,
                        ["Color"] = p8
                    }):Play()
                    table.insert(u10, v12)
                end
                local _ = workspace.CurrentCamera
            end
        end
        if p7 ~= nil then
            return function() --[[ Line: 77 ]]
                --[[
                Upvalues:
                    [1] = u10
                --]]
                for v16 = 1, #u10 do
                    u10[v16]:Destroy()
                end
            end
        end
    end
end
return v1