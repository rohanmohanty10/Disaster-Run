 

local u1 = {}
u1.__index = u1
game:GetService("ReplicatedStorage")
local v2 = game.Players.LocalPlayer
game:GetService("UserInputService")
if not v2.Character then
    v2.CharacterAdded:Wait()
end
local _, _, _, _, u3 = require(game.ReplicatedStorage.Modules.ScriptSet).get()
game:GetService("UserInputService")
local u4 = require(game.ReplicatedStorage.KenHaki)
local u5 = false
function u1.new(p6) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v7 = u1
    local v8 = setmetatable({}, v7)
    v8.Handler = p6
    v8.Utils = p6.Utils
    return v8
end
function u1.PC_Activate(_) --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u5
        [3] = u4
    --]]
    if u3.Stats.KenMastery.Value >= 1 then
        if u5 == true then
            if u4.On == false then
                local v9 = string.find(u3.Stats.DF.Value, "Mochi") ~= nil and u3.Stats.KenMastery.Value >= 700
                if u3.Skills.KenV2.Value == true then
                    game.ReplicatedStorage.KenHaki.v2fail:Play()
                    return
                end
                if v9 == false then
                    game.ReplicatedStorage.KenHaki.fail:Play()
                    return
                end
                game.ReplicatedStorage.KenHaki.fail2:Play()
            end
            return
        end
        u5 = true
        if u4.On == false and _G.canuse == true then
            u4:Enable()
        elseif u4.On == true then
            u4:Disable()
        end
        task.wait(1)
        u5 = false
    end
end
u1.Mobile_Activate = u1.PC_Activate
return u1