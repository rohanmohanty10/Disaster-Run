 

local u1 = {}
u1.__index = u1
local u2 = game:GetService("ReplicatedStorage")
local u3 = game.Players.LocalPlayer
game:GetService("UserInputService")
local u4 = u3.Character or u3.CharacterAdded:Wait()
function u1.new(p5) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v6 = u1
    local v7 = setmetatable({}, v6)
    v7.Handler = p5
    v7.Utils = p5.Utils
    return v7
end
local u8 = false
function u1.PC_Activate(_) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u4
        [4] = u8
    --]]
    local v9 = u2["Stats" .. u3.Name]
    if u4:FindFirstChildWhichIsA("Tool") and (u8 == false and (v9.Stats.BusoMastery.Value > 0 and (_G.check:inspect(u4) == true and _G.canuse == true))) then
        if v9.BusoBar.Value < v9.BusoBar.MaxValue * 0.1 and u4:FindFirstChild("BusoMelee") == nil then
            _G.BusoRed(v9.BusoBar.MaxValue * 0.1)
            return
        end
        u8 = true
        game.ReplicatedStorage.Events.Haki:FireServer("Buso")
        task.delay(2, function() --[[ Line: 29 ]]
            --[[
            Upvalues:
                [1] = u8
            --]]
            u8 = false
        end)
    end
end
u1.Mobile_Activate = u1.PC_Activate
return u1