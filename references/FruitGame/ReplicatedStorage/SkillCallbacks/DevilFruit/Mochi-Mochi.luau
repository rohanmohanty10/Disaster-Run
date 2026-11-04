 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
local v5 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
game:GetService("UserInputService")
v5:GetControls()
u1:GetMouse()
local u6 = setmetatable({}, u4)
u6.__index = u6
local u7 = require(game:GetService("ReplicatedStorage").Modules.sBeat)
local u8 = 1
local u9 = nil
function FindBoneReference(p10)
    --[[
    Upvalues:
        [1] = u9
    --]]
    local function u13(p11, p12) --[[ Line: 29 ]]
        --[[
        Upvalues:
            [1] = u9
            [2] = u13
        --]]
        if p12 <= 0 then
            u9 = p11
            return p11
        end
        u13(p11:GetChildren()[1], p12 - 1)
    end
    return u13(p10.RootPart.MochiArmJoints, 9)
end
function set_buzzcut_length(p14, p15, p16)
    if p16 <= 3 then
        set_buzzcut_length(p14:FindFirstChildOfClass("Bone"), p15, p16 + 1)
        if p16 > 0 then
            p14.CFrame = CFrame.new(p14:GetAttribute("OrigPos")) * CFrame.new(0, p15, 0)
        end
    end
end
function u6.new(_) --[[ Line: 48 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u6
    --]]
    local v17 = u4.new(script.Name)
    local v18 = u6
    local v19 = setmetatable(v17, v18)
    v19.Cooldowns = {
        ["barrage"] = false,
        ["drops"] = false,
        ["burn"] = false,
        ["buzz"] = false,
        ["roll"] = false,
        ["chest"] = false,
        ["punch"] = false
    }
    return v19
end
function u6.MochiBarrage(p20, p21) --[[ Line: 56 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v22 = p20.Cooldowns
    local u23 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v22.barrage == false and (_G.check:inspect(u23) == true and _G.StamCheck("Mochi Barrage") == true) then
        local v24 = u3.GetM("Mochi Barrage")
        local v25 = v24.cd
        if _G.StamCheck("Mochi Barrage") == false then
            return
        end
        if v24.statreq and _G.MeetReq(v24.statreq) == false then
            return
        end
        v22.barrage = true
        local v26 = u23.Humanoid:LoadAnimation(script.barrage)
        v26:Play()
        v26:AdjustWeight(2)
        v26:AdjustSpeed(2)
        _G.canuse = false
        u23.Humanoid.WalkSpeed = 4
        task.wait(0.375)
        v26:AdjustSpeed(0.25)
        local u27 = game.ReplicatedStorage.Events.Skill:InvokeServer("Mochi Barrage", p20:GetMouseCFrame().Position)
        local u28 = tick()
        p20:ChargeSkill(p21, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 83 ]]
                --[[
                Upvalues:
                    [1] = u23
                --]]
                u23.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 88 ]]
                --[[
                Upvalues:
                    [1] = u28
                    [2] = u27
                --]]
                if tick() - u28 >= 2 or u27 == nil then
                    return true
                end
            end
        })
        u23.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Mochi Barrage", v25)
        _G.fw(v25)
        v22.barrage = false
    end
