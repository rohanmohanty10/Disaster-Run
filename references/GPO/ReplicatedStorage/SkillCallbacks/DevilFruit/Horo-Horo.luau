 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
local v5 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
game:GetService("UserInputService")
u1:GetMouse()
local u6 = v5:GetControls()
local u7 = setmetatable({}, u4)
u7.__index = u7
function u7.new(_) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u7
        [3] = u1
    --]]
    local v8 = u4.new(script.Name)
    local v9 = u7
    local u10 = setmetatable(v8, v9)
    u10.Cooldowns = {
        ["negitive"] = false,
        ["kami"] = false,
        ["snap"] = false,
        ["mini"] = false,
        ["fly"] = false,
        ["depressSnap"] = false
    }
    task.spawn(function() --[[ Line: 25 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u1
        --]]
        u10.Tool = u1.Character:WaitForChild("Horo-Horo") or u1.Backpack:WaitForChild("Horo-Horo")
    end)
    u10.CurrentSwipe = 1
    return u10
end
local u11 = {}
function u7.NegativeHollow(u12, p13) --[[ Line: 53 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v14 = u12.Cooldowns
    local u15 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v14.negitive == false and (_G.check:inspect(u15) == true and _G.StamCheck("Negative Hollow") == true) then
        local v16 = u3.GetM("Negative Hollow")
        local v17 = v16.cd
        if _G.StamCheck("Negative Hollow") == false then
            return
        end
        if v16.statreq and _G.MeetReq(v16.statreq) == false then
            return
        end
        local v18 = game.ReplicatedStorage.Events.Skill:InvokeServer("Negative Hollow")
        if v18 == nil then
            return
        end
        v14.negitive = true
        local u19 = false
        u12:DoubleCastSkill(p13, {
            ["ToolName"] = script.Name,
            ["Button"] = p13,
            ["Key"] = Enum.KeyCode.E,
            ["PassFunction"] = function() --[[ Name: PassFunction, Line 80 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u15
                --]]
                local v20
                if u12.Tool.Parent == u15 and _G.canuse == true then
                    v20 = _G.check:inspect(u15) == true
                else
                    v20 = false
                end
                return v20
            end,
            ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 83 ]]
                --[[
                Upvalues:
                    [1] = u19
                --]]
                u19 = true
            end
        })
        repeat
            game["Run Service"].Heartbeat:Wait()
        until u19 == true or (u15.Parent == nil or u15.Parent ~= workspace.PlayerCharacters)
        local v21 = u15.Humanoid:LoadAnimation(script.target)
        v21:Play()
        v21:AdjustWeight(2)
        v21:AdjustSpeed(2)
        if v18 then
            task.wait(0.3)
            v18:FireServer({
                ["Target"] = _G.getTargetNearMouse() or u12:GetMouseCFrame(),
                ["cf"] = u12:GetMouseCFrame()
            })
        end
        _G.keysetup:cooldown("Negative Hollow", v17)
        _G.fw(v17)
        v14.negitive = false
    end
end
function u7.KamikazeHollow(u22, p23) --[[ Line: 107 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v24 = u22.Cooldowns
    local u25 = u1.Character
    local v26 = u2["Stats" .. u1.Name]
    if v24.kami == false and (_G.check:inspect(u25) == true and _G.StamCheck("Kamikaze Hollow") == true) then
        local v27 = u3.GetM("Kamikaze Hollow")
        local v28 = v27.cd
        if _G.StamCheck("Kamikaze Hollow") == false then
            return
        end
        if v27.statreq and _G.MeetReq(v27.statreq) == false then
            return
        end
        local v29 = game.ReplicatedStorage.Events.Skill:InvokeServer("Kamikaze Hollow")
        if v29 == nil then
            return
        end
        v24.kami = true
        local u30 = false
        u22:DoubleCastSkill(p23, {
            ["ToolName"] = script.Name,
            ["Key"] = Enum.KeyCode.C,
            ["Button"] = p23,
            ["PassFunction"] = function() --[[ Name: PassFunction, Line 135 ]]
                --[[
                Upvalues:
                    [1] = u22
                    [2] = u25
                --]]
                local v31
                if u22.Tool.Parent == u25 and _G.canuse == true then
                    v31 = _G.check:inspect(u25) == true
                else
                    v31 = false
                end
                return v31
            end,
            ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 138 ]]
                --[[
                Upvalues:
                    [1] = u30
                --]]
                u30 = true
            end
        })
        repeat
            game["Run Service"].Heartbeat:Wait()
        until u30 == true or (u25.Parent == nil or (u25.Parent ~= workspace.PlayerCharacters or v26.Stamina.Value <= 0))
        local v32 = u25.Humanoid:LoadAnimation(script.throwKami)
        v32:Play()
        v32:AdjustWeight(2)
        v32:AdjustSpeed(2)
        if v29 then
            task.wait(0.3)
            v29:FireServer({
                ["Target"] = _G.getTargetNearMouse(),
                ["cf"] = u22:GetMouseCFrame()
            })
        end
        _G.keysetup:cooldown("Kamikaze Hollow", v28)
        _G.fw(v28)
        v24.kami = false
    end
