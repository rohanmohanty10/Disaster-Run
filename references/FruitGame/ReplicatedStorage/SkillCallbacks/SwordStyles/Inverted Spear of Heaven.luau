 

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
        ["counter"] = false,
        ["reel"] = false
    }
    return v7
end
function u4.MassacreCounter(p8, _) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v9 = p8.Cooldowns
    local v10 = u1.Character
    if v9.counter == false and _G.check:inspect(v10) == true then
        local v11 = u2.GetM("Massacre Counter")
        local v12 = v11.cd
        if _G.StamCheck("Massacre Counter") == false then
            return
        end
        if v11.statreq and _G.MeetReq(v11.statreq) == false then
            return
        end
        v9.counter = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Massacre Counter")
        task.wait(0.85)
        _G.canuse = true
        _G.keysetup:cooldown("Massacre Counter", v12)
        _G.fw(v12)
        v9.counter = false
    end
end
function u4.ChainReel(u13, p14) --[[ Line: 62 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local u15 = u1.Character
    local v16 = u13.Cooldowns
    if v16.reel == false and _G.check:inspect(u15) == true then
        local v17 = u2.GetM("Chain Reel")
        local v18 = v17.cd
        if _G.StamCheck("Chain Reel") == false then
            return
        end
        if v17.statreq and _G.MeetReq(v17.statreq) == false then
            return
        end
        local v19 = u15.Humanoid.Animator:LoadAnimation(script.charge)
        v19:Play()
        v19:AdjustWeight(2)
        v16.reel = true
        _G.FaceMouse = true
        _G.canuse = false
        local v20 = game.ReplicatedStorage.Events.Skill:InvokeServer("Chain Reel")
        local u21 = tick()
        u13:ChargeSkill(p14, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 89 ]]
                --[[
                Upvalues:
                    [1] = u15
                --]]
                u15.Humanoid.AutoRotate = false
            end,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 93 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u13
                    [3] = u21
                --]]
                return _G.check:inspect(u15) == false and true or (u13.Tool.Parent ~= u15 and true or tick() - u21 >= 4)
            end,
            ["HoldDuration"] = 0.25
        })
        v19:Stop()
        local v22 = u15.Humanoid.Animator:LoadAnimation(script.throw)
        v22:Play()
        v22:AdjustWeight(2)
        _G.FaceMouse = false
        u15.HumanoidRootPart.Anchored = true
        u15.Humanoid.AutoRotate = false
        u15:PivotTo(CFrame.new(u15.PrimaryPart.Position, u13:GetMousePosition()))
        if v20 then
            v20:FireServer(u13:GetMouseCFrame())
        end
        task.wait(0.5)
        u15.Humanoid.AutoRotate = true
        u15.HumanoidRootPart.Anchored = false
        u15.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Chain Reel", v18)
        _G.fw(v18)
        v16.reel = false
    end
end
return u4