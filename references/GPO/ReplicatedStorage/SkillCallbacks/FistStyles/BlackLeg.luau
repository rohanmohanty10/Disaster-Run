 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local u3 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
local u4 = require(game.ReplicatedStorage.Modules.RotatedRegion3)
u1:GetMouse()
local u5 = setmetatable({}, u3)
u5.__index = u5
function u5.new(_) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u5
    --]]
    local v6 = u3.new(script.Name)
    local v7 = u5
    local v8 = setmetatable(v6, v7)
    v8.Cooldowns = {
        ["Party Table"] = false,
        ["BShot"] = false,
        ["Con"] = false,
        ["AntiManer"] = false,
        ["Coiller"] = false,
        ["transform"] = false,
        ["strike"] = false,
        ["spectrum"] = false,
        ["axe"] = false,
        ["flash"] = false,
        ["bliz"] = false,
        ["asend"] = false
    }
    return v8
end
local function u26(p9, p10, p11, p12) --[[ Line: 26 ]]
    local v13 = 0.5 * p9 * p12 * p12 + p10 * p12 + p11
    local v14 = v13 - (p9 * p12 * p12 + p10 * p12) / 3
    local v15 = (0.125 * p9 * p12 * p12 + 0.5 * p10 * p12 + p11 - 0.125 * (p11 + v13)) / 0.375 - v14
    local v16 = (v15 - p11).Magnitude
    local v17 = (v14 - v13).Magnitude
    local v18 = (p11 - v13).unit
    local v19 = (v15 - p11).unit
    local v20 = v19:Cross(v18).unit
    local v21 = (v14 - v13).unit
    local v22 = v21:Cross(v18).unit
    local v23 = v20:Cross(v19).unit
    local v24 = CFrame.new(p11.x, p11.y, p11.z, v19.x, v20.x, v23.x, v19.y, v20.y, v23.y, v19.z, v20.z, v23.z)
    local v25 = CFrame.new(v13.x, v13.y, v13.z, v21.x, v22.x, v23.x, v21.y, v22.y, v23.y, v21.z, v22.z, v23.z)
    return v16, -v17, v24, v25
