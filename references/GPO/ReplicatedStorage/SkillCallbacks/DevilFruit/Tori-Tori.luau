 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = game:GetService("TweenService")
local u4 = require(game.ReplicatedStorage.Modules.Skills)
local u5 = require(script.Parent.Parent.MobileBase)
local v6 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
game:GetService("UserInputService")
u1:GetMouse()
local u7 = v6:GetControls()
local u8 = setmetatable({}, u5)
u8.__index = u8
local u9 = {
    { "Block", "f" },
    { "Triple Talon Kick", "e" },
    { "Talon Barrage", "r" },
    { "Phoenix Pyreapple", "t" },
    { "Phoenix Transformation", "z" },
    { "Phoenix Burst", "x" },
    { "Phoenix Dive Bomb", "c" }
}
function u8.new(_) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u8
        [3] = u1
        [4] = u3
        [5] = u7
    --]]
    local v10 = u5.new(script.Name)
    local v11 = u8
    local u12 = setmetatable(v10, v11)
    u12.Cooldowns = {
        ["trans"] = false,
        ["carry"] = false,
        ["rapid"] = false,
        ["talon"] = false,
        ["heal"] = false,
        ["block"] = false,
        ["burst"] = false,
        ["brand"] = false,
        ["bomb"] = false,
        ["pburst"] = false
    }
    local u13 = u1.Character
    local u14 = u13.HumanoidRootPart
    local u15 = u13.Humanoid
    local v16 = Instance.new("BodyVelocity")
    v16.Name = "geppo"
    v16.P = (1 / 0)
    v16.MaxForce = Vector3.new(inf, inf, inf)
    v16.Velocity = Vector3.new()
    local v17 = Instance.new("BodyGyro")
    v17.P = 100000
    v17.D = 2000
    v17.MaxTorque = Vector3.new(100000000000, 100000000000, 100000000000)
    u12.bv = v16
    u12.bg = v17
    local u18 = u12.Tool:WaitForChild("flap")
    local u19 = script.VectorForce:Clone()
    u19.Attachment0 = u14:FindFirstChild("RootRigAttachment")
    local u20 = script.AlignOrientation:Clone()
    u20.Attachment0 = u19.Attachment0
    u12.vectorForce = u19
    u12.alignOrientation = u20
    local u21 = {
        ["idle"] = u15:LoadAnimation(script.Flights.Half.idle),
        ["fly"] = u15:LoadAnimation(script.Flights.Half.fly),
        ["fullidle"] = nil,
        ["fullfly"] = nil
    }
    local u22 = {}
    local u23 = {}
    local u24 = 0
    u12.busy = false
    u12.preTransformCNT = nil
    u12.transformed = false
    u13:GetAttributeChangedSignal("Transformed"):Connect(function() --[[ Line: 106 ]]
        --[[
        Upvalues:
            [1] = u12
            [2] = u13
        --]]
        u12.transformed = u13:GetAttribute("Transformed") or false
    end)
    function u12.setFlaps(_) --[[ Line: 110 ]]
        --[[
        Upvalues:
            [1] = u22
            [2] = u13
            [3] = u21
            [4] = u18
        --]]
        task.spawn(function() --[[ Line: 111 ]]
            --[[
            Upvalues:
                [1] = u22
                [2] = u13
                [3] = u21
                [4] = u18
            --]]
            local u25 = u22
            pcall(function() --[[ Line: 86 ]]
                --[[
                Upvalues:
                    [1] = u25
                --]]
                for v26 = 1, #u25 do
                    if u25[v26] then
                        u25[v26]:Disconnect()
                        u25[v26] = nil
                    end
                end
                table.clear(u25)
            end)
            if u13.PhoenixFullForm.Body.Transparency == 1 then
                u22[1] = u21.fly:GetMarkerReachedSignal("Flap"):Connect(function() --[[ Line: 98 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                    --]]
                    if _G.canuse ~= false then
                        u18:FireServer()
                    end
                end)
                u22[2] = u21.idle:GetMarkerReachedSignal("Flap"):Connect(function() --[[ Line: 98 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                    --]]
                    if _G.canuse ~= false then
                        u18:FireServer()
                    end
                end)
            else
                repeat
                    game["Run Service"].Heartbeat:Wait()
                until u21.fullfly ~= nil
                local u27 = u22
                pcall(function() --[[ Line: 86 ]]
                    --[[
                    Upvalues:
                        [1] = u27
                    --]]
                    for v28 = 1, #u27 do
                        if u27[v28] then
                            u27[v28]:Disconnect()
                            u27[v28] = nil
                        end
                    end
                    table.clear(u27)
                end)
                u22[1] = u21.fullfly:GetMarkerReachedSignal("Flap"):Connect(function() --[[ Line: 98 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                    --]]
                    if _G.canuse ~= false then
                        u18:FireServer()
                    end
                end)
                u22[2] = u21.fullidle:GetMarkerReachedSignal("Flap"):Connect(function() --[[ Line: 98 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                    --]]
                    if _G.canuse ~= false then
                        u18:FireServer()
                    end
                end)
            end
        end)
    end
    local function u30() --[[ Line: 134 ]]
        --[[
        Upvalues:
            [1] = u19
            [2] = u20
            [3] = u15
            [4] = u24
            [5] = u21
        --]]
        u19.Parent = nil
        u20.Parent = nil
        u15:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        u15.AutoRotate = true
        u15.PlatformStand = false
        u24 = 0
        for _, v29 in u21 do
            if v29 and v29.IsPlaying == true then
                v29:Stop()
            end
        end
    end
    u12.HeartbeatConnection = game["Run Service"].RenderStepped:Connect(function(p31) --[[ Line: 151 ]]
        --[[
        Upvalues:
            [1] = u14
            [2] = u13
            [3] = u12
            [4] = u15
            [5] = u19
            [6] = u20
            [7] = u3
            [8] = u24
            [9] = u21
            [10] = u7
            [11] = u23
            [12] = u30
        --]]
        if not u14.Anchored then
            if u13:GetAttribute("Transformed") == true then
                local v32 = u13:FindFirstChildWhichIsA("Tool")
                if v32 and v32 ~= u12.Tool then
                    task.defer(function() --[[ Line: 159 ]]
                        --[[
                        Upvalues:
                            [1] = u15
                        --]]
                        u15:UnequipTools()
                    end)
                end
                if u19.Parent == nil then
                    local v33 = u19
                    local v34 = u14.AssemblyLinearVelocity.Y * workspace.Gravity
                    local v35 = math.abs(v34) + 7000
                    v33.Force = Vector3.new(0, v35, 0)
                    u19.Parent = u14
                    u20.CFrame = u14.CFrame
                    u20.Enabled = true
                    u20.Parent = u14
                    local v36 = workspace.Gravity
                    local v37 = Vector3.new(0, v36, 0) * u14.AssemblyMass
                    if v37 ~= v37 then
                        local v38 = workspace.Gravity
                        v37 = Vector3.new(0, v38, 0) * 20
                    end
                    u3:Create(u19, TweenInfo.new(0.25), {
                        ["Force"] = v37
                    }):Play()
                    u24 = 0
                end
                pcall(function() --[[ Line: 181 ]]
                    --[[
                    Upvalues:
                        [1] = u15
                    --]]
                    if u15.SeatPart then
                        u15.PlatformStand = false
                        u15.SeatPart:Sit(nil)
                    end
                end)
                u24 = u24 + p31
                u15.AutoRotate = false
                u15.PlatformStand = true
                u15.Sit = false
                u15:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                local v39 = u13:FindFirstChild("PhoenixFullForm")
                local v40
                if v39 then
                    v40 = v39.Body.Transparency == 0
                else
                    v40 = v39
                end
                local v41, v42, v43
                if v40 then
                    if u21.fullfly == nil then
                        u21.fullfly = v39.AnimationController:LoadAnimation(script.Flights.Full.fly)
                    end
                    if u21.fullidle == nil then
                        u21.fullidle = v39.AnimationController:LoadAnimation(script.Flights.Full.idle)
                    end
                    v41 = u21.fullidle
                    v42 = u21.fullfly
                    v43 = 6000
                else
                    v41 = u21.idle
                    v42 = u21.fly
                    v43 = 4200
                end
                local v44 = u7:GetMoveVector()
                local v45 = workspace.CurrentCamera.CFrame
                local v46 = workspace.Gravity
                local v47 = Vector3.new(0, v46, 0) * u14.AssemblyMass
                if v47 ~= v47 then
                    local v48 = workspace.Gravity
                    v47 = Vector3.new(0, v48, 0) * 20
                end
                local v49 = u24 * (v40 and 4 or 2) * 3.141592653589793 / 1.827
                local v50 = Vector3.new(0, 500, 0) * math.sin(v49)
                local v51 = -(u14.AssemblyLinearVelocity.Magnitude > 0 and u14.AssemblyLinearVelocity.Unit or Vector3.new(0, 0, 0)) * 1.9 * u14.AssemblyMass
                local v52 = u14.AssemblyLinearVelocity.Magnitude
                local v53 = u14.AssemblyLinearVelocity.Magnitude + 1
                local v54 = v51 * math.clamp(v52, 1, v53) ^ 1.2 + v47
                local v55 = _G.FaceMouse == true and true or (u13:FindFirstChild("Stun") or _G.canuse == false)
                local v56 = u13:FindFirstChild("Blocking")
                u20.Enabled = not _G.FaceMouse
                local v57 = u12.busy == true and 0 or 1
                if u13:FindFirstChild("inCombat") then
                    v57 = v57 * 0.5
                end
                local v58 = u15.Health / u15.MaxHealth
                local v59 = v44 == Vector3.new(0, 0, 0) and Vector3.new(0, 0, 0) or CFrame.new(v45.Position, v45 * CFrame.new(v44).Position).LookVector * v43 * v58 * v57
                local v60 = v59:Dot(v59) ~= v59:Dot(v59) and Vector3.new(0, 0, 0) or v59
                if u15.MoveDirection == Vector3.new(0, 0, 0) or v56 ~= nil then
                    if v41 and v41.IsPlaying == false then
                        v41:Play()
                        if u23[v41] then
                            v41.TimePosition = u23[v41]
                        end
                    end
                    if v42 and v42.IsPlaying == true then
                        u23[v42] = v42.TimePosition
                        v42:Stop()
                    end
                else
                    if v41 and v41.IsPlaying == true then
                        u23[v41] = v41.TimePosition
                        v41:Stop()
                    end
                    if v42 and v42.IsPlaying == false then
                        v42:Play()
                        if u23[v42] then
                            v42.TimePosition = u23[v42]
                        end
                    end
                end
                local v61 = nil
                local v62
                if v55 or v56 ~= nil then
                    v62 = v54 + v50
                    if _G.FaceMouse == true then
                        u20.Enabled = true
                        v61 = CFrame.new(u14.Position, u12:GetMouseCFrame().Position)
                    elseif v56 == nil or _G.canuse ~= true then
                        if _G.canuse == false then
                            v61 = u14.CFrame
                        end
                    else
                        v61 = v45
                    end
                else
                    v62 = v54 + v60 + v50
                    if v60 == Vector3.new(0, 0, 0) then
                        v61 = v45
                    else
                        v61 = CFrame.new(Vector3.new(0, 0, 0), v60) or v45
                    end
                end
                if v62 == v62 and (v61 == nil or v61 == v61) then
                    u19.Force = v62
                    if v61 ~= nil then
                        u20.CFrame = v61
                        return
                    end
                else
                    local v63 = v54 == v54 and (v60 == v60 and (v50 == v50 and "add together" or "flap") or "move dir") or "float"
                    warn("NAN MOVEMENT", v63)
                    if v63 ~= "float" then
                        return
                    end
                    if u15.SeatPart then
                        u15.Sit = false
                        return
                    end
                end
            elseif _G.FaceMouse == false and u19.Parent ~= nil then
                u30()
            end
        end
    end)
    return u12
