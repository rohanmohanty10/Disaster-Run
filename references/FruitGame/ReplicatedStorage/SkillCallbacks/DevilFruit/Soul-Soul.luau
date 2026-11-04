 

local u1 = game.Players.LocalPlayer
local u2 = game:GetService("RunService")
local u3 = game:GetService("ReplicatedStorage")
local u4 = require(game.ReplicatedStorage.Modules.Skills)
local u5 = require(script.Parent.Parent.MobileBase)
local v6 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
game:GetService("UserInputService")
local u7 = v6:GetControls()
local v8 = RaycastParams.new()
v8.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
v8.FilterType = Enum.RaycastFilterType.Include
u1:GetMouse()
local u9 = setmetatable({}, u5)
u9.__index = u9
function u9.new(_) --[[ Line: 25 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u9
        [3] = u1
    --]]
    local v10 = u5.new(script.Name)
    local v11 = u9
    local v12 = setmetatable(v10, v11)
    v12.Cooldowns = {
        ["Hellfire Ring"] = false
    }
    local _ = u1.Character
    return v12
end
function u9.SoulSwap(p13, _) --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v14 = p13.Cooldowns
    local v15 = u1.Character
    local _ = u3["Stats" .. u1.Name]
    if _G.check:inspect(v15) == true then
        if v14["Soul Swap"] == true then
            return
        end
        local v16 = u4.GetM("Soul Swap")
        local v17 = v16.cd
        if _G.StamCheck("Soul Swap") == false then
            return
        end
        if v16.statreq and _G.MeetReq(v16.statreq) == false then
            return
        end
        v14["Soul Swap"] = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Soul Swap")
        _G.keysetup:cooldown("Soul Swap", v17)
        _G.fw(v17)
        v14["Soul Swap"] = false
    end
