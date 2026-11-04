 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local u3 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u4 = setmetatable({}, u3)
u4.__index = u4
function u4.new(_) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u1
    --]]
    local v5 = u3.new(script.Name)
    local v6 = u4
    local v7 = setmetatable(v5, v6)
    v7.Cooldowns = {
        ["FloorShock"] = false,
        ["Dash"] = false,
        ["Slam"] = false,
        ["Strike"] = false,
        ["Fist"] = false
    }
    function v7.removeBV() --[[ Line: 22 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v8 = u1.Character.HumanoidRootPart:GetChildren()
        for v9 = 1, #v8 do
            if v8[v9]:IsA("BodyVelocity") then
                v8[v9]:Destroy()
            end
        end
    end
    return v7
end
function u4.ElectroLuna(p10, p11) --[[ Line: 34 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v12 = p10.Cooldowns
    local v13 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u14 = u1.Character
    if v12.FloorShock == false and (_G.check:inspect(u14) == true and _G.StamCheck("Electro Luna") == true) then
        local v15 = u2.GetM("Electro Luna")
        local v16 = v15.cd
        if v15.stamreq and v13.Stamina.Value < v15.stamreq then
            return
        end
        if v15.statreq and _G.MeetReq(v15.statreq) == false then
            return
        end
        v12.FloorShock = true
        _G.canuse = false
        game.ReplicatedStorage.Events.StamRequest:InvokeServer("Electro Luna")
        local u17 = u14.Humanoid:LoadAnimation(script.Floor)
        u17:Play()
        u17:AdjustWeight(5)
        u14.Humanoid.WalkSpeed = 4
        task.spawn(function() --[[ Line: 57 ]]
            task.wait()
            script.grab2:Play()
        end)
        _G.PauseAnim(u17, 0.55, 2)
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 64 ]]
                --[[
                Upvalues:
                    [1] = u14
                    [2] = u17
                --]]
                u14.Humanoid.WalkSpeed = 4
                if _G.check:inspect(u14) == false then
                    u17:Stop()
                    return true
                end
                if u14:FindFirstChild(script.Name) == nil then
                    return true
                end
            end
        })
        u17:AdjustSpeed(1)
        task.wait(0.1)
        local _ = u14.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Electro Luna", {
            ["CFrame"] = u14.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)
        })
        task.wait(0.25)
        u14.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Electro Luna", v16)
        _G.fw(v16)
        v12.FloorShock = false
    end
end
function u4.ElectroDash(p18, p19) --[[ Line: 95 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v20 = p18.Cooldowns
    local v21 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u22 = u1.Character
    if v20.Dash == false and (_G.check:inspect(u22) == true and _G.StamCheck("Electro Dash") == true) then
        local v23 = u2.GetM("Electro Dash")
        local v24 = v23.cd
        if v23.stamreq and v21.Stamina.Value < v23.stamreq then
            return
        end
        if v23.statreq and _G.MeetReq(v23.statreq) == false then
            return
        end
        v20.Dash = true
        _G.canuse = false
        game.ReplicatedStorage.Events.StamRequest:InvokeServer("Electro Dash")
        local u25 = u22.Humanoid:LoadAnimation(script.Dash)
        u25:Play()
        u25:AdjustWeight(2)
        u25:AdjustSpeed(0)
        u22.Humanoid.WalkSpeed = 4
        local u26 = 0
        local u27 = tick()
        local u28 = tick()
        local function v29() --[[ Line: 124 ]]
            --[[
            Upvalues:
                [1] = u22
                [2] = u25
                [3] = u27
                [4] = u26
                [5] = u28
            --]]
            u22.Humanoid.WalkSpeed = 4
            if _G.check:inspect(u22) == false then
                u25:Stop()
                return true
            end
            if tick() - u27 >= 0.2 then
                game.ReplicatedStorage.Events.takestam:FireServer(2)
                u26 = u26 + 3
                u27 = tick()
            end
            if u22:FindFirstChild(script.Name) == nil or tick() - u28 >= 2 then
                return true
            end
        end
        p18:ChargeSkill(p19, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = v29
        })
        local v30 = u26
        u26 = math.clamp(v30, 0, 150)
        u25:AdjustSpeed(1)
        task.spawn(function() --[[ Line: 151 ]]
            game.ReplicatedStorage.Events.Skill:InvokeServer("Electro Dash")
        end)
        task.wait(0.1)
        p18.removeBV()
        local v31 = Instance.new("BodyVelocity", u22.HumanoidRootPart)
        v31.MaxForce = Vector3.new(100000, 1000, 100000)
        v31.Velocity = u22.HumanoidRootPart.CFrame.LookVector * (u26 + 75)
        local v32 = tick()
        while true do
            task.wait()
            v31.Velocity = u22.HumanoidRootPart.CFrame.LookVector * (u26 + 75)
            if _G.check:inspect(u22) == false then
                v31.MaxForce = Vector3.new()
                break
            end
            if tick() - v32 >= 0.55 then
                break
            end
        end
        _G.tween(v31, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["MaxForce"] = Vector3.new(0, 0, 0)
        })
        _G.destroy(v31, 0.5)
        u25:AdjustSpeed(2)
        task.wait(0.1)
        u22.Humanoid.WalkSpeed = 16
        u22.Humanoid.AutoRotate = true
        task.wait(0.25)
        _G.canuse = true
        _G.keysetup:cooldown("Electro Dash", v24)
        _G.fw(v24)
        v20.Dash = false
    end
