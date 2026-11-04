 

local v1 = game:GetService("ReplicatedStorage")
local u2 = require(v1.Modules.Client.WeaponVFXRecolor)
return {
    ["start"] = function(_, p3) --[[ Name: start, Line 6 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v4 = p3.char
        local v5 = p3.sword
        local v6 = p3.cf
        if v5 == nil then
            return
        elseif v5:FindFirstChild("Blade") ~= nil then
            local v7 = script.Sword_Spawn:Clone()
            u2.apply(v7, v4)
            v7.CFrame = v6 * CFrame.Angles(1.5707963267948966, 0, 0)
            v7.Parent = workspace.Effects
            if v5 and v5:FindFirstChild("Blade") then
                _G.customWeld(v7, v5.Blade, CFrame.Angles(1.5707963267948966, 0, 0), v7)
            end
            _G.customEmit(v7)
            _G.destroy(v7, 3)
        end
    end
}