end
function u5.PartyTableKickCourse(p27, p28) --[[ Line: 68 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v29 = p27.Cooldowns
    local u30 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u31 = u1.Character
    if v29["Party Table"] == false and (_G.StamCheck("Party Table Kick Course") == true and (_G.canuse == true and _G.check:inspect(u31) == true)) then
        local v32 = u2.GetM("Party Table Kick Course")
        local v33 = v32.cd
        if v32.statreq and _G.MeetReq(v32.statreq) == false then
            return
        end
        v29["Party Table"] = true
        local v34 = u31.Humanoid:LoadAnimation(script.Party)
        v34:Play()
        v34:AdjustSpeed(2.25);
        ({}).hold = true
        local u35 = tick()
        _G.canuse = false
        task.wait(0.5777777777777778)
        v34:Stop()
        local u36 = u31.Humanoid:LoadAnimation(script.PartySpin)
        u36:Play()
        u36:AdjustSpeed(2)
        local v37 = game.ReplicatedStorage.Events.Skill:InvokeServer("Party Table Kick Course")
        local u38 = tick()
        local function v41() --[[ Line: 98 ]]
            --[[
            Upvalues:
                [1] = u31
                [2] = u36
                [3] = u38
            --]]
            local v39 = u31.Humanoid:GetPlayingAnimationTracks()
            for v40 = 1, #v39 do
                if v39[v40] ~= u36 and v39[v40].Priority == Enum.AnimationPriority.Action then
                    v39[v40].Priority = Enum.AnimationPriority.Movement
                end
            end
            u31.Humanoid.WalkSpeed = 4
            if tick() - u38 >= 0.2 then
                u38 = tick()
            end
        end
        p27:ChargeSkill(p28, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = v41,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 113 ]]
                --[[
                Upvalues:
                    [1] = u31
                    [2] = u35
                    [3] = u30
                --]]
                if u31:FindFirstChild("Stun") then
                    return true
                end
                if tick() - u35 >= 4 or u30.Stamina.Value <= 0 then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        if v37 then
            v37:InvokeServer()
        end
        u36:Stop()
        u36 = u31.Humanoid:LoadAnimation(script.PartyStop)
        u36:Play()
        u36:AdjustSpeed(1.5)
        u31.Humanoid.WalkSpeed = 0
        task.wait(0.8666666666666667)
        u36:Stop()
        u31.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Party Table Kick Course", v33)
        _G.canuse = true
        task.wait(v33)
        v29["Party Table"] = false
    end
end
u5["B-Shot"] = function(p42, p43) --[[ Line: 148 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v44 = p42.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u45 = u1.Character
    if v44.BShot == false and (_G.StamCheck("B-Shot") == true and (_G.canuse == true and _G.check:inspect(u45) == true)) then
        local v46 = u2.GetM("B-Shot")
        local v47 = v46.cd
        if v46.statreq and _G.MeetReq(v46.statreq) == false then
            return
        end
        v44.BShot = true
        _G.canuse = false
        game.ReplicatedStorage.Events.StamRequest:InvokeServer("B-Shot")
        local u48 = u45.Humanoid:LoadAnimation(script.BShot)
        u48:Play()
        u48:AdjustSpeed(2)
        u48:AdjustWeight(2)
        local v49 = u45.Humanoid.HipHeight
        u45.Humanoid.HipHeight = u45.Humanoid.HipHeight + 1
        _G.PauseAnim(u48, 0.6, 1.5, function() --[[ Line: 169 ]]
            --[[
            Upvalues:
                [1] = u45
            --]]
            u45.Humanoid.WalkSpeed = 4
        end)
        local u50 = tick()
        p42:ChargeSkill(p43, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 175 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 179 ]]
                --[[
                Upvalues:
                    [1] = u45
                    [2] = u48
                    [3] = u50
                --]]
                u45.Humanoid.WalkSpeed = 8
                if _G.check:inspect(u45) == false then
                    u48:Stop()
                    return true
                end
                if tick() - u50 >= 4 then
                    return true
                end
            end
        })
        u48:AdjustSpeed(2)
        local u51 = Instance.new("BodyVelocity", u45.HumanoidRootPart)
        u51.Velocity = u45.HumanoidRootPart.CFrame.LookVector * 15 + Vector3.new(0, 20, 0)
        u51.MaxForce = Vector3.new(1000000, 1000000, 1000000)
        _G.destroy(u51, 0.25)
        _G.PlaySound(u45.PrimaryPart, script.bwoosh)
        local u52 = false
        local function v53() --[[ Line: 207 ]]
            --[[
            Upvalues:
                [1] = u51
                [2] = u52
                [3] = u48
            --]]
            u51:Destroy()
            u52 = true
            u48:Stop()
        end
        _G.hitbox:start(u45, Vector3.new(5, 5, 7), 0.3, CFrame.new(0, -1, -1), function(p54) --[[ Name: hitfound, Line 203 ]]
            --[[
            Upvalues:
                [1] = u51
            --]]
            u51:Destroy()
            game.ReplicatedStorage.Events.Skill:InvokeServer("B-Shot", {
                ["Target"] = p54.Parent
            })
        end, v53)
        u45.Humanoid.HipHeight = v49
        task.wait(0.4)
        u45.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("B-Shot", v47)
        task.wait(v47)
        v44.BShot = false
    end