end
function u8.TripleTalonKick(p64, _) --[[ Line: 325 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
    --]]
    local v65 = p64.Cooldowns
    local v66 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v65.talon ~= v66 and (_G.check:inspect(v66) == true and (_G.canuse == true and (_G.StamCheck("Triple Talon Kick") == true and p64.transformed == false))) then
        local v67 = u4.GetM("Triple Talon Kick")
        local v68 = v67.cd
        if _G.StamCheck("Triple Talon Kick") == false then
            return
        end
        if v67.statreq and _G.MeetReq(v67.statreq) == false then
            return
        end
        v65.talon = true
        _G.canuse = false
        v66.Humanoid.WalkSpeed = 6
        local u69 = v66.Humanoid:LoadAnimation(script.CraneTalons)
        u69:Play()
        u69.Priority = Enum.AnimationPriority.Action4
        u69:AdjustWeight(2)
        task.delay(1.39, function() --[[ Line: 349 ]]
            --[[
            Upvalues:
                [1] = u69
            --]]
            u69:AdjustSpeed(0.45)
            task.wait(0.5)
            u69:Stop(0.35)
        end)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Triple Talon Kick", v66.PrimaryPart.CFrame)
        task.wait(0.45)
        u69:Stop(0)
        v66.PrimaryPart.Anchored = false
        v66.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Triple Talon Kick", v68)
        _G.fw(v68)
        v65.talon = false
    end
