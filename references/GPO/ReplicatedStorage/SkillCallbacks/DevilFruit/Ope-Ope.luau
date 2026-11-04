 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
game:GetService("UserInputService")
u1:GetMouse()
local u5 = setmetatable({}, u4)
u5.__index = u5
local u6 = {
    { "Block", "f" },
    { "Room", "e" },
    { "Thorn", "r" },
    { "Shambles", "t" },
    { "Surgeon Mode", "y" },
    { "Tact", "z" },
    { "Counter Shock", "x" },
    { "Gamma Knife", "c" }
}
local u7 = {
    { "Block", "f" },
    { "Room", "e" },
    { "Mes", "r" },
    { "Shambles", "t" },
    { "Surgeon Mode", "y" },
    { "Radio Knife", "z" },
    { "Injection Shot", "x" },
    { "Gamma Knife", "c" }
}
function u5.new(_) --[[ Line: 23 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
        [3] = u1
    --]]
    local v8 = u4.new(script.Name)
    local v9 = u5
    local u10 = setmetatable(v8, v9)
    u10.Cooldowns = {
        ["room"] = false,
        ["mes"] = false,
        ["tact"] = false,
        ["shambles"] = false,
        ["counterShock"] = false,
        ["injection"] = false,
        ["radio"] = false,
        ["gamma"] = false,
        ["sur"] = false,
        ["thorn"] = false
    }
    local u11 = u1.Character
    u10.surMode = false
    u10.inRoom = false
    u11.AttributeChanged:Connect(function(p12) --[[ Line: 33 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u11
        --]]
        if p12 == "surgeonMode" then
            u10.surMode = u11:GetAttribute("surgeonMode") or false
        end
    end)
    u10.HeartbeatConnection = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 39 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u10
            [3] = u11
        --]]
        local v13 = workspace.Effects:FindFirstChild("roomBubble" .. u1.Name)
        if v13 == nil then
            u10.inRoom = false
            u10.roomData = nil
        end
        if v13 and (v13:GetAttribute("originCFrame") and (u11.PrimaryPart.Position - v13:GetAttribute("originCFrame").Position).Magnitude <= v13:GetAttribute("roomSize") / 2) then
            u10.inRoom = true
        else
            u10.inRoom = false
        end
        if v13 and u10.roomData == nil then
            local v14 = v13:GetAttribute("roomSize")
            u10.roomData = {
                ["cf"] = v13:GetAttribute("originCFrame"),
                ["Size"] = Vector3.new(v14, v14, v14)
            }
        end
    end)
    return u10
