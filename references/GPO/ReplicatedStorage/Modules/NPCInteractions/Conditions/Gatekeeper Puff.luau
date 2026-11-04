 

local v1 = {
    ["Costs"] = {
        ["Normal"] = 500
    }
}
local u2 = workspace.Islands["Reverse Mountain"]
function v1.check(_) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v3 = game.Players.LocalPlayer
    local _ = v3.Character
    if game.ReplicatedStorage:FindFirstChild("Stats" .. v3.Name).Stats.Level.Value < 325 then
        return {
            {
                ["talkname"] = "notReady",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    if _G.HasItem(v3, "World Scroll") == true and u2.Gate.Barrier.CastShadow == true then
        return {
            {
                ["talkname"] = "opengate",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    if u2.Gate.Barrier.CastShadow == false then
        return {
            {
                ["talkname"] = "gateAlreadyOpen",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
end
return v1