end
function u6.MochiDrops(u29, p30) --[[ Line: 110 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v31 = u29.Cooldowns
    local u32 = u1.Character
    local u33 = u2["Stats" .. u1.Name]
    if v31.drops == false and (_G.check:inspect(u32) == true and _G.StamCheck("Mochi Drops") == true) then
        local v34 = u3.GetM("Mochi Drops")
        local v35 = v34.cd
        if _G.StamCheck("Mochi Drops") == false then
            return
        end
        if v34.statreq and _G.MeetReq(v34.statreq) == false then
            return
        end
        v31.drops = true
        local v36 = u32.Humanoid:LoadAnimation(script.drop)
        v36:Play()
        v36:AdjustWeight(2)
        u32.Humanoid.WalkSpeed = 4
        _G.canuse = false
        _G.PauseAnim(v36, 0.4, 1.2000000000000002)
        local u37 = tick()
        u29:ChargeSkill(p30, {
            ["Key"] = Enum.KeyCode.Y,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 136 ]]
                --[[
                Upvalues:
                    [1] = u32
                --]]
                u32.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 141 ]]
                --[[
                Upvalues:
                    [1] = u37
                    [2] = u29
                    [3] = u32
                    [4] = u33
                --]]
                if tick() - u37 >= 10 or (u29.Tool.Parent ~= u32 or (u32.Parent == nil or (u32.Parent ~= workspace.PlayerCharacters or u33.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v36:AdjustSpeed(1)
        local v38 = u29:GetMouseCFrame().Position
        game.ReplicatedStorage.Events.Skill:InvokeServer("Mochi Drops", v38)
        tick()
        _G.canuse = false
        v36:AdjustSpeed(0.7)
        task.wait(0.6)
        _G.canuse = true
        u32.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Mochi Drops", v35)
        _G.fw(v35)
        v31.drops = false
    end
end
function u6.MochiDonutRoll(u39, p40) --[[ Line: 169 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v41 = u39.Cooldowns
    local u42 = u1.Character
    local u43 = u2["Stats" .. u1.Name]
    if v41.roll == false and (_G.grounded == false and (_G.check:inspect(u42) == true and _G.StamCheck("Mochi Donut Roll") == true)) then
        local v44 = u3.GetM("Mochi Donut Roll")
        local v45 = v44.cd
        if _G.StamCheck("Mochi Donut Roll") == false then
            return
        end
        if v44.statreq and _G.MeetReq(v44.statreq) == false then
            return
        end
        v41.roll = true
        local v46 = workspace.CurrentCamera
        local v47 = u42.Humanoid:LoadAnimation(script.wheelStart)
        v47:Play(0)
        v47:AdjustSpeed(1.35)
        v47:AdjustWeight(2)
        _G.canuse = false
        task.wait(0.4)
        v46.CameraType = Enum.CameraType.Attach
        local v48 = game.ReplicatedStorage.Events.Skill:InvokeServer("Mochi Donut Roll")
        local u49 = tick()
        u39:ChargeSkill(p40, {
            ["Key"] = Enum.KeyCode.T,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 199 ]]
                --[[
                Upvalues:
                    [1] = u42
                --]]
                u42.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 204 ]]
                --[[
                Upvalues:
                    [1] = u49
                    [2] = u39
                    [3] = u42
                    [4] = u43
                --]]
                if tick() - u49 >= 20 or (u39.Tool.Parent ~= u42 or (u42.Parent == nil or (u42.Parent ~= workspace.PlayerCharacters or (u43.Stamina.Value <= 0 or _G.check:inspect(u42) == false)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        u42:SetAttribute("inWheel", false)
        if v48 then
            v48:FireServer()
        end
        v46.CameraType = Enum.CameraType.Custom
        local v50 = u42.Humanoid:LoadAnimation(script.wheelEnd)
        v50:Play(0)
        v50:AdjustWeight(2)
        tick()
        _G.canuse = true
        u42.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Mochi Donut Roll", v45)
        _G.fw(v45)
        v41.roll = false
    end
end
function u6.BurningMochiPunch(u51, p52) --[[ Line: 234 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v53 = u51.Cooldowns
    local u54 = u1.Character
    local u55 = u2["Stats" .. u1.Name]
    if v53.burn == false and (_G.check:inspect(u54) == true and _G.StamCheck("Burning Mochi Punch") == true) then
        local v56 = u3.GetM("Burning Mochi Punch")
        local v57 = v56.cd
        if _G.StamCheck("Burning Mochi Punch") == false then
            return
        end
        if v56.statreq and _G.MeetReq(v56.statreq) == false then
            return
        end
        v53.burn = true
        local v58 = u54.Humanoid:LoadAnimation(script.burnStart)
        v58:Play()
        v58:AdjustWeight(2)
        u54.Humanoid.WalkSpeed = 4
        _G.FaceMouse = true
        _G.canuse = false
        local v59 = game.ReplicatedStorage.Events.Skill:InvokeServer("Burning Mochi Punch")
        _G.PauseAnim(v58, 0.4166666666666667, 0.8)
        local u60 = tick()
        u51:ChargeSkill(p52, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 263 ]]
                --[[
                Upvalues:
                    [1] = u51
                    [2] = u54
                    [3] = u55
                    [4] = u60
                --]]
                if u51.Tool.Parent ~= u54 or (u54.Parent == nil or (u54.Parent ~= workspace.PlayerCharacters or (u55.Stamina.Value <= 0 or tick() - u60 >= 7))) then
                    return true
                end
            end
        })
        v58:AdjustSpeed(1)
        _G.FaceMouse = false
        u54.HumanoidRootPart.Anchored = true
        if v59 then
            v59:FireServer(u54.HumanoidRootPart.CFrame)
            task.spawn(function() --[[ Line: 280 ]]
                --[[
                Upvalues:
                    [1] = u54
                --]]
                task.wait(0.53)
                local v61 = u54.HumanoidRootPart.CFrame
                local _, v62 = _G.raycast:cast(u54.HumanoidRootPart.CFrame.Position, u54.HumanoidRootPart.CFrame.LookVector * -5, { workspace.Islands, workspace.Ships, workspace.Env })
                local v63 = (v61.Position - v62).Magnitude
                _G.tween(u54.HumanoidRootPart, {
                    0.28,
                    "Sine",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = u54.HumanoidRootPart.CFrame * CFrame.new(0, 0, v63)
                })
            end)
        end
        task.wait(0.98)
        u54.HumanoidRootPart.Anchored = false
        _G.canuse = true
        u54.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Burning Mochi Punch", v57)
        _G.fw(v57)
        v53.burn = false
    end
end
function u6.MochiBuzzcut(u64, p65) --[[ Line: 299 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u8
        [5] = u7
    --]]
    local v66 = u64.Cooldowns
    local u67 = u1.Character
    local u68 = u2["Stats" .. u1.Name]
    if v66.buzz == false and (_G.check:inspect(u67) == true and _G.StamCheck("Mochi Buzzcut") == true) then
        local v69 = u3.GetM("Mochi Buzzcut")
        local v70 = v69.cd
        if _G.StamCheck("Mochi Buzzcut") == false then
            return
        end
        if v69.statreq and _G.MeetReq(v69.statreq) == false then
            return
        end
        v66.buzz = true
        u8 = 1
        local v71 = u67.Humanoid:LoadAnimation(script.buzzcutstart)
        v71:Play()
        v71:AdjustWeight(2)
        v71.Priority = Enum.AnimationPriority.Action4
        u67.Humanoid.WalkSpeed = 4
        _G.canuse = false
        local u72 = game.ReplicatedStorage.Events.Skill:InvokeServer("Mochi Buzzcut")
        local v73
        if u72 then
            task.wait(2.37)
            v73 = u67.Humanoid:LoadAnimation(script.buzzcutloop)
            v73:Play(0)
            v73.Priority = Enum.AnimationPriority.Action4
        else
            v73 = nil
        end
        local u74 = tick()
        local u75 = 0
        local function v76() --[[ Line: 343 ]]
            --[[
            Upvalues:
                [1] = u75
                [2] = u72
                [3] = u67
                [4] = u74
                [5] = u64
                [6] = u68
            --]]
            _G.canuse = false
            if tick() - u75 >= 0.58083333 then
                u75 = tick()
                if u72 then
                    u72:FireServer(true)
                end
            end
            u67.Humanoid.WalkSpeed = 4
            if tick() - u74 >= 7 or (u64.Tool.Parent ~= u67 or (u67.Parent == nil or (u67.Parent ~= workspace.PlayerCharacters or u68.Stamina.Value <= 0))) then
                return false
            end
        end
        u64:ChargeSkill(p65, {
            ["Key"] = Enum.KeyCode.C,
            ["IgnoreInstantCastSetting"] = true,
            ["CheckFunction"] = v76
        })
        if u72 then
            v73:Stop()
            local v77 = u67.Humanoid:LoadAnimation(script.buzzcutend)
            v77:Play()
            v77.Priority = Enum.AnimationPriority.Action4
            v77:AdjustWeight(2)
            u67.Humanoid.WalkSpeed = 0
            u72:FireServer()
            u7(3)
            u7(40)
            u7(77)
            u7(53)
            u7(60)
        end
        u67.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        u67.HumanoidRootPart.Anchored = false
        _G.canuse = true
        u67.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Mochi Buzzcut", v70)
        _G.fw(v70)
        v66.buzz = false
    end
end
function u6.ChestnutMochi(u78, p79) --[[ Line: 402 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v80 = u78.Cooldowns
    local u81 = u1.Character
    local u82 = u2["Stats" .. u1.Name]
    if v80.chest == false and (_G.check:inspect(u81) == true and _G.StamCheck("Chestnut Mochi") == true) then
        local v83 = u3.GetM("Chestnut Mochi")
        local v84 = v83.cd
        if _G.StamCheck("Chestnut Mochi") == false then
            return
        end
        if v83.statreq and _G.MeetReq(v83.statreq) == false then
            return
        end
        v80.chest = true
        local v85 = u81.Humanoid:LoadAnimation(script.cheststart)
        v85:Play()
        v85:AdjustWeight(2)
        v85:AdjustSpeed(0.5)
        u81.Humanoid.WalkSpeed = 4
        _G.FaceMouse = true
        _G.mouseLevel = true
        _G.canuse = false
        local v86 = game.ReplicatedStorage.Events.Skill:InvokeServer("Chestnut Mochi", u81.PrimaryPart.CFrame)
        task.wait(1.4)
        local v87 = u81.Humanoid:LoadAnimation(script.chestloop)
        v87:Play()
        v87:AdjustWeight(2)
        local u88 = tick()
        u78:ChargeSkill(p79, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 434 ]]
                --[[
                Upvalues:
                    [1] = u78
                    [2] = u81
                    [3] = u82
                    [4] = u88
                --]]
                if u78.Tool.Parent ~= u81 or (u81.Parent == nil or (u81.Parent ~= workspace.PlayerCharacters or (u82.Stamina.Value <= 0 or tick() - u88 >= 10))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        _G.mouseLevel = false
        v87:Stop()
        _G.FaceMouse = false
        if v86 then
            v86:FireServer()
        end
        _G.canuse = true
        u81.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Chestnut Mochi", v84)
        _G.fw(v84)
        v80.chest = false
    end
end
function u6.PowerMochi(u89, p90) --[[ Line: 461 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v91 = u89.Cooldowns
    local u92 = u1.Character
    local u93 = u2["Stats" .. u1.Name]
    if v91.punch == false and (_G.check:inspect(u92) == true and _G.StamCheck("Power Mochi") == true) then
        local v94 = u3.GetM("Power Mochi")
        local v95 = v94.cd
        if _G.StamCheck("Power Mochi") == false then
            return
        end
        if v94.statreq and _G.MeetReq(v94.statreq) == false then
            return
        end
        v91.punch = true
        local v96 = u92.Humanoid:LoadAnimation(script.punch)
        v96:Play()
        v96:AdjustWeight(5)
        u92.Humanoid.WalkSpeed = 4
        _G.FaceMouse = true
        _G.canuse = false
        local v97 = game.ReplicatedStorage.Events.Skill:InvokeServer("Power Mochi")
        _G.PauseAnim(v96, 0.43, 1)
        local u98 = tick()
        u89:ChargeSkill(p90, {
            ["Key"] = Enum.KeyCode.R,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 489 ]]
                --[[
                Upvalues:
                    [1] = u89
                    [2] = u92
                    [3] = u93
                    [4] = u98
                --]]
                if u89.Tool.Parent ~= u92 or (u92.Parent == nil or (u92.Parent ~= workspace.PlayerCharacters or (u93.Stamina.Value <= 0 or tick() - u98 >= 10))) then
                    return true
                end
            end
        })
        v96:AdjustSpeed(1)
        local v99 = u92.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
        _G.FaceMouse = false
        u92.HumanoidRootPart.Anchored = true
        task.wait(0.2)
        if v97 then
            v97:FireServer(v99)
        end
        task.wait(0.75)
        u92.HumanoidRootPart.Anchored = false
        _G.canuse = true
        u92.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Power Mochi", v95)
        _G.fw(v95)
        v91.punch = false
    end
end
return u6