 

local v1 = script.Parent.Parent
local v2 = require(v1:WaitForChild("Config"))
local u3 = require(script:WaitForChild("Gizmo"))
local u4 = game:GetService("RunService"):IsStudio() or v2.ALLOW_LIVE_GAME_DEBUG
if u4 then
    u3.Init()
end
local v6 = setmetatable({}, {
    ["__index"] = function(_, p5) --[[ Name: __index, Line 21 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u3
        --]]
        return not u4 and (({
            ["SetStyle"] = true,
            ["AddDebrisInSeconds"] = true,
            ["PushProperty"] = true,
            ["PopProperty"] = true,
            ["AddDebrisInFrames"] = true,
            ["SetEnabled"] = true,
            ["DoCleaning"] = true,
            ["ScheduleCleaning"] = true,
            ["TweenProperties"] = true
        })[p5] and function() --[[ Line: 38 ]] end or {
            ["Draw"] = function() --[[ Name: Draw, Line 42 ]] end,
            ["Create"] = function() --[[ Name: Create, Line 43 ]] end
        }) or u3[p5]
    end
})
return table.freeze(v6)