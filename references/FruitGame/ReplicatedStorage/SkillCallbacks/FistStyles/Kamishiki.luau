 

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
    --]]
    local v5 = u3.new(script.Name)
    local v6 = u4
    local v7 = setmetatable(v5, v6)
    v7.Cooldowns = {
        ["shiganBarrage"] = false,
        ["counter"] = false,
        ["Tekkai"] = false,
        ["Rank"] = false,
        ["InstantSoru"] = false,
        ["Rokuogan"] = false
    }
    return v7
end
require(game.ReplicatedStorage.Modules.RotatedRegion3)
function u4.ShiganBarrage(u8, p9) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v10 = u8.Cooldowns
    local u11 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u12 = u1.Character
    if v10.shiganBarrage == false and _G.check:inspect(u12) == true then
        local v13 = u2.GetM("Shigan Barrage")
        local v14 = v13.cd
        if _G.StamCheck("Shigan Barrage") == false then
            return
        end
        if v13.statreq and _G.MeetReq(v13.statreq) == false then
            return
        end
        v10.shiganBarrage = true
        _G.canuse = false
        u12.Humanoid.WalkSpeed = 4
        local v15 = u12.Humanoid.Animator:LoadAnimation(script.fingerBarrage)
        v15:Play()
        v15:AdjustWeight(2)
        v15:AdjustSpeed(1.5)
        v15.Priority = Enum.AnimationPriority.Action4
        local u16 = game.ReplicatedStorage.Events.Skill:InvokeServer("Shigan Barrage", {
            ["cf"] = u12.HumanoidRootPart.CFrame
        })
        local u17 = tick()
        u8:ChargeSkill(p9, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 62 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u8
                    [3] = u16
                    [4] = u17
                    [5] = u11
                --]]
                u12.Humanoid.WalkSpeed = 4
                _G.canuse = false
                if u8.Tool.Parent ~= u12 or (u12:FindFirstChild("Stun") or (u16 == nil or (tick() - u17 >= 2 or (_G.check:inspect(u12) == false or u11.Stamina.Value <= 0)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v15:Stop()
        if u16 then
            u16:FireServer()
        end
        task.wait(0.3)
        u12.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Shigan Barrage", v14)
        _G.fw(v14)
        v10.shiganBarrage = false
    end
end
function u4.CounterKick(p18, _) --[[ Line: 91 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v19 = p18.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v20 = u1.Character
    if v19.counter == false and _G.check:inspect(v20) == true then
        local v21 = u2.GetM("Counter Kick")
        local v22 = v21.cd
        if _G.StamCheck("Counter Kick") == false then
            return
        end
        if v21.statreq and _G.MeetReq(v21.statreq) == false then
            return
        end
        v19.counter = true
        _G.canuse = false
        v20.Humanoid.WalkSpeed = 4
        game.ReplicatedStorage.Events.Skill:InvokeServer("Counter Kick", v20.HumanoidRootPart.CFrame)
        v20.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Counter Kick", v22)
        _G.fw(v22)
        v19.counter = false
    end
end
function u4.AbsoluteTekkai(u23, u24) --[[ Line: 121 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v25 = u23.Cooldowns
    local u26 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u27 = u1.Character
    if v25.Tekkai == false and (_G.check:inspect(u27) == true and _G.StamCheck("Absolute Tekkai") == true) then
        local v28 = u2.GetM("Absolute Tekkai")
        local v29 = v28.cd
        if v28.stamreq and u26.Stamina.Value < v28.stamreq then
            return
        end
        if v28.statreq and _G.MeetReq(v28.statreq) == false then
            return
        end
        v25.Tekkai = true
        _G.canuse = false
        game.ReplicatedStorage.Events.StamRequest:InvokeServer("Absolute Tekkai")
        local v30 = u27.Humanoid:LoadAnimation(script.tekkai)
        v30:Play()
        v30.Priority = Enum.AnimationPriority.Action2
        local v31 = Instance.new("BodyVelocity", u27.HumanoidRootPart)
        v31.MaxForce = Vector3.new(100000000000, 0, 100000000000)
        v31.Velocity = Vector3.new(0, 0, 0)
        _G.PauseAnim(v30, 0.85, 2, function() --[[ Line: 146 ]] end)
        v30:AdjustSpeed(0)
        v30.TimePosition = 0.85
        local u32 = game.ReplicatedStorage.Events.Skill:InvokeServer("Absolute Tekkai", u27.PrimaryPart.CFrame)
        if u32 then
            local u33 = u27:WaitForChild("Blocking", 3)
            local u34 = game.ReplicatedStorage.Util.Melee.BlockGui:Clone()
            u34.Parent = u27.HumanoidRootPart
            local u35 = false
            local v36 = nil
            local function v38() --[[ Line: 162 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u34
                    [3] = u27
                    [4] = u23
                    [5] = u26
                    [6] = u32
                    [7] = u35
                --]]
                pcall(function() --[[ Line: 163 ]]
                    --[[
                    Upvalues:
                        [1] = u33
                        [2] = u34
                    --]]
                    local v37 = u33.Value / u33.MaxValue
                    u34.ImageLabel.Frame.Position = UDim2.new(0, 0, 1 - v37, 0)
                    u34.ImageLabel.Frame.Size = UDim2.new(1, 0, v37, 0)
                    _G.canuse = false
                    u34.ImageLabel.Frame.ImageLabel.Size = UDim2.new(1, 0, 1 / v37, 0)
                    u34.ImageLabel.Frame.ImageLabel.Position = UDim2.new(0, 0, -(u34.ImageLabel.Frame.Position.Y.Scale / u34.ImageLabel.Frame.Size.Y.Scale), 0)
                end)
                u27.Humanoid.WalkSpeed = 0
                if u23.Tool and u23.Tool.Parent ~= u27 or (u33 and (u33.Value <= 0 or u33.Parent == nil) or (u26.Stamina.Value <= 0 or (u32 == nil or u35 == true))) then
                    return true
                end
            end
            task.delay(0.5, function() --[[ Line: 179 ]]
                --[[
                Upvalues:
                    [1] = u35
                    [2] = u23
                    [3] = u24
                    [4] = u32
                    [5] = u27
                --]]
                if u35 == false then
                    u23:DoubleCastSkill(u24, {
                        ["Key"] = Enum.KeyCode.Q,
                        ["SkipTap"] = true,
                        ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 196 ]]
                            --[[
                            Upvalues:
                                [1] = u35
                                [2] = u32
                                [3] = u27
                            --]]
                            if u35 ~= true then
                                u32:FireServer("dash", u27.PrimaryPart.CFrame)
                                u35 = true
                                u27.Humanoid.WalkSpeed = 16
                            end
                        end,
                        ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 204 ]]
                            --[[
                            Upvalues:
                                [1] = u35
                            --]]
                            if u35 == true then
                                return true
                            end
                        end,
                        ["PassFunction"] = function() --[[ Name: PassFunction, Line 209 ]]
                            --[[
                            Upvalues:
                                [1] = u32
                            --]]
                            return u32
                        end
                    })
                end
            end)
            u23:ChargeSkill(u24, {
                ["Key"] = Enum.KeyCode.R,
                ["EndFunction"] = v38,
                ["IgnoreInstantCastSetting"] = true
            })
            u34:Destroy()
            u35 = true
            if v36 then
                v36:Disconnect()
            end
        end
        if u32 then
            u32:FireServer()
        end
        v31:Destroy()
        u27.Humanoid.WalkSpeed = 16
        v30:Stop()
        _G.canuse = true
        _G.keysetup:cooldown("Absolute Tekkai", v29)
        _G.fw(v29)
        v25.Tekkai = false
    end
end
function u4.InstantSoru(p39, _) --[[ Line: 247 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v40 = p39.Cooldowns
    local v41 = game.ReplicatedStorage["Stats" .. u1.Name]
    local v42 = u1.Character
    if v40.InstantSoru == false and (_G.check:inspect(v42) == true and _G.StamCheck("Instant Soru") == true) then
        local v43 = u2.GetM("Instant Soru")
        local v44 = v43.cd
        if v43.stamreq and v41.Stamina.Value < v43.stamreq then
            return
        end
        if v43.statreq and _G.MeetReq(v43.statreq) == false then
            return
        end
        v40.InstantSoru = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Instant Soru", p39:GetMouseCFrame())
        _G.canuse = true
        _G.keysetup:cooldown("Instant Soru", v44)
        _G.fw(v44)
        v40.InstantSoru = false
    end
end
function u4.TrueRankakyu(u45, p46) --[[ Line: 273 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v47 = u45.Cooldowns
    local v48 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u49 = u1.Character
    if v47.Rank == false and (_G.check:inspect(u49) == true and _G.StamCheck("True Rankakyu") == true) then
        local v50 = u2.GetM("True Rankakyu")
        local v51 = v50.cd
        if v50.stamreq and v48.Stamina.Value < v50.stamreq then
            return
        end
        if v50.statreq and _G.MeetReq(v50.statreq) == false then
            return
        end
        v47.Rank = true
        _G.canuse = false
        local v52 = u49.Humanoid:LoadAnimation(script.rank)
        v52:Play()
        local u53 = game.ReplicatedStorage.Events.Skill:InvokeServer("True Rankakyu")
        _G.FaceMouse = true
        _G.PauseAnim(v52, 0, 1)
        local u54 = tick()
        local u55 = false
        local function v56() --[[ Line: 303 ]]
            --[[
            Upvalues:
                [1] = u54
                [2] = u55
                [3] = u53
            --]]
            _G.canuse = false
            if tick() - u54 >= 0.8695652173913044 and u55 == false then
                u55 = true
                if u53 then
                    u53:FireServer("charged")
                end
            end
        end
        u45:ChargeSkill(p46, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 313 ]]
                --[[
                Upvalues:
                    [1] = u45
                    [2] = u49
                    [3] = u54
                --]]
                if u45.Tool.Parent ~= u49 or (tick() - u54 >= 5 or _G.check:inspect(u49) == false) then
                    return true
                end
            end,
            ["CheckFunction"] = v56,
            ["IgnoreInstantCastSetting"] = true
        })
        v52:AdjustSpeed(1.5)
        task.wait(0.1)
        if u53 then
            local v57 = tick()
            while u53:IsDescendantOf(game) ~= false do
                u53:FireServer(u45:GetMouseCFrame().Position)
                task.wait()
                if tick() - v57 >= 1.5 then
                    break
                end
            end
        end
        _G.FaceMouse = false
        u49.HumanoidRootPart.Anchored = true
        task.wait(0.5)
        u49.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("True Rankakyu", v51)
        _G.fw(v51)
        v47.Rank = false
    end
end
function u4.TrueRokuogan(u58, p59) --[[ Line: 349 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v60 = u58.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u61 = u1.Character
    if v60.Rokuogan == false and _G.check:inspect(u61) == true then
        local v62 = u2.GetM("True Rokuogan")
        local v63 = v62.cd
        if _G.StamCheck("True Rokuogan") == false then
            return
        end
        if v62.statreq and _G.MeetReq(v62.statreq) == false then
            return
        end
        v60.Rokuogan = true
        _G.canuse = false
        _G.FaceMouse = true
        local u64 = tick()
        local u65 = game.ReplicatedStorage.Events.Skill:InvokeServer("True Rokuogan", {
            ["cf"] = u61.HumanoidRootPart.CFrame
        })
        local v66 = u61.Humanoid:LoadAnimation(script.rokuogan)
        v66:Play()
        v66:AdjustWeight(5)
        _G.PauseAnim(v66, 0.38, 1)
        u58:ChargeSkill(p59, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 385 ]]
                --[[
                Upvalues:
                    [1] = u58
                    [2] = u61
                    [3] = u65
                    [4] = u64
                --]]
                if u58.Tool.Parent ~= u61 or (u65 == nil or tick() - u64 >= 2) then
                    return true
                end
            end
        })
        v66:AdjustSpeed(1)
        task.wait(0.1)
        _G.FaceMouse = false
        if u65 then
            u65:InvokeServer(u58:GetMouseCFrame())
        end
        _G.canuse = true
        _G.keysetup:cooldown("True Rokuogan", v63)
        _G.fw(v63)
        v60.Rokuogan = false
    end
end
return u4