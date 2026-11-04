 

local v1 = {}
local u2 = game:GetService("TweenService")
local u3 = Random.new()
function v1.start(_, p4, p5) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    if p4 ~= nil then
        local v6 = u3:NextNumber(0.05, 0.15)
        local v7 = script["Dark_Gold.002"]:Clone()
        v7.Color = p5
        v7.Size = p4.Size
        v7.CastShadow = false
        v7.Transparency = u3:NextNumber(0.85, 0.9)
        local v8 = Instance.new("Weld")
        v8.Part0 = p4
        v8.Part1 = v7
        v8.Parent = v7
        v7.Parent = workspace.Effects
        u2:Create(v8, TweenInfo.new(v6 / u3:NextNumber(1.25, 2), Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["C1"] = CFrame.new(u3:NextNumber(-0.15, 0.15), u3:NextNumber(-0.15, 0.15), u3:NextNumber(-0.15, 0.15))
        }):Play()
        u2:Create(v7, TweenInfo.new(v6, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
            ["Transparency"] = 1
        }):Play()
        task.delay(v6, v7.Destroy, v7)
    end
end
return v1