end
function u8.TalonBarrage(u70, p71) --[[ Line: 373 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
    --]]
    local v72 = u70.Cooldowns
    local u73 = u1.Character
    local u74 = u2["Stats" .. u1.Name]
    if v72.rapid == false and (_G.check:inspect(u73) == true and (_G.canuse == true and (_G.StamCheck("Talon Barrage") == true and u70.transformed == false))) then
        local v75 = u4.GetM("Talon Barrage")
        local v76 = v75.cd
        if _G.StamCheck("Talon Barrage") == false then
            return
        end
        if v75.statreq and _G.MeetReq(v75.statreq) == false then
            return
        end
        v72.rapid = true
        _G.canuse = false
        u73.Humanoid.WalkSpeed = 4
        local u77 = tick()
        local v78 = u73.Humanoid:LoadAnimation(script.windupKick)
        v78:Play()
        v78.Priority = Enum.AnimationPriority.Action4
        local v79 = game.ReplicatedStorage.Events.Skill:InvokeServer("Talon Barrage")
        local u80 = Instance.new("BodyVelocity")
        u80.MaxForce = Vector3.new(1000000, 1000000, 1000000)
        u80.Velocity = Vector3.new(0, 5, 0)
        u80.Parent = u73.LowerTorso
        task.wait(0.25)
        v78:Stop()
        local v81 = u73.Humanoid:LoadAnimation(script.kickloop)
        v81:Play()
        u70:ChargeSkill(p71, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 403 ]]
                --[[
                Upvalues:
                    [1] = u73
                    [2] = u77
                    [3] = u80
                --]]
                u73.Humanoid.WalkSpeed = 4
                if tick() - u77 >= 0.25 then
                    u80.Velocity = u73.HumanoidRootPart.CFrame.LookVector * 10
                end
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 410 ]]
                --[[
                Upvalues:
                    [1] = u70
                    [2] = u73
                    [3] = u77
                    [4] = u74
                --]]
                if u70.Tool.Parent ~= u73 or (tick() - u77 >= 3 or (u74.Stamina.Value <= 0 or _G.check:inspect(u73) == false)) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        if v79 then
            v79:FireServer()
        end
        u80:Destroy()
        v81:Stop()
        u73.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Talon Barrage", v76)
        _G.fw(v76)
        v72.rapid = false
    end
