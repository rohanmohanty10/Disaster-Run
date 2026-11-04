 

function PlayFlipbook(p1, p2, p3, p4, p5)
    for v6 = p4, p5 do
        local v7
        if p2:FindFirstChild((tostring(v6))) then
            v7 = v6
        else
            v7 = v6 + 1
        end
        p1.Texture = p2[tostring(v7)].Texture
        task.wait(p3)
    end
end
Emit = _G.Emit
TweenCreate = _G.Ess.Tween
Apply = _G.Apply
local _ = Enum.EasingStyle
local _ = Enum.EasingDirection
local u12 = {
    ["Heaven-sent Impact"] = {
        ["Hold"] = require(script["Heaven-sent Impact"].Hold),
        ["Release"] = require(script["Heaven-sent Impact"].Release)
    },
    ["Rising Fist"] = {
        ["Hold"] = require(script["Rising Fist"].Hold),
        ["Release"] = require(script["Rising Fist"].Release)
    },
    ["start"] = function(_, p8, p9, p10, p11) --[[ Name: start, Line 32 ]]
        --[[
        Upvalues:
            [1] = u12
        --]]
        Random.new()
        u12[p8][p9](p10, unpack(p11))
    end
}
return u12