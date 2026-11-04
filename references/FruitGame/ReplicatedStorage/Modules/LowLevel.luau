 

local u1 = require(game.ReplicatedStorage.Modules.Leveling).LowLevel
_G.PVPBountyThreshold = 10000
local function u3(p2) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    return p2.Stats.Level.Value < u1 and { false, "Low Level" } or (p2.Settings.PVPMode.Value == false and { false, "PVP Off" } or { true, "" })
end
return function(p4, p5, p6, p7) --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
    --]]
    local v8 = game["Run Service"]:IsServer()
    if _G.BattleRoyale ~= nil then
        return false
    end
    if game.ReplicatedStorage.reservedCode:GetAttribute("battleRoyale") ~= nil then
        return false
    end
    local v9 = (p4 ~= nil and (p4:IsA("Player") and game.Players:GetPlayerFromCharacter(p5)) and true or false) and (p5 ~= p4.Character and game.Players:GetPlayerFromCharacter(p5))
    if v9 then
        if p5:FindFirstChild("SafeFF") ~= nil then
            return true
        end
        local v10 = game.ReplicatedStorage:FindFirstChild("Stats" .. p4.Name)
        local v11 = game.ReplicatedStorage:FindFirstChild("Stats" .. v9.Name)
        if v10 == nil or v11 == nil then
            return true
        end
        if v10.Stats.Crew.Value == v11.Stats.Crew.Value and (v10.Stats.Crew.Value ~= "" and p7 == nil) then
            if v9.CrewPVP.Value == false then
                return true
            end
            if p4.CrewPVP.Value == false then
                return true
            end
        end
        if u3(v10)[1] == false and _G.arena == false then
            if p6 == nil and v8 == true then
                if p4:GetAttribute("preLevelWarning") == nil then
                    p4:SetAttribute("preLevelWarning", 0)
                end
                local v12 = u3(v10)[2]
                if tick() - p4:GetAttribute("preLevelWarning") >= 1 then
                    if v12 == "Low Level" then
                        game.ReplicatedStorage.Events.note:FireClient(p4, "<Color=Red>You need to reach level " .. u1 .. " to attack others.")
                    elseif v12 == "PVP Off" then
                        game.ReplicatedStorage.Events.note:FireClient(p4, "<Color=Red>You need to turn on PVP to attack others.")
                    end
                    p4:SetAttribute("preLevelWarning", tick())
                end
            end
            return true
        end
        if u3(v11)[1] ~= false or _G.arena ~= false then
            return false
        end
        if p6 == nil and v8 == true then
            if p4:GetAttribute("preLevelWarning") == nil then
                p4:SetAttribute("preLevelWarning", 0)
            end
            local v13 = u3(v10)[2]
            if tick() - p4:GetAttribute("preLevelWarning") >= 1 then
                if v13 == "Low Level" then
                    game.ReplicatedStorage.Events.note:FireClient(p4, "<Color=Red>You cant attack low level players.")
                else
                    game.ReplicatedStorage.Events.note:FireClient(p4, "<Color=Red>You cant attack players that have PVP off.")
                end
                p4:SetAttribute("preLevelWarning", tick())
            end
        end
        return true
    end
end