 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local u3 = require(script.Parent.Parent.MobileBase)
local v4 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u5 = v4:GetControls()
local u6 = setmetatable({}, u3)
u6.__index = u6
game:GetService("UserInputService")
function u6.new(_) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u6
        [3] = u1
    --]]
    local v7 = u3.new(script.Name)
    local v8 = u6
    local u9 = setmetatable(v7, v8)
    local u10 = u1.Character
    u9.Cooldowns = {
        ["blows"] = false,
        ["laser"] = false,
        ["missle"] = false,
        ["air"] = false,
        ["Flight"] = false,
        ["rush"] = false
    }
    function u9.stopAnims(p11) --[[ Line: 28 ]]
        for v12 = 1, #p11 do
            if p11[v12].IsPlaying ~= false then
                p11[v12]:Stop()
            end
        end
    end
    function u9.playAnimation(p13, p14, p15) --[[ Line: 37 ]]
        --[[
        Upvalues:
            [1] = u10
        --]]
        local v16 = u10:GetDescendants()
        local v17 = {}
        for v18 = 1, #v16 do
            if (v16[v18]:IsA("Humanoid") or v16[v18]:IsA("AnimationController")) and (not v16[v18]:IsA("AnimationController") or v16[v18].Parent:GetAttribute("cyborgModel") ~= nil) then
                local v19 = v16[v18]:LoadAnimation(p13)
                v19:AdjustWeight(2)
                if p14 == nil then
                    v19:Play()
                    v19.Priority = Enum.AnimationPriority.Action3
                end
                if p15 then
                    v19.Priority = p15
                end
                table.insert(v17, v19)
            end
        end
        return v17
    end
    local u20 = {
        ["Idle"] = u9.playAnimation(script.Fly.idle, true, Enum.AnimationPriority.Action2),
        ["Front"] = u9.playAnimation(script.Fly.front, true),
        ["Back"] = u9.playAnimation(script.Fly.back, true),
        ["Left"] = u9.playAnimation(script.Fly.left, true),
        ["Right"] = u9.playAnimation(script.Fly.right, true)
    }
    u9.fly = u20
    function u9.stopAll(p21) --[[ Line: 67 ]]
        --[[
        Upvalues:
            [1] = u20
            [2] = u9
        --]]
        for v22, v23 in u20 do
            if v22 ~= p21 then
                u9.stopAnims(v23)
            end
        end
    end
    function u9.playAnim(p24, p25) --[[ Line: 75 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u9
            [3] = u20
        --]]
        if _G.check:inspect(u10) == false and p25 == nil then
            u9.stopAll(nil)
        else
            if u20[p24][1].IsPlaying == false then
                for v26 = 1, #u20[p24] do
                    u20[p24][v26]:Play()
                end
            end
            if p25 == nil then
                u9.stopAll(p24)
            end
        end
    end
    function u9.adjustWeight(p27, p28) --[[ Line: 90 ]]
        --[[
        Upvalues:
            [1] = u20
        --]]
        for v29 = 1, #u20[p27] do
            u20[p27][v29]:AdjustWeight(p28)
        end
    end
    return u9
