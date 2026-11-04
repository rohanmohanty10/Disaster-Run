 

local u1 = game:GetService("HttpService")
local u2 = game:GetService("ReplicatedStorage")
game:GetService("Players")
local u3 = game:GetService("UserInputService")
local u13 = {
    ["GetStatsFolder"] = function(p4) --[[ Name: GetStatsFolder, Line 9 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        if typeof(p4) == "Instance" and p4:IsA("Player") then
            return u2:FindFirstChild("Stats" .. p4.Name)
        else
            return u2:FindFirstChild("Stats" .. p4)
        end
    end,
    ["PlayerHasItem"] = function(p5, p6) --[[ Name: PlayerHasItem, Line 18 ]]
        --[[
        Upvalues:
            [1] = u13
            [2] = u1
        --]]
        local v7 = u13.GetStatsFolder(p5)
        if v7 ~= nil then
            return u1:JSONDecode(v7.Inventory.Inventory.Value)[p6] and true or false
        end
        warn("Failed to get inventory for ", p5)
        return nil
    end,
    ["CheckItemAmount"] = function(p8, p9) --[[ Name: CheckItemAmount, Line 48 ]]
        --[[
        Upvalues:
            [1] = u13
            [2] = u1
        --]]
        local v10 = u13.GetStatsFolder(p8)
        if v10 ~= nil then
            return u1:JSONDecode(v10.Inventory.Inventory.Value)[p9] or 0
        end
        warn("Failed to get inventory for ", p8)
        return 0
    end,
    ["CheckUltDamage"] = function(p11) --[[ Name: CheckUltDamage, Line 79 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u13
        --]]
        if u2.reservedCode.Value == "arena" then
            local v12 = 1000 - u13.GetStatsFolder(p11).Stats.Defense.Value
            return math.clamp(v12, 0, 10000) + 1200
        end
    end,
    ["GetInputType"] = function() --[[ Name: GetInputType, Line 86 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        return u3.TouchEnabled and not (u3.KeyboardEnabled or (u3.MouseEnabled or u3.GamepadEnabled)) and "Mobile" or ((u3.TouchEnabled or (not u3.KeyboardEnabled or (not u3.MouseEnabled or u3.GamepadEnabled))) and (game:GetService("GuiService"):IsTenFootInterface() == true and "Console" or "PC") or "PC")
    end
}
return u13