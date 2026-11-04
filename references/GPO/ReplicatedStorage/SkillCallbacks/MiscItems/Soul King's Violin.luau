 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local u3 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u4 = setmetatable({}, u3)
u4.__index = u4
function u4.new(_) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    local v5 = u3.new(script.Name)
    local v6 = u4
    local v7 = setmetatable(v5, v6)
    v7.Cooldowns = {
        ["tune"] = false
    }
    return v7
end
function u4.FreezingTune(p8, _) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v9 = p8.Cooldowns
    local v10 = u1.Character
    if v9.tune == false and (_G.check:inspect(v10) == true and _G.StamCheck("Jack in the Box") == true) then
        local v11 = u2.GetM("Freezing Tune")
        local v12 = v11.cd
        if _G.StamCheck("Freezing Tune") == false then
            return
        end
        if v11.statreq and _G.MeetReq(v11.statreq) == false then
            return
        end
        v9.tune = true
        _G.canuse = false
        v10.Humanoid.WalkSpeed = 4
        local v13 = v10.Humanoid:LoadAnimation(script.play)
        v13:Play()
        v13:AdjustWeight(2)
        v13:AdjustSpeed(2)
        task.wait(0.3)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Freezing Tune", v10.PrimaryPart.CFrame)
        local v14 = tick()
        while true do
            v10.Humanoid.WalkSpeed = 4
            if _G.check:inspect(v10) == false then
                v13:Stop()
                break
            end
            _G.canuse = false
            task.wait()
            if tick() - v14 >= 1.75 then
                break
            end
        end
        v10.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Freezing Tune", v12)
        _G.fw(v12)
        v9.tune = false
    end
end
return u4