end
function u5.Room(u15, p16) --[[ Line: 61 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local u17 = u15.Cooldowns
    local u18 = u1.Character
    local u19 = u2["Stats" .. u1.Name]
    if u17.room == false and (_G.check:inspect(u18) == true and _G.StamCheck("Room") == true) then
        local v20 = u3.GetM("Room")
        local u21 = v20.cd
        if _G.StamCheck("Room") == false then
            return
        end
        if v20.statreq and _G.MeetReq(v20.statreq) == false then
            return
        end
        local v22 = 125 + u19.Stats.DevilFruitMastery.Value / 2
        local v23 = v22 >= 1000 and 1000 or v22
        u17.room = true
        local v24 = u18.Humanoid:LoadAnimation(script.roomLoop)
        v24:Play()
        v24:AdjustWeight(2)
        v24:AdjustSpeed(1)
        _G.canuse = false
        local u25 = game.ReplicatedStorage.Events.Skill:InvokeServer("Room")
        local u26 = Instance.new("NumberValue", script)
        u26.Value = v23 * 0.2
        _G.tween(u26, {
            1.5,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Value"] = v23
        })
        local u27 = game.ReplicatedStorage.Refrences.Ope.indicatorMesh:Clone()
        u27.CFrame = u18.HumanoidRootPart.CFrame * CFrame.new(0.25, -0.5, -2.2)
        u27.Parent = workspace.Effects
        _G.tween(u27, {
            0.1,
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 0.95
        })
        u27.Anchored = true
        local u28 = tick()
        local function v33() --[[ Line: 108 ]]
            --[[
            Upvalues:
                [1] = u25
                [2] = u26
                [3] = u27
                [4] = u18
            --]]
            if u25 == nil then
                return false
            end
            if u26 ~= nil then
                local v29 = u27
                local v30 = u26.Value
                local v31 = u26.Value
                local v32 = u26.Value
                v29.Size = Vector3.new(v30, v31, v32)
            end
            u27.CFrame = u18.HumanoidRootPart.CFrame * CFrame.new(0.25, -0.5, -2.2)
        end
        local function v34() --[[ Line: 119 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u18
                [3] = u28
                [4] = u19
            --]]
            if u15.Tool.Parent ~= u18 or (tick() - u28 >= 1.5 or (u18.Parent == nil or (u18.Parent ~= workspace.PlayerCharacters or u19.Stamina.Value <= 0))) then
                return true
            end
        end
        u15:ChargeSkill(p16, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = v33,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = v34
        })
        if tick() - u28 <= 0.2 then
            task.wait(0.2)
        end
        u26:Destroy()
        u26 = nil
        _G.tween(u27, {
            1.5,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.destroy(u27, 1.5)
        game.Lighting.BlurF.Size = 15
        _G.tween(game.Lighting.BlurF, {
            1,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = 0
        })
        v24:Stop()
        if u25 then
            u15.roomData = {
                ["cf"] = u18.PrimaryPart.CFrame,
                ["Size"] = u27.Size
            }
            u25:FireServer(u27.Size.X, u18.PrimaryPart.CFrame * CFrame.new(0.25, -0.5, -2.2))
        end
        local v35 = u18.Humanoid:LoadAnimation(script.roomRelease)
        v35:Play()
        v35:AdjustWeight(2)
        v35:AdjustSpeed(1)
        _G.canuse = true
        u18.Humanoid.WalkSpeed = 16
        u15:DoubleCastSkill(p16, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = v33,
            ["EndFunction"] = v34,
            ["SkipTap"] = true,
            ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 166 ]]
                --[[
                Upvalues:
                    [1] = u25
                    [2] = u15
                    [3] = u21
                    [4] = u17
                --]]
                if u25 then
                    u25:FireServer("release")
                end
                u15.roomData = nil
                _G.keysetup:cooldown("Room", u21)
                _G.canuse = true
                _G.fw(u21)
                u17.room = false
            end,
            ["PassFunction"] = function() --[[ Name: PassFunction, Line 176 ]]
                --[[
                Upvalues:
                    [1] = u18
                --]]
                local v36 = u18:FindFirstChild(script.Name)
                if v36 then
                    v36 = _G.canuse == true
                end
                return v36
            end
        })
    end