end
function u5.Concasser(u55, p56) --[[ Line: 224 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u26
    --]]
    local v57 = u55.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u58 = u1.Character
    if v57.Con == false and (_G.StamCheck("Concasser") == true and (_G.canuse == true and _G.check:inspect(u58) == true)) then
        local v59 = u2.GetM("Concasser")
        local v60 = v59.cd
        if v59.statreq and _G.MeetReq(v59.statreq) == false then
            return
        end
        v57.Con = true
        _G.canuse = false
        game.ReplicatedStorage.Events.StamRequest:InvokeServer("Concasser")
        local u61 = u58.Humanoid:LoadAnimation(script.Conse)
        u61:Play()
        u61:AdjustSpeed(0)
        local u62 = 0
        local u63 = tick()
        local u64 = tick()
        local u65 = Instance.new("Attachment", game.Workspace.Terrain)
        local u66 = Instance.new("Attachment", game.Workspace.Terrain)
        local u67 = script.Beam:Clone()
        u67.Attachment0 = u65
        u67.Attachment1 = u66
        u67.Parent = workspace.Terrain
        local v68 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0)
        game:GetService("TweenService"):Create(u67, v68, {
            ["Width0"] = 0.25,
            ["Width1"] = 0.25
        }):Play()
        local u69 = nil
        local u70 = nil
        local u71 = nil
        local u72 = u55:GetMouseCFrame()
        local function v81() --[[ Line: 267 ]]
            --[[
            Upvalues:
                [1] = u58
                [2] = u61
                [3] = u64
                [4] = u72
                [5] = u55
                [6] = u62
                [7] = u69
                [8] = u70
                [9] = u71
                [10] = u26
                [11] = u67
                [12] = u65
                [13] = u66
                [14] = u63
            --]]
            if u58.Humanoid.SeatPart ~= nil then
                u61:Stop()
                return true
            end
            if tick() - u64 >= 0.2 then
                u64 = tick()
                game.ReplicatedStorage.Events.takestam:FireServer(2)
            end
            u72 = u72:Lerp(u55:GetMouseCFrame(), 0.1)
            local v73 = Ray.new(workspace.CurrentCamera.CFrame.Position, (workspace.CurrentCamera.CFrame.Position - u72.Position).unit * -(u62 + 75))
            local v74, v75 = _G.raycastWhitelist(v73, { workspace.Islands, workspace.Env, workspace.Ships })
            u69 = v74
            u70 = v75
            local v76 = u70
            u71 = u58.HumanoidRootPart.CFrame.Position
            local v77, v78, v79, v80 = u26(Vector3.new(0, -196.2, 0), (v76 - u71 - Vector3.new(0, -98.1, 0)) / 1, u71, 1)
            u67.CurveSize0 = v77
            u67.CurveSize1 = v78
            u65.CFrame = u65.Parent.CFrame:inverse() * v79
            u66.CFrame = u66.Parent.CFrame:inverse() * v80
            u62 = u62 + 0.5
            u58.Humanoid.WalkSpeed = 4
            if _G.check:inspect(u58) == false then
                u61:Stop()
                return true
            end
            if tick() - u63 >= 3 then
                return true
            end
        end
        u55:ChargeSkill(p56, {
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 263 ]] end,
            ["EndFunction"] = v81,
            ["IgnoreInstantCastSetting"] = true,
            ["RunServiceType"] = game["Run Service"].Stepped
        })
        local v82 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0)
        game:GetService("TweenService"):Create(u67, v82, {
            ["Width0"] = 0,
            ["Width1"] = 0
        }):Play()
        _G.destroy(u65, 0.25)
        _G.destroy(u66, 0.25)
        u66 = nil
        u65 = nil
        _G.destroy(u67, 0.25)
        u67 = nil
        u61:AdjustSpeed(2)
        local v83 = u62
        u62 = math.clamp(v83, 0, 80)
        task.wait(0.1)
        local u84 = false
        if u70 == nil then
            u70 = u58.PrimaryPart.Position
        end
        local v85 = u70 + Vector3.new(0, 2, 0)
        local u86 = (CFrame.new(u70, u58.HumanoidRootPart.Position) * CFrame.new(0, 0, 100)).Position
        local u87 = u58.Humanoid:LoadAnimation(script.ConseSpin)
        task.delay(0.25, function() --[[ Line: 336 ]]
            --[[
            Upvalues:
                [1] = u61
                [2] = u84
                [3] = u87
            --]]
            u61:Stop()
            if u84 == false then
                u87:Play()
            end
        end)
        if u71 == nil then
            u71 = u58.HumanoidRootPart.CFrame.Position
        end
        local u88 = (v85 - u71 - Vector3.new(0, -98.1, 0)) / 1
        local u89 = 0
        local u90 = nil
        local u91 = nil
        local v92 = {
            ["g"] = Vector3.new(0, -196.2, 0),
            ["char"] = u58,
            ["nt"] = u89,
            ["t"] = 1,
            ["v0"] = u88,
            ["x0"] = u71,
            ["en2"] = u86,
            ["endcf"] = u91
        }
        local v93 = game.ReplicatedStorage.Events.Skill:InvokeServer("Concasser", v92)
        local v94 = Instance.new("BoolValue", u58.HumanoidRootPart)
        v94.Name = "geppo"
        if _G.check:inspect(u58) == true then
            local _ = game["Run Service"].Heartbeat:Connect(function(p95) --[[ Line: 356 ]]
                --[[
                Upvalues:
                    [1] = u58
                    [2] = u89
                    [3] = u88
                    [4] = u71
                    [5] = u86
                    [6] = u91
                    [7] = u90
                    [8] = u84
                    [9] = u87
                --]]
                u58.HumanoidRootPart.CFrame = CFrame.new(CFrame.new(Vector3.new(0, -98.1, 0) * u89 * u89 + u88 * u89 + u71).Position, u86)
                local v96 = u89 + p95
                local v97 = CFrame.new(Vector3.new(0, -98.1, 0) * v96 * v96 + u88 * v96 + u71)
                local v98 = Ray.new(u58.HumanoidRootPart.CFrame.Position, (u58.HumanoidRootPart.CFrame.Position - v97.Position).unit * -(u58.HumanoidRootPart.CFrame.Position - v97.Position).Magnitude)
                local v99, v100 = _G.raycastIgnoreList(v98, {
                    u58,
                    workspace.Ragdolls,
                    workspace.Effects,
                    workspace.Projectiles,
                    workspace.CurrentCamera,
                    workspace.PlayerCharacters
                })
                Ray.new(u58.HumanoidRootPart.CFrame.Position, (u58.HumanoidRootPart.CFrame.Position - v97.Position).unit * (u58.HumanoidRootPart.CFrame.Position - v97.Position).Magnitude / 2)
                u58.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                if v99 then
                    local v101 = u58.Humanoid.HipHeight * 1.5
                    local v102 = v100 + Vector3.new(0, v101)
                    local v103 = u58.HumanoidRootPart
                    local v104 = CFrame.new
                    local v105 = u86.x
                    local v106 = v102.y
                    local v107 = u86.z
                    v103.CFrame = v104(v102, (Vector3.new(v105, v106, v107)))
                    u91 = u58.HumanoidRootPart.CFrame
                    u58.HumanoidRootPart.Anchored = true
                    u58.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    u90:Disconnect()
                    u90 = nil
                    u84 = true
                end
                u87:AdjustSpeed(u89 * 1.5)
                u89 = u89 + p95
            end)
        else
            u84 = true
        end
        repeat
            task.wait()
        until u84 == true
        u87:Stop()
        local u108 = u58.Humanoid:LoadAnimation(script.ConEnd)
        u108:Play()
        u108:AdjustWeight(2)
        if v93 then
            v93:InvokeServer({
                ["cf"] = u91,
                ["cf2"] = u58.RightFoot.CFrame
            })
        end
        task.delay(0.2, function() --[[ Line: 391 ]]
            --[[
            Upvalues:
                [1] = u108
            --]]
            u108:Stop()
        end)
        u58.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        task.wait(0.2)
        u58.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        u58.HumanoidRootPart.Anchored = false
        task.wait(0.4)
        v94:Destroy()
        u58.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Concasser", v60)
        _G.canuse = true
        task.wait(v60)
        v57.Con = false
    end
