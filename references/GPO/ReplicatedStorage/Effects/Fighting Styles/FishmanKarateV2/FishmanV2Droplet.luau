 

local v1 = {}
local u2 = script.Parent.Assets
function v1.start(_, p3) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.Position) ~= false then
        local v4 = u2.DropletActor:Clone()
        v4.Parent = game.ReplicatedStorage.Assets
        v4.DropletActor.Enabled = true
        v4:SendMessage("Initialize", p3)
    end
end
return v1