end
function u7.ExplosiveSnap(p33, _) --[[ Line: 160 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v34 = p33.Cooldowns
    local v35 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v34.snap == false and (_G.check:inspect(v35) == true and _G.StamCheck("Explosive Snap") == true) then
        local v36 = u3.GetM("Explosive Snap")
        local v37 = v36.cd
        if _G.StamCheck("Explosive Snap") == false then
            return
        end
        if v36.statreq and _G.MeetReq(v36.statreq) == false then
            return
        end
        v34.snap = true
        local v38 = v35.Humanoid:LoadAnimation(script.snap)
        v38:Play()
        v38:AdjustWeight(2)
        v38:AdjustSpeed(2)
        task.wait(0.3)
        task.spawn(function() --[[ Line: 182 ]]
            game.ReplicatedStorage.Events.Skill:InvokeServer("Explosive Snap")
        end)
        _G.keysetup:cooldown("Explosive Snap", v37)
        _G.fw(v37)
        v34.snap = false
    end
end
function u7.MiniHollowBarrage(u39, p40) --[[ Line: 191 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v41 = u39.Cooldowns
    local u42 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v41.mini == false and (_G.check:inspect(u42) == true and _G.StamCheck("Mini Hollow Barrage") == true) then
        local v43 = u3.GetM("Mini Hollow Barrage")
        local v44 = v43.cd
        if _G.StamCheck("Mini Hollow Barrage") == false then
            return
        end
        if v43.statreq and _G.MeetReq(v43.statreq) == false then
            return
        end
        local v45 = game.ReplicatedStorage.Events.Skill:InvokeServer("Mini Hollow Barrage")
        if v45 == nil then
            return
        end
        v41.mini = true
        local u46 = false
        u39:DoubleCastSkill(p40, {
            ["ToolName"] = script.Name,
            ["Key"] = Enum.KeyCode.Z,
            ["Button"] = p40,
            ["PassFunction"] = function() --[[ Name: PassFunction, Line 218 ]]
                --[[
                Upvalues:
                    [1] = u39
                    [2] = u42
                --]]
                local v47
                if u39.Tool.Parent == u42 and _G.canuse == true then
                    v47 = _G.check:inspect(u42) == true
                else
                    v47 = false
                end
                return v47
            end,
            ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 221 ]]
                --[[
                Upvalues:
                    [1] = u46
                --]]
                u46 = true
            end
        })
        repeat
            game["Run Service"].Heartbeat:Wait()
        until u46 == true or (u42.Parent == nil or u42.Parent ~= workspace.PlayerCharacters)
        if v45 then
            local v48 = v45:GetAttribute("TotalHollows")
            v45:FireServer({
                ["Target"] = _G.getTargetNearMouse(),
                ["cf"] = u39:GetMouseCFrame()
            })
            if v48 then
                task.wait(v48 * 0.1)
            end
        end
        _G.keysetup:cooldown("Mini Hollow Barrage", v44)
        _G.fw(v44)
        v41.mini = false
    end
end
local function u66(p49) --[[ Line: 243 ]]
    local v50 = p49.X
    local v51 = math.abs(v50)
    local v52 = p49.Y
    if math.abs(v52) < v51 then
        local v53 = p49.X
        local v54 = math.abs(v53)
        local v55 = p49.Z
        if math.abs(v55) < v54 then
            local v56 = p49.X > 0 and "Right" or "Left"
            local v57 = p49.X
            return v56, math.abs(v57)
        end
    end
    local v58 = p49.Z
    local v59 = math.abs(v58)
    local v60 = p49.X
    if math.abs(v60) < v59 then
        local v61 = p49.Z
        local v62 = math.abs(v61)
        local v63 = p49.Y
        if math.abs(v63) < v62 then
            local v64 = p49.Z > 0 and "Down" or "Up"
            local v65 = p49.Z
            return v64, math.abs(v65)
        end
    end
    return "None", 0
end
function u7.SoulUnbound(u67, p68) --[[ Line: 253 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u11
        [5] = u6
        [6] = u66
    --]]
    local v69 = u67.Cooldowns
    local u70 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if _G.grounded == false and (v69.fly == false and (_G.check:inspect(u70) == true and _G.StamCheck("Soul Unbound") == true)) then
        local v71 = u3.GetM("Soul Unbound")
        local v72 = v71.cd
        if _G.StamCheck("Soul Unbound") == false then
            return
        end
        if v71.statreq and _G.MeetReq(v71.statreq) == false then
            return
        end
        v69.fly = true
        local u73 = nil
        local u74 = nil
        local u75 = nil
        local u76 = nil
        local u77 = nil
        local u78 = nil
        local u79 = false
        pcall(function() --[[ Line: 276 ]]
            --[[
            Upvalues:
                [1] = u11
                [2] = u70
                [3] = u77
                [4] = u78
                [5] = u73
                [6] = u74
                [7] = u79
            --]]
            u11 = {
                ["Idle"] = u70.Humanoid:LoadAnimation(script.Flight.idle),
                ["Front"] = u70.Humanoid:LoadAnimation(script.Flight.front),
                ["Back"] = u70.Humanoid:LoadAnimation(script.Flight.back),
                ["Left"] = u70.Humanoid:LoadAnimation(script.Flight.left),
                ["Right"] = u70.Humanoid:LoadAnimation(script.Flight.right)
            }
            u70.Humanoid:LoadAnimation(script.unboundSoul):Play()
            u77 = script.DepthOfField:Clone()
            u77.Parent = workspace.CurrentCamera
            u77.FarIntensity = 0
            u77.NearIntensity = 0
            u78 = script.ColorCorrection:Clone()
            u78.Parent = workspace.CurrentCamera
            u78.Brightness = 0
            u78.Contrast = 0
            u78.TintColor = Color3.fromRGB(255, 255, 255)
            u78.Saturation = 0
            _G.tween(u78, {
                1,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Saturation"] = script.ColorCorrection.Saturation,
                ["TintColor"] = script.ColorCorrection.TintColor,
                ["Contrast"] = script.ColorCorrection.Contrast,
                ["Brightness"] = script.ColorCorrection.Brightness
            })
            _G.tween(u77, {
                1,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["FarIntensity"] = script.DepthOfField.FarIntensity,
                ["NearIntensity"] = script.DepthOfField.NearIntensity
            })
            local v80 = game.ReplicatedStorage.Events.Skill
            local v81 = u70.HumanoidRootPart.CFrame
            local v82, v83 = unpack(v80:InvokeServer("Soul Unbound", v81, true))
            u73 = v82
            u74 = v83
            function u73.OnClientInvoke() --[[ Line: 296 ]]
                --[[
                Upvalues:
                    [1] = u79
                --]]
                if u79 ~= true then
                    u79 = true
                    script.SoulInterrupt:Play()
                end
            end
            if u11.Idle.IsPlaying == false then
                u11.Idle.Priority = Enum.AnimationPriority.Movement
                u11.Idle:Play()
            end
            for v84, v85 in u11 do
                if v84 ~= "Idle" then
                    v85:Stop()
                end
            end
        end)
        u67:DoubleCastSkill(p68, {
            ["ToolName"] = script.Name,
            ["Key"] = Enum.KeyCode.T,
            ["Button"] = p68,
            ["SkipTap"] = true,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 312 ]]
                --[[
                Upvalues:
                    [1] = u79
                --]]
                return u79 == true
            end,
            ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 315 ]]
                --[[
                Upvalues:
                    [1] = u79
                --]]
                u79 = true
            end
        })
        if u74 ~= nil then
            u75 = Instance.new("BodyVelocity", u70.HumanoidRootPart)
            u75.Name = "geppo"
            u75.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
            u75.Velocity = Vector3.new()
            u76 = Instance.new("BodyGyro", u70.HumanoidRootPart)
            u76.P = 100000
            u76.D = 2500
            u76.MaxTorque = Vector3.new(100000000000, 100000000000, 100000000000)
        end
        local v86 = tick()
        local u87 = u70.Humanoid
        local v89 = u70.ChildAdded:Connect(function(p88) --[[ Line: 336 ]]
            --[[
            Upvalues:
                [1] = u67
                [2] = u87
            --]]
            if p88:IsA("Tool") and p88 ~= u67.Tool then
                task.defer(function() --[[ Line: 339 ]]
                    --[[
                    Upvalues:
                        [1] = u87
                    --]]
                    u87:UnequipTools()
                end)
            end
        end)
        local v90 = u79
        local v91 = u77
        local v92 = u78
        local v93 = u73
        local u94 = 0
        while true do
            game["Run Service"].Heartbeat:Wait()
            if u74 == nil or u70.HumanoidRootPart.Position.Y <= workspace.Env.WaterStuff.Falls.Position.Y then
                break
            end
            pcall(function() --[[ Line: 356 ]]
                --[[
                Upvalues:
                    [1] = u6
                    [2] = u70
                    [3] = u74
                    [4] = u94
                    [5] = u66
                    [6] = u75
                    [7] = u76
                    [8] = u11
                --]]
                local v95 = u6:GetMoveVector()
                local v96 = 0.05 * (60 / _G.FPS)
                local v97 = 30 * (1 - (u70.HumanoidRootPart.Position - u74.PrimaryPart.Position).Magnitude / 200)
                u94 = math.clamp(v97, 10, 30) * (u70.Humanoid.Health / u70.Humanoid.MaxHealth)
                Vector3.new()
                local v98, _ = u66(v95)
                local v99
                if v95.Magnitude > 0 then
                    local v100 = Vector3.new(0, 0, 0)
                    if v98 == "Up" then
                        local v101 = workspace.CurrentCamera.CFrame.LookVector * u94
                        local v102 = v101.X
                        local v103 = v101.Y * 2
                        local v104 = v101.Z
                        v100 = Vector3.new(v102, v103, v104)
                    elseif v98 == "Down" then
                        local v105 = workspace.CurrentCamera.CFrame.LookVector * -u94
                        local v106 = v105.X
                        local v107 = v105.Y * 2
                        local v108 = v105.Z
                        v100 = Vector3.new(v106, v107, v108)
                    end
                    local v109 = u70.Humanoid.MoveDirection.X
                    local v110 = u70.Humanoid.MoveDirection.Z
                    v99 = v100 + Vector3.new(v109, 0, v110) * u94
                else
                    v99 = Vector3.new()
                end
                if _G.FaceMouse == true or (u70:FindFirstChildWhichIsA("ObjectValue") or _G.canuse == false and script.Parent.Parent ~= u70) then
                    v99 = Vector3.new()
                end
                u75.Velocity = u75.Velocity:Lerp(v99, v96)
                if _G.FaceMouse == true then
                    u76.Parent = nil
                    u76.MaxTorque = Vector3.new(0, 0, 0)
                else
                    if v98 == "Down" then
                        if u11.Back.IsPlaying == false then
                            u11.Back.Priority = Enum.AnimationPriority.Movement
                            u11.Back:Play()
                        end
                        for v111, v112 in u11 do
                            if v111 ~= "Back" then
                                v112:Stop()
                            end
                        end
                    elseif v98 == "Left" then
                        if u11.Left.IsPlaying == false then
                            u11.Left.Priority = Enum.AnimationPriority.Movement
                            u11.Left:Play()
                        end
                        for v113, v114 in u11 do
                            if v113 ~= "Left" then
                                v114:Stop()
                            end
                        end
                    elseif v98 == "Right" then
                        if u11.Right.IsPlaying == false then
                            u11.Right.Priority = Enum.AnimationPriority.Movement
                            u11.Right:Play()
                        end
                        for v115, v116 in u11 do
                            if v115 ~= "Right" then
                                v116:Stop()
                            end
                        end
                    elseif v98 == "Up" then
                        if u11.Front.IsPlaying == false then
                            u11.Front.Priority = Enum.AnimationPriority.Movement
                            u11.Front:Play()
                        end
                        for v117, v118 in u11 do
                            if v117 ~= "Front" then
                                v118:Stop()
                            end
                        end
                    else
                        if u11.Idle.IsPlaying == false then
                            u11.Idle.Priority = Enum.AnimationPriority.Movement
                            u11.Idle:Play()
                        end
                        for v119, v120 in u11 do
                            if v119 ~= "Idle" then
                                v120:Stop()
                            end
                        end
                    end
                    u76.Parent = u70.HumanoidRootPart
                    u76.MaxTorque = Vector3.new(100000000000, 100000000000, 100000000000)
                    u76.CFrame = CFrame.new(u70.HumanoidRootPart.Position, workspace.CurrentCamera.CFrame * CFrame.new(0, 0, 1000).Position) * CFrame.Angles(0, 3.141592653589793, 0)
                end
            end)
            local v121 = u70:FindFirstChildWhichIsA("Tool")
            if v121 and v121.Name ~= script.Name then
                task.defer(function() --[[ Line: 409 ]]
                    --[[
                    Upvalues:
                        [1] = u70
                    --]]
                    u70.Humanoid:UnequipTools()
                end)
            end
            u70.Humanoid.PlatformStand = true
            if v90 == true or (u70.Parent == nil or (u70.Parent ~= workspace.PlayerCharacters or tick() - v86 >= 15)) then
                break
            end
        end
        v89:Disconnect()
        u70.Humanoid.PlatformStand = false
        local v122 = Instance.new("ObjectValue", u70)
        _G.canuse = false
        for v123, v124 in u11 do
            if v123 ~= nil then
                v124:Stop()
            end
        end
        if v93 then
            u75:Destroy()
            u76:Destroy()
            v93:InvokeServer({
                ["Target"] = _G.MouseTarget,
                ["cf"] = u67:GetMouseCFrame()
            })
        end
        _G.tween(v92, {
            0.7,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Saturation"] = 0,
            ["TintColor"] = Color3.fromRGB(255, 255, 255),
            ["Brightness"] = 0,
            ["Contrast"] = 0
        })
        _G.tween(v91, {
            0.7,
            Enum.EasingStyle.Sine,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["FarIntensity"] = 0,
            ["NearIntensity"] = 0
        })
        _G.destroy(v92, 0.7)
        _G.destroy(v91, 0.7)
        task.wait(1)
        v122:Destroy()
        _G.canuse = true
        _G.keysetup:cooldown("Soul Unbound", v72)
        _G.fw(v72)
        v69.fly = false
    end
end
u7["ExplosiveSnap:Twirl"] = function(p125, _) --[[ Line: 448 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v126 = p125.Cooldowns
    local v127 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v126.depressSnap == false and (_G.check:inspect(v127) == true and _G.StamCheck("Explosive Snap: Twirl") == true) then
        local v128 = u3.GetM("Explosive Snap: Twirl")
        local v129 = v128.cd
        if _G.StamCheck("Explosive Snap: Twirl") == false then
            return
        end
        if v128.statreq and _G.MeetReq(v128.statreq) == false then
            return
        end
        v126.depressSnap = true
        local v130 = v127.Humanoid:LoadAnimation(script.snap2)
        v130:Play()
        v130:AdjustWeight(2)
        v130.Priority = Enum.AnimationPriority.Action4
        _G.canuse = false
        v127.Humanoid.WalkSpeed = 4
        game.ReplicatedStorage.Events.Skill:InvokeServer("Explosive Snap: Twirl", v127.HumanoidRootPart.CFrame)
        _G.canuse = true
        v127.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Explosive Snap: Twirl", v129)
        _G.fw(v129)
        v126.depressSnap = false
    end
end
return u7