end
u5["Anti-MannerKickCourse"] = function(p109, p110) --[[ Line: 411 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v111 = p109.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u112 = u1.Character
    if v111.AntiManer == false and (_G.StamCheck("Anti-Manner Kick Course") == true and (_G.canuse == true and _G.check:inspect(u112) == true)) then
        local v113 = u2.GetM("Anti-Manner Kick Course")
        local v114 = v113.cd
        if v113.statreq and _G.MeetReq(v113.statreq) == false then
            return
        end
        v111.AntiManer = true
        _G.canuse = false
        game.ReplicatedStorage.Events.StamRequest:InvokeServer("Anti-Manner Kick Course")
        local u115 = u112.Humanoid:LoadAnimation(script.AntiManer)
        u115:Play()
        u115:AdjustSpeed(0)
        u115:AdjustWeight(2)
        _G.PauseAnim(u115, 0.3, 1, function() --[[ Line: 431 ]]
            --[[
            Upvalues:
                [1] = u112
            --]]
            u112.Humanoid.WalkSpeed = 4
        end)
        local u116 = tick()
        p109:ChargeSkill(p110, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 437 ]]
                --[[
                Upvalues:
                    [1] = u112
                    [2] = u115
                    [3] = u116
                --]]
                u112.Humanoid.WalkSpeed = 4
                if _G.check:inspect(u112) == false then
                    u115:Stop()
                    return true
                end
                if tick() - u116 >= 10 then
                    return true
                end
            end
        })
        u115:AdjustSpeed(2)
        _G.PlaySound(u112.PrimaryPart, script.antiwoosh)
        local u117 = false
        local function v118() --[[ Line: 460 ]]
            --[[
            Upvalues:
                [1] = u117
                [2] = u115
            --]]
            u117 = true
            u115:Stop()
        end
        _G.hitbox:start(u112, Vector3.new(5, 5, 5), 0.3, CFrame.new(0, 0, -1), function(p119) --[[ Name: hitfound, Line 457 ]]
            game.ReplicatedStorage.Events.Skill:InvokeServer("Anti-Manner Kick Course", {
                ["Target"] = p119.Parent
            })
        end, v118)
        task.wait(0.4)
        u112.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Anti-Manner Kick Course", v114)
        _G.canuse = true
        task.wait(v114)
        v111.AntiManer = false
    end