end
function u4.RaijuPunishment(p33, p34) --[[ Line: 191 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v35 = p33.Cooldowns
    local v36 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u37 = u1.Character
    if v35.Slam == false and (_G.check:inspect(u37) == true and _G.StamCheck("Raiju Punishment") == true) then
        local v38 = u2.GetM("Raiju Punishment")
        local v39 = v38.cd
        if v38.stamreq and v36.Stamina.Value < v38.stamreq then
            return
        end
        if v38.statreq and _G.MeetReq(v38.statreq) == false then
            return
        end
        v35.Slam = true
        _G.canuse = false
        local u40 = u37.Humanoid:LoadAnimation(script.Slam)
        u40:Play()
        u40:AdjustWeight(3)
        u40:AdjustSpeed(0)
        u37.Humanoid.WalkSpeed = 4
        _G.PauseAnim(u40, 0.4, 2)
        tick()
        local u41 = tick()
        p33:ChargeSkill(p34, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 222 ]]
                --[[
                Upvalues:
                    [1] = u37
                    [2] = u40
                    [3] = u41
                --]]
                u37.Humanoid.WalkSpeed = 4
                if _G.check:inspect(u37) == false then
                    u40:Stop()
                    return true
                end
                if u37:FindFirstChild(script.Name) == nil or tick() - u41 >= 2 then
                    return true
                end
            end
        })
        math.clamp(0, 0, 150)
        u40:AdjustSpeed(1)
        u37.Humanoid.WalkSpeed = 16
        p33.removeBV()
        if _G.check:inspect(u37) == false then
            u40:Stop()
        else
            local v42 = Instance.new("BodyVelocity", u37.HumanoidRootPart)
            v42.Name = "geppo"
            v42.MaxForce = Vector3.new(1000000000, 1000000000, 1000000000)
            v42.Velocity = u37.HumanoidRootPart.CFrame.upVector * 100
            v42.P = 4324234234
            _G.destroy(v42, 0.25)
            local u43 = nil
            task.spawn(function() --[[ Line: 257 ]]
                --[[
                Upvalues:
                    [1] = u43
                --]]
                u43 = game.ReplicatedStorage.Events.Skill:InvokeServer("Raiju Punishment")
            end)
            task.wait(0.7999999999999999)
            local v44 = u37.HumanoidRootPart.Position
            local v45 = Ray.new(v44, CFrame.new(v44).upVector * -500)
            local v46, v47 = _G.raycastWhitelist(v45, { workspace.Islands, workspace.Env, workspace.Ships })
            u37.HumanoidRootPart.Anchored = true
            if v46 then
                local v48 = (v44 - v47).Magnitude
                local u49 = u37.HumanoidRootPart.CFrame * CFrame.new(0, -v48, 0) * CFrame.new(0, u37.Humanoid.HipHeight * 1.25, 0)
                u37.HumanoidRootPart.CFrame = u49
                task.spawn(function() --[[ Line: 272 ]]
                    --[[
                    Upvalues:
                        [1] = u43
                        [2] = u49
                    --]]
                    repeat
                        game["Run Service"].RenderStepped:Wait()
                    until u43 ~= nil
                    u43:FireServer({
                        ["cf"] = u49 * CFrame.new(0, 0, -2),
                        ["endCF"] = u49
                    })
                end)
            else
                u40:Stop()
            end
        end
        task.wait(0.25)
        u37.HumanoidRootPart.Anchored = false
        u37.Humanoid.AutoRotate = true
        _G.canuse = true
        _G.keysetup:cooldown("Raiju Punishment", v39)
        _G.fw(v39)
        v35.Slam = false
    end