end
function u8.PhoenixPyreapple(u82, p83) --[[ Line: 441 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
    --]]
    local v84 = u82.Cooldowns
    local u85 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v84.heal == false and (_G.canuse == true and (_G.check:inspect(u85) == true and _G.StamCheck("Phoenix Pyreapple") == true)) then
        local v86 = u4.GetM("Phoenix Pyreapple")
        local v87 = v86.cd
        if _G.StamCheck("Phoenix Pyreapple") == false then
            return
        end
        if v86.statreq and _G.MeetReq(v86.statreq) == false then
            return
        end
        if (u85:GetAttribute("Transformed") or false) == true then
            u82.busy = true
        end
        _G.canuse = false
        local v88 = game.ReplicatedStorage.Events.Skill:InvokeServer("Phoenix Pyreapple", {
            ["cf"] = u82:GetMouseCFrame()
        })
        task.delay(1, function() --[[ Line: 464 ]]
            --[[
            Upvalues:
                [1] = u82
            --]]
            u82.busy = false
        end)
        _G.canuse = true
        if v88 == nil then
            return
        end
        v84.heal = true
        local u89 = true
        local u90 = nil
        if v88 then
            u82:DoubleCastSkill(p83, {
                ["Key"] = Enum.KeyCode.T,
                ["SkipTap"] = true,
                ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 480 ]]
                    --[[
                    Upvalues:
                        [1] = u89
                    --]]
                    u89 = false
                end,
                ["PassFunction"] = function() --[[ Name: PassFunction, Line 483 ]]
                    --[[
                    Upvalues:
                        [1] = u82
                        [2] = u85
                    --]]
                    return u82.Tool.Parent == u85
                end
            })
        end
        repeat
            game["Run Service"].Heartbeat:Wait()
            local v91 = u85:GetAttribute("Transformed")
        until (v91 == false or v91 == nil) and _G.check:inspect(u85) == false or (u89 == false or (u85.Parent == workspace.Ragdolls or (u85:FindFirstChild("pHealing") == nil or u85:GetAttribute("Transformed") == true and (u85:FindFirstChild("inCombat") and _G.check:inspect(u85, true) == false))))
        pcall(function() --[[ Line: 498 ]]
            --[[
            Upvalues:
                [1] = u90
            --]]
            u90:Disconnect()
            u90 = nil
        end)
        v88:FireServer()
        _G.keysetup:cooldown("Phoenix Pyreapple", v87)
        _G.fw(v87)
        v84.heal = false
    end
