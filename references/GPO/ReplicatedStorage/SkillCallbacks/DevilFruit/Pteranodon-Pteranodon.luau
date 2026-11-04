 

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
        [3] = u3
        [4] = u1
    --]]
    local v6 = u4.new(script.Name)
    local v7 = u5
    local u8 = setmetatable(v6, v7)
    u8.Cooldowns = {
        ["Pteranodon Transform"] = false,
        ["Sonic Screech"] = false,
        ["Vermillion Bow"] = false,
        ["Winged Flight"] = false,
        ["Dive Bomb"] = false,
        ["Pteranodon Carry"] = false
    }
    function u8.hasRequirements(p9) --[[ Line: 33 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u3
            [3] = u1
        --]]
        if u8.Cooldowns[p9] then
            warn("on cd")
            return
        else
            local v10 = u3.GetM(p9)
            local v11 = v10.cd
            if _G.StamCheck(p9) then
                if v10.statreq and not _G.MeetReq(v10.statreq) then
                    warn("stat req")
                elseif _G.canuse ~= false and _G.check:inspect(u1.Character) ~= false then
                    return p9, v11
                end
            else
                warn("stam")
                return
            end
        end
    end
    return u8
end
function u5.SonicScreech(u12, p13) --[[ Line: 52 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v14 = u12.Cooldowns
    local u15 = u1.Character
    local u16 = u2["Stats" .. u1.Name]
    local v17, v18 = u12.hasRequirements("Sonic Screech")
    if not v17 then
        return
    end
    _G.canuse = false
    local u19 = game.ReplicatedStorage.Events.Skill:InvokeServer(v17, {
        ["cf"] = u12:GetMouseCFrame()
    })
    v14[v17] = true
    local v20 = u15:GetAttribute("FormType") == "Hybrid"
    local v21 = (v20 and u15.Humanoid or u15:FindFirstChild("FormAnimator", true)):LoadAnimation(script[u15:GetAttribute("FormType")].SonicScreech)
    v21:Play()
    _G.FaceMouse = true
    if v20 == true then
        _G.mouseLevel = true
    end
    if v20 then
        _G.PauseAnim(v21, 0.1, 1)
    else
        _G.PauseAnim(v21, 0.598, 1)
    end
    local u22 = os.clock()
    u12:ChargeSkill(p13, {
        ["Key"] = Enum.KeyCode.E,
        ["EndFunction"] = function() --[[ Line: 82 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u22
                [3] = u12
                [4] = u15
                [5] = u16
            --]]
            return (u19 == nil or (os.clock() - u22 >= 3 or (u12.Tool.Parent ~= u15 or (u15.Parent == nil or u15.Parent ~= workspace.PlayerCharacters)))) and true or u16.Stamina.Value <= 0
        end
    })
    _G.FaceMouse = false
    _G.mouseLevel = nil
    u15.PrimaryPart.Anchored = true
    if v20 then
        v21:AdjustSpeed(1)
        task.wait(0.2)
    else
        v21:AdjustSpeed(1)
        task.wait(0.15)
    end
    if u19 then
        u19:FireServer(u12:GetMouseCFrame())
    end
    if v20 then
        task.wait(2.25)
        ::l21::
        u15.PrimaryPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown(v17, v18)
        _G.fw(v18)
        v14[v17] = false
        return
    else
        local v23 = tick()
        while true do
            if u19 then
                u19:FireServer(u12:GetMouseCFrame())
            end
            task.wait()
            if tick() - v23 >= 0.9 then
                v21:Stop()
                goto l21
            end
        end
    end
end
function u5.VermillionBow(u24, p25) --[[ Line: 131 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v26 = u24.Cooldowns
    local u27 = u1.Character
    local u28 = u2["Stats" .. u1.Name]
    local v29, v30 = u24.hasRequirements("Vermillion Bow")
    if v29 then
        _G.canuse = false
        local u31 = game.ReplicatedStorage.Events.Skill:InvokeServer(v29, {
            ["cf"] = u24:GetMouseCFrame()
        })
        v26[v29] = true
        local v32 = u27:GetAttribute("FormType") == "Hybrid"
        local v33 = (v32 and u27.Humanoid or u27:FindFirstChild("FormAnimator", true)):LoadAnimation(script[u27:GetAttribute("FormType")].VermillionBow)
        v33:Play()
        _G.FaceMouse = true
        _G.PauseAnim(v33, 0.4, 1)
        local u34 = os.clock()
        u24:ChargeSkill(p25, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function() --[[ Line: 151 ]]
                --[[
                Upvalues:
                    [1] = u31
                    [2] = u34
                    [3] = u24
                    [4] = u27
                    [5] = u28
                --]]
                return (u31 == nil or (os.clock() - u34 >= 3 or (u24.Tool.Parent ~= u27 or (u27.Parent == nil or u27.Parent ~= workspace.PlayerCharacters)))) and true or u28.Stamina.Value <= 0
            end
        })
        v33:AdjustSpeed(1)
        if v32 == false then
            v33:AdjustSpeed(1.5)
        end
        task.wait(0.2)
        _G.FaceMouse = false
        if v32 == true then
            v33:Stop()
        end
        if u31 then
            u31:InvokeServer(u27.PrimaryPart.CFrame, u24:GetMouseCFrame())
        end
        task.wait(0.25)
        _G.canuse = true
        _G.keysetup:cooldown(v29, v30)
        _G.fw(v30)
        v26[v29] = false
    end
end
function u5.RelentlessStrikes(u35, p36) --[[ Line: 184 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v37 = u35.Cooldowns
    local u38 = u1.Character
    local u39 = u2["Stats" .. u1.Name]
    local v40, v41 = u35.hasRequirements("Relentless Strikes")
    if v40 then
        _G.canuse = false
        local u42 = game.ReplicatedStorage.Events.Skill:InvokeServer(v40, {
            ["cf"] = u35:GetMouseCFrame()
        })
        v37[v40] = true
        local v43 = u38.Humanoid:LoadAnimation(script.Hybrid.RelentlessStrikes)
        v43:Play()
        _G.FaceMouse = true
        _G.mouseLevel = true
        _G.PauseAnim(v43, 0.1, 1)
        local u44 = os.clock()
        u35:ChargeSkill(p36, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = function() --[[ Line: 205 ]]
                --[[
                Upvalues:
                    [1] = u42
                    [2] = u44
                    [3] = u35
                    [4] = u38
                    [5] = u39
                --]]
                return (u42 == nil or (os.clock() - u44 >= 10 or (u35.Tool.Parent ~= u38 or (u38.Parent == nil or u38.Parent ~= workspace.PlayerCharacters)))) and true or u39.Stamina.Value <= 0
            end
        })
        v43:AdjustSpeed(1)
        _G.FaceMouse = false
        _G.mouseLevel = nil
        task.wait(0.2)
        if u42 then
            u42:FireServer(u38.HumanoidRootPart.CFrame)
        end
        task.wait(2.25)
        _G.canuse = true
        _G.keysetup:cooldown(v40, v41)
        _G.fw(v41)
        v37[v40] = false
    end
end
function u5.WingedFlight(u45, p46) --[[ Line: 233 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v47 = u45.Cooldowns
    local u48 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    local v49, v50 = u45.hasRequirements("Winged Flight")
    if v49 then
        if _G.grounded ~= true then
            _G.canuse = false
            v47[v49] = true
            local u51 = game.ReplicatedStorage.Events.Skill:InvokeServer(v49)
            _G.canuse = true
            if u51 then
                u45:DoubleCastSkill(p46, {
                    ["Key"] = Enum.KeyCode.T,
                    ["SkipTap"] = true,
                    ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 253 ]]
                        --[[
                        Upvalues:
                            [1] = u51
                        --]]
                        if u51 then
                            u51:FireServer("end")
                        end
                    end,
                    ["CancelFunction"] = function() --[[ Name: CancelFunction, Line 258 ]]
                        --[[
                        Upvalues:
                            [1] = u48
                        --]]
                        local v52 = u48:GetAttribute("FormType") == "Hybrid"
                        if u48:FindFirstChild("inCombat") and (v52 == true and u48:FindFirstChild("PB")) then
                            return true
                        end
                    end,
                    ["PassFunction"] = function() --[[ Name: PassFunction, Line 267 ]]
                        --[[
                        Upvalues:
                            [1] = u45
                            [2] = u48
                        --]]
                        if u45.Tool.Parent == u48 then
                            return true
                        end
                    end
                })
                repeat
                    task.wait()
                until u48:GetAttribute("PetraFlying") == nil
            end
            _G.keysetup:cooldown(v49, v50)
            _G.fw(v50)
            v47[v49] = false
        end
    else
        return
    end
end
function u5.SkyborneSlam(u53, p54) --[[ Line: 300 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v55 = u53.Cooldowns
    local u56 = u1.Character
    local u57 = u2["Stats" .. u1.Name]
    local v58, v59 = u53.hasRequirements("Skyborne Slam")
    if v58 then
        _G.canuse = false
        v55[v58] = true
        local v60 = u56.Humanoid:LoadAnimation(script.Hybrid.grabWindup)
        v60:Play()
        u56.Humanoid.WalkSpeed = 4
        _G.PauseAnim(v60, 0.22, 1)
        local u61 = tick()
        u53:ChargeSkill(p54, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function() --[[ Line: 319 ]]
                --[[
                Upvalues:
                    [1] = u56
                    [2] = u61
                    [3] = u53
                    [4] = u57
                --]]
                u56.Humanoid.WalkSpeed = 4
                return (tick() - u61 >= 5 or (u53.Tool.Parent ~= u56 or (u56.Parent == nil or u56.Parent ~= workspace.PlayerCharacters))) and true or u57.Stamina.Value <= 0
            end
        })
        v60:AdjustSpeed(2)
        task.wait(0.1)
        game.ReplicatedStorage.Events.Skill:InvokeServer(v58, {
            ["cf"] = u53:GetMouseCFrame()
        })
        u56.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown(v58, v59)
        _G.fw(v59)
        v55[v58] = false
    end
end
function u5.PteranodonTransform(p62, _) --[[ Line: 342 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v63 = p62.Cooldowns
    local v64 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    local v65, v66 = p62.hasRequirements("Pteranodon Transform")
    if v65 then
        if v64:GetAttribute("FormType") == "Hybrid" then
            local v67
            if v64:GetAttribute("pteranodonDamage") then
                local v68 = v64:GetAttribute("pteranodonDamage")
                v67 = math.ceil(v68)
            else
                v67 = 0
            end
            if v67 < require(game.ReplicatedStorage.Modules.Skills.Modes.Pteranodon)(u1) * p62.Tool:GetAttribute("modePercent") then
                _G.displayMessage((("<Color=/>I need <Color=Purple>%*%%<Color=/> mode bar for full form."):format(p62.Tool:GetAttribute("modePercent") * 100)))
            else
                _G.canuse = false
                v63[v65] = true
                v64.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                game.ReplicatedStorage.Events.Skill:InvokeServer("Pteranodon Transform", "Full")
                _G.canuse = true
                v63[v65] = true
                _G.keysetup:cooldown(v65, v66)
                _G.fw(v66)
                v63[v65] = false
            end
        else
            game.ReplicatedStorage.Events.Skill:InvokeServer("Pteranodon Transform")
            return
        end
    else
        return
    end
end
function u5.FlameForm(p69, _) --[[ Line: 380 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v70 = p69.Cooldowns
    local _ = u1.Character
    local _ = u2["Stats" .. u1.Name]
    local v71, v72 = p69.hasRequirements("Flame Form")
    if v71 then
        if not v70[v71] then
            _G.canuse = false
            game.ReplicatedStorage.Events.Skill:InvokeServer(v71, {
                ["cf"] = p69:GetMouseCFrame()
            })
            _G.canuse = true
            v70[v71] = true
            _G.keysetup:cooldown(v71, v72)
            _G.fw(v72)
            v70[v71] = false
        end
    else
        return
    end
end
function u5.BarrelRoll(p73, _) --[[ Line: 399 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v74 = p73.Cooldowns
    local v75 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    local v76, v77 = p73.hasRequirements("Barrel Roll")
    if v76 then
        _G.canuse = false
        local v78 = v75:FindFirstChild("FormAnimator", true):LoadAnimation(script.Full.Roll)
        v78:Play()
        v78.Priority = Enum.AnimationPriority.Action4
        game.ReplicatedStorage.Events.Skill:InvokeServer("Barrel Roll")
        _G.canuse = true
        v74[v76] = true
        _G.keysetup:cooldown(v76, v77)
        _G.fw(v77)
        v74[v76] = false
    end
end
function u5.ImperialDiveBomb(u79, p80) --[[ Line: 422 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v81 = u79.Cooldowns
    local u82 = u1.Character
    local u83 = u2["Stats" .. u1.Name]
    local v84, v85 = u79.hasRequirements("Imperial Dive Bomb")
    if v84 then
        _G.canuse = false
        local u86 = game.ReplicatedStorage.Events.Skill:InvokeServer(v84, {
            ["cf"] = u79:GetMouseCFrame()
        })
        v81[v84] = true
        local v87 = u82:FindFirstChild("FormAnimator", true):LoadAnimation(script.Full.ultHold)
        v87:Play()
        _G.FaceMouse = true
        local u88 = os.clock()
        u79:ChargeSkill(p80, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = function() --[[ Line: 443 ]]
                --[[
                Upvalues:
                    [1] = u86
                    [2] = u88
                    [3] = u79
                    [4] = u82
                    [5] = u83
                --]]
                return (u86 == nil or (os.clock() - u88 >= 4 or (u79.Tool.Parent ~= u82 or (u82.Parent == nil or u82.Parent ~= workspace.PlayerCharacters)))) and true or u83.Stamina.Value <= 0
            end
        })
        v87:Stop()
        if u86 then
            u86:InvokeServer(u79:GetMouseCFrame())
        end
        _G.FaceMouse = false
        task.wait(0.5)
        _G.canuse = true
        _G.keysetup:cooldown(v84, v85)
        _G.fw(v85)
        v81[v84] = false
    end
end
function u5.ImperialStorm(u89, p90) --[[ Line: 472 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v91 = u89.Cooldowns
    local u92 = u1.Character
    local u93 = u2["Stats" .. u1.Name]
    local v94, v95 = u89.hasRequirements("Imperial Storm")
    if v94 then
        _G.canuse = false
        _G.FaceMouse = true
        local u96 = game.ReplicatedStorage.Events.Skill:InvokeServer(v94, {
            ["cf"] = u89:GetMouseCFrame()
        })
        v91[v94] = true
        local u97 = tick()
        u89:ChargeSkill(p90, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function() --[[ Line: 490 ]]
                --[[
                Upvalues:
                    [1] = u96
                    [2] = u97
                    [3] = u89
                    [4] = u92
                    [5] = u93
                --]]
                return u96 == nil and true or (tick() - u97 >= 10 and true or (u89.Tool.Parent ~= u92 and true or (u92.Parent == nil and true or (u92.Parent ~= workspace.PlayerCharacters and true or (u93.Stamina.Value <= 0 and true or not u92:GetAttribute("Shooting"))))))
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        task.wait(0.2)
        if u96 then
            u96:FireServer()
        end
        _G.FaceMouse = false
        _G.canuse = true
        _G.keysetup:cooldown(v94, v95)
        _G.fw(v95)
        v91[v94] = false
    end
end
function u5.PteranodonCarry(p98, p99) --[[ Line: 515 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v100 = p98.Cooldowns
    local _ = u1.Character
    local _ = u2["Stats" .. u1.Name]
    local v101, v102 = p98.hasRequirements("Pteranodon Carry")
    if v101 then
        local u103 = game.ReplicatedStorage.Events.Skill:InvokeServer(v101)
        if u103 then
            p98:DoubleCastSkill(p99, {
                ["Key"] = Enum.KeyCode.T,
                ["SkipTap"] = true,
                ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 530 ]]
                    --[[
                    Upvalues:
                        [1] = u103
                    --]]
                    if u103 then
                        u103:FireServer()
                    end
                end,
                ["PassFunction"] = function() --[[ Name: PassFunction, Line 535 ]]
                    return true
                end
            })
            repeat
                task.wait()
            until u103:IsDescendantOf(game) == false
        end
        _G.keysetup:cooldown(v101, v102)
        _G.fw(v102)
        v100[v101] = false
    end
end
return u5