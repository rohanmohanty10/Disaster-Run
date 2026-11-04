 

local v1 = {}
local u2 = require(script.ef)
function v1.impact(p3, p4, p5, p6, _) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if p4 then
        p3.CFrame = CFrame.new(p5, p5 + p6)
        if _G.checkRenderDistance(p3.Position) == false then
            return
        end
        u2:start(p5, p4)
    end
    p3.Parent:Destroy()
end
function v1.splash(p7, p8) --[[ Line: 20 ]]
    _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Splash]:start({
        ["obj"] = p7,
        ["Strength"] = 25,
        ["Size"] = 7,
        ["cf"] = p8,
        ["PSize"] = NumberSequence.new(2, 0)
    })
end
function v1.Fire(_, _, p9) --[[ Line: 25 ]]
    local v10 = script.magiccast5:Clone()
    v10.Parent = p9
    v10:Play()
end
function v1.whiz(p11) --[[ Line: 32 ]]
    if p11 == nil then
        return true
    end
end
return v1