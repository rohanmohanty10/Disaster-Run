 

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
    { "Gomu-Gomu no Pistol", "e" },
    { "Gomu-Gomu no Balloon", "r" },
    { "Gomu-Gomu no Rocket", "t" },
    { "Gomu-Gomu no Bazooka", "z" },
    { "Gomu-Gomu no Gatling", "x" },
    { "Gomu-Gomu no Rifle", "c" },
    { "Gear 2 Transformation", "Y" }
}
local u7 = {
    { "Block", "f" },
    { "Jet Pistol", "e" },
    { "Jet Stomp", "r" },
    { "Jet Rocket", "t" },
    { "Red Hawk", "z" },
    { "Jet Gatling", "x" },
    { "Elephant Gun", "c" },
    { "Gear 2 Transformation", "Y" }
}
local function u14(p8) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    if p8 == nil then
        return nil
    end
    local v9 = game.Players:GetPlayers()
    local v10 = nil
    for v11 = 1, #v9 do
        if p8:IsDescendantOf(v9[v11].Character) and v9[v11] ~= u1 then
            if ((not v9[v11]:FindFirstChild("Party") or (v9[v11].Party.Value == nil or u1.Party.Value ~= v9[v11].Party.Value)) and true or false) == true then
                v10 = v9[v11].Character
            end
            break
        end
    end
    if v10 == nil then
        local v12 = workspace.NPCs:GetChildren()
        for v13 = 1, #v12 do
            if p8:IsDescendantOf(v12[v13]) and (v12[v13]:FindFirstChild("Info") and v12[v13].Info:FindFirstChild("SeaNPC") == nil) then
                return v12[v13]
            end
        end
    end
    return v10
end
function u5.new(_) --[[ Line: 52 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
        [3] = u1
    --]]
    local v15 = u4.new(script.Name)
    local v16 = u5
    local u17 = setmetatable(v15, v16)
    u17.Cooldowns = {
        ["pistol"] = false,
        ["galt"] = false,
        ["bazooka"] = false,
        ["rocket"] = false,
        ["jetRocket"] = false,
        ["balloon"] = false,
        ["rifle"] = false,
        ["gear2"] = false,
        ["ult"] = false,
        ["jetgalt"] = false,
        ["jetpistol"] = false,
        ["missile"] = false,
        ["stamp"] = false,
        ["hawk"] = false
    }
    local u18 = u1.Character
    u17.Anims = {
        ["idle"] = u18.Humanoid:LoadAnimation(script.Gear2Anims.g2Idle),
        ["walk"] = u18.Humanoid:LoadAnimation(script.Gear2Anims.walk)
    }
    u17.Anims.idle.Priority = Enum.AnimationPriority.Action
    u17.Anims.idle:AdjustWeight(5)
    u17.Anims.walk.Priority = Enum.AnimationPriority.Action
    function u17.RocketCD(_, p19) --[[ Line: 67 ]]
        --[[
        Upvalues:
            [1] = u18
            [2] = u17
        --]]
        if u18:FindFirstChild("inCombat") then
            u17.Cooldowns.rocket = true
            u17.Cooldowns.jetRocket = true
            _G.keysetup:cooldown("Gomu-Gomu no Rocket", p19)
            _G.keysetup:cooldown("Jet Rocket", p19)
            task.delay(p19, function() --[[ Line: 75 ]]
                --[[
                Upvalues:
                    [1] = u17
                --]]
                u17.Cooldowns.rocket = false
                u17.Cooldowns.jetRocket = false
            end)
        end
    end
    return u17