end
function u4.ElectroRain(p50, p51) --[[ Line: 293 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v52 = p50.Cooldowns
    local v53 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u54 = u1.Character
    if v52.Strike == false and (_G.check:inspect(u54) == true and _G.StamCheck("Electro Rain") == true) then
        local v55 = u2.GetM("Electro Rain")
        local v56 = v55.cd
        if v55.stamreq and v53.Stamina.Value < v55.stamreq then
            return
        end
        if v55.statreq and _G.MeetReq(v55.statreq) == false then
            return
        end
        v52.Strike = true
        _G.canuse = false
        local u57 = u54.Humanoid:LoadAnimation(script.strike)
        u57:Play()
        u57:AdjustWeight(5)
        u57:AdjustSpeed(0)
        u54.Humanoid.WalkSpeed = 4
        _G.PauseAnim(u57, 0.35, 1)
        tick()
        local u58 = tick()
        p50:ChargeSkill(p51, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 323 ]]
                --[[
                Upvalues:
                    [1] = u54
                    [2] = u57
                    [3] = u58
                --]]
                u54.Humanoid.WalkSpeed = 4
                if _G.check:inspect(u54) == false then
                    u57:Stop()
                    return true
                end
                if u54:FindFirstChild(script.Name) == nil or tick() - u58 >= 2 then
                    return true
                end
            end
        })
        math.clamp(0, 0, 150)
        u57:AdjustSpeed(1)
        u54.Humanoid.WalkSpeed = 16
        p50.removeBV()
        local v59 = Instance.new("BodyVelocity", u54.HumanoidRootPart)
        v59.Name = "geppo"
        v59.MaxForce = Vector3.new(1000000000, 1000000000, 1000000000)
        v59.Velocity = u54.HumanoidRootPart.CFrame.upVector * 75
        v59.P = 4324234234
        _G.destroy(v59, 0.25)
        local u60 = nil
        task.spawn(function() --[[ Line: 356 ]]
            --[[
            Upvalues:
                [1] = u60
            --]]
            u60 = game.ReplicatedStorage.Events.Skill:InvokeServer("Electro Rain")
        end)
        task.wait(0.6)
        local v61 = Instance.new("BodyVelocity", u54.HumanoidRootPart)
        v61.Name = "geppo"
        v61.MaxForce = Vector3.new(1000000000, 1000000000, 1000000000)
        u54.HumanoidRootPart.Anchored = true
        task.spawn(function() --[[ Line: 364 ]]
            --[[
            Upvalues:
                [1] = u60
                [2] = u54
            --]]
            repeat
                game["Run Service"].RenderStepped:Wait()
            until u60 ~= nil
            u60:FireServer({
                ["cf"] = u54.HumanoidRootPart.CFrame * CFrame.new(0, -2, -2),
                ["endCF"] = u54.HumanoidRootPart.CFrame
            })
        end)
        task.wait(0.35)
        v61.MaxForce = Vector3.new(0, 0, 0)
        _G.destroy(v61, 0.25)
        u54.HumanoidRootPart.Anchored = false
        u54.Humanoid.AutoRotate = true
        _G.canuse = true
        _G.keysetup:cooldown("Electro Rain", v56)
        _G.fw(v56)
        v52.Strike = false
    end
end
function u4.ElectroFist(p62, _) --[[ Line: 384 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v63 = p62.Cooldowns
    local v64 = game.ReplicatedStorage["Stats" .. u1.Name]
    local v65 = u1.Character
    if v63.Fist == false and (_G.check:inspect(v65) == true and _G.StamCheck("Electro Fist") == true) then
        if v65:FindFirstChild("ElecFist") then
            return
        end
        local v66 = u2.GetM("Electro Fist")
        local v67 = v66.cd
        if v66.stamreq and v64.Stamina.Value < v66.stamreq then
            return
        end
        if v66.statreq and _G.MeetReq(v66.statreq) == false then
            return
        end
        v63.Fist = true
        _G.canuse = false
        local v68 = v65.Humanoid:LoadAnimation(script.fist)
        v68:Play()
        v68:AdjustWeight(2)
        v68:AdjustSpeed(1)
        task.wait(0.7)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Electro Fist")
        _G.canuse = true
        _G.keysetup:cooldown("Electro Fist", v67)
        _G.fw(v67)
        v63.Fist = false
    end
end
return u4