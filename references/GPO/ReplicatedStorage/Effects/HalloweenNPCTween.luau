 

local v1 = {}
local u2 = require(script.LODTween)
local u3 = {
    ["minDistance"] = 150,
    ["maxDistance"] = 300,
    ["minLerpInterval"] = 0,
    ["maxLerpInterval"] = 0.2
}
function v1.start(_, p4, p5, p6, _) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if p4 ~= nil and (not p4 or p4.PrimaryPart ~= nil) then
        u2:AddTween(p4.PrimaryPart, p6, p5, u3)
    end
end
return v1