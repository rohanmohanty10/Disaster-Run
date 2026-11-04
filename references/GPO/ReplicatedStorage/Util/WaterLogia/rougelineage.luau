 

local v1 = {}
local u2 = {
    ["Hie-Hie"] = true,
    ["Magu-Magu"] = true
}
function v1.solans(_, p3) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v4 = game.Players.LocalPlayer
    local v5 = game.ReplicatedStorage:FindFirstChild("Stats" .. v4.Name)
    local v6 = game.Players.LocalPlayer.Character
    local v7 = p3 or v5.Stats.DF.Value
    local v8 = v6:FindFirstChild(v7)
    if v8 == nil then
        v8 = v4.Backpack:FindFirstChild(v7)
    end
    local v9 = v8 and v8:FindFirstChild("Main") and true or false
    if u2[v7] == nil then
        v9 = false
    end
    return v9
end
return v1