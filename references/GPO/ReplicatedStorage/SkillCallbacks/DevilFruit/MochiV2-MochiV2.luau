 

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
function u5.new(_) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    local v6 = u4.new(script.Name)
    local v7 = u5
    local v8 = setmetatable(v6, v7)
    v8.Cooldowns = {
        ["Burning Power Mochi"] = false,
        ["Zigzag Power Pummel"] = false,
        ["Spiked Donut Roll"] = false,
        ["Mochi Blitz Barrage"] = false,
        ["Burning Chestnut Mochi"] = false,
        ["Burning Mochi Rocket"] = false,
        ["Supreme Mochi Buzzcut"] = false
    }
    v8.usingChesetnut = false
    v8.rollingDonut = false
    return v8
end
function u5.BurningPowerMochi(u9, p10) --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = u9.Cooldowns
    local u12 = u1.Character
    local u13 = u2["Stats" .. u1.Name]
    if v11["Burning Power Mochi"] == false and (_G.check:inspect(u12) == true and (_G.StamCheck("Burning Power Mochi") == true and u9.usingChesetnut == false)) then
        local v14 = u3.GetM("Burning Power Mochi")
        local v15 = v14.cd
        if _G.StamCheck("Burning Power Mochi") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        v11["Burning Power Mochi"] = true
        local u16 = u12.Humanoid:LoadAnimation(script.punch2)
        u16:Play()
        u16:AdjustWeight(5)
        u16.Priority = Enum.AnimationPriority.Action4
        u12.Humanoid.WalkSpeed = 4
        _G.FaceMouse = true
        _G.canuse = false
        local v17 = game.ReplicatedStorage.Events.Skill:InvokeServer("Burning Power Mochi")
        _G.PauseAnim(u16, 0.217, 0.36)
        local u18 = tick()
        u9:ChargeSkill(p10, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 60 ]]
                --[[
                Upvalues:
                    [1] = u9
                    [2] = u12
                    [3] = u13
                    [4] = u18
                --]]
                if u9.Tool.Parent ~= u12 or (u12.Parent == nil or (u12.Parent ~= workspace.PlayerCharacters or (u13.Stamina.Value <= 0 or tick() - u18 >= 10))) then
                    return true
                end
            end
        })
        u16:AdjustSpeed(1)
        local v19 = u12.HumanoidRootPart.CFrame
        u12.Humanoid.AutoRotate = false
        u12.HumanoidRootPart.Anchored = true
        task.delay(0.45, function() --[[ Line: 76 ]]
            --[[
            Upvalues:
                [1] = u16
            --]]
            u16:AdjustSpeed(0)
        end)
        task.wait(0.2)
        u12.Humanoid.AutoRotate = false
        if v17 then
            v17:InvokeServer(v19)
        end
        _G.FaceMouse = false
        u16:Stop()
        u12.Humanoid.AutoRotate = true
        u12.HumanoidRootPart.Anchored = false
        _G.canuse = true
        u12.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Burning Power Mochi", v15)
        _G.fw(v15)
        v11["Burning Power Mochi"] = false
    end
