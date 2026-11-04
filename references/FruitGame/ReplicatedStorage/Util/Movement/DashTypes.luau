 

local v1 = {}
local u2 = game.Players.LocalPlayer
local u3 = game.ReplicatedStorage:FindFirstChild("Stats" .. u2.Name)
local u4 = require(game.ReplicatedStorage.Modules.Skills)
game:GetService("UserInputService")
require(game.ReplicatedStorage.Modules.FastWait)
local u5 = {
    ["Bomb-Bomb"] = true
}
function v1.dash(_, p6) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u4
        [4] = u5
    --]]
    local v7 = u2.Character
    local v8 = "Regular"
    if v7:GetAttribute("flyMode") then
        return false
    else
        local v9 = v7:GetAttribute("sulongTransformed") ~= nil and "Moonlit Electro" or v8
        local v10 = u3.Stats.FightingStyle.Value == "Rokushiki" and (_G.MeetReq(u4.GetM("Soru").statreq, nil, true) == false and "Regular" or "Soru") or v9
        local v11 = u3.Stats.FightingStyle.Value == "Kamishiki" and "Soru" or v10
        local v12 = v7:GetAttribute("GEAR2Active") ~= nil and "Soru" or v11
        local v13 = script:FindFirstChild(u3.Stats.DF.Value) and true or false
        if script:FindFirstChild(u3.Stats.DF.Value) and (u3.Settings.OverrideDash.Value == false and _G.isFruitSupressed(u2) == false) then
            v12 = u3.Stats.DF.Value
        end
        if u3 and u3.Settings.OverrideDash.Value == true then
            v12 = v13 == true and v12 ~= "Soru" and "Regular" or (v13 == false and "Regular" or v12)
        end
        if u3.Settings.DashMode.Value == "Default" then
            v12 = "Regular"
        elseif u3.Settings.DashMode.Value == "Fruit" then
            local v14 = (not v13 or _G.isFruitSupressed(u2) ~= false) and "Regular" or u3.Stats.DF.Value
            v12 = v7:GetAttribute("GEAR2Active") ~= nil and "Soru" or v14
        elseif u3.Settings.DashMode.Value == "FightingStyle" then
            local v15 = v7:GetAttribute("sulongTransformed") == nil and "Regular" or "Moonlit Electro"
            if u3.Stats.FightingStyle.Value == "Rokushiki" then
                v12 = _G.MeetReq(u4.GetM("Soru").statreq, nil, true) and "Soru" or v15
            else
                v12 = u3.Stats.FightingStyle.Value == "Kamishiki" and "Soru" or v15
            end
        end
        local v16 = Ray.new(v7.HumanoidRootPart.Position, v7.HumanoidRootPart.CFrame.upVector * -(v7.Humanoid.HipHeight * 3))
        if _G.raycastWhitelist(v16, { workspace.Islands, workspace.Env, workspace.Ships }) == nil and u5[v12] == nil then
            return
        else
            local v17 = v12 == "Spring-Spring" and (_G.blocking == true or v7:GetAttribute("springMode") == nil) and "Regular" or v12
            local v18 = v17 == "Bomb-Bomb" and _G.blocking == true and "Regular" or v17
            local v19 = _G.isCustomHUB == true and "Regular" or v18
            local v20 = _G.blocking == true and "Regular" or v19
            local v21 = script:FindFirstChild(v20)
            if v21 then
                return require(v21):start(p6)
            else
                return false
            end
        end
    end
end
return v1