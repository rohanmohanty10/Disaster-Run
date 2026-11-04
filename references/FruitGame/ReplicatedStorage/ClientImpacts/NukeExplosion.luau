 

local v1 = {}
local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Sparks]
local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.RockDebs]
function v1.start(_, p2) --[[ Line: 6 ]]
    local _ = p2.obj
    local v3 = p2.cf
    local _ = p2.hit
    local _ = p2.normal
    local u4 = script.Model:Clone()
    u4.Parent = workspace.Effects
    u4:PivotTo(v3)
    local v5 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
    game:GetService("TweenService"):Create(u4.Sphere, v5, {
        ["Size"] = Vector3.new(800, 800, 800),
        ["Transparency"] = 0
    }):Play()
    local v6 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
    game:GetService("TweenService"):Create(u4.Ring, v6, {
        ["Size"] = Vector3.new(1200, 2, 1200),
        ["Transparency"] = 0
    }):Play()
    task.spawn(function() --[[ Line: 30 ]]
        --[[
        Upvalues:
            [1] = u4
        --]]
        task.wait(2)
        local v7 = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
        game:GetService("TweenService"):Create(u4.Sphere, v7, {
            ["Transparency"] = 1
        }):Play()
        local v8 = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
        game:GetService("TweenService"):Create(u4.Ring, v8, {
            ["Transparency"] = 1
        }):Play()
        _G.destroy(u4, 20)
        _G.destroy(u4, 20)
    end)
end
return v1