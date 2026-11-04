 

local u1 = game.Players.LocalPlayer
local u2 = game:GetService("RunService")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
local v5 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u6 = v5:GetControls()
local u7 = setmetatable({}, u4)
u7.__index = u7
function u7.new(_) --[[ Line: 19 ]]
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
        ["Firefly"] = false,
        ["Hiken"] = false,
        ["Flight"] = false,
        ["Pillar"] = false,
        ["Entai"] = false
    }
    task.spawn(function() --[[ Line: 30 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u10
        --]]
        local v11 = (u1.Character or u1.CharacterAdded:Wait()).Humanoid
        u10.fly = {
            ["Idle"] = v11:LoadAnimation(script.Fly.idle),
            ["Front"] = v11:LoadAnimation(script.Fly.front),
            ["Back"] = v11:LoadAnimation(script.Fly.back),
            ["Left"] = v11:LoadAnimation(script.Fly.left),
            ["Right"] = v11:LoadAnimation(script.Fly.right)
        }
    end)
    return u10
end
function u7.stopAll(p12, p13) --[[ Line: 45 ]]
    for v14, v15 in p12.fly do
        if v14 ~= p13 then
            v15:Stop()
        end
    end
end
function u7.playAnim(p16, p17) --[[ Line: 53 ]]
    if p16.fly[p17].IsPlaying == false then
        p16.fly[p17]:Play()
    end
    p16:stopAll(p17)
end
function u7.Firefly(p18, _) --[[ Line: 60 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    local v19 = p18.Cooldowns
    local v20 = u1.Character
    if v19.Firefly == false and (_G.check:inspect(v20) == true and _G.StamCheck("Firefly") == true) then
        local v21 = u3.GetM("Firefly")
        local v22 = v21.cd
        if _G.StamCheck("Firefly") == false then
            return
        end
        if v21.statreq and _G.MeetReq(v21.statreq) == false then
            return
        end
        v19.Firefly = true
        _G.canuse = false
        local v23 = v20.Humanoid:LoadAnimation(script.firefly)
        v23:Play()
        v23.Priority = Enum.AnimationPriority.Action2
        local v24 = {
            ["Target"] = _G.getTargetNearMouse(),
            ["cf"] = p18:GetMouseCFrame()
        }
        game.ReplicatedStorage.Events.Skill:InvokeServer("Firefly", v24)
        task.wait(0.25)
        _G.canuse = true
        v23:Stop()
        _G.keysetup:cooldown("Firefly", v22)
        _G.fw(v22)
        v19.Firefly = false
    end
end
function u7.FlamePillar(p25, p26) --[[ Line: 94 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    local v27 = p25.Cooldowns
    local u28 = u1.Character
    if v27.Pillar == false and (_G.check:inspect(u28) == true and _G.StamCheck("Flame Pillar") == true) then
        local v29 = u3.GetM("Flame Pillar")
        local v30 = v29.cd
        if _G.StamCheck("Flame Pillar") == false then
            return
        end
        if v29.statreq and _G.MeetReq(v29.statreq) == false then
            return
        end
        if p25.Flying then
            _G.displayMessage("<Color=Red>Cant use flame pillar while flying!")
            return
        end
        v27.Pillar = true
        _G.canuse = false
        local u31 = u28.Humanoid:LoadAnimation(script.pillar)
        u31:Play()
        u31:AdjustWeight(2)
        u28.Humanoid.WalkSpeed = 4
        local v32 = game.ReplicatedStorage.Events.Skill:InvokeServer("Flame Pillar")
        _G.PauseAnim(u31, 0.4, 0.6)
        p25:ChargeSkill(p26, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 123 ]]
                --[[
                Upvalues:
                    [1] = u28
                --]]
                u28.Humanoid.WalkSpeed = 4
                _G.canuse = false
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 128 ]]
                --[[
                Upvalues:
                    [1] = u28
                --]]
                return not u28:FindFirstChild("Mera-Mera")
            end
        })
        u31:AdjustSpeed(1)
        spawn(function() --[[ Line: 139 ]]
            --[[
            Upvalues:
                [1] = u31
            --]]
            task.wait(0.25)
            u31:AdjustSpeed(0)
        end)
        task.wait(0.2)
        if v32 then
            v32:InvokeServer()
        end
        u31:AdjustSpeed(1)
        spawn(function() --[[ Line: 148 ]]
            --[[
            Upvalues:
                [1] = u31
            --]]
            task.wait(1)
            u31:Stop()
        end)
        u28.Humanoid.WalkSpeed = 16
        u28.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Flame Pillar", v30)
        _G.fw(v30)
        v27.Pillar = false
    end
