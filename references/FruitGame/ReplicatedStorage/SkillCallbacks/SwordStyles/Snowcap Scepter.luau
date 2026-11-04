 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u5 = setmetatable({}, u4)
u5.__index = u5
function u5.new(_) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    local v6 = u4.new(script.Name)
    local v7 = u5
    local v8 = setmetatable(v6, v7)
    v8.Cooldowns = {
        ["snowball"] = false,
        ["storm"] = false
    }
    v8.CurrentBall = 0
    v8.doingSlash = false
    return v8
end
function u5.ScepterSnowball(p9, _) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v10 = p9.Cooldowns
    local v11 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v10.snowball == false and (_G.check:inspect(v11) == true and _G.StamCheck("Scepter Snowball") == true) then
        local v12 = u3.GetM("Scepter Snowball")
        local v13 = v12.cd
        if _G.StamCheck("Scepter Snowball") == false then
            return
        end
        if v12.statreq and _G.MeetReq(v12.statreq) == false then
            return
        end
        v10.snowball = true
        _G.canuse = false
        local v14 = game.ReplicatedStorage.Events.Skill:InvokeServer("Scepter Snowball")
        local v15 = v11.Humanoid:LoadAnimation(script.projectileSkill)
        v15:Play(0)
        v15:AdjustSpeed(2)
        v15:AdjustWeight(2)
        task.wait(0.2)
        if v14 then
            v14:FireServer(v11.PrimaryPart.CFrame, p9:GetMouseCFrame())
        end
        p9.CurrentBall = p9.CurrentBall + 1
        task.wait(0.1)
        if p9.CurrentBall >= 3 then
            p9.CurrentBall = 0
            v13 = 10
        end
        _G.keysetup:cooldown("Scepter Snowball", v13)
        _G.canuse = true
        _G.fw(v13)
        v10.snowball = false
    end
end
function u5.ScepterStorm(p16, _) --[[ Line: 76 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v17 = p16.Cooldowns
    local v18 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v17.storm == false and (_G.check:inspect(v18) == true and _G.StamCheck("Scepter Storm") == true) then
        local v19 = u3.GetM("Scepter Storm")
        local v20 = v19.cd
        if _G.StamCheck("Scepter Storm") == false then
            return
        end
        if v19.statreq and _G.MeetReq(v19.statreq) == false then
            return
        end
        v17.storm = true
        _G.canuse = false
        local v21 = game.ReplicatedStorage.Events.Skill:InvokeServer("Scepter Storm", v18.PrimaryPart.CFrame)
        local v22 = v18.Humanoid:LoadAnimation(script.startUp)
        v22:Play()
        task.wait(0.4)
        if v21 then
            v22:Stop()
            local v23 = v18.Humanoid:LoadAnimation(script.spinAnim)
            v23:Play()
            v21:InvokeServer(v18.PrimaryPart.CFrame)
            v23:Stop()
        else
            v22:Stop()
        end
        _G.keysetup:cooldown("Scepter Storm", v20)
        _G.canuse = true
        _G.fw(v20)
        v17.storm = false
    end
end
return u5