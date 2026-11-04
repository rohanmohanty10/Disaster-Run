 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u5 = setmetatable({}, u4)
u5.__index = u5
function u5.new(_) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    local v6 = u4.new(script.Name)
    local v7 = u5
    local v8 = setmetatable(v6, v7)
    v8.Cooldowns = {
        ["flight"] = false,
        ["cyclone"] = false,
        ["throw"] = false
    }
    return v8
end
function u5.SpinningFlight(u9, p10) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = u9.Cooldowns
    local u12 = u1.Character
    local u13 = u2["Stats" .. u1.Name]
    if _G.grounded == false and (v11.flight == false and (_G.check:inspect(u12) == true and _G.StamCheck("Spinning Flight") == true)) then
        local v14 = u3.GetM("Spinning Flight")
        local v15 = v14.cd
        if _G.StamCheck("Spinning Flight") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        v11.flight = true
        _G.canuse = false
        local v16 = u12.Humanoid:LoadAnimation(script.flywindup)
        v16:Play()
        v16:AdjustWeight(2)
        local u17 = Instance.new("BodyGyro", u12.HumanoidRootPart)
        u17.MaxTorque = Vector3.new(1000000, 1000000, 1000000)
        u17.CFrame = CFrame.new(u12.HumanoidRootPart.Position, u9:GetMouseCFrame().Position)
        u17.P = 10000000
        u17.D = 15000
        local u18 = Instance.new("BodyVelocity", u12.LowerTorso)
        u18.Velocity = u17.CFrame.LookVector * 25
        u18.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
        u12.Humanoid.PlatformStand = true
        local v19 = game.ReplicatedStorage.Events.Skill:InvokeServer("Spinning Flight", {
            ["cf"] = u9:GetMouseCFrame()
        })
        task.wait(0.5)
        v16:Stop()
        local u20 = u12.Humanoid:LoadAnimation(script.flyloop)
        u20:Play()
        u20:AdjustWeight(2)
        local u21 = tick()
        u9:ToggleSkill(p10, {
            ["Key"] = Enum.KeyCode.E,
            ["IgnoreInstantCastSetting"] = true,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 71 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u20
                    [3] = u17
                    [4] = u9
                    [5] = u18
                --]]
                local v22 = u12.Humanoid.Health / u12.Humanoid.MaxHealth
                u20:AdjustSpeed(0.5 + v22)
                u17.CFrame = CFrame.new(u12.HumanoidRootPart.Position, u9:GetMousePosition())
                u18.Velocity = u17.CFrame.LookVector * (50 * v22)
                u12.Humanoid.PlatformStand = true
            end,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 78 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u12
                    [3] = u13
                --]]
                return (tick() - u21 >= 10 or (u12:FindFirstChild(script.Name) == false or (u12.Parent == nil or u12.Parent ~= workspace.PlayerCharacters))) and true or u13.Stamina.Value <= 0
            end
        })
        if v19 then
            v19:FireServer()
        end
        u20:Stop()
        u17:Destroy()
        u18:Destroy()
        u12.Humanoid.PlatformStand = false
        _G.canuse = true
        _G.keysetup:cooldown("Spinning Flight", v15)
        _G.fw(v15)
        v11.flight = false
    end
end
function u5.SpinningCyclone(p23, p24) --[[ Line: 99 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v25 = p23.Cooldowns
    local u26 = u1.Character
    local u27 = u2["Stats" .. u1.Name]
    if v25.cyclone == false and (_G.check:inspect(u26) == true and _G.StamCheck("Spinning Cyclone") == true) then
        local v28 = u3.GetM("Spinning Cyclone")
        local v29 = v28.cd
        if _G.StamCheck("Spinning Cyclone") == false then
            return
        end
        if v28.statreq and _G.MeetReq(v28.statreq) == false then
            return
        end
        v25.cyclone = true
        _G.canuse = false
        local v30 = u26.Humanoid:LoadAnimation(script.spinwindup)
        v30:Play()
        v30:AdjustWeight(2)
        local u31 = Instance.new("BodyVelocity", u26.LowerTorso)
        u31.Velocity = u26.HumanoidRootPart.CFrame.LookVector * 5
        u31.MaxForce = Vector3.new(1000000, 10000, 1000000)
        task.wait(0.5)
        v30:Stop()
        local v32 = u26.Humanoid:LoadAnimation(script.spinloop)
        v32:Play()
        v32:AdjustWeight(2)
        local u33 = game.ReplicatedStorage.Events.Skill:InvokeServer("Spinning Cyclone", {
            ["cf"] = p23:GetMouseCFrame()
        })
        local u34 = tick()
        p23:ToggleSkill(p24, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 137 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u31
                --]]
                local v35 = u26.HumanoidRootPart.CFrame.LookVector * 25
                local v36 = u31
                local v37 = v35.X
                local v38 = v35.Z
                v36.Velocity = Vector3.new(v37, -5, v38)
            end,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 143 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u26
                    [3] = u34
                    [4] = u27
                --]]
                return u33 == nil and true or (_G.check:inspect(u26) == false and true or ((tick() - u34 >= 3 or (u26:FindFirstChild(script.Name) == false or (u26.Parent == nil or u26.Parent ~= workspace.PlayerCharacters))) and true or u27.Stamina.Value <= 0))
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        if u33 then
            u33:FireServer()
        end
        v32:Stop()
        u31:Destroy()
        _G.canuse = true
        _G.keysetup:cooldown("Spinning Cyclone", v29)
        _G.fw(v29)
        v25.cyclone = false
    end
end
function u5.TwisterThrow(p39, p40) --[[ Line: 171 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v41 = p39.Cooldowns
    local u42 = u1.Character
    local u43 = u2["Stats" .. u1.Name]
    if v41.throw == false and (_G.check:inspect(u42) == true and _G.StamCheck("Twister Throw") == true) then
        local v44 = u3.GetM("Twister Throw")
        local v45 = v44.cd
        if _G.StamCheck("Twister Throw") == false then
            return
        end
        if v44.statreq and _G.MeetReq(v44.statreq) == false then
            return
        end
        v41.throw = true
        _G.canuse = false
        local v46 = u42.Humanoid:LoadAnimation(script.twisterthrow)
        v46:Play()
        v46:AdjustWeight(2)
        u42.Humanoid.WalkSpeed = 4
        _G.PauseAnim(v46, 0.35, 1)
        local u47 = tick()
        p39:ChargeSkill(p40, {
            ["Button"] = p40,
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 198 ]]
                --[[
                Upvalues:
                    [1] = u42
                --]]
                u42.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 202 ]]
                --[[
                Upvalues:
                    [1] = u47
                    [2] = u42
                    [3] = u43
                --]]
                return (tick() - u47 >= 10 or (u42:FindFirstChild(script.Name) == false or (u42.Parent == nil or u42.Parent ~= workspace.PlayerCharacters))) and true or u43.Stamina.Value <= 0
            end
        })
        v46:AdjustSpeed(1)
        task.wait(0.05)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Twister Throw", {
            ["cf"] = u42.HumanoidRootPart.CFrame
        })
        task.wait(0.2)
        u42.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Twister Throw", v45)
        _G.fw(v45)
        v41.throw = false
    end
end
return u5