end
Color3.new(0.333333, 0.333333, 1)
function u6.MachineGunBlows(p30, _) --[[ Line: 119 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v31 = p30.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u32 = u1.Character
    if v31.blows == false and (_G.StamCheck("Machine Gun Blows") == true and (_G.canuse == true and _G.check:inspect(u32) == true)) then
        local v33 = u2.GetM("Machine Gun Blows")
        local v34 = v33.cd
        if _G.StamCheck("Machine Gun Blows") == false then
            return
        end
        if v33.statreq and _G.MeetReq(v33.statreq) == false then
            return
        end
        _G.canuse = false
        local v35 = game.ReplicatedStorage.Events.Skill:InvokeServer("Machine Gun Blows", {
            ["cf"] = p30:GetMouseCFrame()
        })
        v31.blows = true
        p30.playAnimation(script.mechwindup)
        _G.canuse = false
        local v36 = u32:FindFirstChild("ComboBP", true)
        if v36 then
            v36:Destroy()
        end
        local u37 = nil
        task.delay(0.3, function() --[[ Line: 149 ]]
            --[[
            Upvalues:
                [1] = u37
                [2] = u32
            --]]
            u37 = Instance.new("BodyVelocity", u32.HumanoidRootPart)
            u37.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
            u37.Velocity = u32.PrimaryPart.CFrame.LookVector * -35 + Vector3.new(0, 35, 0)
        end)
        task.wait(0.48)
        u37:Destroy()
        _G.FaceMouse = true
        task.wait(0.52)
        local v38 = p30.playAnimation(script.mechloop)
        tick()
        tick()
        if v35 ~= nil then
            local v39 = tick()
            repeat
                task.wait()
            until tick() - v39 >= 2 or u32:FindFirstChild("PB")
        end
        p30.stopAnims(v38)
        _G.FaceMouse = false
        u32.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Machine Gun Blows", v34)
        _G.fw(v34)
        v31.blows = false
    end
end
function u6.LaserPulsar(p40, p41) --[[ Line: 186 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v42 = p40.Cooldowns
    local u43 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u44 = u1.Character
    if v42.laser == false and (_G.StamCheck("Laser Pulsar") == true and (_G.canuse == true and _G.check:inspect(u44) == true)) then
        local v45 = u2.GetM("Laser Pulsar")
        local v46 = v45.cd
        if _G.StamCheck("Laser Pulsar") == false then
            return
        end
        if v45.statreq and _G.MeetReq(v45.statreq) == false then
            return
        end
        _G.canuse = false
        local v47 = game.ReplicatedStorage.Events.Skill:InvokeServer("Laser Pulsar", {
            ["cf"] = p40:GetMouseCFrame()
        })
        v42.laser = true
        local v48 = p40.playAnimation(script.laserStart)
        _G.canuse = false
        _G.FaceMouse = true
        task.wait(0.4)
        p40.stopAnims(v48)
        local u49 = tick()
        local v50 = p40.playAnimation(script.laserCharge)
        p40:ChargeSkill(p41, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 220 ]]
                --[[
                Upvalues:
                    [1] = u44
                    [2] = u49
                    [3] = u43
                --]]
                if u44:FindFirstChild(script.Name) == nil or (tick() - u49 >= 10 or (u44.Parent == nil or (u44.Parent ~= workspace.PlayerCharacters or u43.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        if tick() - u49 <= 0.25 then
            task.wait(0.25 - (tick() - u49))
        end
        _G.FaceMouse = false
        u44.PrimaryPart.Anchored = true
        if v47 then
            v47:FireServer(u44.PrimaryPart.CFrame)
        end
        p40.stopAnims(v50)
        p40.playAnimation(script.laserFire)
        task.wait(0.4)
        u44.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Laser Pulsar", v46)
        _G.fw(v46)
        v42.laser = false
    end
end
function u6.MissleShower(u51, p52) --[[ Line: 255 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v53 = u51.Cooldowns
    local u54 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u55 = u1.Character
    if v53.missle == false and (_G.StamCheck("Missle Shower") == true and (_G.canuse == true and _G.check:inspect(u55) == true)) then
        local v56 = u2.GetM("Missle Shower")
        local v57 = v56.cd
        if _G.StamCheck("Missle Shower") == false then
            return
        end
        if v56.statreq and _G.MeetReq(v56.statreq) == false then
            return
        end
        _G.canuse = false
        v53.missle = true
        local v58 = u51.playAnimation(script.ultWindup)
        _G.canuse = false
        task.wait(0.4)
        local u59 = game.ReplicatedStorage.Events.Skill:InvokeServer("Missle Shower", u51:GetMouseCFrame())
        local v60 = Instance.new("BodyVelocity", u55.HumanoidRootPart)
        v60.MaxForce = Vector3.new(inf, inf, inf)
        v60.Velocity = u55.PrimaryPart.CFrame.LookVector * -5 + Vector3.new(0, 60, 0)
        v60.Name = "geppo"
        task.wait(0.55)
        _G.FaceMouse = true
        v60:Destroy()
        u51.stopAnims(v58)
        local u61 = tick()
        local v62 = u51.playAnimation(script.ultLoop)
        for v63 = 1, #v62 do
            v62[v63]:AdjustSpeed(2)
        end
        local u64 = 0
        local function v65() --[[ Line: 298 ]]
            --[[
            Upvalues:
                [1] = u59
                [2] = u64
                [3] = u51
                [4] = u55
                [5] = u61
                [6] = u54
            --]]
            if u59 and tick() - u64 >= 0.09 then
                u59:FireServer(u51:GetMouseCFrame())
                u64 = tick()
            end
            if u55:FindFirstChild(script.Name) == nil or (u59 == nil or (u55:FindFirstChild("PB") or (tick() - u61 >= 10 or (u55.Parent == nil or (u55.Parent ~= workspace.PlayerCharacters or u54.Stamina.Value <= 0))))) then
                return true
            end
        end
        u51:ChargeSkill(p52, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = v65,
            ["IgnoreInstantCastSetting"] = true
        })
        if u59 then
            u59:FireServer()
        end
        u51.stopAnims(v62)
        _G.FaceMouse = false
        u55.PrimaryPart.Anchored = true
        task.wait(0.4)
        u55.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Missle Shower", v57)
        _G.fw(v57)
        v53.missle = false
    end
end
function u6.SelfRepair(p66, p67) --[[ Line: 331 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v68 = p66.Cooldowns
    local u69 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u70 = u1.Character
    if v68.air == false and (_G.StamCheck("Self Repair") == true and (_G.canuse == true and _G.check:inspect(u70) == true)) then
        local v71 = u2.GetM("Self Repair")
        local v72 = v71.cd
        if _G.StamCheck("Self Repair") == false then
            return
        end
        if v71.statreq and _G.MeetReq(v71.statreq) == false then
            return
        end
        _G.canuse = false
        local v73 = game.ReplicatedStorage.Events.Skill:InvokeServer("Self Repair", {
            ["cf"] = p66:GetMouseCFrame()
        })
        v68.air = true
        local v74 = u70.Humanoid:LoadAnimation(script.selfRepair)
        v74:Play()
        v74:AdjustWeight(2)
        v74.Priority = Enum.AnimationPriority.Action4
        _G.canuse = false
        local u75 = tick()
        p66:ChargeSkill(p67, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 365 ]]
                --[[
                Upvalues:
                    [1] = u70
                    [2] = u75
                    [3] = u69
                --]]
                if u70:FindFirstChild(script.Name) == nil or (tick() - u75 >= 10 or (u70.Parent == nil or (u70.Parent ~= workspace.PlayerCharacters or u69.Stamina.Value <= 0))) then
                    return true
                end
                if _G.check:inspect(u70) == false then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 361 ]]
                --[[
                Upvalues:
                    [1] = u70
                --]]
                u70.Humanoid.WalkSpeed = 1
            end
        })
        u70.Humanoid.WalkSpeed = 16
        if v73 then
            v73:FireServer(CFrame.new(u70.UpperTorso.Position))
        end
        v74:Stop()
        _G.canuse = true
        _G.keysetup:cooldown("Self Repair", v72)
        _G.fw(v72)
        v68.air = false
    end
end
function u6.CyborgFlight(u76, p77) --[[ Line: 404 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u5
    --]]
    local v78 = u76.Cooldowns
    local u79 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u80 = u1.Character
    if _G.grounded == false and (u80.LowerTorso:FindFirstChild("flightBV") == nil and (v78.Flight == false and (_G.check:inspect(u80) == true and _G.StamCheck("Cyborg Flight") == true))) then
        local v81 = u2.GetM("Cyborg Flight")
        local v82 = v81.cd
        if _G.StamCheck("Cyborg Flight") == false then
            return
        end
        if v81.statreq and _G.MeetReq(v81.statreq) == false then
            return
        end
        if u80:GetAttribute("flyMode") then
            return
        end
        v78.Flight = true
        u80.Humanoid.WalkSpeed = 0
        local u83 = game.ReplicatedStorage.Events.Skill:InvokeServer("Cyborg Flight")
        local v84 = u80:FindFirstChild("ComboBP", true)
        if v84 then
            v84:Destroy()
        end
        local v85 = Instance.new("BodyVelocity", u80.LowerTorso)
        v85.Name = "geppo"
        v85.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
        v85.Velocity = Vector3.new()
        local v86 = Instance.new("BodyGyro", u80.LowerTorso)
        v86.P = 100000
        v86.D = 2500
        v86.MaxTorque = Vector3.new(100000000000, 100000000000, 100000000000)
        u80.Humanoid.WalkSpeed = 16
        local u87 = false
        u76:DoubleCastSkill(p77, {
            ["Key"] = Enum.KeyCode.T,
            ["SkipTap"] = true,
            ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 442 ]]
                --[[
                Upvalues:
                    [1] = u87
                --]]
                u87 = true
            end,
            ["CancelFunction"] = function() --[[ Name: CancelFunction, Line 445 ]]
                --[[
                Upvalues:
                    [1] = u80
                    [2] = u79
                    [3] = u83
                --]]
                if u80:FindFirstChild("inCombat") and u80:FindFirstChild("PB") then
                    return true
                end
                local v88 = u80.Parent == workspace.PlayerCharacters and u79.Stamina.Value > 0 and (u83 ~= nil and u83)
                if v88 then
                    v88 = u83:IsDescendantOf(game) == false
                end
                return v88
            end,
            ["PassFunction"] = function() --[[ Name: PassFunction, Line 455 ]]
                --[[
                Upvalues:
                    [1] = u76
                    [2] = u80
                --]]
                return u76.Tool.Parent == u80
            end
        })
        u80.Humanoid.PlatformStand = true
        local v89 = Instance.new("NumberValue", game.ReplicatedStorage)
        v89.Value = 125
        u80:PivotTo(CFrame.new(u80.HumanoidRootPart.Position, workspace.CurrentCamera.CFrame * CFrame.new(0, 0, 1000).Position) * CFrame.Angles(0, 3.141592653589793, 0))
        _G.tween(v89, {
            0.5,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Value"] = 70
        })
        local v90 = u87
        for _, v91 in pairs(u76.fly) do
            for v92 = 1, #v91 do
                v91[v92]:Play()
            end
        end
        local v93 = 0
        while true do
            local v94 = u80:FindFirstChild("inCombat") and 0.5 or 1
            local v95 = v89.Value * (u80.Humanoid.Health / u80.Humanoid.MaxHealth) * v94
            if u80:FindFirstChild("Blocking") then
                v95 = v95 * 0.2
            end
            local v96 = u5:GetMoveVector()
            local v97 = u80.PrimaryPart.CFrame
            local _, _, _ = v97:ToOrientation()
            local v98 = v97 * CFrame.new(0, 0, -100)
            local v99 = CFrame.new
            local v100 = v97.Position
            local v101 = v98.X
            local v102 = v97.Y
            local v103 = v98.Z
            local v104 = v99(v100, (Vector3.new(v101, v102, v103)))
            local v105 = v104.LookVector:Dot(u80.Humanoid.MoveDirection)
            local v106 = v104.RightVector:Dot(u80.Humanoid.MoveDirection)
            if u80.Humanoid.MoveDirection == Vector3.new(0, 0, 0) then
                v85.Velocity = Vector3.new()
            else
                local v107 = workspace.CurrentCamera
                v85.Velocity = (v107.CFrame.LookVector * -v96.Z + v107.CFrame.RightVector * v96.X) * v95
                if v96.Z == 1 or v96.Z == -1 then
                    local v108 = v85.Velocity.X
                    local v109 = v85.Velocity.Y
                    local v110 = v85.Velocity.Z
                    v85.Velocity = Vector3.new(v108, v109, v110)
                end
            end
            if _G.FaceMouse == true or (u80:FindFirstChildWhichIsA("ObjectValue") or _G.canuse == false) then
                v85.Velocity = Vector3.new()
            end
            if _G.FaceMouse == true then
                v86.Parent = nil
                v86.MaxTorque = Vector3.new(0, 0, 0)
            else
                if u80.Humanoid.MoveDirection == Vector3.new(0, 0, 0) then
                    u76.playAnim("Idle", true)
                else
                    for v111, v112 in pairs(u76.fly) do
                        if v111 == "Idle" then
                            for v113 = 1, #v112 do
                                if v112[v113].IsPlaying == true then
                                    v112[v113]:Stop()
                                end
                            end
                        else
                            for v114 = 1, #v112 do
                                if v112[v114].IsPlaying == false then
                                    v112[v114]:Play()
                                end
                            end
                        end
                    end
                    if tick() - v93 >= 0.016666666666666666 then
                        u76.adjustWeight("Front", (math.clamp(v105, 0, 3)))
                        local v115 = u76.adjustWeight
                        local v116 = -v105
                        v115("Back", (math.clamp(v116, 0, 3)))
                        u76.adjustWeight("Right", (math.clamp(v106, 0, 3)))
                        local v117 = u76.adjustWeight
                        local v118 = -v106
                        v117("Left", (math.clamp(v118, 0, 3)))
                        v93 = tick()
                    end
                end
                v86.Parent = u80.HumanoidRootPart
                v86.MaxTorque = Vector3.new(100000000000, 100000000000, 100000000000)
                v86.CFrame = CFrame.new(u80.HumanoidRootPart.Position, workspace.CurrentCamera.CFrame * CFrame.new(0, 0, 1000).Position) * CFrame.Angles(0, 3.141592653589793, 0)
            end
            u80.Humanoid.PlatformStand = true
            u80.Humanoid.AutoRotate = false
            local v119 = u80:FindFirstChildWhichIsA("Tool")
            if v119 and v119 ~= u76.Tool then
                task.defer(function() --[[ Line: 558 ]]
                    --[[
                    Upvalues:
                        [1] = u80
                    --]]
                    u80.Humanoid:UnequipTools()
                end)
            end
            if _G.grounded == true then
                break
            end
            game["Run Service"].RenderStepped:Wait()
            if v90 == true then
                break
            end
        end
        u76.stopAll()
        v89:Destroy()
        u80.Humanoid.AutoRotate = true
        u80.Humanoid.PlatformStand = false
        v85:Destroy()
        v86:Destroy()
        if u83 then
            pcall(function() --[[ Line: 578 ]]
                --[[
                Upvalues:
                    [1] = u83
                --]]
                u83:InvokeServer()
            end)
        end
        _G.keysetup:cooldown("Cyborg Flight", v82)
        _G.fw(v82)
        v78.Flight = false
    end
end
function u6.ObliterationRush(p120, _) --[[ Line: 589 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v121 = p120.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v122 = u1.Character
    if v121.rush == false and (_G.StamCheck("Obliteration Rush") == true and (_G.canuse == true and _G.check:inspect(v122) == true)) then
        local v123 = u2.GetM("Obliteration Rush")
        local v124 = v123.cd
        if _G.StamCheck("Obliteration Rush") == false then
            return
        end
        if v123.statreq and _G.MeetReq(v123.statreq) == false then
            return
        end
        _G.canuse = false
        local v125 = _G.getTargetNearMouse()
        if v125 and (v125.Position - v122.PrimaryPart.Position).Magnitude >= 250 then
            v125 = nil
        end
        if v125 == nil then
            script.CyNoTarget:Play()
            task.wait(0.1)
            _G.canuse = true
            return
        end
        script.CyLockOn:Play()
        v121.rush = true
        local v126, _, _ = _G.getRayFloor(v125.CFrame, 10)
        local v127 = v126 == nil and "Air" or "Ground"
        if v127 == "Air" then
            p120.playAnimation(script.attemptAir)
        else
            p120.playAnimation(script.GroundGrab.attempt)
        end
        game.ReplicatedStorage.Events.Skill:InvokeServer("Obliteration Rush", { v125, v127 })
        _G.canuse = true
        _G.keysetup:cooldown("Obliteration Rush", v124)
        _G.fw(v124)
        v121.rush = false
    end
end
return u6