end
function u5.Coiller(p120, p121) --[[ Line: 474 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v122 = p120.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u123 = u1.Character
    if v122.Coiller == false and (_G.StamCheck("Coiller") == true and (_G.canuse == true and _G.check:inspect(u123) == true)) then
        local v124 = u2.GetM("Coiller")
        local v125 = v124.cd
        if v124.statreq and _G.MeetReq(v124.statreq) == false then
            return
        end
        v122.Coiller = true
        _G.canuse = false
        game.ReplicatedStorage.Events.StamRequest:InvokeServer("Coiller")
        local u126 = u123.Humanoid:LoadAnimation(script.Coiller)
        u126:Play()
        u126:AdjustSpeed(0)
        u126:AdjustWeight(2)
        _G.PauseAnim(u126, 0.25, 1.15, function() --[[ Line: 493 ]]
            --[[
            Upvalues:
                [1] = u123
            --]]
            u123.Humanoid.WalkSpeed = 4
        end)
        local u127 = tick()
        p120:ChargeSkill(p121, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 499 ]]
                --[[
                Upvalues:
                    [1] = u123
                    [2] = u126
                    [3] = u127
                --]]
                u123.Humanoid.WalkSpeed = 4
                if _G.check:inspect(u123) == false then
                    u126:Stop()
                    return true
                end
                if tick() - u127 >= 10 then
                    return true
                end
            end
        })
        u126:AdjustSpeed(2)
        _G.PlaySound(u123.PrimaryPart, script.ColWoosh)
        local u128 = false
        local function v129() --[[ Line: 522 ]]
            --[[
            Upvalues:
                [1] = u128
                [2] = u126
            --]]
            u128 = true
            u126:Stop()
        end
        _G.hitbox:start(u123, Vector3.new(5, 5, 7), 0.3, CFrame.new(0, 0, -2), function(p130) --[[ Name: hitfound, Line 519 ]]
            game.ReplicatedStorage.Events.Skill:InvokeServer("Coiller", {
                ["Target"] = p130.Parent
            })
        end, v129)
        task.wait(0.225)
        u123.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Coiller", v125)
        _G.canuse = true
        task.wait(v125)
        v122.Coiller = false
    end