end
function u9.ThunderDrop(u18, p19) --[[ Line: 69 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v20 = u18.Cooldowns
    local u21 = u1.Character
    local u22 = u3["Stats" .. u1.Name]
    if _G.check:inspect(u21) == true then
        if v20["Thunder Drop"] == true then
            return
        end
        local v23 = u4.GetM("Thunder Drop")
        local v24 = v23.cd
        if _G.StamCheck("Thunder Drop") == false then
            return
        end
        if v23.statreq and _G.MeetReq(v23.statreq) == false then
            return
        end
        if u21:GetAttribute("ZeusBusy") then
            return
        end
        v20["Thunder Drop"] = true
        if u18.Flying == nil then
            _G.mouseLevel = true
            _G.FaceMouse = true
        end
        local u25 = tick()
        local v26
        if u18.Flying == nil then
            v26 = u21.Humanoid:LoadAnimation(script.BoltCharge)
            v26:Play()
        else
            v26 = nil
        end
        _G.canuse = false
        local v27 = game.ReplicatedStorage.Events.Skill:InvokeServer("Thunder Drop", u18:GetMouseCFrame().Position)
        local v28, u29
        if v27 then
            v28, u29 = unpack(v27)
        else
            u29 = nil
            v28 = nil
        end
        local function v31() --[[ Line: 121 ]]
            --[[
            Upvalues:
                [1] = u29
                [2] = u18
                [3] = u21
                [4] = u25
                [5] = u22
            --]]
            if u29 then
                local v30 = u18:GetMouseCFrame().Position
                if u18.Flying ~= nil then
                    v30 = u21.PrimaryPart.Position
                end
                u29:FireServer(v30)
            end
            if tick() - u25 >= 3 or (u18.Tool.Parent ~= u21 or (_G.check:inspect(u21) == false or (u21.Parent == nil or (u21.Parent ~= workspace.PlayerCharacters or (u22.Stamina.Value <= 0 or u21:FindFirstChild("PB")))))) then
                return true
            end
        end
        u18:ChargeSkill(p19, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = v31,
            ["HoldDuration"] = 0.25
        })
        if v26 then
            v26:Stop()
            u21.Humanoid:LoadAnimation(script.BoltStrike):Play()
        end
        if v28 ~= nil then
            local v32 = workspace.Effects:FindFirstChild(u1.Name .. "\'s Clouds").ZeusRoot
            v28:SetAttribute("Released", true)
            v28:FireServer(v32.Position)
            if u18.Flying == nil then
                _G.mouseLevel = false
                _G.FaceMouse = false
                u21.PrimaryPart.Anchored = true
                task.wait(0.75)
                u21.PrimaryPart.Anchored = false
            end
        end
        _G.mouseLevel = false
        _G.FaceMouse = false
        _G.canuse = true
        _G.keysetup:cooldown("Thunder Drop", v24)
        _G.fw(v24)
        v20["Thunder Drop"] = false
    end
end
function u9.StormCircuit(p33, _) --[[ Line: 173 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v34 = p33.Cooldowns
    local v35 = u1.Character
    local _ = u3["Stats" .. u1.Name]
    if _G.check:inspect(v35) == true then
        if v34["Storm Circuit"] == true then
            return
        end
        if workspace.Effects:FindFirstChild((("%*\'s Clouds"):format(u1.Name))).Zeus:GetAttribute("CustomMover") then
            _G.displayMessage("<Color=Red>Cant use this while flying!")
            return
        end
        local v36 = u4.GetM("Storm Circuit")
        local v37 = v36.cd
        if v36.customCDInfo.FunctionCheck(u1, v35) == false then
            return
        end
        if _G.StamCheck("Storm Circuit") == false then
            return
        end
        if v36.statreq and _G.MeetReq(v36.statreq) == false then
            return
        end
        if v35:GetAttribute("ZeusBusy") then
            return
        end
        v34["Storm Circuit"] = true
        local v38 = workspace.CurrentCamera.CFrame.Position
        local v39 = p33:GetMouseCFrame()
        local v40 = (v39.Position - v38).Unit
        local v41 = RaycastParams.new()
        v41.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
        v41.FilterType = Enum.RaycastFilterType.Include
        local v42 = workspace:Raycast(v38, v40 * 200, v41)
        local v43
        if v42 then
            v43 = v42.Position + v42.Normal * 5
        else
            v43 = v38 + (v39.Position - v38).Unit * 200
        end
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Storm Circuit", CFrame.new(v43))
        _G.canuse = true
        if v36.customCDInfo.FunctionCheck(u1, v35) == false and v37 >= 0.2 then
            v37 = v36.customCDInfo.FullCooldown
        end
        _G.keysetup:cooldown("Storm Circuit", v37)
        _G.fw(v37)
        v34["Storm Circuit"] = false
    end
end
function u9.StormChaser(p44, _) --[[ Line: 245 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v45 = p44.Cooldowns
    local v46 = u1.Character
    local _ = u3["Stats" .. u1.Name]
    if _G.check:inspect(v46) == true then
        if v45["Storm Chaser"] == true then
            return
        end
        if workspace.Effects:FindFirstChild((("%*\'s Clouds"):format(u1.Name))).Zeus:GetAttribute("CustomMover") then
            _G.displayMessage("<Color=Red>Cant use this while flying!")
            return
        end
        local v47 = u4.GetM("Storm Chaser")
        local v48 = v47.cd
        if _G.StamCheck("Storm Chaser") == false then
            return
        end
        if v47.statreq and _G.MeetReq(v47.statreq) == false then
            return
        end
        if v46:GetAttribute("ZeusBusy") then
            return
        end
        local v49 = _G.getTargetNearMouse(300)
        if v49 == nil then
            _G.displayMessage("<Color=Red>No targets")
            return
        end
        v45["Storm Chaser"] = true
        _G.canuse = false
        v46:SetPrimaryPartCFrame(CFrame.new(v46.PrimaryPart.Position, v49.Position))
        v46.Humanoid:LoadAnimation(script.SendZeus):Play()
        task.wait(0.27)
        if _G.check:inspect(v46) == true then
            game.ReplicatedStorage.Events.Skill:InvokeServer("Storm Chaser", {
                ["target"] = v49,
                ["startCFrame"] = v46.PrimaryPart.CFrame
            })
        end
        task.wait(0.07999999999999996)
        _G.canuse = true
        _G.keysetup:cooldown("Storm Chaser", v48)
        _G.fw(v48)
        v45["Storm Chaser"] = false
    end
end
function u9.ProminenceRay(u50, p51) --[[ Line: 308 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v52 = u50.Cooldowns
    local u53 = u1.Character
    local u54 = u3["Stats" .. u1.Name]
    if _G.check:inspect(u53) == true and _G.StamCheck("Prominence Ray") == true then
        local v55 = u4.GetM("Prominence Ray")
        local v56 = v55.cd
        if v52["Prominence Ray"] == true then
            return
        end
        if u53:GetAttribute("SunBusy") then
            return
        end
        if v55.statreq and _G.MeetReq(v55.statreq) == false then
            return
        end
        _G.canuse = false
        v52["Prominence Ray"] = true
        local u57 = os.clock()
        _G.FaceMouse = true
        _G.mouseLevel = true
        local v58 = game.ReplicatedStorage.Events.Skill:InvokeServer("Prominence Ray", u50:GetMouseCFrame().Position)
        local u59, u60
        if v58 then
            u59, u60 = unpack(v58)
        else
            u60 = nil
            u59 = nil
        end
        u50.Tool:FindFirstChild("UpdateHomies", true)
        local function v61(_) --[[ Line: 346 ]]
            --[[
            Upvalues:
                [1] = u53
                [2] = u60
                [3] = u50
                [4] = u59
                [5] = u54
                [6] = u57
            --]]
            u53.Humanoid.WalkSpeed = 4
            if u60 then
                u60:FireServer(u50:GetMouseCFrame().Position)
            end
            if not u59 then
                return true
            end
            if u50.Tool.Parent ~= u53 or (u53.Parent == nil or (u53.Parent ~= workspace.PlayerCharacters or (u54.Stamina.Value <= 0 or (os.clock() - u57 >= 5 or _G.check:inspect(u53) == false)))) then
                return true
            end
        end
        u50:ChargeSkill(p51, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = v61,
            ["IgnoreInstantCastSetting"] = true
        })
        u53.Humanoid.WalkSpeed = 16
        if u59 then
            u59:FireServer("Finished")
        end
        _G.FaceMouse = false
        _G.mouseLevel = false
        _G.canuse = true
        _G.keysetup:cooldown("Prominence Ray", v56)
        _G.fw(v56)
        v52["Prominence Ray"] = false
    end
end
u9["Bon-BonFireball"] = function(p62, _) --[[ Line: 382 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v63 = p62.Cooldowns
    local v64 = u1.Character
    local _ = u3["Stats" .. u1.Name]
    if _G.check:inspect(v64) == true then
        if v63["Bon-Bon Fireball"] == true then
            return
        end
        local v65 = u4.GetM("Bon-Bon Fireball")
        local v66 = v65.cd
        if _G.StamCheck("Bon-Bon Fireball") == false then
            return
        end
        if v65.statreq and _G.MeetReq(v65.statreq) == false then
            return
        end
        if v64:GetAttribute("SunBusy") then
            return
        end
        local v67 = workspace.Effects:FindFirstChild((("%*\'s Clouds"):format(u1.Name)))
        local v68 = v67.Prometheus
        local v69 = v67.PrometheusRoot
        local _ = v68.PrimaryPart
        v63["Bon-Bon Fireball"] = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Bon-Bon Fireball", {
            ["MousePosition"] = p62:GetMouseCFrame().Position,
            ["SunCFrame"] = v69.CFrame
        })
        _G.keysetup:cooldown("Bon-Bon Fireball", v66)
        _G.fw(v66)
        v63["Bon-Bon Fireball"] = false
    end
end
u9["Bon-BonBomb"] = function(u70, p71) --[[ Line: 422 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
        [4] = u2
    --]]
    local v72 = u70.Cooldowns
    local u73 = u1.Character
    local u74 = u3["Stats" .. u1.Name]
    local _ = u73.RightHand
    if _G.check:inspect(u73) == true and _G.StamCheck("Bon-Bon Bomb") == true then
        if v72["Bon-Bon Bomb"] == true then
            return
        end
        if u73:GetAttribute("SunBusy") then
            return
        end
        local v75 = u4.GetM("Bon-Bon Bomb")
        local v76 = v75.cd
        if v75.statreq and _G.MeetReq(v75.statreq) == false then
            return
        end
        local v77 = workspace.Effects:FindFirstChild((("%*\'s Clouds"):format(u1.Name)))
        local _ = v77.Prometheus.RootPart
        local u78 = v77.PrometheusRoot
        local v79 = u73.Humanoid.Animator:LoadAnimation(script.BombCharge)
        v79:Play()
        _G.FaceMouse = true
        _G.canuse = false
        v72["Bon-Bon Bomb"] = true
        local u80 = os.clock()
        local u81 = game.ReplicatedStorage.Events.Skill:InvokeServer("Bon-Bon Bomb")
        local u82 = os.clock()
        local v92 = u2.Heartbeat:Connect(function(_) --[[ Line: 458 ]]
            --[[
            Upvalues:
                [1] = u82
                [2] = u73
                [3] = u78
            --]]
            local v83 = (os.clock() - u82) * 3
            local v84 = math.clamp(v83, 0, 1)
            local v85 = 1 - v84
            local v86 = CFrame.new
            local v87 = u73.RightHand.CFrame
            local v88 = CFrame.Angles
            local v89 = v84 * 360
            local v90 = v86(v87 * v88(0, math.rad(v89), 0) * CFrame.new(0, v85 * -2, v85 * 5).Position, u73.PrimaryPart.CFrame * CFrame.new(0, 5, 25).Position)
            local v91 = u78.CFrame:Lerp(v90, v84)
            u78.BodyPosition.Position = v91.Position
            u78.BodyGyro.CFrame = v91
            u78.CFrame = v91
        end)
        u70:ChargeSkill(p71, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function(_) --[[ Name: endFunction, Line 470 ]]
                --[[
                Upvalues:
                    [1] = u81
                    [2] = u70
                    [3] = u73
                    [4] = u74
                    [5] = u80
                --]]
                if not u81 then
                    return true
                end
                if u70.Tool.Parent ~= u73 or (u73.Parent == nil or (u73.Parent ~= workspace.PlayerCharacters or (u74.Stamina.Value <= 0 or (os.clock() - u80 >= 5 or _G.check:inspect(u73) == false)))) then
                    return true
                end
            end,
            ["HoldDuration"] = 0.3
        })
        v79:Stop()
        u73.PrimaryPart.Anchored = true
        _G.FaceMouse = false
        u73.Humanoid.Animator:LoadAnimation(script.BombThrow):Play()
        local v93 = u70:GetMouseCFrame().Position
        local v94 = u78.CFrame
        task.wait(0.15)
        if u81 then
            u81:FireServer(v93, v94)
        end
        v92:Disconnect()
        task.wait(0.3)
        u73.PrimaryPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Bon-Bon Bomb", v76)
        _G.fw(v76)
        v72["Bon-Bon Bomb"] = false
    end
end
function u9.NimbusRide(u95, p96) --[[ Line: 517 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
        [4] = u2
        [5] = u7
    --]]
    local u97 = u95.Cooldowns
    local u98 = u1.Character
    local u99 = u3["Stats" .. u1.Name]
    local _ = u98.RightHand
    if _G.check:inspect(u98) == true and _G.StamCheck("Nimbus Ride") == true then
        if u97["Nimbus Ride"] == true then
            return
        end
        if u98:GetAttribute("ZeusBusy") then
            return
        end
        local v100 = u4.GetM("Nimbus Ride")
        local u101 = v100.cd
        if v100.statreq and _G.MeetReq(v100.statreq) == false then
            return
        end
        local v102 = workspace.Effects:FindFirstChild((("%*\'s Clouds"):format(u1.Name)))
        local u103 = v102.Zeus
        local _ = u103.RootPart
        local v104 = v102.ZeusRoot
        u97["Nimbus Ride"] = true
        _G.canM1 = false
        _G.canuse = false
        local u105 = game.ReplicatedStorage.Events.Skill:InvokeServer("Nimbus Ride")
        local u106 = workspace.CurrentCamera
        local v107 = u98.Humanoid
        local u108 = v104.BodyPosition
        local u109 = v104.BodyGyro
        v107.PlatformStand = true
        local u110 = u98.PrimaryPart
        local u111 = u110.AssemblyMass
        local u112 = Vector3.new(0, 1, 0) * u111 * workspace.Gravity
        local u113 = Instance.new("VectorForce")
        u113.Attachment0 = u110:FindFirstChild("RootRigAttachment")
        u113.RelativeTo = Enum.ActuatorRelativeTo.World
        u113.Parent = u110
        local u114 = Instance.new("AlignOrientation")
        u114.Attachment0 = u113.Attachment0
        u114.CFrame = CFrame.new()
        u114.MaxTorque = 50000
        u114.Mode = Enum.OrientationAlignmentMode.OneAttachment
        u114.Parent = u110
        u114.CFrame = CFrame.lookAlong(u106.CFrame.Position, (Vector3.new(0, 1, 0)):Cross(u106.CFrame.RightVector))
        local u115 = u103.AnimationController:LoadAnimation(script.FlyAnims.ZeusFly)
        u115:Play()
        u115.Priority = Enum.AnimationPriority.Action3
        local u116 = u98.Humanoid:LoadAnimation(script.FlyAnims.CharFly)
        u116:Play()
        u116.Priority = Enum.AnimationPriority.Action3
        local u117 = u98.Humanoid
        u117:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        u95.Flying = u2.RenderStepped:Connect(function(_) --[[ Line: 586 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u106
                [3] = u98
                [4] = u111
                [5] = u110
                [6] = u103
                [7] = u108
                [8] = u109
                [9] = u117
                [10] = u114
                [11] = u113
                [12] = u112
                [13] = u95
            --]]
            local v118 = u7:GetMoveVector()
            local v119 = u106.CFrame.RightVector * v118.X + u106.CFrame.LookVector * -v118.Z
            local v120 = 125
            if u98:FindFirstChild("inCombat") == nil then
                v120 = v120 * 1.3
            end
            local v121 = u98.Humanoid.Health / u98.Humanoid.MaxHealth
            local v122 = v120 * (v121 > 0.25 and 1 or v121)
            if u98:FindFirstChild("Blocking") then
                v122 = v122 / 7
            end
            if _G.check:inspect(u98) == false then
                v122 = v122 / 10
            end
            local v123 = _G.canuse == false and 0 or v122
            local v124 = v119 * u111 * v123
            local v125 = u110.AssemblyLinearVelocity * u111 * 2
            local v126 = u103:GetScale() or 1
            local v127 = u110.CFrame * CFrame.new(0, -3 * v126, 0)
            u108.Position = v127.Position
            u109.CFrame = v127
            if u117.MoveDirection ~= Vector3.new() then
                u114.CFrame = CFrame.lookAlong(u106.CFrame.Position, (Vector3.new(0, 1, 0)):Cross(u106.CFrame.RightVector))
            end
            u113.Force = u112 + v124 - v125
            u117.PlatformStand = true
            _G.canM1 = false
            local v128 = u98:FindFirstChildWhichIsA("Tool")
            if v128 and v128 ~= u95.Tool then
                task.defer(function() --[[ Line: 630 ]]
                    --[[
                    Upvalues:
                        [1] = u98
                    --]]
                    u98.Humanoid:UnequipTools()
                end)
            end
        end)
        local u129 = tick()
        _G.canuse = true
        u95:DoubleCastSkill(p96, {
            ["ToolName"] = script.Name,
            ["Button"] = p96,
            ["Key"] = Enum.KeyCode.T,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 667 ]]
                --[[
                Upvalues:
                    [1] = u98
                    [2] = u129
                    [3] = u117
                    [4] = u99
                --]]
                if u98:FindFirstChild("inCombat") then
                    if tick() - u129 >= 30 then
                        return true
                    end
                    if u98:FindFirstChild("PB") then
                        return true
                    end
                    if u117.SeatPart ~= nil then
                        return true
                    end
                end
                return (u98.Parent ~= workspace.PlayerCharacters or (u99.Stamina.Value <= 0 or _G.grounded == true)) and true or u98:GetAttribute("ZeusFlying") == nil
            end,
            ["CompleteFunction"] = function() --[[ Name: finishFunction, Line 638 ]]
                --[[
                Upvalues:
                    [1] = u95
                    [2] = u105
                    [3] = u115
                    [4] = u116
                    [5] = u98
                    [6] = u114
                    [7] = u113
                    [8] = u101
                    [9] = u117
                    [10] = u97
                --]]
                if u95.Flying then
                    u95.Flying:Disconnect()
                    u95.Flying = nil
                end
                if u105 then
                    u105:FireServer()
                end
                u115:Stop()
                u116:Stop()
                u98.Humanoid.PlatformStand = false
                u114:Destroy()
                u113:Destroy()
                _G.keysetup:cooldown("Nimbus Ride", u101)
                _G.canM1 = true
                u117:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                _G.fw(u101)
                u97["Nimbus Ride"] = false
            end,
            ["SkipTap"] = true
        })
    end
end
function u9.SoulRage(p130, _) --[[ Line: 690 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v131 = p130.Cooldowns
    local v132 = u1.Character
    local _ = u3["Stats" .. u1.Name]
    if _G.check:inspect(v132) == true then
        if v131["Soul Rage"] == true then
            return
        end
        local v133 = u4.GetM("Soul Rage")
        local v134 = v133.cd
        if _G.StamCheck("Soul Rage") == false then
            return
        end
        if v133.statreq and _G.MeetReq(v133.statreq) == false then
            return
        end
        v131["Soul Rage"] = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Soul Rage")
        _G.keysetup:cooldown("Soul Rage", v134)
        _G.fw(v134)
        v131["Soul Rage"] = false
    end
end
u9["Bon-BonTorch"] = function(u135, p136) --[[ Line: 723 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v137 = u135.Cooldowns
    local u138 = u1.Character
    local u139 = u3["Stats" .. u1.Name]
    if _G.check:inspect(u138) == true and _G.StamCheck("Bon-Bon Torch") == true then
        local v140 = u4.GetM("Bon-Bon Torch")
        local v141 = v140.cd
        if v137["Bon-Bon Torch"] == true then
            return
        end
        if v140.statreq and _G.MeetReq(v140.statreq) == false then
            return
        end
        if u138:GetAttribute("SunBusy") then
            return
        end
        local u142 = os.clock()
        v137["Bon-Bon Torch"] = true
        _G.canuse = false
        _G.FaceMouse = true
        local u143 = game.ReplicatedStorage.Events.Skill:InvokeServer("Bon-Bon Torch")
        u135:ChargeSkill(p136, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function(_) --[[ Name: endFunction, Line 750 ]]
                --[[
                Upvalues:
                    [1] = u143
                    [2] = u135
                    [3] = u138
                    [4] = u139
                    [5] = u142
                --]]
                if not u143 then
                    return true
                end
                if u135.Tool.Parent ~= u138 or (u138.Parent == nil or (u138.Parent ~= workspace.PlayerCharacters or (u139.Stamina.Value <= 0 or (os.clock() - u142 >= 5 or _G.check:inspect(u138) == false)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true,
            ["HoldDuration"] = 0.35
        })
        if u143 then
            u143:FireServer("Finished")
        end
        _G.FaceMouse = false
        u138.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Bon-Bon Torch", v141)
        _G.fw(v141)
        v137["Bon-Bon Torch"] = nil
    end
end
function u9.SunfallCataclysm(u144, p145) --[[ Line: 782 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v146 = u144.Cooldowns
    local u147 = u1.Character
    local u148 = u3["Stats" .. u1.Name]
    if _G.check:inspect(u147) == true and _G.StamCheck("Sunfall Cataclysm") == true then
        local v149 = u4.GetM("Sunfall Cataclysm")
        local v150 = v149.cd
        if v146["Sunfall Cataclysm"] == true then
            return
        end
        if u147:GetAttribute("SunBusy") then
            return
        end
        if v149.statreq and _G.MeetReq(v149.statreq) == false then
            return
        end
        local u151 = os.clock()
        v146["Sunfall Cataclysm"] = true
        _G.canuse = false
        _G.FaceMouse = true
        local u152 = game.ReplicatedStorage.Events.Skill:InvokeServer("Sunfall Cataclysm")
        local v153 = u147.Humanoid:LoadAnimation(script.SunUlt.Loop)
        v153:Play()
        local v154 = workspace.Effects[u147.Name .. "\'s Clouds"].Prometheus
        u144:ChargeSkill(p145, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function(_) --[[ Name: endFunction, Line 813 ]]
                --[[
                Upvalues:
                    [1] = u152
                    [2] = u144
                    [3] = u147
                    [4] = u148
                    [5] = u151
                --]]
                if not u152 then
                    return true
                end
                if u144.Tool.Parent ~= u147 or (u147.Parent == nil or (u147.Parent ~= workspace.PlayerCharacters or (u148.Stamina.Value <= 0 or (os.clock() - u151 >= 4 or _G.check:inspect(u147) == false)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v153:Stop()
        u147.Humanoid:LoadAnimation(script.SunUlt.Release):Play()
        if u152 then
            u152:FireServer(u144:GetMouseCFrame().Position, v154:GetScale(), v154.PrimaryPart.CFrame)
        end
        _G.FaceMouse = false
        u147.PrimaryPart.Anchored = true
        task.wait(0.75)
        u147.PrimaryPart.Anchored = false
        u147.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Sunfall Cataclysm", v150)
        _G.fw(v150)
        v146["Sunfall Cataclysm"] = nil
    end
end
local function u162(p155, p156) --[[ Line: 854 ]]
    local v157 = p155.PrimaryPart.Position
    local v158 = Vector3.new(0, p156, 0)
    local v159 = RaycastParams.new()
    v159.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
    v159.FilterType = Enum.RaycastFilterType.Include
    v159.RespectCanCollide = true
    local v160 = workspace:Raycast(v157, v158, v159)
    if not (v160 and v160.Instance) then
        return p155.PrimaryPart.CFrame * CFrame.new(0, p156, 0)
    end
    local v161 = (v160.Position - v157).Magnitude - 0.5
    math.min(p156, v161)
    return p155.PrimaryPart.CFrame
end
function u9.ZigzagBolt(u163, p164) --[[ Line: 874 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
        [4] = u162
    --]]
    local v165 = u163.Cooldowns
    local u166 = u1.Character
    local u167 = u3["Stats" .. u1.Name]
    if _G.check:inspect(u166) == true and _G.StamCheck("Zigzag Bolt") == true then
        local v168 = u4.GetM("Zigzag Bolt")
        local v169 = v168.cd
        if v165["Zigzag Bolt"] == true then
            return
        end
        if u166:GetAttribute("ZeusBusy") then
            return
        end
        if v168.statreq and _G.MeetReq(v168.statreq) == false then
            return
        end
        local u170 = os.clock()
        v165["Zigzag Bolt"] = true
        _G.canuse = false
        local v171 = workspace.Effects:FindFirstChild((("%*\'s Clouds"):format(u1.Name)))
        local v172 = v171.Zeus
        local u173 = v171.ZeusRoot
        v172:SetAttribute("CustomMovement", true)
        u166.PrimaryPart.CFrame = u162(u166, 5)
        local _ = u166.PrimaryPart
        local v174 = u166.Humanoid
        v174.PlatformStand = true
        local v175 = v174:LoadAnimation(script.ZigzagCharge)
        v175:Play()
        v175.Priority = Enum.AnimationPriority.Action2
        local v176 = v172.RageModel.AnimationController:LoadAnimation(u3.Assets.SoulHomies.Animations.ZeusRageIdle)
        v176:Play()
        v176.Priority = Enum.AnimationPriority.Action2
        _G.FaceMouse = true
        local u177 = game.ReplicatedStorage.Events.Skill:InvokeServer("Zigzag Bolt", u166.PrimaryPart.CFrame)
        local _ = workspace.Effects[u166.Name .. "\'s Clouds"].Prometheus
        u163:ChargeSkill(p164, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function(_) --[[ Name: endFunction, Line 923 ]]
                --[[
                Upvalues:
                    [1] = u177
                    [2] = u173
                    [3] = u166
                    [4] = u163
                    [5] = u167
                    [6] = u170
                --]]
                if not u177 then
                    return true
                end
                u173.CFrame = u166.PrimaryPart.CFrame * CFrame.new(0, -4, 0)
                if u163.Tool.Parent ~= u166 or (u166.Parent == nil or (u166.Parent ~= workspace.PlayerCharacters or (u167.Stamina.Value <= 0 or (os.clock() - u170 >= 5 or _G.check:inspect(u166) == false)))) then
                    return true
                end
            end,
            ["HoldDuration"] = 0.15
        })
        v174.PlatformStand = false
        if u177 then
            u177:InvokeServer(u163:GetMouseCFrame().Position)
        end
        v175:Stop()
        v176:Stop()
        _G.FaceMouse = false
        u166.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Zigzag Bolt", v169)
        _G.fw(v169)
        v165["Zigzag Bolt"] = nil
    end
end
function u9.RaijinPlunge(u178, p179) --[[ Line: 963 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
        [4] = u162
    --]]
    local v180 = u178.Cooldowns
    local u181 = u1.Character
    local u182 = u3["Stats" .. u1.Name]
    if _G.check:inspect(u181) == true and _G.StamCheck("Raijin Plunge") == true then
        local v183 = u4.GetM("Raijin Plunge")
        local v184 = v183.cd
        if v180["Raijin Plunge"] == true then
            return
        end
        if u181:GetAttribute("ZeusBusy") then
            return
        end
        if v183.statreq and _G.MeetReq(v183.statreq) == false then
            return
        end
        local u185 = os.clock()
        v180["Raijin Plunge"] = true
        u181.PrimaryPart.CFrame = u162(u181, 5)
        _G.canuse = false
        _G.FaceMouse = true
        local u186 = game.ReplicatedStorage.Events.Skill:InvokeServer("Raijin Plunge", u181.PrimaryPart.CFrame)
        local _ = workspace.Effects[u181.Name .. "\'s Clouds"].Prometheus
        u178:ChargeSkill(p179, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function(_) --[[ Name: endFunction, Line 992 ]]
                --[[
                Upvalues:
                    [1] = u186
                    [2] = u178
                    [3] = u181
                    [4] = u182
                    [5] = u185
                --]]
                if not u186 then
                    return true
                end
                if u178.Tool.Parent ~= u181 or (u181.Parent == nil or (u181.Parent ~= workspace.PlayerCharacters or (u182.Stamina.Value <= 0 or (os.clock() - u185 >= 5 or _G.check:inspect(u181) == false)))) then
                    return true
                end
            end,
            ["HoldDuration"] = 0.1
        })
        _G.FaceMouse = false
        local v187 = Instance.new("BodyVelocity")
        v187.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
        v187.Velocity = Vector3.new()
        v187.Parent = u181.PrimaryPart
        u181.Humanoid.AutoRotate = false
        if u186 then
            u186:InvokeServer(u178:GetMouseCFrame().Position)
        end
        v187:Destroy()
        u181.Humanoid.AutoRotate = true
        u181.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Raijin Plunge", v184)
        _G.fw(v184)
        v180["Raijin Plunge"] = nil
    end
end
function u9.DivineThunderfall(u188, p189) --[[ Line: 1034 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v190 = u188.Cooldowns
    local u191 = u1.Character
    local _ = u3["Stats" .. u1.Name]
    if _G.check:inspect(u191) == true and _G.StamCheck("Divine Thunderfall") == true then
        local v192 = u4.GetM("Divine Thunderfall")
        local v193 = v192.cd
        if v190["Divine Thunderfall"] == true then
            return
        end
        if u191:GetAttribute("ZeusBusy") then
            return
        end
        if v192.statreq and _G.MeetReq(v192.statreq) == false then
            return
        end
        local u194 = os.clock()
        v190["Divine Thunderfall"] = true
        _G.canuse = false
        os.clock()
        local v195 = workspace.Effects[u191.Name .. "\'s Clouds"]
        local _ = v195.Zeus
        local u196 = v195.ZeusRoot
        local u197 = u191.HumanoidRootPart
        local _ = u196.BodyPosition
        if u191.HumanoidRootPart:FindFirstChild("ComboBP") == nil then
            local v198 = Instance.new("BodyVelocity", u191.LowerTorso)
            v198.Name = "geppo"
            v198.MaxForce = Vector3.new(1000000000, 10000000000000000, 1000000000)
            v198.Velocity = u191.HumanoidRootPart.CFrame.upVector * 100
            v198.P = 4324234234
            _G.destroy(v198, 0.25)
            task.delay(0.2, function() --[[ Line: 1078 ]]
                _G.FaceMouse = true
            end)
        end
        local v199 = game.ReplicatedStorage.Events.Skill:InvokeServer("Divine Thunderfall")
        local u200, v201
        if v199 then
            u200, v201 = unpack(v199)
        else
            u200 = nil
            v201 = nil
        end
        local u202 = 0
        local u230 = task.spawn(function() --[[ Line: 1093 ]]
            --[[
            Upvalues:
                [1] = u196
                [2] = u202
                [3] = u188
                [4] = u197
            --]]
            local v203 = u196.CFrame
            local v204 = v203.Position
            local v205 = 0.5
            local v206 = 10
            local v207 = Vector3.new(0, 0, 0)
            while true do
                local v208 = task.wait()
                local v209 = u202 / 2
                local v210 = math.min(v209, 1)
                local v211 = v210 >= 1
                local v212 = 18.84955592153876 * v210
                local v213 = math.sin(v212)
                local v214 = 18.84955592153876 * v210
                local v215 = math.cos(v214)
                local v216 = Vector3.new(v213, 0, v215)
                local v217 = v210 * 3.141592653589793
                local v218 = v216 * math.sin(v217) * 25
                local v219 = u188:GetMousePosition()
                local v220 = Vector3.new(0, 50, 0) * v210
                u202 = u202 + v208
                v205 = v205 + ((v211 and 1.5 or 0.5) - v205) * v208 * 2
                v206 = v206 + ((v211 and 11 or 10) - v206) * v208 * 2
                local v221 = v219.X
                local v222 = u197.Position.Y
                local v223 = v219.Z
                local v224 = Vector3.new(v221, v222, v223) - u197.Position
                if v224.Magnitude > 200 then
                    v224 = v224.Unit * 200
                end
                v207 = v207:Lerp(v224, v208 * v205)
                local v225 = u197.Position + v218 + v207 + v220
                if (v225 - v204).Magnitude > 0.1 then
                    local v226 = CFrame.new
                    local v227 = v225.X
                    local v228 = v204.Y
                    local v229 = v225.Z
                    v203 = v203:Lerp(v226(v204, (Vector3.new(v227, v228, v229))), v208 * v206)
                end
                u196.BodyGyro.CFrame = v203
                u196.BodyPosition.Position = v225
                v204 = v225
            end
        end)
        if u200 then
            function u200.OnClientInvoke() --[[ Line: 1143 ]]
                --[[
                Upvalues:
                    [1] = u230
                --]]
                task.defer(task.cancel, u230)
            end
        end
        u188:ChargeSkill(p189, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function(_) --[[ Name: endFunction, Line 1148 ]]
                --[[
                Upvalues:
                    [1] = u200
                    [2] = u188
                    [3] = u191
                    [4] = u194
                --]]
                if not u200 then
                    return true
                end
                if u188.Tool.Parent ~= u191 or (u191.Parent == nil or (u191.Parent ~= workspace.PlayerCharacters or os.clock() - u194 >= 5)) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        task.spawn(function() --[[ Line: 1166 ]]
            --[[
            Upvalues:
                [1] = u200
            --]]
            if u200 then
                u200:InvokeServer("Finished")
            end
        end)
        if v201 and v201:GetAttribute("ThunderStart") == nil then
            repeat
                task.wait()
            until v201:GetAttribute("ThunderStart")
        end
        if v201 and v201:GetAttribute("Ended") == nil then
            repeat
                task.wait()
            until v201:GetAttribute("Ended") or v201:IsDescendantOf(game) == false
        end
        _G.FaceMouse = false
        _G.canuse = true
        _G.keysetup:cooldown("Divine Thunderfall", v193)
        _G.fw(v193)
        v190["Divine Thunderfall"] = nil
    end
end
function u9.ProminencePunch(u231, p232) --[[ Line: 1193 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v233 = u231.Cooldowns
    local u234 = u1.Character
    local u235 = u3["Stats" .. u1.Name]
    local _ = u234.RightHand
    if _G.check:inspect(u234) == true and _G.StamCheck("Prominence Punch") == true then
        local v236 = u4.GetM("Prominence Punch")
        local v237 = v236.cd
        if v233["Prominence Punch"] == true then
            return
        end
        if u234:GetAttribute("SunBusy") then
            return
        end
        if v236.statreq and _G.MeetReq(v236.statreq) == false then
            return
        end
        local _ = workspace.Effects[u234.Name .. "\'s Clouds"].Prometheus.RootPart
        local u238 = os.clock()
        v233["Prominence Punch"] = true
        _G.canuse = false
        _G.FaceMouse = true
        local v239 = u234.Humanoid:LoadAnimation(script.CharPunch)
        v239:Play()
        local u240 = game.ReplicatedStorage.Events.Skill:InvokeServer("Prominence Punch")
        u231:ChargeSkill(p232, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function(_) --[[ Name: endFunction, Line 1230 ]]
                --[[
                Upvalues:
                    [1] = u240
                    [2] = u231
                    [3] = u234
                    [4] = u235
                    [5] = u238
                --]]
                if not u240 then
                    return true
                end
                if u231.Tool.Parent ~= u234 or (u234.Parent == nil or (u234.Parent ~= workspace.PlayerCharacters or (u235.Stamina.Value <= 0 or (os.clock() - u238 >= 5 or _G.check:inspect(u234) == false)))) then
                    return true
                end
            end,
            ["HoldDuration"] = 0.3
        })
        v239:Stop()
        u234.Humanoid:LoadAnimation(script.CharPunchRelease):Play()
        _G.FaceMouse = false
        if u240 then
            u234.PrimaryPart.Anchored = true
            u240:FireServer(u231:GetMousePosition())
            task.wait(0.6)
            u234.PrimaryPart.Anchored = false
        end
        task.wait()
        _G.canuse = true
        _G.keysetup:cooldown("Prominence Punch", v237)
        _G.fw(v237)
        v233["Prominence Punch"] = nil
    end
end
function u9.SoulSummoning(p241, _) --[[ Line: 1268 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u4
    --]]
    local v242 = p241.Cooldowns
    local v243 = u1.Character
    local _ = u3["Stats" .. u1.Name]
    if _G.check:inspect(v243) == true then
        if v242["Soul Summoning"] == true then
            return
        end
        local v244 = u4.GetM("Soul Summoning")
        local v245 = v244.cd
        if _G.StamCheck("Soul Summoning") == false then
            return
        end
        if v244.statreq and _G.MeetReq(v244.statreq) == false then
            return
        end
        v242["Soul Summoning"] = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Soul Summoning")
        if v243:GetAttribute("SoulSummonMode") == true then
            if p241.SoulSummonUI == nil then
                p241.SoulSummonUI = script.SoulSummonUI:Clone()
                p241.SoulSummonUI.ImageLabel.ImageTransparency = 1
                p241.SoulSummonUI.Parent = u1.PlayerGui
                _G.tween(p241.SoulSummonUI.ImageLabel, {
                    0.25,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["ImageTransparency"] = script.SoulSummonUI.ImageLabel.ImageTransparency
                })
            end
        elseif p241.SoulSummonUI then
            _G.tween(p241.SoulSummonUI.ImageLabel, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["ImageTransparency"] = 1
            })
            _G.destroy(p241.SoulSummonUI, 0.25)
            p241.SoulSummonUI = nil
        end
        _G.keysetup:cooldown("Soul Summoning", v245)
        _G.fw(v245)
        v242["Soul Summoning"] = false
    end
end
for _, u246 in ipairs({ "Lick, the Lollipop", "Crumbleshot, the Cake", "Gloomroot, the Tree" }) do
    u9[u246:gsub("%s", "")] = function(p247) --[[ Line: 1327 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u3
            [3] = u246
            [4] = u4
        --]]
        local v248 = p247.Cooldowns
        local v249 = u1.Character
        local _ = u3["Stats" .. u1.Name]
        if _G.check:inspect(v249) == true then
            local v250 = u246
            if v248[v250] == true then
                return
            end
            local v251 = u4.GetM(v250)
            local v252 = v251.cd
            if _G.StamCheck(v250) == false then
                return
            end
            if v251.statreq and _G.MeetReq(v251.statreq) == false then
                return
            end
            v248[v250] = true
            _G.canuse = false
            v249.Humanoid.WalkSpeed = 4
            game.ReplicatedStorage.Events.Skill:InvokeServer(v250, {
                ["SpawnCFrame"] = p247:GetMouseCFrame()
            })
            _G.canuse = true
            v249.Humanoid.WalkSpeed = 16
            _G.keysetup:cooldown(v250, v252)
            _G.fw(v252)
            v248[v250] = false
        end
    end
end
return u9