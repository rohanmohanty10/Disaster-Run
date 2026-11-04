 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("TweenService")
local u4 = require(game.ReplicatedStorage.Modules.Skills)
local u5 = require(script.Parent.Parent.MobileBase)
local v6 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
v6:GetControls()
local u7 = setmetatable({}, u5)
u7.__index = u7
function u7.new(_) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u7
        [3] = u1
    --]]
    local v8 = u5.new(script.Name)
    local v9 = u7
    local v10 = setmetatable(v8, v9)
    v10.Cooldowns = {
        ["smash"] = false,
        ["float"] = false
    }
    function v10.PlayAnimation(p11) --[[ Line: 26 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v12 = u1.Character
        local v13 = v12.Humanoid
        local v14 = v12:FindFirstChild(script.Name .. "Sword")
        local u15 = {}
        table.insert(u15, v13:LoadAnimation(p11))
        local v16 = v14 and v14:FindFirstChild("AnimationController")
        if v16 then
            table.insert(u15, v16:LoadAnimation(p11))
        end
        local v20 = {
            ["Stop"] = function(_) --[[ Name: Stop, Line 43 ]]
                --[[
                Upvalues:
                    [1] = u15
                --]]
                for v17 = 1, #u15 do
                    u15[v17]:Stop()
                end
            end,
            ["PauseAnim"] = function(_, ...) --[[ Name: PauseAnim, Line 49 ]]
                --[[
                Upvalues:
                    [1] = u15
                --]]
                for v18 = 1, #u15 do
                    _G.PauseAnim(u15[v18], ...)
                end
            end,
            ["AdjustSpeed"] = function(_, ...) --[[ Name: AdjustSpeed, Line 55 ]]
                --[[
                Upvalues:
                    [1] = u15
                --]]
                for v19 = 1, #u15 do
                    u15[v19]:AdjustSpeed(...)
                end
            end
        }
        for v21 = 1, #u15 do
            u15[v21]:Play()
        end
        return v20
    end
    return v10
end
function u7.UmbrellaThrust(p22, p23) --[[ Line: 71 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
    --]]
    local v24 = p22.Cooldowns
    local u25 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v24.smash == false and _G.check:inspect(u25) == true then
        local v26 = u4.GetM("Umbrella Thrust")
        local v27 = v26.cd
        if _G.StamCheck("Umbrella Thrust") == false then
            return
        end
        if v26.statreq and _G.MeetReq(v26.statreq) == false then
            return
        end
        _G.canuse = false
        v24.smash = true
        local v28 = game.ReplicatedStorage.Events.Skill:InvokeServer("Umbrella Thrust")
        local v29 = p22.PlayAnimation(script.thrust)
        v29:PauseAnim(0.5, 2)
        p22:ChargeSkill(p23, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 100 ]]
                --[[
                Upvalues:
                    [1] = u25
                --]]
                u25.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 109 ]]
                --[[
                Upvalues:
                    [1] = u25
                --]]
                if u25:FindFirstChild(script.Name) == nil then
                    return true
                end
            end
        })
        v29:AdjustSpeed(1)
        u25.Humanoid.WalkSpeed = 0
        if v28 then
            v28:InvokeServer(u25.HumanoidRootPart.CFrame)
        end
        v29:Stop()
        u25.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Umbrella Thrust", v27)
        _G.fw(v27)
        v24.smash = false
    end
end
function u7.UmbrellaFloat(p30, p31) --[[ Line: 139 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
        [4] = u3
    --]]
    local v32 = p30.Cooldowns
    local u33 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v32.float == false and _G.check:inspect(u33) == true then
        local v34 = u4.GetM("Umbrella Float")
        local v35 = v34.cd
        if _G.StamCheck("Umbrella Float") == false then
            return
        end
        if v34.statreq and _G.MeetReq(v34.statreq) == false then
            return
        end
        _G.canuse = false
        v32.float = true
        tick()
        local v36 = p30.PlayAnimation(script.floatStartup)
        local v37 = u33.PrimaryPart
        local v38 = game.Workspace.Gravity
        local v39 = Vector3.new(0, v38, 0) * v37.AssemblyMass
        if v39 ~= v39 then
            local v40 = game.Workspace.Gravity
            local _ = Vector3.new(0, v40, 0) * 20
        end
        local u41 = nil
        task.spawn(function() --[[ Line: 171 ]]
            --[[
            Upvalues:
                [1] = u41
            --]]
            u41 = game.ReplicatedStorage.Events.Skill:InvokeServer("Umbrella Float")
        end)
        local u42 = Instance.new("BodyVelocity")
        u42.MaxForce = Vector3.new(0, 100000000000, 0)
        u42.Name = "geppo"
        u42.Parent = u33.PrimaryPart
        u42.Velocity = Vector3.new(0, 5, 0)
        local v43 = script.LinearVelocity:Clone()
        v43.Attachment0 = v37:FindFirstChild("RootRigAttachment")
        v43.Parent = v37
        v43.VectorVelocity = Vector3.new(0, 2, 0)
        local v44 = u3
        local v45 = TweenInfo.new(0.48000000000000004, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v46 = {}
        local v47 = _G.ScaleWithHPChar(u33, 50)
        v46.VectorVelocity = Vector3.new(0, v47, 0)
        v44:Create(v43, v45, v46):Play()
        task.delay(0.537, function() --[[ Line: 188 ]]
            --[[
            Upvalues:
                [1] = u42
            --]]
            u42.MaxForce = Vector3.new()
        end)
        task.wait(0.437)
        local _ = u33.Humanoid
        local v48 = u33.PrimaryPart
        v48.AssemblyLinearVelocity = v48.AssemblyLinearVelocity + Vector3.new(0, 50, 0)
        task.wait(0.48000000000000004)
        v36:Stop()
        local u49 = tick()
        local u50 = p30.PlayAnimation(script.floatLoop)
        p30:ChargeSkill(p31, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function(_) --[[ Name: checkFunction, Line 205 ]]
                --[[
                Upvalues:
                    [1] = u33
                --]]
                u33.Humanoid.WalkSpeed = 35
                if u33.PrimaryPart.AssemblyLinearVelocity.Y <= 2 then
                    local v51 = u33.PrimaryPart
                    v51.AssemblyLinearVelocity = v51.AssemblyLinearVelocity + Vector3.new(0, 2, 0)
                end
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 215 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u49
                    [3] = u50
                --]]
                if u33:FindFirstChild(script.Name) == nil then
                    return true
                end
                if tick() - u49 >= 4 then
                    return true
                end
                if _G.check:inspect(u33) == false then
                    u50:Stop()
                    return true
                end
            end
        })
        u42:Destroy()
        u50:Stop()
        v43:Destroy()
        if u41 then
            u41:InvokeServer()
        end
        u33.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Umbrella Float", v35)
        _G.fw(v35)
        v32.float = false
    end
end
return u7