end
function u5.ZigzagPowerPummel(p20, _) --[[ Line: 99 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v21 = p20.Cooldowns
    local v22 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v21["Zigzag Power Pummel"] == false and (_G.check:inspect(v22) == true and (_G.StamCheck("Zigzag Power Pummel") == true and p20.usingChesetnut == false)) then
        local v23 = u3.GetM("Zigzag Power Pummel")
        local v24 = v23.cd
        if _G.StamCheck("Zigzag Power Pummel") == false then
            return
        end
        if v23.statreq and _G.MeetReq(v23.statreq) == false then
            return
        end
        v21["Zigzag Power Pummel"] = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Zigzag Power Pummel", v22.PrimaryPart.CFrame)
        _G.canuse = true
        v22.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Zigzag Power Pummel", v24)
        _G.fw(v24)
        v21["Zigzag Power Pummel"] = false
    end
end
function u5.SpikedDonutRoll(u25, p26) --[[ Line: 128 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local u27 = u25.Cooldowns
    local u28 = u1.Character
    local u29 = u2["Stats" .. u1.Name]
    if u27["Spiked Donut Roll"] == false and (_G.check:inspect(u28) == true and (_G.StamCheck("Spiked Donut Roll") == true and u25.usingChesetnut == false)) then
        local v30 = u3.GetM("Spiked Donut Roll")
        local u31 = v30.cd
        if _G.StamCheck("Spiked Donut Roll") == false then
            return
        end
        if v30.statreq and _G.MeetReq(v30.statreq) == false then
            return
        end
        u27["Spiked Donut Roll"] = true
        local _ = workspace.CurrentCamera
        local v32 = u28.Humanoid:LoadAnimation(script.wheelStart)
        v32:Play(0)
        v32:AdjustSpeed(1.35)
        v32:AdjustWeight(2)
        _G.allowJumpWhileStunned = true
        _G.canuse = false
        u28.Humanoid.AutoRotate = false
        task.wait(0.2)
        local u33 = game.ReplicatedStorage.Events.Skill:InvokeServer("Spiked Donut Roll")
        if u33 then
            u25.rollingDonut = true
        end
        local u34 = tick()
        local u35 = false
        u25:DoubleCastSkill(p26, {
            ["ToolName"] = script.Name,
            ["Button"] = p26,
            ["Key"] = Enum.KeyCode.T,
            ["IgnoreInstantCastSetting"] = true,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 167 ]]
                --[[
                Upvalues:
                    [1] = u28
                    [2] = u35
                    [3] = u34
                    [4] = u25
                    [5] = u29
                --]]
                u28.Humanoid.WalkSpeed = 0
                u28.Humanoid.AutoRotate = false
                if u28:GetAttribute("usingSupremeBuzzcut") == true then
                    u35 = true
                end
                _G.allowJumpWhileStunned = true
                if tick() - u34 >= 60 or (u28:GetAttribute("spikedMochiRolling") == nil or (u25.Tool.Parent ~= u28 or (u28.Parent == nil or (u35 == true or (u28.Parent ~= workspace.PlayerCharacters or (u29.Stamina.Value <= 0 or _G.check:inspect(u28) == false and u28:FindFirstChild("GrabTag") == nil)))))) or u28:FindFirstChild("PB") then
                    return true
                end
            end,
            ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 180 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u35
                    [3] = u28
                    [4] = u25
                    [5] = u31
                    [6] = u27
                --]]
                if u33 then
                    u33:FireServer(u35)
                end
                if u28:GetAttribute("usingSupremeBuzzcut") == nil then
                    local v36 = u28.Humanoid:LoadAnimation(script.wheelEnd)
                    v36:Play(0)
                    v36:AdjustWeight(2)
                end
                u25.rollingDonut = false
                tick()
                task.wait(0.75)
                _G.allowJumpWhileStunned = nil
                if u28:GetAttribute("usingSupremeBuzzcut") == nil then
                    _G.canuse = true
                end
                u28.Humanoid.AutoRotate = true
                u28.Humanoid.WalkSpeed = 16
                _G.keysetup:cooldown("Spiked Donut Roll", u31)
                _G.fw(u31)
                u27["Spiked Donut Roll"] = false
            end,
            ["PassFunction"] = function() --[[ Name: PassFunction, Line 210 ]]
                return true
            end,
            ["SkipTap"] = true
        })
    end
end
function u5.MochiBlitzBarrage(u37, p38) --[[ Line: 219 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v39 = u37.Cooldowns
    local u40 = u1.Character
    local u41 = u2["Stats" .. u1.Name]
    if v39["Mochi Blitz Barrage"] == false and (_G.check:inspect(u40) == true and (_G.StamCheck("Mochi Blitz Barrage") == true and u37.usingChesetnut == false)) then
        local v42 = u3.GetM("Mochi Blitz Barrage")
        local v43 = v42.cd
        if _G.StamCheck("Mochi Blitz Barrage") == false then
            return
        end
        if v42.statreq and _G.MeetReq(v42.statreq) == false then
            return
        end
        local u44 = tick()
        local u45 = tick()
        _G.canuse = false
        u37:ChargeSkill(p38, {
            ["Key"] = Enum.KeyCode.E,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 245 ]]
                --[[
                Upvalues:
                    [1] = u45
                    [2] = u44
                --]]
                u45 = tick() - u44
                return u45 > 0.2
            end,
            ["canUse"] = false
        })
        local v46 = nil
        if tick() - u44 < 0.2 then
            warn("long range", tick() - u44, 0.2)
            v46 = true
        else
            warn("close range")
        end
        v39["Mochi Blitz Barrage"] = true
        local v47
        if v46 == nil then
            v47 = u40.Humanoid:LoadAnimation(script.barrage)
            v47:Play()
            v47:AdjustSpeed(2)
        else
            v47 = u40.Humanoid:LoadAnimation(script.barragelong)
            v47:Play()
            v47:AdjustWeight(2)
            v47:AdjustSpeed(2)
            task.wait(0.375)
        end
        local v48 = game.ReplicatedStorage.Events.Skill:InvokeServer("Mochi Blitz Barrage", {
            ["MousePosition"] = u37:GetMouseCFrame(),
            ["longRange"] = v46
        })
        if v46 == nil then
            local u49, v50
            if v48 then
                u49, v50 = unpack(v48)
            else
                u49 = nil
                v50 = nil
            end
            local u51 = tick()
            local u52 = 0
            local function v61(_, _) --[[ Line: 288 ]]
                --[[
                Upvalues:
                    [1] = u37
                    [2] = u40
                    [3] = u41
                    [4] = u51
                    [5] = u49
                    [6] = u52
                --]]
                if u37.Tool.Parent ~= u40 or (u40.Humanoid:GetAttribute("isRagdolled") == true or (_G.check:inspect(u40) == false or (u40.Parent == nil or (u40.Parent ~= workspace.PlayerCharacters or (u41.Stamina.Value <= 0 or (tick() - u51 >= 3 or u40:FindFirstChild("PB"))))))) then
                    return true
                end
                u40.Humanoid.WalkSpeed = 4
                local v53 = u37:GetMouseCFrame().Position
                u40.Humanoid.Jump = false
                u40.Humanoid.AutoRotate = false
                local v54 = u40.PrimaryPart
                local v55 = u40.PrimaryPart.CFrame
                local v56 = CFrame.new
                local v57 = u40.PrimaryPart.Position
                local v58 = v53.X
                local v59 = u40.PrimaryPart.Position.Y
                local v60 = v53.Z
                v54.CFrame = v55:Lerp(v56(v57, (Vector3.new(v58, v59, v60))), 0.5)
                if u49 and tick() - u52 >= 0.05 then
                    u49:FireServer(v53)
                    u52 = tick()
                end
            end
            u37:ChargeSkill(p38, {
                ["Key"] = Enum.KeyCode.E,
                ["EndFunction"] = v61,
                ["IgnoreInstantCastSetting"] = true,
                ["RunServiceType"] = game["Run Service"].Stepped
            })
            v47:Stop()
            u40.HumanoidRootPart.Anchored = true
            if u49 then
                u49:FireServer(nil, u40.PrimaryPart.CFrame)
            end
            if v50 then
                v50:InvokeServer()
            end
        else
            v47:AdjustSpeed(0.25)
        end
        u40.Humanoid.AutoRotate = true
        u40.HumanoidRootPart.Anchored = false
        _G.canuse = true
        u40.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Mochi Blitz Barrage", v43)
        _G.fw(v43)
        v39["Mochi Blitz Barrage"] = false
    end
