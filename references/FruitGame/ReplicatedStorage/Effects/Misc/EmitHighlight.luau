 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
local v2 = game:GetService("ReplicatedStorage")
local u3 = require(v2.Modules.VFXUtility.highlight_emit)
function v1.start(_, p4, p5) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    if p4 ~= nil then
        u3.tweenHighlight(p4, p5.fillColor, p5.outlineColor, p5.duration, p5.depthMode, p5.tweenType, p5.initialFillTransparency)
    end
end
return v1