end
u7["DaiEnkai:Entei"] = function(p33, p34) --[[ Line: 162 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    local v35 = p33.Cooldowns
    local u36 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u37 = u1.Character
    local _ = u3.GetM("Dai Enkai: Entei").cd
    if v35.Entai == false and (_G.check:inspect(u37) == true and _G.StamCheck("Dai Enkai: Entei") == true) then
        local v38 = u3.GetM("Dai Enkai: Entei")
        local v39 = v38.cd
        if _G.StamCheck("Dai Enkai: Entei") == false then
            return
        end
        if v38.statreq and _G.MeetReq(v38.statreq) == false then
            return
        end
        v35.Entai = true
        _G.canuse = false
        local v40 = u37.Humanoid:LoadAnimation(script.enkai)
        v40:Play()
        v40:AdjustWeight(2)
        _G.FaceMouse = true
        _G.PauseAnim(v40, 0.5, 1)
        local u41 = tick()
        local v42 = game.ReplicatedStorage.Events.Skill:InvokeServer("Dai Enkai: Entei")
        p33:ChargeSkill(p34, {
            ["Key"] = Enum.KeyCode.C,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 189 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 193 ]]
                --[[
                Upvalues:
                    [1] = u37
                    [2] = u36
                    [3] = u41
                --]]
                if not u37:FindFirstChild("Mera-Mera") or (u36.Stamina.Value <= 0 or (tick() - u41 >= 15 or u37:GetAttribute("meraUltMax") ~= nil)) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v40:AdjustSpeed(1)
        task.wait(0.1)
        _G.FaceMouse = false
        u37.HumanoidRootPart.Anchored = true
        if v42 then
            v42:InvokeServer(p33:GetMousePosition())
        end
        task.wait(0.25)
        u37.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Dai Enkai: Entei", v39)
        _G.fw(v39)
        v35.Entai = false
    end
end
function u7.Hiken(p43, p44) --[[ Line: 222 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    local v45 = p43.Cooldowns
    local v46 = u1.Character
    if v45.Hiken == false and (_G.check:inspect(v46) == true and _G.StamCheck("Hiken") == true) then
        local v47 = u3.GetM("Hiken")
        local v48 = v47.cd
        if _G.StamCheck("Hiken") == false then
            return
        end
        if v47.statreq and _G.MeetReq(v47.statreq) == false then
            return
        end
        v45.Hiken = true
        _G.canuse = false
        local v49 = v46.Humanoid:LoadAnimation(script.hiken)
        v49:Play()
        v49:AdjustWeight(2)
        _G.FaceMouse = true
        _G.PauseAnim(v49, 0.4, 2)
        v46.Humanoid.PlatformStand = true
        local u50 = tick()
        local v51 = game.ReplicatedStorage.Events.Skill:InvokeServer("Hiken")
        local function v52() --[[ Line: 251 ]]
            --[[
            Upvalues:
                [1] = u1
                [2] = u50
            --]]
            if not u1.Character:FindFirstChild("Mera-Mera") or tick() - u50 >= 10 then
                return true
            end
        end
        p43:ChargeSkill(p44, {
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 247 ]] end,
            ["EndFunction"] = v52
        })
        _G.FaceMouse = false
        v46.Humanoid.PlatformStand = false
        v46.HumanoidRootPart.Anchored = true
        v49:AdjustSpeed(1)
        task.wait(0.2)
        if v51 then
            v51:InvokeServer(v46.PrimaryPart.CFrame)
        end
        task.wait(0.5)
        v46.HumanoidRootPart.Anchored = false
        _G.keysetup:cooldown("Hiken", v48)
        _G.canuse = true
        _G.fw(v48)
        v45.Hiken = false
    end
end
local function u70(p53) --[[ Line: 281 ]]
    local v54 = p53.X
    local v55 = math.abs(v54)
    local v56 = p53.Y
    if math.abs(v56) < v55 then
        local v57 = p53.X
        local v58 = math.abs(v57)
        local v59 = p53.Z
        if math.abs(v59) < v58 then
            local v60 = p53.X > 0 and "Right" or "Left"
            local v61 = p53.X
            return v60, math.abs(v61)
        end
    end
    local v62 = p53.Z
    local v63 = math.abs(v62)
    local v64 = p53.X
    if math.abs(v64) < v63 then
        local v65 = p53.Z
        local v66 = math.abs(v65)
        local v67 = p53.Y
        if math.abs(v67) < v66 then
            local v68 = p53.Z > 0 and "Down" or "Up"
            local v69 = p53.Z
            return v68, math.abs(v69)
        end
    end
    return "None", 0
end
function u7.FlameFlight(u71, p72) --[[ Line: 292 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
        [3] = u2
        [4] = u6
        [5] = u70
    --]]
    local u73 = u71.Cooldowns
    local u74 = game.ReplicatedStorage["Stats" .. u1.Name]
    local v75 = u3.GetM("Flame Flight")
    local u76 = v75.cd
    local u77 = u1.Character
    local function v78() --[[ Line: 300 ]]
        --[[
        Upvalues:
            [1] = u71
            [2] = u77
            [3] = u76
            [4] = u73
        --]]
        if u71.Flying then
            u71.Flying:Disconnect()
            u71.Flying = nil
        end
        u71:stopAll()
        u77.Humanoid.PlatformStand = false
        u71.flyBG:Destroy()
        u71.flyBV:Destroy()
        if u71.FlyRemote then
            pcall(function() --[[ Line: 312 ]]
                --[[
                Upvalues:
                    [1] = u71
                --]]
                u71.FlyRemote:InvokeServer()
            end)
            u71.FlyRemote = nil
        end
        _G.keysetup:cooldown("Flame Flight", u76)
        _G.fw(u76)
        u73.Flight = false
    end
    if _G.grounded == false and (u73.Flight == false and (_G.check:inspect(u77) == true and _G.StamCheck("Flame Flight") == true)) then
        if _G.StamCheck("Flame Flight") == false then
            return
        end
        if v75.statreq and _G.MeetReq(v75.statreq) == false then
            return
        end
        u73.Flight = true
        _G.canuse = false
        local v79 = u77.Humanoid:LoadAnimation(script.flyactivation)
        v79:Play()
        v79:AdjustSpeed(1)
        v79:AdjustWeight(2)
        u77.Humanoid.WalkSpeed = 0
        task.wait(0.4)
        if u77.HumanoidRootPart:FindFirstChild("ComboBP") == nil then
            local v80 = Instance.new("BodyVelocity", u77.LowerTorso)
            v80.Name = "geppo"
            v80.MaxForce = Vector3.new(1000000000, 10000000000000000, 1000000000)
            v80.Velocity = u77.HumanoidRootPart.CFrame.upVector * 100
            v80.P = 4324234234
            _G.destroy(v80, 0.25)
        end
        u71.FlyRemote = game.ReplicatedStorage.Events.Skill:InvokeServer("Flame Flight")
        task.wait(0.6)
        local u81 = Instance.new("BodyVelocity", u77.LowerTorso)
        u81.Name = "geppo"
        u81.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
        u81.Velocity = Vector3.new()
        local u82 = Instance.new("BodyGyro")
        u82.P = 100000
        u82.D = 2500
        u82.MaxTorque = Vector3.new(100000000000, 100000000000, 100000000000)
        u77.Humanoid.WalkSpeed = 16
        u82.Parent = u77.LowerTorso
        u71.flyBG = u82
        u71.flyBV = u81
        u77.Humanoid.PlatformStand = true
        local u83 = 50
        u71.Flying = u2.RenderStepped:Connect(function() --[[ Line: 369 ]]
            --[[
            Upvalues:
                [1] = u77
                [2] = u74
                [3] = u71
                [4] = u83
                [5] = u6
                [6] = u70
                [7] = u81
                [8] = u82
            --]]
            if u77.Parent == workspace.PlayerCharacters and (u74.Stamina.Value > 0 and (u71.FlyRemote ~= nil and (not u71.FlyRemote or u71.FlyRemote.Parent ~= nil))) and not _G.grounded then
                if u77:FindFirstChild("inCombat") == nil then
                    u83 = 50
                else
                    u83 = 25
                end
                local v84 = u6:GetMoveVector()
                local v85 = u83 * (u77.Humanoid.Health / u77.Humanoid.MaxHealth)
                local v86 = u70(v84)
                local v87 = workspace.CurrentCamera
                u81.Velocity = (v87.CFrame.LookVector * -v84.Z * 2 + v87.CFrame.RightVector * v84.X) * v85
                if _G.FaceMouse == true or (u77:FindFirstChildWhichIsA("ObjectValue") or _G.canuse == false) then
                    u81.Velocity = Vector3.new()
                end
                if _G.FaceMouse == true then
                    u82.Parent = nil
                    u82.MaxTorque = Vector3.new(0, 0, 0)
                else
                    if v86 == "Down" then
                        u71:playAnim("Back")
                    elseif v86 == "Left" then
                        u71:playAnim("Left")
                    elseif v86 == "Right" then
                        u71:playAnim("Right")
                    elseif v86 == "Up" then
                        u71:playAnim("Front")
                    elseif v86 == "None" then
                        u71:playAnim("Idle")
                    end
                    u82.MaxTorque = Vector3.new(100000000000, 100000000000, 100000000000)
                    u82.CFrame = workspace.CurrentCamera.CFrame
                    u82.Parent = u77.LowerTorso
                end
                u77.Humanoid.PlatformStand = true
                local v88 = u77:FindFirstChildWhichIsA("Tool")
                if v88 and v88 ~= u71.Tool then
                    task.defer(function() --[[ Line: 426 ]]
                        --[[
                        Upvalues:
                            [1] = u77
                        --]]
                        u77.Humanoid:UnequipTools()
                    end)
                end
            end
        end)
        local u89 = tick()
        u71:DoubleCastSkill(p72, {
            ["ToolName"] = script.Name,
            ["Button"] = p72,
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 440 ]]
                --[[
                Upvalues:
                    [1] = u77
                    [2] = u89
                    [3] = u74
                    [4] = u71
                --]]
                if u77:FindFirstChild("inCombat") then
                    if tick() - u89 >= 30 then
                        return true
                    end
                    if u77:FindFirstChild("PB") then
                        return true
                    end
                end
                return (u77.Parent ~= workspace.PlayerCharacters or (u74.Stamina.Value <= 0 or (u71.FlyRemote == nil or u71.FlyRemote and u71.FlyRemote:IsDescendantOf(game) == false))) and true or _G.grounded
            end,
            ["CompleteFunction"] = v78,
            ["SkipTap"] = true
        })
        _G.canuse = true
    end
end
return u7