end
function u5.BurningChestnutMochi(u62, p63) --[[ Line: 336 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v64 = u62.Cooldowns
    local u65 = u1.Character
    local u66 = u2["Stats" .. u1.Name]
    if v64["Burning Chestnut Mochi"] == false and (_G.check:inspect(u65) == true and (_G.StamCheck("Burning Chestnut Mochi") == true and u62.usingChesetnut == false)) then
        local v67 = u3.GetM("Burning Chestnut Mochi")
        local v68 = v67.cd
        if _G.StamCheck("Burning Chestnut Mochi") == false then
            return
        end
        if v67.statreq and _G.MeetReq(v67.statreq) == false then
            return
        end
        _G.canuse = false
        local u69 = tick()
        local u70 = tick()
        _G.canuse = false
        u62:ChargeSkill(p63, {
            ["Key"] = Enum.KeyCode.Z,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 362 ]]
                --[[
                Upvalues:
                    [1] = u70
                    [2] = u69
                --]]
                u70 = tick() - u69
                return u70 > 0.25
            end,
            ["canUse"] = false
        })
        local v71 = tick() - u69 < 0.25 and true or nil
        v64["Burning Chestnut Mochi"] = true
        u65.Humanoid:LoadAnimation(script.chestnutStart):Play(0)
        local u72 = game.ReplicatedStorage.Events.Skill:InvokeServer("Burning Chestnut Mochi", {
            ["MousePosition"] = u62:GetMouseCFrame(),
            ["tappedVersion"] = v71
        })
        task.wait(1.75)
        _G.canuse = true
        local u73 = tick()
        local u74 = 0
        local function v76(_, _) --[[ Line: 389 ]]
            --[[
            Upvalues:
                [1] = u62
                [2] = u65
                [3] = u66
                [4] = u73
                [5] = u72
                [6] = u74
            --]]
            if u62.Tool.Parent ~= u65 or (u65.Parent == nil or (u65.Parent ~= workspace.PlayerCharacters or (u66.Stamina.Value <= 0 or (tick() - u73 >= 5 or u65:FindFirstChild("PB"))))) then
                return true
            end
            local v75 = u62:GetMouseCFrame().Position
            if u72 and tick() - u74 >= 0.05 then
                u72:FireServer(v75)
                u74 = tick()
            end
        end
        u62.usingChesetnut = true
        if v71 == nil then
            u62:ChargeSkill(p63, {
                ["Key"] = Enum.KeyCode.Z,
                ["EndFunction"] = v76,
                ["IgnoreInstantCastSetting"] = true,
                ["RunServiceType"] = game["Run Service"].Stepped,
                ["canUse"] = false
            })
        else
            repeat
                task.wait()
            until v76() == true
        end
        u62.usingChesetnut = false
        u65.HumanoidRootPart.Anchored = true
        if u72 then
            u72:FireServer(nil, u65.PrimaryPart.CFrame)
        end
        u65.HumanoidRootPart.Anchored = false
        u65.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Burning Chestnut Mochi", v68)
        _G.fw(v68)
        v64["Burning Chestnut Mochi"] = false
    end