end
function u8.PhoenixTransformation(u92, p93) --[[ Line: 509 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
        [4] = u9
    --]]
    local v94 = u92.Cooldowns
    local u95 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v94.trans == false and (_G.check:inspect(u95) == true and (_G.StamCheck("Phoenix Transformation") == true and _G.canuse == true)) then
        local v96 = u4.GetM("Phoenix Transformation")
        local v97 = v96.cd
        if _G.StamCheck("Phoenix Transformation") == false then
            return
        end
        if v96.statreq and _G.MeetReq(v96.statreq) == false then
            return
        end
        if u95:GetAttribute("toriDamage") == nil then
            _G.displayMessage("<Color=Red>You dont have enough mode bar!")
            return
        end
        if (u95:GetAttribute("Transformed") == nil or u95:GetAttribute("Transformed") == false) and u95:GetAttribute("toriDamage") < require(game.ReplicatedStorage.Modules.Skills.Modes.Tori)(u1) / 4 then
            if u92.transformed == false then
                _G.displayMessage("<Color=Red>You dont have enough mode bar!")
            end
        end
        v94.trans = true
        tick()
        _G.canuse = false
        local u98 = tick()
        local u99 = tick()
        local u100 = _G.mobile == true and 1 or 0.25
        u92:ChargeSkill(p93, {
            ["Key"] = Enum.KeyCode.Z,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 550 ]]
                --[[
                Upvalues:
                    [1] = u98
                    [2] = u99
                    [3] = u100
                --]]
                u98 = tick() - u99
                return u100 < u98
            end
        })
        local u101 = u100 < u98
        if u101 == true and (_G.arena == true and u95:GetAttribute("toriDamage") < require(game.ReplicatedStorage.Modules.Skills.Modes.Tori)(u1) * 0.95) then
            _G.displayMessage("<Color=/>I need <Color=Blue>95%<Color=/> mode bar for full mode.")
            _G.canuse = true
            v94.trans = false
            return
        end
        _G.canuse = false
        if u95:GetAttribute("Transformed") == nil or u95:GetAttribute("Transformed") == false then
            task.delay(0.35, function() --[[ Line: 571 ]]
                --[[
                Upvalues:
                    [1] = u101
                    [2] = u95
                --]]
                local v102 = u101 and 0.3 or 0
                local v103 = Instance.new("BodyVelocity")
                v103.MaxForce = Vector3.new(1000000, inf, 1000000)
                local v104 = v102 + 35
                v103.Velocity = Vector3.new(0, v104, 0)
                v103.Parent = u95.HumanoidRootPart
                _G.destroy(v103, v102 + 0.25)
            end)
        end
        if u92.bg then
            u92.bg.CFrame = u95.PrimaryPart.CFrame
        end
        u92.busy = true
        local v105 = u95:GetAttribute("Transformed") == true
        local v106 = u101 == true and v105 == true and true or nil
        local v107 = u95:FindFirstChild("PhoenixFullForm")
        if v106 == true and (v107 and v107.Body.Transparency == 0) then
            v106 = nil
        end
        game.ReplicatedStorage.Events.Skill:InvokeServer("Phoenix Transformation", { u101, v106, u95.PrimaryPart.CFrame })
        u92.setFlaps()
        u95.Humanoid.PlatformStand = false
        u95.Humanoid.AutoRotate = true
        if u92.preTransformCNT then
            u92.preTransformCNT:Disconnect()
            u92.preTransformCNT = nil
        end
        if v105 == false then
            if u101 == false then
                task.wait(0.25)
                u92.busy = false
            else
                task.wait(1.5)
                u92.busy = false
            end
        else
            u92.busy = false
            u95.Humanoid.PlatformStand = false
            u95.Humanoid.AutoRotate = true
            _G.keysetup:Destroy()
            _G.keysetup:setup(u92.Tool.Name, u9)
        end
        if u95:GetAttribute("Transformed") == true then
            u92.preTransformCNT = u95:GetAttributeChangedSignal("Transformed"):Connect(function() --[[ Line: 635 ]]
                --[[
                Upvalues:
                    [1] = u95
                    [2] = u92
                    [3] = u9
                --]]
                if u95:GetAttribute("Transformed") == false then
                    u92.preTransformCNT:Disconnect()
                    u92.preTransformCNT = nil
                    u92.setFlaps()
                    u92.busy = false
                    u95.Humanoid.PlatformStand = false
                    u95.Humanoid.AutoRotate = true
                    _G.keysetup:Destroy()
                    _G.keysetup:setup(u92.Tool.Name, u9)
                end
            end)
            _G.keysetup:Destroy()
            _G.keysetup:setup(u92.Tool.Name .. " Transformed", {
                { "Block", "f" },
                { "Phoenix Brand", "e" },
                { "Immortal Thistle", "r" },
                { "Phoenix Pyreapple", "t" },
                { "Phoenix Transformation", "z" },
                { "Phoenix Burst", "x" },
                { "Phoenix Dive Bomb", "c" },
                { "Phoenix Carry", "y" }
            })
        end
        task.wait(0.35)
        _G.canuse = true
        _G.keysetup:cooldown("Phoenix Transformation", v97)
        _G.fw(v97)
        v94.trans = false
    end
