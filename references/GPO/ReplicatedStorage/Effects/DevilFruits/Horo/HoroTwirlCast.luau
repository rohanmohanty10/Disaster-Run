 

local v1 = game:GetService("ReplicatedStorage")
local v2 = {}
local u3 = require(v1.Modules.Part_Icles)
function v2.start(_, p4) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    if _G.checkRenderDistance(p4.Position) ~= false then
        local v5 = CFrame.new(p4.Position)
        _G.PlaySound(v5, script.start)
        local v6 = script.mandp:Clone()
        v6:SetPrimaryPartCFrame(v5)
        v6.Parent = workspace.Effects
        u3:AbsoluteEmit(v6)
        _G.destroy(v6, 6)
    end
end
return v2