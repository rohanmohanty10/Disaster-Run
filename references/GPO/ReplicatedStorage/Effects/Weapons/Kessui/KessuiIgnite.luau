 

game:GetService("RunService")
game:GetService("TweenService")
game:GetService("UserInputService")
local v1 = game:GetService("ReplicatedStorage")
local _ = workspace.Effects
local v2 = {}
local u3 = require(v1.Modules.Utility)
function v2.start(_, p4) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local u5 = p4:FindFirstChild("Double Blade")
    if u5 == nil then
        return
    elseif u5:GetAttribute("Ignited") then
        u3:ToggleEnabled(u5, false)
        u5:SetAttribute("Ignited", false)
    else
        u5:SetAttribute("Ignited", true)
        task.delay(0.12, function() --[[ Line: 30 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u3
            --]]
            local v6 = u5.Middle.IgniteToggle
            u3:ToggleEnabled(v6, true)
            task.wait(0.35)
            u3:ToggleEnabled(v6, false)
            v6.Main.LockedToPart = false
            v6.Second.LockedToPart = false
        end)
        task.wait(0.6)
        u3:Emit(u5.Main.Lower)
        u3:Emit(u5.Main.Upper)
        u3:Emit(u5.Middle.IgniteEmit)
        u3:ToggleEnabled(u5.Main.LowerBladeFalse, true)
        u3:ToggleEnabled(u5.Main.UpperBladeFalse, true)
    end
end
return v2