end
u5["Gomu-GomunoPistol"] = function(u20, p21) --[[ Line: 85 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u14
    --]]
    local v22 = u20.Cooldowns
    local u23 = u1.Character
    local u24 = u2["Stats" .. u1.Name]
    if v22.pistol == false and (_G.check:inspect(u23) == true and _G.StamCheck("Gomu-Gomu no Pistol") == true) then
        local v25 = u3.GetM("Gomu-Gomu no Pistol")
        local v26 = v25.cd
        if _G.StamCheck("Gomu-Gomu no Pistol") == false then
            return
        end
        if v25.statreq and _G.MeetReq(v25.statreq) == false then
            return
        end
        v22.pistol = true
        _G.canuse = false
        local v27 = u23.Humanoid:LoadAnimation(script.pistol)
        v27:Play()
        v27:AdjustWeight(2)
        _G.FaceMouse = true
        _G.PauseAnim(v27, 0.4, 1.5)
        local u28 = tick()
        u20:ChargeSkill(p21, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 112 ]]
                --[[
                Upvalues:
                    [1] = u28
                    [2] = u20
                    [3] = u23
                    [4] = u24
                --]]
                if tick() - u28 >= 10 or (u20.on == false or (u23.Parent == nil or (u23.Parent ~= workspace.PlayerCharacters or u24.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        _G.FaceMouse = false
        u23.HumanoidRootPart.Anchored = true
        v27:AdjustSpeed(1)
        local v29 = u20:GetMouseCFrame()
        local v30 = u14(_G.MouseTarget)
        if v30 then
            u23.HumanoidRootPart.CFrame = CFrame.new(u23.HumanoidRootPart.Position, v30.HumanoidRootPart.Position)
        else
            u23.HumanoidRootPart.CFrame = CFrame.new(u23.HumanoidRootPart.Position, v29.Position)
        end
        task.wait(0.15)
        u23.Humanoid.AutoRotate = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Gomu-Gomu no Pistol", {
            ["targetCF"] = v29,
            ["cf"] = u23.HumanoidRootPart.CFrame,
            ["target"] = v30,
            ["armCF"] = u23.RightLowerArm.CFrame,
            ["handCF"] = u23.RightLowerArm.CFrame * CFrame.Angles(-1.562069680534925, 0, 0.4363323129985824)
        })
        v27:AdjustSpeed(1)
        task.wait(1)
        u23.Humanoid.AutoRotate = true
        u23.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Gomu-Gomu no Pistol", v26)
        _G.fw(v26)
        v22.pistol = false
    end
end
u5["Gomu-GomunoGatling"] = function(u31, p32) --[[ Line: 152 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v33 = u31.Cooldowns
    local u34 = u1.Character
    local u35 = u2["Stats" .. u1.Name]
    if v33.galt == false and (_G.check:inspect(u34) == true and _G.StamCheck("Gomu-Gomu no Gatling") == true) then
        local v36 = u3.GetM("Gomu-Gomu no Gatling")
        local v37 = v36.cd
        if _G.StamCheck("Gomu-Gomu no Gatling") == false then
            return
        end
        if v36.statreq and _G.MeetReq(v36.statreq) == false then
            return
        end
        v33.galt = true
        _G.canuse = false
        local v38 = u34.Humanoid:LoadAnimation(script.galtstart)
        v38:Play()
        v38:AdjustWeight(2)
        _G.PauseAnim(v38, 0.6, 1)
        v38:Stop()
        local u39 = game.ReplicatedStorage.Events.Skill:InvokeServer("Gomu-Gomu no Gatling", {
            ["cf"] = u34.HumanoidRootPart.CFrame
        })
        local v40 = u34.Humanoid:LoadAnimation(script.galtloop)
        v40:Play()
        v40:AdjustWeight(2)
        local u41 = tick()
        u31:ChargeSkill(p32, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 182 ]]
                --[[
                Upvalues:
                    [1] = u34
                --]]
                u34.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 186 ]]
                --[[
                Upvalues:
                    [1] = u39
                    [2] = u41
                    [3] = u34
                    [4] = u31
                    [5] = u35
                --]]
                if u39 == nil or (tick() - u41 >= 5 or (u34:FindFirstChild("PB") or (u31.on == false or (u34.Parent == nil or (u34.Parent ~= workspace.PlayerCharacters or u35.Stamina.Value <= 0))))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v40:Stop()
        u34.Humanoid:LoadAnimation(script.galtend):Play()
        if u39 then
            u39:FireServer()
        end
        task.wait(0.5)
        u34.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Gomu-Gomu no Gatling", v37)
        _G.fw(v37)
        v33.galt = false
    end
end
u5["Gomu-GomunoBazooka"] = function(u42, p43) --[[ Line: 217 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v44 = u42.Cooldowns
    local u45 = u1.Character
    local u46 = u2["Stats" .. u1.Name]
    if v44.bazooka == false and (_G.check:inspect(u45) == true and _G.StamCheck("Gomu-Gomu no Bazooka") == true) then
        local v47 = u3.GetM("Gomu-Gomu no Bazooka")
        local v48 = v47.cd
        if _G.StamCheck("Gomu-Gomu no Bazooka") == false then
            return
        end
        if v47.statreq and _G.MeetReq(v47.statreq) == false then
            return
        end
        v44.bazooka = true
        _G.canuse = false
        local v49 = u45.Humanoid:LoadAnimation(script.bazooka)
        v49:Play()
        v49:AdjustWeight(2)
        _G.FaceMouse = true
        local u50 = nil
        task.spawn(function() --[[ Line: 240 ]]
            --[[
            Upvalues:
                [1] = u50
                [2] = u45
            --]]
            task.wait(0.2)
            u50 = game.ReplicatedStorage.Events.Skill:InvokeServer("Gomu-Gomu no Bazooka", {
                ["cf"] = u45.HumanoidRootPart.CFrame
            })
        end)
        tick()
        _G.PauseAnim(v49, 0.67, 1.25)
        local u51 = tick()
        local function v52() --[[ Line: 256 ]]
            --[[
            Upvalues:
                [1] = u50
                [2] = u51
                [3] = u42
                [4] = u45
                [5] = u46
            --]]
            if u50 == nil or (tick() - u51 >= 5 or (u42.on == false or (u45.Parent == nil or (u45.Parent ~= workspace.PlayerCharacters or u46.Stamina.Value <= 0)))) then
                return true
            end
        end
        u42:ChargeSkill(p43, {
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 252 ]]
                --[[
                Upvalues:
                    [1] = u45
                --]]
                u45.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = v52
        })
        v49:AdjustSpeed(1.5)
        _G.FaceMouse = false
        u45.HumanoidRootPart.Anchored = true
        task.wait(0.2)
        u45.Humanoid.AutoRotate = false
        if u50 then
            u50:FireServer(u45.HumanoidRootPart.CFrame)
        end
        task.wait(1)
        u45.Humanoid.AutoRotate = true
        u45.Humanoid.WalkSpeed = 16
        u45.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Gomu-Gomu no Bazooka", v48)
        _G.fw(v48)
        v44.bazooka = false
    end
end
u5["Gomu-GomunoRocket"] = function(u53, p54) --[[ Line: 290 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v55 = u53.Cooldowns
    local u56 = u1.Character
    local u57 = u2["Stats" .. u1.Name]
    if _G.grounded == false and (v55.rocket == false and (_G.check:inspect(u56) == true and _G.StamCheck("Gomu-Gomu no Rocket") == true)) then
        local v58 = u3.GetM("Gomu-Gomu no Rocket")
        local v59 = v58.cd
        if _G.StamCheck("Gomu-Gomu no Rocket") == false then
            return
        end
        if v58.statreq and _G.MeetReq(v58.statreq) == false then
            return
        end
        v55.rocket = true
        _G.canuse = false
        local u60 = u56.Humanoid:LoadAnimation(script.rocket)
        u60:Play()
        u60:AdjustWeight(2)
        _G.FaceMouse = true
        _G.PauseAnim(u60, 0.35, 1)
        local u61 = tick()
        u53:ChargeSkill(p54, {
            ["Key"] = Enum.KeyCode.T,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 320 ]]
                --[[
                Upvalues:
                    [1] = u56
                --]]
                u56.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 324 ]]
                --[[
                Upvalues:
                    [1] = u61
                    [2] = u53
                    [3] = u56
                    [4] = u57
                --]]
                if tick() - u61 >= 9 or (u53.on == false or (u56.Parent == nil or (u56.Parent ~= workspace.PlayerCharacters or u57.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        u60:AdjustSpeed(1)
        _G.FaceMouse = false
        u56.HumanoidRootPart.Anchored = true
        u56.Humanoid.AutoRotate = false
        local v62 = u56.HumanoidRootPart.CFrame
        local v63 = _G.FPS / 60
        local u64 = Instance.new("BodyVelocity", u56.HumanoidRootPart)
        u64.Name = "geppo"
        u64.MaxForce = Vector3.new(inf, inf, inf)
        u64.Velocity = Vector3.new(0, 0, 0)
        task.wait(0.1)
        local u65 = nil
        local u66 = nil
        local u67 = nil
        local u68 = nil
        pcall(function() --[[ Line: 357 ]]
            --[[
            Upvalues:
                [1] = u65
                [2] = u66
                [3] = u67
                [4] = u68
                [5] = u53
                [6] = u56
            --]]
            local v69 = game.ReplicatedStorage.Events.Skill
            local v70 = {
                ["cf"] = u53:GetMouseCFrame(),
                ["charCF"] = u56.HumanoidRootPart.CFrame
            }
            local v71, v72, v73, v74 = unpack(v69:InvokeServer("Gomu-Gomu no Rocket", v70))
            u65 = v71
            u66 = v72
            u67 = v73
            u68 = v74
        end)
        if u65 == nil or u68 == nil then
            task.wait(0.2)
            u60:AdjustSpeed(0)
            task.spawn(function() --[[ Line: 409 ]]
                --[[
                Upvalues:
                    [1] = u60
                    [2] = u56
                    [3] = u64
                --]]
                task.wait(0.1)
                u60:Stop()
                u56.Humanoid:LoadAnimation(script.rocketmiss):Play(0)
                u64:Destroy()
            end)
            if u68 then
                u68:FireServer(u56.HumanoidRootPart.CFrame)
            end
        else
            u56.HumanoidRootPart.Anchored = false
            u56.Humanoid.PlatformStand = true
            local v75 = not u65 and 200 or (u56.HumanoidRootPart.Position - u66).Magnitude
            u60:AdjustSpeed(0)
            local v76 = u68
            local v77 = u66
            local v78 = false
            for v79 = 1, 40 * v63 do
                local v80
                if u65 and u65.Anchored == true then
                    v80 = v77 + Vector3.new(0, 5, 0)
                elseif u65 then
                    v80 = u65.Position + Vector3.new(0, 5, 0)
                else
                    v80 = v77
                end
                u56.HumanoidRootPart.Velocity = Vector3.new()
                u56.HumanoidRootPart.RotVelocity = Vector3.new()
                local v81 = u56.HumanoidRootPart
                local v82 = CFrame.new(v80, v80 + (v80 - v62.Position))
                local v83 = v79 / (40 * v63)
                v81.CFrame = v62:Lerp(v82, v83 * v83 * v83 * v83)
                local v84 = 40 * v63 * 0.9
                if math.floor(v84) <= v79 and (v78 == false and v76) then
                    v76:FireServer(u56.HumanoidRootPart.CFrame)
                    v78 = true
                end
                u56.Humanoid.AutoRotate = false
                game["Run Service"].Stepped:Wait()
            end
            u56.HumanoidRootPart.Anchored = false
            u64:Destroy()
            u56.HumanoidRootPart.Velocity = u56.HumanoidRootPart.CFrame.LookVector * v75
            u56.HumanoidRootPart.Velocity = u56.HumanoidRootPart.Velocity + Vector3.new(0, 70, 0) + u56.HumanoidRootPart.CFrame.LookVector * 50
            u56.HumanoidRootPart.CFrame = CFrame.new(u56.HumanoidRootPart.Position, u56.HumanoidRootPart.Position + u56.HumanoidRootPart.Velocity)
            u60:Stop(0)
            u56.Humanoid:LoadAnimation(script.rocketend):Play()
        end
        if u65 == nil then
            task.wait(0.5)
        else
            task.wait(0.2)
            u56.Humanoid.PlatformStand = false
        end
        u56.Humanoid.AutoRotate = true
        u56.HumanoidRootPart.Anchored = false
        u56.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Gomu-Gomu no Rocket", v59)
        u53.RocketCD("Gomu-Gomu no Rocket", v59)
        _G.fw(v59)
        v55.rocket = false
    end
end
u5["Gomu-GomunoBalloon"] = function(p85, p86) --[[ Line: 441 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v87 = p85.Cooldowns
    local v88 = u1.Character
    local v89 = u2["Stats" .. u1.Name]
    if v87.balloon == false and (_G.check:inspect(v88) == true and _G.StamCheck("Gomu-Gomu no Balloon") == true) then
        local v90 = u3.GetM("Gomu-Gomu no Balloon")
        local v91 = v90.cd
        if _G.StamCheck("Gomu-Gomu no Balloon") == false then
            return
        end
        if v90.statreq and _G.MeetReq(v90.statreq) == false then
            return
        end
        v87.balloon = true
        _G.canuse = false
        local u92 = v88.Humanoid:LoadAnimation(script.balloon)
        u92:Play()
        local u93 = true
        p85:DoubleCastSkill(p86, {
            ["ToolName"] = script.Name,
            ["Button"] = p86,
            ["Key"] = Enum.KeyCode.R,
            ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 466 ]]
                --[[
                Upvalues:
                    [1] = u93
                --]]
                u93 = false
            end,
            ["SkipTap"] = true
        })
        task.wait(0.4)
        if v88:FindFirstChild("ragcarry") then
            _G.canuse = true
            u92:Stop()
            task.wait(1)
            v87.balloon = false
            return
        end
        local v94 = game.ReplicatedStorage.Events.Skill:InvokeServer("Gomu-Gomu no Balloon", {
            ["cf"] = v88.HumanoidRootPart.CFrame
        })
        v88.Humanoid.PlatformStand = true
        local v95 = Random.new()
        local v96 = v88.HumanoidRootPart
        local v97 = v95:NextNumber(-10, 10)
        local v98 = v95:NextNumber(-10, 10)
        v96.AssemblyAngularVelocity = Vector3.new(v97, v98, v95:NextNumber(-10, 10))
        local v99 = script.BalloonForce:Clone()
        v99.Parent = v88.HumanoidRootPart
        delay(0.8, function() --[[ Line: 487 ]]
            --[[
            Upvalues:
                [1] = u92
            --]]
            u92:AdjustSpeed(0)
        end)
        local v100 = tick()
        local v101 = u93
        while true do
            if true then
                game["Run Service"].Heartbeat:Wait()
                v88.Humanoid.WalkSpeed = 4
                local v102 = v88.Humanoid.MoveDirection
                if v88.Humanoid.MoveDirection:FuzzyEq(Vector3.new(0, 0, 0)) then
                    v99.MaxForce = Vector3.new(0, 0, 0)
                else
                    v99.MaxForce = Vector3.new(100, 0, 100)
                end
            end
            v99.Velocity = v102 * 100
            v88.Humanoid.PlatformStand = true
            v88.Humanoid.AutoRotate = false
            if v94 == nil or (v101 == false or (tick() - v100 >= 20 or (p85.on == false or (v88.Parent == nil or (v88.Parent ~= workspace.PlayerCharacters or v89.Stamina.Value <= 0))))) then
                v99:Destroy()
                u92:Stop()
                local v103 = v88.Humanoid:LoadAnimation(script.balloonend)
                v103:Play()
                v103:AdjustSpeed(0.5)
                v88.Humanoid.WalkSpeed = 16
                if v94 then
                    v94:FireServer()
                end
                task.wait(3)
                v88.Humanoid.PlatformStand = false
                v88.Humanoid.AutoRotate = true
                _G.canuse = true
                _G.keysetup:cooldown("Gomu-Gomu no Balloon", v91)
                _G.fw(v91)
                v87.balloon = false
                goto l2
            end
        end
    else
        ::l2::
        return
    end
end
u5["Gomu-GomunoRifle"] = function(u104, p105) --[[ Line: 523 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v106 = u104.Cooldowns
    local u107 = u1.Character
    local u108 = u2["Stats" .. u1.Name]
    if v106.rifle == false and (_G.check:inspect(u107) == true and _G.StamCheck("Gomu-Gomu no Rifle") == true) then
        local v109 = u3.GetM("Gomu-Gomu no Rifle")
        local v110 = v109.cd
        if _G.StamCheck("Gomu-Gomu no Rifle") == false then
            return
        end
        if v109.statreq and _G.MeetReq(v109.statreq) == false then
            return
        end
        v106.rifle = true
        _G.canuse = false
        local u111 = u107.Humanoid:LoadAnimation(script.rifle)
        u111:Play()
        u111:AdjustWeight(2)
        u107.Humanoid.WalkSpeed = 4
        local u112 = game.ReplicatedStorage.Events.Skill:InvokeServer("Gomu-Gomu no Rifle", {
            ["cf"] = u107.HumanoidRootPart.CFrame
        })
        _G.PauseAnim(u111, 0.4, 1.25)
        local u113 = tick()
        u104:ChargeSkill(p105, {
            ["Key"] = Enum.KeyCode.C,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 552 ]]
                --[[
                Upvalues:
                    [1] = u107
                --]]
                u107.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 556 ]]
                --[[
                Upvalues:
                    [1] = u112
                    [2] = u113
                    [3] = u104
                    [4] = u107
                    [5] = u108
                --]]
                if u112 == nil or (tick() - u113 >= 9 or (u104.on == false or (u107.Parent == nil or (u107.Parent ~= workspace.PlayerCharacters or u108.Stamina.Value <= 0)))) then
                    return true
                end
            end
        })
        u111:AdjustSpeed(3)
        local u114 = Instance.new("BodyVelocity", u107.HumanoidRootPart)
        u114.MaxForce = Vector3.new(1000000, 0, 1000000)
        u114.Velocity = u107.HumanoidRootPart.CFrame.LookVector * 250
        _G.destroy(u114, 0.1)
        local u115 = nil
        local u116 = false
        local function v118(p117) --[[ Line: 574 ]]
            --[[
            Upvalues:
                [1] = u115
                [2] = u107
                [3] = u114
                [4] = u112
                [5] = u113
            --]]
            u115 = true
            u107.HumanoidRootPart.Anchored = true
            u107.HumanoidRootPart.Velocity = Vector3.new()
            u114.Velocity = Vector3.new()
            u114:Destroy()
            u114 = nil
            if u112 then
                u112:FireServer(p117.Parent, u107.HumanoidRootPart.CFrame, 0.2 - (tick() - u113))
            end
        end
        local function v119() --[[ Line: 586 ]]
            --[[
            Upvalues:
                [1] = u114
                [2] = u116
                [3] = u111
                [4] = u112
            --]]
            u114:Destroy()
            u114 = nil
            u116 = true
            u111:Stop()
            if u112 then
                u112:FireServer()
            end
        end
        _G.hitbox:start(u107, Vector3.new(13, 13, 8), 0.3, CFrame.new(0, 0, -2), v118, v119)
        if u112 then
            u112:FireServer()
        end
        task.spawn(function() --[[ Line: 599 ]]
            --[[
            Upvalues:
                [1] = u115
                [2] = u112
                [3] = u111
            --]]
            task.wait(0.5)
            if u115 == nil and u112 then
                u111:Stop(0.2)
            end
        end)
        task.wait(0.5)
        u107.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Gomu-Gomu no Rifle", v110)
        _G.fw(v110)
        v106.rifle = false
    end
end
function u5.Gear2Transformation(u120, p121) --[[ Line: 623 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u7
        [5] = u6
    --]]
    local u122 = u120.Cooldowns
    local u123 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if u122.gear2 == false and (_G.check:inspect(u123) == true and _G.StamCheck("Gear 2 Transformation") == true) then
        local v124 = u3.GetM("Gear 2 Transformation")
        local u125 = v124.cd
        if _G.StamCheck("Gear 2 Transformation") == false then
            return
        end
        if v124.statreq and _G.MeetReq(v124.statreq) == false then
            return
        end
        if (u123:GetAttribute("gomuDamage") or 0) < require(game.ReplicatedStorage.Modules.Skills.Modes.Gomu)(u1) / 5 then
            _G.displayMessage("I need <Color=Pink>25%<Color=/> mode bar...")
            return
        end
        if u120.preG2Cnt then
            return
        end
        u122.gear2 = true
        _G.canuse = false
        u123.PrimaryPart.Anchored = true
        local u126 = game.ReplicatedStorage.Events.Skill:InvokeServer("Gear 2 Transformation", u123.PrimaryPart.CFrame)
        if u126 == nil then
            u123.PrimaryPart.Anchored = false
            _G.canuse = true
            u122.gear2 = false
            return
        end
        script.Parent:SetAttribute("customIdle", true)
        _G.keysetup:Destroy()
        _G.keysetup:setup(u120.Tool.Name .. " Gear 2", u7)
        u120.preG2Cnt = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 665 ]]
            --[[
            Upvalues:
                [1] = u120
                [2] = u123
            --]]
            if u120.on == true and u123.Humanoid.FloorMaterial ~= Enum.Material.Air then
                if u123.Humanoid.MoveDirection == Vector3.new() then
                    if u120.Anims.idle.IsPlaying == false then
                        u120.Anims.idle:Play()
                    end
                    if u120.Anims.walk.IsPlaying == true then
                        u120.Anims.walk:Stop()
                        return
                    end
                else
                    if u120.Anims.idle.IsPlaying == true then
                        u120.Anims.idle:Stop()
                    end
                    if u120.Anims.walk.IsPlaying == false then
                        u120.Anims.walk:Play()
                        return
                    end
                end
            else
                if u120.Anims.idle.IsPlaying == true then
                    u120.Anims.idle:Stop()
                end
                if u120.Anims.walk.IsPlaying == true then
                    u120.Anims.walk:Stop()
                end
            end
        end)
        u120:DoubleCastSkill(p121, {
            ["ToolName"] = script.Name,
            ["Button"] = p121,
            ["Key"] = Enum.KeyCode.Y,
            ["PassFunction"] = function() --[[ Name: PassFunction, Line 696 ]]
                --[[
                Upvalues:
                    [1] = u120
                    [2] = u123
                --]]
                return u120.Tool.Parent == u123
            end,
            ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 699 ]]
                --[[
                Upvalues:
                    [1] = u126
                --]]
                if u126 then
                    u126:FireServer()
                end
            end,
            ["SkipTap"] = true
        })
        u123:GetAttributeChangedSignal("GEAR2Active"):Connect(function() --[[ Line: 707 ]]
            --[[
            Upvalues:
                [1] = u123
                [2] = u120
                [3] = u6
                [4] = u125
                [5] = u122
            --]]
            if u123:GetAttribute("GEAR2Active") == nil then
                if u120.preG2Cnt then
                    u120.preG2Cnt:Disconnect()
                    u120.preG2Cnt = nil
                end
                if u120.Anims.idle.IsPlaying == true then
                    u120.Anims.idle:Stop()
                end
                script.Parent:SetAttribute("customIdle", nil)
                _G.keysetup:Destroy()
                _G.keysetup:setup(u120.Tool.Name, u6)
                _G.keysetup:cooldown("Gear 2 Transformation", u125)
                _G.fw(u125)
                u122.gear2 = false
            end
        end)
        task.wait(2)
        u123.PrimaryPart.Anchored = false
        _G.canuse = true
    end
