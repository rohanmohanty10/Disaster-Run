 

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
        ["sweep"] = false
    }
    return v9
end
local u10 = "First"
local u11 = false
function u6.GhostBarrage(p12, p13) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v14 = p12.Cooldowns
    local u15 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v14.spin == false and _G.check:inspect(u15) == true then
        local v16 = u3.GetM("Ghost Barrage")
        local v17 = v16.cd
        if _G.StamCheck("Ghost Barrage") == false then
            return
        end
        if v16.statreq and _G.MeetReq(v16.statreq) == false then
            return
        end
        v14.spin = true
        _G.canuse = false
        local u18 = tick()
        local v19 = u15.Humanoid:LoadAnimation(script.floorLand)
        v19:Play()
        v19:AdjustWeight(5)
        u15.Humanoid.WalkSpeed = 4
        _G.PauseAnim(v19, 0.4, 1)
        p12:ChargeSkill(p13, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 59 ]]
                --[[
                Upvalues:
                    [1] = u15
                --]]
                u15.Humanoid.WalkSpeed = 4
                if _G.check:inspect(u15) == false then
                    return true
                end
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 66 ]]
                --[[
                Upvalues:
                    [1] = u15
                    [2] = u18
                --]]
                if u15:FindFirstChild(script.Name) == nil or tick() - u18 >= 10 then
                    return true
                end
            end
        })
        v19:AdjustSpeed(1)
        u15.HumanoidRootPart.Anchored = true
        task.wait(0.2)
        local v20 = game.ReplicatedStorage.Events.Skill:InvokeServer("Ghost Barrage", { u15.PrimaryPart.CFrame })
        if v20 == nil or v20 and v20 <= 0 then
            task.wait(0.95)
        else
            task.wait(1.6)
        end
        u15.HumanoidRootPart.Anchored = false
        u15.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Ghost Barrage", v17)
        _G.fw(v17)
        v14.spin = false
    end
end
function u6.SpiritPierce(u21, u22) --[[ Line: 99 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u11
        [5] = u10
    --]]
    local v23 = u21.Cooldowns
    local u24 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v23.sweep == false and _G.check:inspect(u24) == true then
        local v25 = u3.GetM("Spirit Pierce")
        local v26 = v25.cd
        if _G.StamCheck("Spirit Pierce") == false then
            return
        end
        if v25.statreq and _G.MeetReq(v25.statreq) == false then
            return
        end
        v23.sweep = true
        _G.canuse = false
        u24.Humanoid.AutoRotate = false
        local v27 = Instance.new("BodyVelocity")
        v27.MaxForce = Vector3.new(100000, 100000, 100000)
        v27.P = 500000
        v27.Parent = u24.HumanoidRootPart
        v27.Velocity = u24.HumanoidRootPart.CFrame.LookVector * 75
        _G.destroy(v27, 0.25)
        u11 = false
        local v28 = u24.Humanoid:LoadAnimation(script["Slash" .. u10])
        v28:Play()
        v28:AdjustWeight(5)
        task.wait(0.4)
        v27.Velocity = Vector3.new()
        local u29 = game.ReplicatedStorage.Events.Skill:InvokeServer("Spirit Pierce", { u24.PrimaryPart.CFrame, u10 })
        task.spawn(function() --[[ Line: 135 ]]
            --[[
            Upvalues:
                [1] = u21
                [2] = u22
                [3] = u29
                [4] = u24
                [5] = u10
                [6] = u11
            --]]
            u21:DoubleCastSkill(u22, {
                ["Key"] = Enum.KeyCode.E,
                ["SkipTap"] = true,
                ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 139 ]]
                    --[[
                    Upvalues:
                        [1] = u29
                        [2] = u24
                        [3] = u10
                        [4] = u11
                    --]]
                    if u29 then
                        local v30 = u24.Humanoid:LoadAnimation(script["Slash" .. u10])
                        v30:Play()
                        v30:AdjustWeight(5)
                        local v31 = Instance.new("BodyVelocity")
                        v31.MaxForce = Vector3.new(100000, 100000, 100000)
                        v31.P = 500000
                        v31.Parent = u24.HumanoidRootPart
                        v31.Velocity = u24.HumanoidRootPart.CFrame.LookVector * 75
                        _G.destroy(v31, 0.25)
                        task.wait(0.1)
                        v31.Velocity = Vector3.new()
                        u29:FireServer({ u24.PrimaryPart.CFrame, u10 })
                        u10 = "First"
                        u11 = true
                    end
                end,
                ["PassFunction"] = function() --[[ Name: PassFunction, Line 158 ]]
                    --[[
                    Upvalues:
                        [1] = u24
                    --]]
                    local v32 = u24:FindFirstChild(script.Name)
                    if v32 then
                        if _G.check:inspect(u24) == true then
                            v32 = _G.canuse == true
                        else
                            v32 = false
                        end
                    end
                    return v32
                end
            })
        end)
        task.wait(0.5)
        if u10 == "First" then
            u10 = "Second"
        else
            u10 = "First"
        end
        u24.Humanoid.AutoRotate = true
        _G.canuse = true
        repeat
            task.wait(0.1)
        until u11 == true or u29 == nil
        _G.keysetup:cooldown("Spirit Pierce", v26)
        _G.fw(v26)
        v23.sweep = false
    end
end
return u6