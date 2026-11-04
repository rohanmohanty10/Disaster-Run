 

local u1 = require(script.Parent.Parent.Modules.Whip)
return function(p2, p3) --[[ Line: 3 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if _G.checkRenderDistance(p2.Position) ~= false then
        u1.new(p2, nil, p3)
    end
end