end
function u5.ElephantGun(p127, _) --[[ Line: 733 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v128 = p127.Cooldowns
    local v129 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v128.ult == false and (_G.check:inspect(v129) == true and _G.StamCheck("Elephant Gun") == true) then
        local v130 = u3.GetM("Elephant Gun")
        local v131 = v130.cd
        if _G.StamCheck("Elephant Gun") == false then
            return
        end
        if v130.statreq and _G.MeetReq(v130.statreq) == false then
            return
        end
        v128.ult = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Elephant Gun", p127:GetMouseCFrame())
        task.wait(3)
        _G.keysetup:cooldown("Elephant Gun", v131)
        _G.canuse = true
        _G.fw(v131)
        v128.ult = false
    end
end
function u5.JetGatling(u132, p133) --[[ Line: 772 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v134 = u132.Cooldowns
    local u135 = u1.Character
    local u136 = u2["Stats" .. u1.Name]
    if v134.jetgalt == false and (_G.check:inspect(u135) == true and _G.StamCheck("Jet Gatling") == true) then
        local v137 = u3.GetM("Jet Gatling")
        local v138 = v137.cd
        if _G.StamCheck("Jet Gatling") == false then
            return
        end
        if v137.statreq and _G.MeetReq(v137.statreq) == false then
            return
        end
        v134.jetgalt = true
        _G.canuse = false
        local v139 = u135.Humanoid:LoadAnimation(script.Gear2Anims.galtingWindup)
        v139:Play()
        v139:AdjustWeight(2)
        local v140 = Instance.new("BoolValue", u135)
        local v141 = (u135.HumanoidRootPart.CFrame * CFrame.new(0, 0, -4.5) - Vector3.new(0, 0, 0)).Position
        local v142 = _G.Ess.Mouse.GetPosition(_G.Ess.RaycastParams)
        local v143 = (v142 - v141).Magnitude
        local v144 = CFrame.new
        local v145 = v142.X
        local v146 = v141.Y
        local v147 = v142.Z
        local _ = (v144(v141, (Vector3.new(v145, v146, v147))) * CFrame.new(0, 0, -math.clamp(v143, 2, 20))).Position
        _G.PauseAnim(v139, 0.68, 1)
        v139:Stop()
        local v148 = game.ReplicatedStorage.Events.Skill:InvokeServer("Jet Gatling")
        local v149 = u135.Humanoid:LoadAnimation(script.Gear2Anims.galtingLoop)
        v149:Play()
        v149:AdjustWeight(2)
        local u150 = tick()
        u132:ChargeSkill(p133, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 811 ]]
                --[[
                Upvalues:
                    [1] = u135
                --]]
                u135.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 815 ]]
                --[[
                Upvalues:
                    [1] = u150
                    [2] = u132
                    [3] = u135
                    [4] = u136
                --]]
                if tick() - u150 >= 5 or (u132.on == false or (u135:FindFirstChild("PB") or (u135.Parent == nil or (u135.Parent ~= workspace.PlayerCharacters or u136.Stamina.Value <= 0)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        task.wait(0.1)
        v140:Destroy()
        v149:Stop()
        if v148 then
            v148:FireServer()
        end
        u135.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Jet Gatling", v138)
        _G.fw(v138)
        v134.jetgalt = false
    end
end
function u5.JetPistol(u151, p152) --[[ Line: 845 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v153 = u151.Cooldowns
    local u154 = u1.Character
    local u155 = u2["Stats" .. u1.Name]
    if v153.jetpistol == false and (_G.check:inspect(u154) == true and _G.StamCheck("Jet Pistol") == true) then
        local v156 = u3.GetM("Jet Pistol")
        local v157 = v156.cd
        if _G.StamCheck("Jet Pistol") == false then
            return
        end
        if v156.statreq and _G.MeetReq(v156.statreq) == false then
            return
        end
        v153.jetpistol = true
        _G.canuse = false
        local v158 = u154.Humanoid:LoadAnimation(script.Gear2Anims.jetpistol)
        v158:Play()
        v158:AdjustWeight(2)
        _G.FaceMouse = true
        _G.PauseAnim(v158, 0.36, 1)
        local u159 = tick()
        local v160 = game.ReplicatedStorage.Events.Skill:InvokeServer("Jet Pistol")
        local function v161() --[[ Line: 872 ]]
            --[[
            Upvalues:
                [1] = u159
                [2] = u151
                [3] = u154
                [4] = u155
            --]]
            if tick() - u159 >= 10 or (u151.on == false or (u154.Parent == nil or (u154.Parent ~= workspace.PlayerCharacters or u155.Stamina.Value <= 0))) then
                return true
            end
        end
        _G.holdSkill(Enum.KeyCode.E, checkFunction, v161)
        u151:ChargeSkill(p152, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = v161
        })
        _G.FaceMouse = false
        u154.HumanoidRootPart.Anchored = true
        local v162 = u151:GetMouseCFrame().Position
        u154:SetPrimaryPartCFrame(CFrame.new(u154.PrimaryPart.Position, v162))
        if v160 then
            v160:FireServer(CFrame.new(v162))
        end
        v158:AdjustSpeed(4)
        task.wait(0.25)
        u154.Humanoid.AutoRotate = false
        u154.Humanoid.AutoRotate = true
        u154.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Jet Pistol", v157)
        _G.fw(v157)
        v153.jetpistol = false
    end
end
function u5.JetRocket(u163, p164) --[[ Line: 915 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v165 = u163.Cooldowns
    local u166 = u1.Character
    local u167 = u2["Stats" .. u1.Name]
    if _G.grounded == false and (v165.jetRocket == false and (_G.check:inspect(u166) == true and _G.StamCheck("Jet Rocket") == true)) then
        local v168 = u3.GetM("Jet Rocket")
        local v169 = v168.cd
        if _G.StamCheck("Jet Rocket") == false then
            return
        end
        if v168.statreq and _G.MeetReq(v168.statreq) == false then
            return
        end
        v165.jetRocket = true
        _G.canuse = false
        local v170 = u166.Humanoid:LoadAnimation(script.Gear2Anims.rocket)
        v170:Play()
        v170:AdjustWeight(2)
        _G.FaceMouse = true
        _G.PauseAnim(v170, 0.48, 1)
        local u171 = tick()
        u163:ChargeSkill(p164, {
            ["Key"] = Enum.KeyCode.T,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 942 ]]
                --[[
                Upvalues:
                    [1] = u171
                    [2] = u163
                    [3] = u166
                    [4] = u167
                --]]
                if tick() - u171 >= 10 or (u163.on == false or (u166.Parent == nil or (u166.Parent ~= workspace.PlayerCharacters or u167.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v170:Stop()
        _G.FaceMouse = false
        local v172 = u163:GetMouseCFrame().Position
        local v173 = _G.getTargetNearMouse(125)
        if v173 then
            v172 = v173.Position
        end
        u166.PrimaryPart.Anchored = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Jet Rocket", v172)
        u166.PrimaryPart.Anchored = false
        task.wait(0.25)
        u166.Humanoid.AutoRotate = false
        u166.Humanoid.AutoRotate = true
        u166.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Jet Rocket", v169)
        u163.RocketCD("Jet Rocket", v169)
        _G.fw(v169)
        v165.jetRocket = false
    end
end
function u5.JetStomp(p174, _) --[[ Line: 977 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v175 = p174.Cooldowns
    local v176 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v175.stamp == false and (_G.check:inspect(v176) == true and _G.StamCheck("Jet Stomp") == true) then
        local v177 = u3.GetM("Jet Stomp")
        local v178 = v177.cd
        if _G.StamCheck("Jet Stomp") == false then
            return
        end
        if v177.statreq and _G.MeetReq(v177.statreq) == false then
            return
        end
        _G.canuse = false
        v175.stamp = true
        local v179 = v176.Humanoid:LoadAnimation(script.Gear2Anims.stamp)
        v179:Play()
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Jet Stomp")
        task.wait(1)
        v179:Stop()
        _G.canuse = true
        _G.keysetup:cooldown("Jet Stomp", v178)
        _G.fw(v178)
        v175.stamp = false
    end
end
function u5.RedHawk(u180, p181) --[[ Line: 1009 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v182 = u180.Cooldowns
    local u183 = u1.Character
    local u184 = u2["Stats" .. u1.Name]
    if v182.hawk == false and (_G.check:inspect(u183) == true and _G.StamCheck("Red Hawk") == true) then
        local v185 = u3.GetM("Red Hawk")
        local v186 = v185.cd
        if _G.StamCheck("Red Hawk") == false then
            return
        end
        if v185.statreq and _G.MeetReq(v185.statreq) == false then
            return
        end
        v182.hawk = true
        _G.canuse = false
        local v187 = u183.Humanoid:LoadAnimation(script.Gear2Anims.redhawk)
        v187:Play()
        v187:AdjustWeight(2)
        _G.FaceMouse = true
        local v188 = game.ReplicatedStorage.Events.Skill:InvokeServer("Red Hawk")
        _G.PauseAnim(v187, 0.5900000000000001, 1)
        local u189 = tick()
        u180:ChargeSkill(p181, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 1040 ]]
                --[[
                Upvalues:
                    [1] = u189
                    [2] = u180
                    [3] = u183
                    [4] = u184
                --]]
                if tick() - u189 >= 10 or (u180.on == false or (u183.Parent == nil or (u183.Parent ~= workspace.PlayerCharacters or u184.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        _G.FaceMouse = false
        u183.HumanoidRootPart.Anchored = true
        local v190 = u180:GetMouseCFrame().Position
        v187:AdjustSpeed(1.25)
        u183:SetPrimaryPartCFrame(CFrame.new(u183.PrimaryPart.Position, v190))
        if v188 then
            v188:FireServer(u183.PrimaryPart.CFrame)
        end
        task.wait(1)
        u183.Humanoid.AutoRotate = false
        u183.Humanoid.AutoRotate = true
        u183.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Red Hawk", v186)
        _G.fw(v186)
        v182.hawk = false
    end
end
return u5