end
function u8.ImmortalThistle(p108, p109) --[[ Line: 657 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
    --]]
    local v110 = p108.Cooldowns
    local u111 = u1.Character
    local u112 = u2["Stats" .. u1.Name]
    if v110.block == false and (_G.check:inspect(u111) == true and (_G.StamCheck("Immortal Thistle") == true and (p108.transformed == true and _G.canuse == true))) then
        local v113 = u4.GetM("Immortal Thistle")
        local v114 = v113.cd
        if _G.StamCheck("Immortal Thistle") == false then
            return
        end
        if v113.statreq and _G.MeetReq(v113.statreq) == false then
            return
        end
        v110.block = true
        _G.canuse = false
        u111.Humanoid.WalkSpeed = 4
        tick()
        local v115 = u111:FindFirstChild("PhoenixFullForm")
        local v116 = v115.Body.Transparency == 0
        local u117 = game.ReplicatedStorage.Events.Skill:InvokeServer("Immortal Thistle", {
            ["cf"] = p108:GetMouseCFrame()
        })
        _G.FaceMouse = true
        local v118
        if v116 == false then
            v118 = u111.Humanoid:LoadAnimation(script.halfBlock)
            v118:Play()
        else
            v118 = v115.AnimationController:LoadAnimation(script.fullBlock)
            v118:Play()
        end
        v118.Priority = Enum.AnimationPriority.Action4
        local u119 = false
        if u117 then
            local u120 = u111:WaitForChild("Blocking", 3)
            local u121 = game.ReplicatedStorage.Util.Melee.BlockGui:Clone()
            u121.Parent = u111.HumanoidRootPart
            p108:ChargeSkill(p109, {
                ["Key"] = Enum.KeyCode.R,
                ["IgnoreInstantCastSetting"] = true,
                ["EndFunction"] = function() --[[ Name: EndFunction, Line 703 ]]
                    --[[
                    Upvalues:
                        [1] = u120
                        [2] = u121
                        [3] = u111
                        [4] = u119
                        [5] = u112
                        [6] = u117
                    --]]
                    pcall(function() --[[ Line: 704 ]]
                        --[[
                        Upvalues:
                            [1] = u120
                            [2] = u121
                            [3] = u111
                        --]]
                        local v122 = u120.Value / u120.MaxValue
                        u121.ImageLabel.Frame.Position = UDim2.new(0, 0, 1 - v122, 0)
                        u121.ImageLabel.Frame.Size = UDim2.new(1, 0, v122, 0)
                        _G.canuse = false
                        u111.Humanoid.WalkSpeed = 0
                        u121.ImageLabel.Frame.ImageLabel.Size = UDim2.new(1, 0, 1 / v122, 0)
                        u121.ImageLabel.Frame.ImageLabel.Position = UDim2.new(0, 0, -(u121.ImageLabel.Frame.Position.Y.Scale / u121.ImageLabel.Frame.Size.Y.Scale), 0)
                    end)
                    return (u119 == true or u120 and u120.Value <= 0) and true or ((u120.Parent == nil or u112.Stamina.Value <= 0) and true or u117 == nil)
                end
            })
            u121:Destroy()
            _G.canuse = true
        end
        local _ = true
        if u117 then
            u117:FireServer()
        end
        _G.FaceMouse = false
        v118:Stop()
        u111.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Immortal Thistle", v114)
        _G.fw(v114)
        v110.block = false
    end