end
function u5.Mes(p37, p38) --[[ Line: 184 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v39 = p37.Cooldowns
    local u40 = u1.Character
    local u41 = u2["Stats" .. u1.Name]
    if p37.surMode == true and (v39.mes == false and (_G.check:inspect(u40) == true and _G.StamCheck("Mes") == true)) then
        local v42 = u3.GetM("Mes")
        local v43 = v42.cd
        if _G.StamCheck("Mes") == false then
            return
        end
        if v42.statreq and _G.MeetReq(v42.statreq) == false then
            return
        end
        if p37.inRoom == false then
            game:GetService("SoundService"):PlayLocalSound(script.OpeOutOfRoom)
            return
        end
        v39.mes = true
        local v44 = u40.Humanoid:LoadAnimation(script.mesWindup)
        v44:Play()
        v44:AdjustWeight(2)
        v44:AdjustSpeed(1)
        _G.canuse = false
        _G.FaceMouse = true
        local u45 = game.ReplicatedStorage.Events.Skill:InvokeServer("Mes")
        local u46 = Instance.new("NumberValue", script)
        u46.Value = 8
        local u47 = game.ReplicatedStorage.Refrences.Ope.aim:Clone()
        u47.Parent = workspace.Effects
        u47.Attachment2.Position = Vector3.new()
        _G.tween(u47.Attachment2, {
            0.25,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Position"] = game.ReplicatedStorage.Refrences.Ope.aim.Attachment2.Position
        })
        local u48 = true
        task.spawn(function() --[[ Line: 224 ]]
            --[[
            Upvalues:
                [1] = u47
                [2] = u40
                [3] = u46
            --]]
            while _G.FaceMouse == true do
                u47.CFrame = u40.HumanoidRootPart.CFrame * CFrame.new(0, -u40.Humanoid.HipHeight * 1.45, -25) * CFrame.Angles(3.141592653589793, 0, 0)
                local v49 = u47.Attachment2
                local v50 = u46.Value - 10
                v49.Position = Vector3.new(0, 0, v50)
                game["Run Service"].RenderStepped:Wait()
            end
        end)
        _G.PauseAnim(v44, 0.5, 1)
        v44:Stop()
        local v51 = u40.Humanoid:LoadAnimation(script.mesLoop)
        v51:Play()
        v51:AdjustWeight(2)
        v51:AdjustSpeed(1)
        task.delay(0.25, function() --[[ Line: 243 ]]
            --[[
            Upvalues:
                [1] = u48
                [2] = u46
            --]]
            if u48 == true then
                game:GetService("TweenService"):Create(u46, TweenInfo.new(0.75, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                    ["Value"] = 16
                }, true):Play()
            end
        end)
        local u52 = tick()
        p37:ChargeSkill(p38, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 254 ]]
                --[[
                Upvalues:
                    [1] = u45
                --]]
                if u45 == nil then
                    return false
                end
            end,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 260 ]]
                --[[
                Upvalues:
                    [1] = u40
                    [2] = u52
                    [3] = u41
                --]]
                if u40:FindFirstChild(script.Name) == nil or (tick() - u52 >= 1.25 or (u40.Parent == nil or (u40.Parent ~= workspace.PlayerCharacters or u41.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        u48 = false
        if tick() - u52 < 0.75 then
            repeat
                task.wait()
            until tick() - u52 >= 0.75
        end
        v51:Stop()
        local v53 = u40.Humanoid:LoadAnimation(script.mesSteal)
        v53:Play()
        v53:AdjustWeight(2)
        v53:AdjustSpeed(1)
        u46:Destroy()
        if u45 then
            local v54 = (u47.Attachment2.Position - u47.Attachment.Position).Magnitude
            u45:FireServer(-v54 / 2, u40.PrimaryPart.CFrame, u47.Attachment2.WorldCFrame, v54)
        end
        _G.tween(u47.Beam, {
            0.25,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Width0"] = 0,
            ["Width1"] = 0
        })
        _G.destroy(u47, 0.25)
        task.wait(0.25)
        _G.canuse = true
        _G.FaceMouse = false
        _G.keysetup:cooldown("Mes", v43)
        _G.canuse = true
        _G.fw(v43)
        v39.mes = false
    end
end
function u5.Tact(u55, p56) --[[ Line: 309 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v57 = u55.Cooldowns
    local u58 = u1.Character
    local u59 = u2["Stats" .. u1.Name]
    if u55.surMode == false and (v57.tact == false and (_G.check:inspect(u58) == true and _G.StamCheck("Tact") == true)) then
        local v60 = u3.GetM("Tact")
        local v61 = v60.cd
        if _G.StamCheck("Tact") == false then
            return
        end
        if v60.statreq and _G.MeetReq(v60.statreq) == false then
            return
        end
        if u55.inRoom == false then
            game:GetService("SoundService"):PlayLocalSound(script.OpeOutOfRoom)
            return
        end
        v57.tact = true
        _G.canuse = false
        local v62 = RaycastParams.new()
        v62.FilterDescendantsInstances = { workspace.Env, workspace.Ships, workspace.Islands }
        v62.FilterType = Enum.RaycastFilterType.Whitelist
        v62.IgnoreWater = true
        local v63 = game.Workspace.Camera.CFrame.Position
        local v64 = CFrame.new(v63, u55:GetMouseCFrame().Position).LookVector * 2000
        local v65 = workspace:Raycast(v63, v64, v62)
        local v66
        if v65 == nil or (v65.Position - u55.roomData.cf.Position).Magnitude >= u55.roomData.Size.X * 0.3 then
            v66 = nil
        else
            v66 = v65.Position
        end
        local v67 = game.ReplicatedStorage.Events.Skill:InvokeServer("Tact")
        local v68 = u58.Humanoid:LoadAnimation(script.tactHold)
        v68:Play()
        v68:AdjustWeight(2)
        v68:AdjustSpeed(1)
        local u69 = tick()
        u55:ChargeSkill(p56, {
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 355 ]]
                --[[
                Upvalues:
                    [1] = u58
                --]]
                u58.Humanoid.WalkSpeed = 4
                local v70 = u58.Humanoid
                local v71 = Random.new():NextNumber(-0.15, 0.15)
                local v72 = Random.new():NextNumber(-0.15, 0.15)
                local v73 = Random.new()
                v70.CameraOffset = Vector3.new(v71, v72, v73:NextNumber(-0.15, 0.15))
            end,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 361 ]]
                --[[
                Upvalues:
                    [1] = u58
                    [2] = u69
                    [3] = u59
                --]]
                if u58:FindFirstChild(script.Name) == nil or (tick() - u69 >= 1.5 or (u58.Parent == nil or (u58.Parent ~= workspace.PlayerCharacters or (u59.Stamina.Value <= 0 or _G.check:inspect(u58) == false)))) then
                    return true
                end
            end
        })
        v68:Stop()
        local v74 = u58.Humanoid:LoadAnimation(script.tactRelease)
        v74:Play()
        v74:AdjustWeight(2)
        v74:AdjustSpeed(1)
        local v75 = u55.roomData.Size.X / 150
        local v76 = (tick() - u69) * 4 * v75
        local v77 = math.ceil(v76)
        local u78
        if v67 and _G.check:inspect(u58) == true then
            u78 = v67:InvokeServer({ v66, v77 })
        else
            u78 = nil
        end
        _G.canuse = true
        _G.FaceMouse = false
        _G.mouseLevel = false
        u58.Humanoid.WalkSpeed = 16
        if u78 then
            local u79 = false
            u55:DoubleCastSkill(p56, {
                ["Key"] = Enum.KeyCode.Z,
                ["PassFunction"] = function() --[[ Name: PassFunction, Line 399 ]]
                    --[[
                    Upvalues:
                        [1] = u58
                        [2] = u55
                    --]]
                    local v80 = u58:FindFirstChild(script.Name)
                    if v80 then
                        if u55.surMode == false and _G.canuse == true then
                            v80 = _G.check:inspect(u58) == true
                        else
                            v80 = false
                        end
                    end
                    return v80
                end,
                ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 402 ]]
                    --[[
                    Upvalues:
                        [1] = u79
                        [2] = u58
                        [3] = u78
                        [4] = u55
                    --]]
                    u79 = true
                    local v81 = u58.Humanoid:LoadAnimation(script.tactLaunch)
                    v81:Play()
                    v81:AdjustWeight(2)
                    v81:AdjustSpeed(1)
                    u78:FireServer(u55:GetMouseCFrame())
                end
            })
            repeat
                task.wait()
            until u79 == true or u55.roomData == nil
            _G.keysetup:cooldown("Tact", v61)
            _G.canuse = true
            _G.fw(v61)
            v57.tact = false
        else
            _G.keysetup:cooldown("Tact", v61)
            _G.canuse = true
            _G.fw(v61)
            v57.tact = false
        end
    end
