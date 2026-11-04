 

local v1 = {}
local u2 = _G.getHumanoid
function v1.impact(p3, p4, p5, _, p6) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p4 then
        p3.CFrame = CFrame.new(p5, p6.startpos) * CFrame.Angles(1.5707963267948966, 0, 0)
        p3.Anchored = false
        local v7 = Instance.new("WeldConstraint", p4)
        v7.Part0 = p4
        v7.Part1 = p3
        p3.Trail.Enabled = false
        if u2(p4) then
            p3.Blood:Emit(20)
            local v8 = script["S" .. math.random(1, 3)]:Clone()
            v8.Parent = p3
            v8:Play()
        else
            local v9 = script.WALL:Clone()
            v9.Parent = p3
            v9:Play()
        end
    end
    _G.destroy(p3.Parent, 10)
end
function v1.splash(p10, p11) --[[ Line: 30 ]]
    _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Splash]:start({
        ["obj"] = p10,
        ["Strength"] = 25,
        ["Size"] = 7,
        ["cf"] = p11,
        ["PSize"] = NumberSequence.new(2, 0)
    })
end
function v1.Fire(_, _, p12) --[[ Line: 35 ]]
    local v13 = script.throwingknife_throw:Clone()
    v13.Parent = p12
    v13:Play()
end
function v1.whiz(p14) --[[ Line: 42 ]]
    if p14 == nil then
        return true
    end
end
return v1