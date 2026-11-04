 

local v1 = {}
game:GetService("PhysicsService")
function v1.impact(p2, p3, _, _, _) --[[ Line: 4 ]]
    if p3 then
        p2.Anchored = false
        local v4 = Instance.new("WeldConstraint", p3)
        v4.Part0 = p3
        v4.Part1 = p2
        _G.PlaySound(p2, script["snowball impact"])
    end
    _G.destroy(p2.Parent, 3)
end
function v1.splash(p5, p6) --[[ Line: 19 ]]
    _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Splash]:start({
        ["obj"] = p5,
        ["Strength"] = 25,
        ["Size"] = 7,
        ["cf"] = p6,
        ["PSize"] = NumberSequence.new(2, 0)
    })
end
function v1.Fire(_, _, p7) --[[ Line: 24 ]]
    local v8 = script.throw:Clone()
    v8.Parent = p7
    v8:Play()
end
local u9 = {}
function v1.move(p10, _) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u9
    --]]
    if u9[p10] == nil then
        u9[p10] = 0
    end
    u9[p10] = u9[p10] + 0.1
    p10.CFrame = p10.CFrame * CFrame.Angles(0, 0, u9[p10])
end
function v1.whiz(p11) --[[ Line: 40 ]]
    if p11 == nil then
        return true
    end
end
return v1