end
function u5.Shambles(p82, _) --[[ Line: 431 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v83 = p82.Cooldowns
    local v84 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v84.Parent ~= workspace.Ragdolls and (v83.shambles == false and (_G.check:inspect(v84) == true and _G.StamCheck("Shambles") == true)) then
        local v85 = u3.GetM("Shambles")
        local v86 = v85.cd
        if _G.StamCheck("Shambles") == false then
            return
        end
        if v85.statreq and _G.MeetReq(v85.statreq) == false then
            return
        end
        if p82.inRoom == false then
            game:GetService("SoundService"):PlayLocalSound(script.OpeOutOfRoom)
            return
        end
        if _G.shamblesTarget == nil then
            return
        end
        if v84:GetAttribute("isDrowning") == true and _G.swimming == true then
            _G.displayMessage("<Color=Red>Cant use this while drowning!")
            return
        end
        v83.shambles = true
        local _ = v84.HumanoidRootPart.Position
        local v87 = _G.shamblesTarget
        game:GetService("TweenService"):Create(game.Workspace.Camera, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["FieldOfView"] = 60
        }, true):Play()
        local v88 = game.ReplicatedStorage.Refrences.Ope.zoomPart:Clone()
        v88.CFrame = game.Workspace.Camera.CFrame
        _G.destroy(v88, 1)
        local v89 = v87.PrimaryPart.CFrame
        local v90 = v84.Humanoid:LoadAnimation(script.shambles)
        v90:Play()
        v90:AdjustWeight(2)
        v90:AdjustSpeed(1)
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Shambles", { v84.PrimaryPart.CFrame, v87, v89 })
        game:GetService("TweenService"):Create(game.Lighting.ColorCorrectionF, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["TintColor"] = Color3.fromRGB(175, 200, 230)
        }, true):Play()
        task.wait(0.3)
        game:GetService("TweenService"):Create(game.Workspace.Camera, TweenInfo.new(0.275, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["FieldOfView"] = 90
        }, true):Play()
        game:GetService("TweenService"):Create(game.Lighting.ColorCorrectionF, TweenInfo.new(0.275, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Brightness"] = 0.2,
            ["Saturation"] = 0.5
        }, true):Play()
        local v91 = Instance.new("Part")
        v91.Size = Vector3.new(1, 1, 1)
        v91.Transparency = 1
        v91.Anchored = true
        v91.CanCollide = false
        v91.CFrame = v84.HumanoidRootPart.CFrame
        v91.Parent = workspace.Effects
        _G.destroy(v91, 0.35)
        game.Workspace.Camera.CameraSubject = v91
        v84.HumanoidRootPart.Anchored = true
        game:GetService("TweenService"):Create(v91, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
            ["CFrame"] = v89
        }, true):Play()
        task.wait(0.275)
        game:GetService("TweenService"):Create(game.Workspace.Camera, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
            ["FieldOfView"] = 70
        }, true):Play()
        game:GetService("TweenService"):Create(game.Lighting.ColorCorrectionF, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
            ["Brightness"] = 0,
            ["Saturation"] = 0
        }, true):Play()
        game:GetService("TweenService"):Create(game.Lighting.ColorCorrectionF, TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
            ["TintColor"] = Color3.fromRGB(255, 255, 255)
        }, true):Play()
        task.wait(0.125)
        game.Workspace.Camera.CameraSubject = v84.Humanoid
        v84.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Shambles", v86)
        _G.fw(v86)
        v83.shambles = false
    end