end
function u5.BurningMochiRocket(u77, p78) --[[ Line: 436 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v79 = u77.Cooldowns
    local u80 = u1.Character
    local u81 = u2["Stats" .. u1.Name]
    if v79["Burning Mochi Rocket"] == false and (_G.check:inspect(u80) == true and (_G.StamCheck("Burning Mochi Rocket") == true and u77.usingChesetnut == false)) then
        local v82 = u3.GetM("Burning Mochi Rocket")
        local v83 = v82.cd
        if _G.StamCheck("Burning Mochi Rocket") == false then
            return
        end
        if v82.statreq and _G.MeetReq(v82.statreq) == false then
            return
        end
        v79["Burning Mochi Rocket"] = true
        _G.canuse = false
        local v84 = game.ReplicatedStorage.Events.Skill:InvokeServer("Burning Mochi Rocket")
        local v85 = u80.Humanoid:LoadAnimation(script.punch3)
        v85:Play(0)
        v85:AdjustWeight(5)
        v85.Priority = Enum.AnimationPriority.Action4
        u80.Humanoid.WalkSpeed = 4
        _G.FaceMouse = true
        _G.PauseAnim(v85, 0.15, 0.8)
        local u86 = tick()
        u77:ChargeSkill(p78, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 467 ]]
                --[[
                Upvalues:
                    [1] = u77
                    [2] = u80
                    [3] = u81
                    [4] = u86
                --]]
                if u77.Tool.Parent ~= u80 or (u80.Parent == nil or (u80.Parent ~= workspace.PlayerCharacters or (u81.Stamina.Value <= 0 or tick() - u86 >= 10))) then
                    return true
                end
            end
        })
        v85:AdjustSpeed(1)
        local _ = u80.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
        _G.FaceMouse = false
        u80.HumanoidRootPart.Anchored = true
        u80.Humanoid.AutoRotate = false
        if v84 then
            v84:InvokeServer(u77:GetMouseCFrame(), u80.PrimaryPart.CFrame, workspace:GetServerTimeNow() + 0.5499999999999999)
        end
        u80.Humanoid.AutoRotate = true
        u80.HumanoidRootPart.Anchored = false
        _G.canuse = true
        u80.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Burning Mochi Rocket", v83)
        _G.fw(v83)
        v79["Burning Mochi Rocket"] = false
    end
end
function u5.SupremeMochiBuzzcut(u87, p88) --[[ Line: 500 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v89 = u87.Cooldowns
    local u90 = u1.Character
    local u91 = u2["Stats" .. u1.Name]
    if v89["Supreme Mochi Buzzcut"] == false and (_G.check:inspect(u90) == true or u90:GetAttribute("spikedMochiRolling") == true) and (_G.StamCheck("Supreme Mochi Buzzcut", true) == true and u87.usingChesetnut == false) then
        local v92 = u3.GetM("Supreme Mochi Buzzcut")
        local v93 = v92.cd
        if _G.StamCheck("Supreme Mochi Buzzcut", true) == false then
            return
        end
        if v92.statreq and _G.MeetReq(v92.statreq) == false then
            return
        end
        v89["Supreme Mochi Buzzcut"] = true
        u90.Humanoid.WalkSpeed = 4
        _G.canuse = false
        local v94 = workspace.CurrentCamera
        v94.CameraSubject = u90.UpperTorso
        u90:SetAttribute("usingSupremeBuzzcut", true)
        local v95 = game.ReplicatedStorage.Events.Skill:InvokeServer("Supreme Mochi Buzzcut")
        local u96 = tick()
        u87:ChargeSkill(p88, {
            ["Key"] = Enum.KeyCode.C,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 525 ]]
                --[[
                Upvalues:
                    [1] = u87
                    [2] = u90
                    [3] = u91
                    [4] = u96
                --]]
                if u87.Tool.Parent ~= u90 or (u90.Parent == nil or (u90.Parent ~= workspace.PlayerCharacters or (u91.Stamina.Value <= 0 or tick() - u96 >= 10))) then
                    return true
                end
            end
        })
        if v95 then
            v95:InvokeServer()
        end
        u90:SetAttribute("usingSupremeBuzzcut", nil)
        v94.CameraSubject = u90.Humanoid
        u90.HumanoidRootPart.Anchored = false
        _G.canuse = true
        u90.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Supreme Mochi Buzzcut", v93)
        _G.fw(v93)
        v89["Supreme Mochi Buzzcut"] = false
    end
end
return u5