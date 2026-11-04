 

local _, _, _, _, u1 = require(game.ReplicatedStorage.Modules.ScriptSet).get()
local v2 = game:GetService("UserInputService")
local u3 = require(game.ReplicatedStorage.KenHaki)
local u4 = false
v2.InputBegan:Connect(function(p5, p6) --[[ Line: 9 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u4
        [3] = u3
    --]]
    if not p6 then
        if p5.KeyCode == Enum.KeyCode.G and u1.Stats.KenMastery.Value >= 1 then
            if u4 == true then
                if u3.On == false then
                    local v7 = u1.Stats.DF.Value == "Mochi-Mochi" and u1.Stats.KenMastery.Value >= 700
                    if u1.Skills.KenV2.Value == true then
                        game.ReplicatedStorage.KenHaki.v2fail:Play()
                        return
                    end
                    if v7 == false then
                        game.ReplicatedStorage.KenHaki.fail:Play()
                        return
                    end
                    game.ReplicatedStorage.KenHaki.fail2:Play()
                end
                return
            end
            u4 = true
            if u3.On == false and _G.canuse == true then
                u3:Enable()
            elseif u3.On == true then
                u3:Disable()
            end
            task.wait(1)
            u4 = false
        end
    end
end)