end
function u5.CounterShock(p92, _) --[[ Line: 542 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v93 = p92.Cooldowns
    local v94 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if p92.surMode == false and (v93.counterShock == false and (_G.check:inspect(v94) == true and _G.StamCheck("Counter Shock") == true)) then
        local v95 = u3.GetM("Counter Shock")
        local v96 = v95.cd
        if _G.StamCheck("Counter Shock") == false then
            return
        end
        if v95.statreq and _G.MeetReq(v95.statreq) == false then
            return
        end
        _G.canuse = false
        v93.counterShock = true
        local v97 = v94.Humanoid:LoadAnimation(script.counterShockHold)
        v97:Play()
        v97:AdjustWeight(2)
        v97:AdjustSpeed(0.5)
        v97.Priority = Enum.AnimationPriority.Action4
        _G.canuse = false
        v94.Humanoid.WalkSpeed = 4
        local v98 = game.ReplicatedStorage.Events.Skill:InvokeServer("Counter Shock", {
            ["cf"] = v94.HumanoidRootPart.CFrame
        })
        task.wait(0.5)
        if v98 then
            v98:FireServer(v94.PrimaryPart.CFrame)
        end
        task.wait(0.4)
        v94.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Counter Shock", v96)
        _G.fw(v96)
        v93.counterShock = false
    end
end
function u5.InjectionShot(p99, p100) --[[ Line: 582 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v101 = p99.Cooldowns
    local u102 = u1.Character
    local u103 = u2["Stats" .. u1.Name]
    if p99.surMode == true and (v101.injection == false and (_G.check:inspect(u102) == true and _G.StamCheck("Injection Shot") == true)) then
        local v104 = u3.GetM("Injection Shot")
        local v105 = v104.cd
        if _G.StamCheck("Injection Shot") == false then
            return
        end
        if v104.statreq and _G.MeetReq(v104.statreq) == false then
            return
        end
        if p99.inRoom == false then
            game:GetService("SoundService"):PlayLocalSound(script.OpeOutOfRoom)
            return
        end
        _G.canuse = false
        local v106 = game.ReplicatedStorage.Events.Skill:InvokeServer("Injection Shot", {
            ["cf"] = p99:GetMouseCFrame()
        })
        if v106 == nil then
            _G.canuse = true
            return
        end
        v101.injection = true
        local u107 = u102.Humanoid:LoadAnimation(script.injectionWindup)
        u107:Play()
        u107:AdjustWeight(2)
        _G.canuse = false
        _G.FaceMouse = true
        task.spawn(function() --[[ Line: 615 ]]
            --[[
            Upvalues:
                [1] = u107
            --]]
            _G.PauseAnim(u107, 0.7, 1)
        end)
        u107:Stop()
        local v108 = u102.Humanoid:LoadAnimation(script.injectionLoop)
        v108:Play()
        v108:AdjustWeight(2)
        tick()
        local u109 = tick()
        p99:ChargeSkill(p100, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 631 ]]
                --[[
                Upvalues:
                    [1] = u109
                    [2] = u102
                    [3] = u103
                --]]
                if tick() - u109 >= 1.5 or (u102:FindFirstChild(script.Name) == nil or (u102.Parent == nil or (u102.Parent ~= workspace.PlayerCharacters or u103.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        if tick() - u109 <= 0.5 then
            task.wait(0.5 - (tick() - u109))
        end
        v108:Stop()
        local v110 = u102.Humanoid:LoadAnimation(script.injectionFire)
        v110:Play()
        v110:AdjustWeight(2)
        u102.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        v110:AdjustSpeed(1)
        if v106 then
            v106:FireServer(u102.HumanoidRootPart.CFrame)
        end
        task.wait(0.75)
        u102.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Injection Shot", v105)
        _G.fw(v105)
        v101.injection = false
    end
end
function u5.RadioKnife(p111, p112) --[[ Line: 665 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v113 = p111.Cooldowns
    local u114 = u1.Character
    local u115 = u2["Stats" .. u1.Name]
    if p111.surMode == true and (v113.radio == false and (_G.check:inspect(u114) == true and _G.StamCheck("Radio Knife") == true)) then
        local v116 = u3.GetM("Radio Knife")
        local v117 = v116.cd
        if _G.StamCheck("Radio Knife") == false then
            return
        end
        if v116.statreq and _G.MeetReq(v116.statreq) == false then
            return
        end
        if p111.inRoom == false then
            game:GetService("SoundService"):PlayLocalSound(script.OpeOutOfRoom)
            return
        end
        _G.canuse = false
        local v118 = game.ReplicatedStorage.Events.Skill:InvokeServer("Radio Knife", {
            ["cf"] = p111:GetMouseCFrame()
        })
        v113.radio = true
        local v119 = u114.Humanoid:LoadAnimation(script.radioWind)
        v119:Play()
        v119:AdjustWeight(2)
        v119:AdjustSpeed(0.7150000000000001)
        _G.canuse = false
        _G.FaceMouse = true
        task.wait(0.5769230769230769)
        v119:Stop()
        local v120 = u114.Humanoid:LoadAnimation(script.radioLoop)
        v120:Play()
        v120:AdjustWeight(2)
        tick()
        local u121 = tick()
        p111:ChargeSkill(p112, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 715 ]]
                --[[
                Upvalues:
                    [1] = u114
                    [2] = u121
                    [3] = u115
                --]]
                if u114:FindFirstChild("PB") then
                    return true
                end
                if tick() - u121 >= 2 or (u114:FindFirstChild(script.Name) == nil or (u114.Parent == nil or (u114.Parent ~= workspace.PlayerCharacters or u115.Stamina.Value <= 0))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v120:Stop()
        local u122 = u114.Humanoid:LoadAnimation(script.radioEnd)
        u122:Play()
        u122:AdjustSpeed(0)
        u122:AdjustWeight(4)
        task.delay(0.25, function() --[[ Line: 735 ]]
            --[[
            Upvalues:
                [1] = u122
            --]]
            u122:AdjustSpeed(1)
        end)
        u114.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        if v118 then
            v118:FireServer(u114.HumanoidRootPart.CFrame)
        end
        task.wait(1.25)
        u114.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Radio Knife", v117)
        _G.fw(v117)
        v113.radio = false
    end
end
function u5.Thorn(u123, p124) --[[ Line: 753 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v125 = u123.Cooldowns
    local u126 = u1.Character
    local u127 = u2["Stats" .. u1.Name]
    if u123.surMode == false and (v125.thorn == false and (_G.check:inspect(u126) == true and _G.StamCheck("Thorn") == true)) then
        local v128 = u3.GetM("Thorn")
        local v129 = v128.cd
        if _G.StamCheck("Thorn") == false then
            return
        end
        if v128.statreq and _G.MeetReq(v128.statreq) == false then
            return
        end
        if u123.inRoom == false then
            game:GetService("SoundService"):PlayLocalSound(script.OpeOutOfRoom)
            return
        end
        _G.canuse = false
        v125.thorn = true
        local v130 = u126.Humanoid:LoadAnimation(script.thornCharge)
        v130:Play()
        v130:AdjustWeight(2)
        local u131 = tick()
        _G.canuse = false
        local u132 = RaycastParams.new()
        u132.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
        u132.FilterType = Enum.RaycastFilterType.Whitelist
        u132.IgnoreWater = true
        local v133 = game.Workspace.Camera.CFrame.Position
        local v134 = CFrame.new(v133, u123:GetMouseCFrame().Position).LookVector * 2000
        local v135 = workspace:Raycast(v133, v134, u132)
        local u136 = nil
        local function u143(p137, p138, p139) --[[ Line: 796 ]]
            --[[
            Upvalues:
                [1] = u123
                [2] = u132
                [3] = u136
                [4] = u143
            --]]
            local v140 = CFrame.new(p137, p138) * CFrame.new(0, 0, -(p137 - p138).Magnitude * p139).Position
            local v141 = CFrame.new(v140, v140 - Vector3.new(0, 1, 0)).LookVector * u123.roomData.Size.X
            local v142 = workspace:Raycast(v140, v141, u132)
            if v142 == nil or (u123.roomData.cf.Position - v142.Position).Magnitude >= u123.roomData.Size.X / 2 then
                if p139 + 0.1 <= 1 then
                    u143(p137, p138, p139 + 0.1)
                end
            else
                u136 = CFrame.new(v142.Position, v142.Position + v142.Normal)
            end
        end
        if v135 == nil or (v135.Position - u123.roomData.cf.Position).Magnitude >= u123.roomData.Size.X / 2 then
            if v135 == nil or (v135.Position - u123.roomData.cf.Position).Magnitude <= u123.roomData.Size.X / 2 then
                if v135 == nil then
                    local v144 = CFrame.new
                    local v145 = u123.roomData.cf.Position
                    local v146 = game.Players.LocalPlayer:GetMouse().Hit.Position.X
                    local v147 = u123.roomData.cf.Position.Y
                    local v148 = game.Players.LocalPlayer:GetMouse().Hit.Position.Z
                    local v149 = v144(v145, (Vector3.new(v146, v147, v148))) * CFrame.new(0, u123.roomData.Size.X / 2, -u123.roomData.Size.X * 0.4).Position
                    local v150 = CFrame.new
                    local v151 = u123.roomData.cf.Position
                    local v152 = game.Players.LocalPlayer:GetMouse().Hit.Position.X
                    local v153 = u123.roomData.cf.Position.Y
                    local v154 = game.Players.LocalPlayer:GetMouse().Hit.Position.Z
                    u143(v149, v150(v151, (Vector3.new(v152, v153, v154))) * CFrame.new(0, u123.roomData.Size.X / 2, u123.roomData.Size.X * 0.4).Position, 0)
                end
            else
                local v155 = CFrame.new
                local v156 = u123.roomData.cf.Position
                local v157 = v135.Position.X
                local v158 = u123.roomData.cf.Position.Y
                local v159 = v135.Position.Z
                local v160 = v155(v156, (Vector3.new(v157, v158, v159))) * CFrame.new(0, u123.roomData.Size.X / 2, -u123.roomData.Size.X * 0.4).Position
                local v161 = CFrame.new
                local v162 = u123.roomData.cf.Position
                local v163 = v135.Position.X
                local v164 = u123.roomData.cf.Position.Y
                local v165 = v135.Position.Z
                u143(v160, v161(v162, (Vector3.new(v163, v164, v165))) * CFrame.new(0, u123.roomData.Size.X / 2, u123.roomData.Size.X * 0.4).Position, 0)
            end
        else
            u136 = CFrame.new(v135.Position, v135.Position + v135.Normal)
        end
        if u136 == nil then
            u136 = u126.PrimaryPart.CFrame
        end
        local v166 = game.ReplicatedStorage.Events.Skill:InvokeServer("Thorn", u136 * CFrame.Angles(0, 0, 0) * CFrame.new(0, 0.1, 0))
        u123:ChargeSkill(p124, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 834 ]]
                --[[
                Upvalues:
                    [1] = u126
                --]]
                u126.Humanoid.WalkSpeed = 4
            end,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 838 ]]
                --[[
                Upvalues:
                    [1] = u131
                    [2] = u126
                    [3] = u127
                --]]
                if tick() - u131 >= 1 or (u126:FindFirstChild(script.Name) == nil or (u126.Parent == nil or (u126.Parent ~= workspace.PlayerCharacters or u127.Stamina.Value <= 0))) then
                    return true
                end
            end,
            ["HoldDuration"] = 0.35
        })
        if tick() - u131 < 0.25 then
            task.wait(0.25 - tick() - u131)
        end
        v130:Stop()
        local v167 = u126.Humanoid:LoadAnimation(script.thornRaise)
        v167:Play()
        v167:AdjustSpeed(1)
        if v166 then
            v166:FireServer()
        end
        u126.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Thorn", v129)
        _G.fw(v129)
        v125.thorn = false
    end
end
function u5.GammaKnife(p168, p169) --[[ Line: 875 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v170 = p168.Cooldowns
    local u171 = u1.Character
    local u172 = u2["Stats" .. u1.Name]
    if v170.gamma == false and (_G.check:inspect(u171) == true and _G.StamCheck("Gamma Knife") == true) then
        local v173 = u3.GetM("Gamma Knife")
        local v174 = v173.cd
        if _G.StamCheck("Gamma Knife") == false then
            return
        end
        if v173.statreq and _G.MeetReq(v173.statreq) == false then
            return
        end
        if p168.inRoom == false then
            game:GetService("SoundService"):PlayLocalSound(script.OpeOutOfRoom)
            return
        end
        _G.canuse = false
        local u175 = game.ReplicatedStorage.Events.Skill:InvokeServer("Gamma Knife", {
            ["cf"] = p168:GetMouseCFrame()
        })
        v170.gamma = true
        local v176 = u171.Humanoid:LoadAnimation(script.gamma)
        v176:Play()
        v176:AdjustWeight(5)
        _G.canuse = false
        u171.Humanoid.WalkSpeed = 4
        _G.PauseAnim(v176, 0.35, 1)
        local u177 = tick()
        p168:ChargeSkill(p169, {
            ["Key"] = Enum.KeyCode.C,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 907 ]]
                --[[
                Upvalues:
                    [1] = u171
                --]]
                u171.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 912 ]]
                --[[
                Upvalues:
                    [1] = u177
                    [2] = u171
                    [3] = u172
                --]]
                if tick() - u177 >= 5 or (u171:FindFirstChild(script.Name) == nil or (u171.Parent == nil or (u171.Parent ~= workspace.PlayerCharacters or u172.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v176:AdjustSpeed(1)
        local u178 = Instance.new("LinearVelocity")
        u178.Attachment0 = u171.PrimaryPart.RootRigAttachment
        u178.MaxForce = 100000000000
        u178.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        u178.VectorVelocity = u171:GetPivot().LookVector * 125
        u178.RelativeTo = Enum.ActuatorRelativeTo.World
        u178.Parent = u171
        local v179 = Instance.new("AlignOrientation")
        v179.Attachment0 = u171.PrimaryPart.RootRigAttachment
        v179.Mode = 0
        v179.CFrame = u171:GetPivot()
        v179.Responsiveness = 45
        v179.MaxTorque = 100000000000
        v179.Parent = u171
        _G.tween(u178, { 0.5, "Linear", Enum.EasingDirection.Out }, {
            ["VectorVelocity"] = Vector3.new(0, 0, 0)
        })
        _G.destroy(u178, 0.5)
        _G.destroy(v179, 0.5)
        if u175 then
            u175:FireServer("woosh")
        end
        local u180 = nil
        local function v182(p181) --[[ Line: 951 ]]
            --[[
            Upvalues:
                [1] = u178
                [2] = u175
                [3] = u171
                [4] = u180
            --]]
            u178:Destroy()
            if u175 then
                u175:FireServer(u171.PrimaryPart.CFrame, p181.Parent)
                u180 = true
            end
        end
        _G.hitbox:start(u171, Vector3.new(15, 15, 10), 0.25, CFrame.new(0, 0, -1), v182)
        task.wait(0.5)
        u171.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Gamma Knife", v174)
        _G.fw(v174)
        v170.gamma = false
    end
end
function u5.SurgeonMode(p183, _) --[[ Line: 970 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u7
        [5] = u6
    --]]
    local v184 = p183.Cooldowns
    local v185 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v184.sur == false and (_G.check:inspect(v185) == true and _G.StamCheck("Surgeon Mode") == true) then
        local v186 = u3.GetM("Surgeon Mode")
        local v187 = v186.cd
        if _G.StamCheck("Surgeon Mode") == false then
            return
        end
        if v186.statreq and _G.MeetReq(v186.statreq) == false then
            return
        end
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Surgeon Mode")
        v184.sur = true
        _G.canuse = true
        if p183.surMode == true then
            local v188 = v185.Humanoid:LoadAnimation(script.surgeon)
            v188:Play()
            v188:AdjustWeight(2)
            _G.keysetup:Destroy()
            _G.keysetup:setup(script.Name .. " Surgeon Mode", u7)
        else
            local v189 = v185.Humanoid:LoadAnimation(script.unmode)
            v189:Play()
            v189:AdjustWeight(2)
            _G.keysetup:Destroy()
            _G.keysetup:setup(script.Name, u6)
        end
        _G.keysetup:cooldown("Surgeon Mode", v187)
        _G.fw(v187)
        v184.sur = false
    end
end
return u5