end
function u8.PhoenixBrand(u123, p124) --[[ Line: 736 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
    --]]
    local v125 = u123.Cooldowns
    local u126 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if u123.transformed == true and (v125.brand == false and (_G.check:inspect(u126) == true and (_G.canuse == true and _G.StamCheck("Phoenix Brand") == true))) then
        local v127 = u4.GetM("Phoenix Brand")
        local v128 = v127.cd
        if _G.StamCheck("Phoenix Brand") == false then
            return
        end
        if v127.statreq and _G.MeetReq(v127.statreq) == false then
            return
        end
        v125.brand = true
        _G.canuse = false
        u126.Humanoid.WalkSpeed = 4
        local u129 = tick()
        local u130 = u126:FindFirstChild("PhoenixFullForm")
        local u131 = u130.Body.Transparency == 0
        _G.FaceMouse = true
        local v132 = game.ReplicatedStorage.Events.Skill:InvokeServer("Phoenix Brand", {
            ["cf"] = u123:GetMouseCFrame()
        })
        local v133
        if u131 == false then
            v133 = u126.Humanoid:LoadAnimation(script.Brand.halfCharge)
            v133:Play()
        else
            v133 = u130.AnimationController:LoadAnimation(script.Brand.fullCharge)
            v133:Play()
        end
        u123:ChargeSkill(p124, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 775 ]]
                --[[
                Upvalues:
                    [1] = u126
                --]]
                u126.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 779 ]]
                --[[
                Upvalues:
                    [1] = u123
                    [2] = u126
                    [3] = u129
                --]]
                if u123.Tool.Parent ~= u126 or tick() - u129 >= 30 then
                    return true
                end
            end
        })
        v133:Stop(0)
        local u134
        if u131 == false then
            u134 = u126.Humanoid:LoadAnimation(script.Brand.dash)
        else
            u134 = u130.AnimationController:LoadAnimation(script.Brand.fullDash)
        end
        u134.Priority = Enum.AnimationPriority.Action3
        u134:Play(0)
        u134:AdjustWeight(10)
        local v135 = u123:GetMouseCFrame().Position
        local v136 = Ray.new(u126.PrimaryPart.CFrame.Position, (v135 - u126.PrimaryPart.CFrame.Position).unit * (v135 - u126.PrimaryPart.CFrame.Position).Magnitude)
        local _, v137 = _G.raycastWhitelist(v136, { workspace.Islands, workspace.Ships, workspace.Env })
        local v138 = (CFrame.new(u126.PrimaryPart.CFrame.Position, v137).Position - v137).Magnitude
        local v139 = math.clamp(v138, 20, 150) - 3
        local v140 = math.clamp(v139, 0, 150) / 300
        task.delay(v140 * 1, function() --[[ Line: 812 ]]
            --[[
            Upvalues:
                [1] = u134
                [2] = u131
                [3] = u126
                [4] = u130
            --]]
            task.wait(0.2)
            task.delay(1, function() --[[ Line: 815 ]]
                --[[
                Upvalues:
                    [1] = u134
                --]]
                u134:Stop(0.15)
            end)
            local v141
            if u131 == false then
                v141 = u126.Humanoid:LoadAnimation(script.Brand.kick)
            else
                v141 = u130.AnimationController:LoadAnimation(script.Brand.fullKick)
            end
            v141:Play(0.1, 1.35, 1.2)
            v141:AdjustWeight(2)
            v141.Priority = Enum.AnimationPriority.Action4
        end)
        u126.Humanoid.AutoRotate = false
        if v132 then
            v132:FireServer(v137)
        end
        u123.busy = true
        _G.FaceMouse = false
        task.wait(1.75)
        u126.Humanoid.AutoRotate = true
        u123.busy = false
        u126.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Phoenix Brand", v128)
        _G.fw(v128)
        v125.brand = false
    end
end
function u8.PhoenixDiveBomb(p142, _) --[[ Line: 847 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
    --]]
    local v143 = p142.Cooldowns
    local v144 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v143.bomb == false and (_G.canuse == true and (_G.check:inspect(v144) == true and _G.StamCheck("Phoenix Dive Bomb") == true)) then
        local v145 = u4.GetM("Phoenix Dive Bomb")
        local v146 = v145.cd
        if _G.StamCheck("Phoenix Dive Bomb") == false then
            return
        end
        if v145.statreq and _G.MeetReq(v145.statreq) == false then
            return
        end
        if p142.transformed == false then
            _G.displayMessage("<Color=Red>You need to be transformed to use this!")
            return
        end
        v143.bomb = true
        _G.canuse = false
        v144.Humanoid.WalkSpeed = 4
        tick()
        local _ = v144:FindFirstChild("PhoenixFullForm").Body.Transparency == 0
        game.ReplicatedStorage.Events.Skill:InvokeServer("Phoenix Dive Bomb", p142:GetMouseCFrame())
        p142.busy = true
        v144.Humanoid.AutoRotate = false
        p142.bg.MaxTorque = Vector3.new(0, 0, 0)
        task.wait(3)
        p142.bg.MaxTorque = Vector3.new(100000000000, 100000000000, 100000000000)
        v144.Humanoid.AutoRotate = true
        p142.busy = false
        v144.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Phoenix Dive Bomb", v146)
        _G.fw(v146)
        v143.bomb = false
    end