end
function u5.DemonSpectrum(p131, p132) --[[ Line: 538 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v133 = p131.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u134 = u1.Character
    if v133.spectrum == false and (_G.StamCheck("Demon Spectrum") == true and (_G.canuse == true and _G.check:inspect(u134) == true)) then
        local v135 = u2.GetM("Demon Spectrum")
        local v136 = v135.cd
        if v135.statreq and _G.MeetReq(v135.statreq) == false then
            return
        end
        v133.spectrum = true
        _G.canuse = false
        local v137 = u134.Humanoid:LoadAnimation(script.specstart)
        v137:Play()
        v137:AdjustSpeed(2)
        local u138 = Instance.new("BodyVelocity")
        u138.MaxForce = Vector3.new(1000000, 1000000, 1000000)
        u138.Velocity = Vector3.new(0, 5, 0)
        u138.Parent = u134.LowerTorso
        task.wait(0.4)
        v137:Stop()
        local v139 = u134.Humanoid:LoadAnimation(script.specloop)
        v139:Play()
        v139:AdjustSpeed(2)
        local u140 = game.ReplicatedStorage.Events.Skill:InvokeServer("Demon Spectrum")
        local u141 = tick()
        p131:ChargeSkill(p132, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 568 ]]
                --[[
                Upvalues:
                    [1] = u138
                    [2] = u134
                    [3] = u141
                    [4] = u140
                --]]
                u138.Velocity = u134.HumanoidRootPart.CFrame.LookVector * 10
                if tick() - u141 >= 3 or u140 == nil then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        u138:Destroy()
        v139:Stop()
        if u140 then
            u140:FireServer()
        end
        _G.keysetup:cooldown("Demon Spectrum", v136)
        _G.canuse = true
        task.wait(v136)
        v133.spectrum = false
    end
end
function u5.DemonAxeDrop(p142, p143) --[[ Line: 595 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v144 = p142.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u145 = u1.Character
    if v144.axe == false and (_G.StamCheck("Demon Axe Drop") == true and (_G.canuse == true and _G.check:inspect(u145) == true)) then
        local v146 = u2.GetM("Demon Axe Drop")
        local v147 = v146.cd
        if v146.statreq and _G.MeetReq(v146.statreq) == false then
            return
        end
        v144.axe = true
        _G.canuse = false
        local v148 = u145.Humanoid:LoadAnimation(script.VenShot)
        v148:Play()
        v148:AdjustSpeed(1.5)
        task.wait(0.26666666666666666)
        local _ = u145.HumanoidRootPart.Position.Y
        local u149 = Instance.new("BodyVelocity")
        u149.MaxForce = Vector3.new(1000000, 1000000, 1000000)
        u149.Velocity = u145.HumanoidRootPart.CFrame.LookVector * 15 + Vector3.new(0, 25, 0)
        u149.Parent = u145.LowerTorso
        local u150 = nil
        local u151 = nil
        pcall(function() --[[ Line: 619 ]]
            --[[
            Upvalues:
                [1] = u150
                [2] = u151
            --]]
            local v152 = game.ReplicatedStorage.Events.Skill
            local v153, v154 = unpack(v152:InvokeServer("Demon Axe Drop"))
            u150 = v153
            u151 = v154
        end)
        task.wait(0.36666666666666664)
        v148:Stop()
        local v155 = u145.Humanoid:LoadAnimation(script.VenLoop)
        v155:Play()
        v155:AdjustSpeed(2)
        local u156 = tick()
        local function v157() --[[ Line: 630 ]]
            --[[
            Upvalues:
                [1] = u149
                [2] = u145
                [3] = u156
                [4] = u150
            --]]
            u149.Velocity = u145.HumanoidRootPart.CFrame.LookVector * 6
            if tick() - u156 >= 3 or u150 == nil then
                return true
            end
        end
        p142:ChargeSkill(p143, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = v157,
            ["IgnoreInstantCastSetting"] = true
        })
        v155:Stop()
        if u150 then
            u150:FireServer()
        end
        if u150 then
            local u158 = u145.Humanoid:LoadAnimation(script.endaxe)
            u158:Play()
            u158:AdjustSpeed(1.5)
            u158:AdjustWeight(2)
            u149.Velocity = u145.HumanoidRootPart.CFrame.LookVector * 25 + Vector3.new(0, 20, 0)
            task.wait(0.19999999999999998)
            u149.Velocity = Vector3.new(0, 0, 0)
            u149.MaxForce = Vector3.new(0, 0, 0)
            task.spawn(function() --[[ Line: 658 ]]
                --[[
                Upvalues:
                    [1] = u158
                --]]
                task.wait(0.25000000000000006)
                u158:AdjustSpeed(0)
            end)
            local v159 = tick()
            local v160 = u151
            local v161 = false
            while true do
                if u145.Humanoid.FloorMaterial ~= Enum.Material.Air then
                    v160:FireServer(true, u145.HumanoidRootPart.CFrame)
                    u145.HumanoidRootPart.Anchored = true
                    break
                end
                game["Run Service"].RenderStepped:Wait()
                if v161 == true or tick() - v159 >= 3 then
                    break
                end
            end
            u149:Destroy()
            task.wait(0.5)
            u158:Stop()
        else
            u149:Destroy()
        end
        u145.HumanoidRootPart.Anchored = false
        _G.keysetup:cooldown("Demon Axe Drop", v147)
        _G.canuse = true
        task.wait(v147)
        v144.axe = false
    end
end
function u5.DemonFlash(p162, _) --[[ Line: 690 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v163 = p162.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v164 = u1.Character
    if v163.flash == false and (_G.StamCheck("Demon Flash") == true and (_G.canuse == true and _G.check:inspect(v164) == true)) then
        local v165 = u2.GetM("Demon Flash")
        local v166 = v165.cd
        if v165.statreq and _G.MeetReq(v165.statreq) == false then
            return
        end
        v163.flash = true
        _G.canuse = false
        local u167 = v164.Humanoid:LoadAnimation(script.flash)
        u167:Play()
        v164.Humanoid.WalkSpeed = 4
        _G.PauseAnim(u167, 0.4, 1.5)
        _G.hitbox:start(v164, Vector3.new(12, 12, 12), 0.35, CFrame.new(0, 0, -1.5), function(p168) --[[ Name: hitfound, Line 708 ]]
            --[[
            Upvalues:
                [1] = u167
            --]]
            u167:AdjustSpeed(2)
            task.wait(0.14999999999999997)
            game.ReplicatedStorage.Events.Skill:InvokeServer("Demon Flash", {
                ["Target"] = p168.Parent
            })
        end, function() --[[ Name: hitinter, Line 713 ]]
            --[[
            Upvalues:
                [1] = u167
            --]]
            u167:Stop()
        end)
        task.wait(0.35)
        u167:Stop()
        v164.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Demon Flash", v166)
        _G.canuse = true
        task.wait(v166)
        v163.flash = false
    end
end
function u5.DemonBlitz(p169, p170) --[[ Line: 728 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v171 = p169.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v172 = u1.Character
    if v171.bliz == false and (_G.StamCheck("Demon Blitz") == true and (_G.canuse == true and _G.check:inspect(v172) == true)) then
        local v173 = u2.GetM("Demon Blitz")
        local v174 = v173.cd
        if v173.statreq and _G.MeetReq(v173.statreq) == false then
            return
        end
        v171.bliz = true
        _G.canuse = false
        local u175 = game.ReplicatedStorage.Events.Skill:InvokeServer("Demon Blitz")
        local v176 = v172.Humanoid:LoadAnimation(script.blizStart)
        v176:Play()
        _G.FaceMouse = true
        task.wait(0.5)
        v176:Stop()
        local v177 = v172.Humanoid:LoadAnimation(script.BlizLoop)
        v177:Play()
        local u178 = tick()
        p169:ChargeSkill(p170, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 753 ]]
                --[[
                Upvalues:
                    [1] = u178
                    [2] = u175
                --]]
                if tick() - u178 >= 3 or u175 == nil then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        if u175 then
            u175:FireServer()
        end
        v177:Stop()
        _G.FaceMouse = false
        _G.keysetup:cooldown("Demon Blitz", v174)
        _G.canuse = true
        task.wait(v174)
        v171.bliz = false
    end
end
function u5.DemonicSkyDriller(p179, p180) --[[ Line: 779 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u4
    --]]
    local v181 = p179.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v182 = u1.Character
    if v181.asend == false and (_G.StamCheck("Demonic Sky Driller") == true and (_G.canuse == true and _G.check:inspect(v182) == true)) then
        local v183 = u2.GetM("Demonic Sky Driller")
        local v184 = v183.cd
        if v183.statreq and _G.MeetReq(v183.statreq) == false then
            return
        end
        v181.asend = true
        _G.canuse = false
        local v185 = v182.Humanoid:LoadAnimation(script.asendStart)
        v185:Play()
        v185:AdjustWeight(2)
        _G.FaceMouse = true
        _G.PauseAnim(v185, 0.3, 1)
        local u186 = tick()
        p179:ChargeSkill(p180, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 800 ]]
                --[[
                Upvalues:
                    [1] = u186
                --]]
                if tick() - u186 >= 10 then
                    return true
                end
            end
        })
        _G.FaceMouse = false
        v185:AdjustSpeed(1)
        task.wait(0.1)
        local v187 = v182.HumanoidRootPart.CFrame
        local v188 = CFrame.new(v182.HumanoidRootPart.Position, p179:GetMouseCFrame().Position)
        p179:GetMouseCFrame()
        local v189 = Ray.new(v188.Position, v188.LookVector * 125)
        local _, v190 = _G.raycastIgnoreList(v189, { workspace.Effects, workspace.Projectiles, v182 })
        local v191 = (v190 - v188.Position).Magnitude
        local v192 = CFrame.new(v190, v182.HumanoidRootPart.CFrame.Position) * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, v182.Humanoid.HipHeight * 2, 3)
        local v193 = v182.HumanoidRootPart.CFrame * CFrame.new(0, 0, -v191 / 2)
        local v194 = v191 + 10
        local v195 = Vector3.new(25, 25, v194)
        local v196 = u4.new(v193, v195):FindPartsInRegion3WithWhiteList({ workspace.NPCs, workspace.PlayerCharacters }, 5000)
        local v197 = _G.getTargetByPart(_G.MouseTarget)
        if v197 == nil then
            for v198 = 1, #v196 do
                if v196[v198].Parent ~= v182 and v196[v198].Parent:FindFirstChild("Humanoid") then
                    if not (v196[v198].Parent:FindFirstChild("Info") and v196[v198].Parent.Info:FindFirstChild("Hostile")) then
                        ::l16::
                        v197 = v196[v198].Parent
                        break
                    end
                    if v196[v198].Parent.Info.Hostile.Value ~= false then
                        if not v196[v198].Parent.Info:FindFirstChild("SeaNPC") then
                            goto l16
                        end
                    end
                end
            end
        end
        if v197 then
            v192 = CFrame.new(v197.HumanoidRootPart.CFrame.Position, v182.HumanoidRootPart.CFrame.Position) * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 2)
        end
        v182.HumanoidRootPart.Anchored = true
        v182.HumanoidRootPart.CFrame = v192
        v185:Stop()
        game.ReplicatedStorage.Events.Skill:InvokeServer("Demonic Sky Driller", {
            ["target"] = v197,
            ["cf"] = v192,
            ["pre"] = v187
        })
        task.wait(0.25)
        v182.HumanoidRootPart.Anchored = false
        _G.keysetup:cooldown("Demonic Sky Driller", v184)
        _G.canuse = true
        task.wait(v184)
        v181.asend = false
    end
