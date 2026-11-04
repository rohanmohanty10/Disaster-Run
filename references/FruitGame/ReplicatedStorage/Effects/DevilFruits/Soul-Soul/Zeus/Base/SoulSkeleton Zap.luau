 

game:GetService("TweenService")
game:GetService("Debris")
Random.new()
require(script.Parent.Shared)
local u1 = script.VFX
return {
    ["start"] = function(_, p2) --[[ Name: start, Line 11 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v3 = u1.SkeletonOutfit:Clone()
        local v4 = Instance.new("Highlight")
        v4.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        v4.FillColor = Color3.new(1, 1, 1)
        v4.OutlineTransparency = 1
        v4.FillTransparency = 0
        v4.Parent = v3
        for _, v5 in v3:GetChildren() do
            if v5:IsA("BasePart") then
                local v6 = p2:FindFirstChild(v5.Name)
                if v6 then
                    local v7 = Instance.new("Weld")
                    v7.Part0 = v6
                    v7.Part1 = v5
                    v7.Parent = v5
                end
            end
        end
        v3.Parent = workspace.Effects
        for _ = 1, 2 do
            v4.FillColor = Color3.new(0, 0, 0)
            task.wait(0.02)
            v4.FillColor = Color3.new(1, 1, 1)
        end
        if v4 then
            v4:Destroy()
        end
        if v3 then
            v3:Destroy()
        end
    end
}