end
function u8.PhoenixBurst(u147, p148) --[[ Line: 893 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
    --]]
    local v149 = u147.Cooldowns
    local u150 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v149.pburst == false and (_G.canuse == true and (_G.check:inspect(u150) == true and _G.StamCheck("Phoenix Burst") == true)) then
        local v151 = u4.GetM("Phoenix Burst")
        local v152 = v151.cd
        if _G.StamCheck("Phoenix Burst") == false then
            return
        end
        if v151.statreq and _G.MeetReq(v151.statreq) == false then
            return
        end
        if u147.transformed == false then
            _G.displayMessage("<Color=Red>You need to be transformed to use this!")
            return
        end
        v149.pburst = true
        _G.canuse = false
        u150.Humanoid.WalkSpeed = 4
        local u153 = tick()
        local v154 = u150:FindFirstChild("PhoenixFullForm")
        local v155 = v154.Body.Transparency == 0
        u150:SetPrimaryPartCFrame(CFrame.new(u150.PrimaryPart.Position, u147:GetMouseCFrame().Position))
        _G.FaceMouse = true
        local v156 = game.ReplicatedStorage.Events.Skill:InvokeServer("Phoenix Burst")
        local v157
        if v155 == false then
            v157 = u150.Humanoid:LoadAnimation(script.Bluebird.halfCharge)
            v157:Play()
        else
            v157 = v154.AnimationController:LoadAnimation(script.Bluebird.fullCharge)
            v157:Play()
        end
        v157:AdjustWeight(5)
        u147:ChargeSkill(p148, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 933 ]]
                --[[
                Upvalues:
                    [1] = u150
                --]]
                _G.canuse = false
                u150.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 938 ]]
                --[[
                Upvalues:
                    [1] = u147
                    [2] = u150
                    [3] = u153
                --]]
                if u147.Tool.Parent ~= u150 or tick() - u153 >= 5 then
                    return true
                end
            end
        })
        v157:Stop()
        if v155 == false then
            u150.Humanoid:LoadAnimation(script.Bluebird.halfBurst):Play(0)
        else
            v154.AnimationController:LoadAnimation(script.Bluebird.fullBurst):Play(0)
        end
        u150.PrimaryPart.Anchored = true
        u150.Humanoid.AutoRotate = false
        if v156 then
            v156:FireServer(u150.PrimaryPart.CFrame)
        end
        u147.busy = true
        _G.FaceMouse = false
        task.wait(0.4)
        u150.PrimaryPart.Anchored = false
        u150.Humanoid.AutoRotate = true
        u147.busy = false
        u150.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Phoenix Burst", v152)
        _G.fw(v152)
        v149.pburst = false
    end
end
function u8.PhoenixCarry(p158, p159) --[[ Line: 983 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
    --]]
    local v160 = p158.Cooldowns
    local v161 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v160.carry == false and (_G.canuse == true and (_G.check:inspect(v161) == true and _G.StamCheck("Phoenix Carry") == true)) then
        local v162 = u4.GetM("Phoenix Carry")
        local v163 = v162.cd
        if v161:GetAttribute("customM1") ~= "ToriFullForm" then
            _G.displayMessage("<Color=Red>You must be fully transformed to use this!")
            return
        end
        if _G.StamCheck("Phoenix Carry") == false then
            return
        end
        if v162.statreq and _G.MeetReq(v162.statreq) == false then
            return
        end
        v160.carry = true
        local u164 = game.ReplicatedStorage.Events.Skill:InvokeServer("Phoenix Carry")
        if u164 then
            p158:DoubleCastSkill(p159, {
                ["Key"] = Enum.KeyCode.Y,
                ["SkipTap"] = true,
                ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 1014 ]]
                    --[[
                    Upvalues:
                        [1] = u164
                    --]]
                    if u164 then
                        u164:FireServer()
                    end
                end,
                ["PassFunction"] = function() --[[ Name: PassFunction, Line 1019 ]]
                    return true
                end
            })
            repeat
                task.wait()
            until u164:IsDescendantOf(game) == false
        end
        _G.keysetup:cooldown("Phoenix Carry", v163)
        _G.fw(v163)
        v160.carry = false
    end
end
return u8