end
local u199 = {
    { "B-Shot", "e" },
    { "Coiller", "r" },
    { "Concasser", "z" },
    { "Party Table Kick Course", "x" },
    { "Anti-Manner Kick Course", "c" },
    { "Demon Step Transformation", "n" }
}
local u200 = {
    { "Demon Step Transformation", "n" },
    { "Demon Spectrum", "e" },
    { "Demon Flash", "r" },
    { "Demon Blitz", "z" },
    { "Demon Axe Drop", "x" },
    { "Demonic Sky Driller", "c" }
}
function u5.DemonStepTransformation(u201, _) --[[ Line: 863 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u200
        [4] = u199
    --]]
    local v202 = u201.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u203 = u1.Character
    if v202.transform == false and (_G.StamCheck("Demon Step Transformation") == true and (_G.canuse == true and _G.check:inspect(u203) == true)) then
        local v204 = u2.GetM("Demon Step Transformation")
        local v205 = v204.cd
        if v204.statreq and _G.MeetReq(v204.statreq) == false then
            return
        end
        if u203:FindFirstChild("Diable") == nil then
            if u203:GetAttribute("blacklegDamage") == nil then
                _G.displayMessage("<Color=Red>You dont have enough mode bar!")
                return
            end
            if u203:GetAttribute("blacklegDamage") < require(game.ReplicatedStorage.Modules.Skills.Modes.BlackLeg)(u1) / 4 then
                _G.displayMessage("<Color=Red>You dont have enough mode bar!")
                return
            end
        end
        v202["Demon Step Transformation"] = true
        _G.canuse = false
        _G.keysetup:Destroy()
        game.ReplicatedStorage.Events.Skill:InvokeServer("Demon Step Transformation", {
            ["cf"] = u203.HumanoidRootPart.CFrame,
            ["cf2"] = u203.RightFoot.CFrame
        })
        if u203:FindFirstChild("Diable") == nil then
            u201.Tool.TextureId = "rbxassetid://4985358600"
            _G.keysetup:setup("BlackLeg", u199)
        else
            u201.Tool.TextureId = "rbxassetid://6585762986"
            _G.keysetup:setup("BlackLegD", u200)
            task.spawn(function() --[[ Line: 894 ]]
                --[[
                Upvalues:
                    [1] = u203
                    [2] = u201
                    [3] = u199
                --]]
                repeat
                    game["Run Service"].Heartbeat:Wait()
                until u203:FindFirstChild("Diable") == nil
                _G.keysetup:Destroy()
                u201.Tool.TextureId = "rbxassetid://4985358600"
                _G.keysetup:setup("BlackLeg", u199)
            end)
        end
        _G.canuse = true
        _G.keysetup:cooldown("Demon Step Transformation", v205)
        task.wait(v205)
        v202["Demon Step Transformation"] = false
    end
end
return u5