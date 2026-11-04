 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
local v5 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
v5:GetControls()
local u6 = setmetatable({}, u4)
u6.__index = u6
function u6.new(_) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u6
    --]]
    local v7 = u4.new(script.Name)
    local v8 = u6
    local v9 = setmetatable(v7, v8)
    v9.Cooldowns = {
        ["spin"] = false,
        ["beat"] = false
    }
    return v9
end
function u6.PipeRush(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local u14 = u2["Stats" .. u1.Name]
    if v12.spin == false and _G.check:inspect(u13) == true then
        local v15 = u3.GetM("Pipe Rush")
        local v16 = v15.cd
        if _G.StamCheck("Pipe Rush") == false then
            return
        end
        if v15.statreq and _G.MeetReq(v15.statreq) == false then
            return
        end
        local v17 = u13.Humanoid.Animator:LoadAnimation(script.spin)
        v17:Play()
        v17:AdjustWeight(2)
        v12.spin = true
        _G.canuse = false
        u13.Humanoid.WalkSpeed = 4
        local v18 = game.ReplicatedStorage.Events.Skill:InvokeServer("Pipe Rush")
        _G.PauseAnim(v17, 0.2, 1.5)
        local u19 = tick()
        local function v20() --[[ Line: 61 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u19
                [3] = u14
            --]]
            if u13:FindFirstChild(script.Name) == nil or (tick() - u19 >= 5 or (u13:FindFirstChild("Stun") or u14.Stamina.Value <= 0)) then
                return true
            end
        end
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 56 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                u13.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = v20
        })
        v17:AdjustSpeed(1)
        task.wait(0.2)
        local v21 = Instance.new("BodyVelocity")
        v21.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
        v21.Velocity = (u13.PrimaryPart.CFrame.UpVector * 0.2 + u13.PrimaryPart.CFrame.LookVector * 1) * 60
        v21.Name = "geppo"
        v21.Parent = u13.PrimaryPart
        _G.destroy(v21, 0.23)
        u13.Humanoid.WalkSpeed = 16
        if v18 then
            v18:FireServer(u13.PrimaryPart.CFrame)
            u19 = tick()
            repeat
                task.wait()
                v18:FireServer("newCF", u13.PrimaryPart.CFrame)
            until tick() - u19 >= 1
        end
        _G.keysetup:cooldown("Pipe Rush", v16)
        _G.canuse = true
        _G.fw(v16)
        v12.spin = false
    end
end
function u6.PipeBeatdown(p22, p23) --[[ Line: 98 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v24 = p22.Cooldowns
    local u25 = u1.Character
    local u26 = u2["Stats" .. u1.Name]
    if v24.beat == false and _G.check:inspect(u25) == true then
        local v27 = u3.GetM("Pipe Beatdown")
        local v28 = v27.cd
        if _G.StamCheck("Pipe Beatdown") == false then
            return
        end
        if v27.statreq and _G.MeetReq(v27.statreq) == false then
            return
        end
        local v29 = u25.Humanoid.Animator:LoadAnimation(script.wind)
        v29:Play()
        v29:AdjustWeight(2)
        v24.beat = true
        _G.canuse = false
        u25.Humanoid.WalkSpeed = 4
        local v30 = game.ReplicatedStorage.Events.Skill:InvokeServer("Pipe Beatdown")
        _G.PauseAnim(v29, 0.2, 1)
        local u31 = tick()
        p22:ChargeSkill(p23, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 126 ]]
                --[[
                Upvalues:
                    [1] = u25
                --]]
                u25.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 130 ]]
                --[[
                Upvalues:
                    [1] = u25
                    [2] = u31
                    [3] = u26
                --]]
                if u25:FindFirstChild(script.Name) == nil or (tick() - u31 >= 2 or (u25:FindFirstChild("Stun") or u26.Stamina.Value <= 0)) then
                    return true
                end
            end
        })
        v29:AdjustSpeed(1.25)
        task.wait(0.22499999999999998)
        u25.Humanoid.WalkSpeed = 16
        if v30 then
            v30:FireServer(u25.PrimaryPart.CFrame)
        end
        _G.keysetup:cooldown("Pipe Beatdown", v28)
        task.wait(0.5)
        _G.canuse = true
        _G.fw(v28)
        v24.beat = false
    end
end
return u6