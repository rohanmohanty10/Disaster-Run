 

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
local u6 = game.ReplicatedStorage.Modules.SwordHandle.Swords["Spring-Spring Mode"]
local function u13(p7, p8) --[[ Line: 21 ]]
    local v9 = p7:GetDescendants()
    local v10 = {}
    for v11 = 1, #v9 do
        if v9[v11]:IsA("Humanoid") or v9[v11]:IsA("AnimationController") and v9[v11].Parent.Name:match("Spring") then
            local v12 = v9[v11]:LoadAnimation(p8)
            v12:Play()
            v12:AdjustWeight(2)
            table.insert(v10, v12)
        end
    end
    return v10
end
local function u16(p14) --[[ Line: 35 ]]
    for v15 = 1, #p14 do
        if p14[v15].IsPlaying ~= false then
            p14[v15]:Stop()
        end
    end
end
local function u20(p17, p18) --[[ Line: 44 ]]
    for v19 = 1, #p17 do
        if p17[v19].IsPlaying ~= true then
            p17[v19]:Play()
            if p18 then
                p17[v19]:AdjustSpeed(p18)
            end
        end
    end
end
function u5.new(_) --[[ Line: 56 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
        [3] = u1
        [4] = u13
        [5] = u6
        [6] = u16
        [7] = u20
    --]]
    local v21 = u4.new(script.Name)
    local v22 = u5
    local u23 = setmetatable(v21, v22)
    u23.Cooldowns = {
        ["blitz"] = false,
        ["crusher"] = false,
        ["knock"] = false,
        ["hooper"] = false,
        ["mode"] = false,
        ["bomb"] = false,
        ["leap"] = false
    }
    local u24 = u1.Character
    u23.swordMode = {
        ["Idle"] = u13(u24, u6.Idle),
        ["Run"] = u13(u24, u6.runAnim),
        ["Walk"] = u13(u24, u6.walkAnim)
    }
    local u25 = u23.swordMode
    u23.HeartConnection = game["Run Service"].Heartbeat:Connect(function() --[[ Line: 70 ]]
        --[[
        Upvalues:
            [1] = u24
            [2] = u23
            [3] = u16
            [4] = u25
            [5] = u20
        --]]
        if u24:GetAttribute("springMode") == nil or (not u23.Tool or (u23.Tool.Parent ~= u24 or u24.Humanoid.FloorMaterial == Enum.Material.Air)) then
            u16(u25.Run)
            u16(u25.Walk)
            u16(u25.Idle)
            if u23.Tool then
                u23.Tool:SetAttribute("customRun", nil)
            end
            return
        elseif u24.Humanoid.MoveDirection == Vector3.new() then
            u16(u25.Run)
            u16(u25.Walk)
            local v26 = u25.Idle
            for v27 = 1, #v26 do
                if v26[v27].IsPlaying ~= true then
                    v26[v27]:Play()
                end
            end
            return
        elseif u24.Humanoid.WalkSpeed < 25 then
            u16(u25.Run)
            local v28 = u25.Walk
            for v29 = 1, #v28 do
                if v28[v29].IsPlaying ~= true then
                    v28[v29]:Play()
                end
            end
        else
            u16(u25.Walk)
            u20(u25.Run, 2)
        end
    end)
    return u23
end
function u5.SpringBlitz(p30, _) --[[ Line: 99 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v31 = p30.Cooldowns
    local v32 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v31.blitz == false and (_G.check:inspect(v32) == true and _G.StamCheck("Spring Blitz") == true) then
        local v33 = u3.GetM("Spring Blitz")
        local v34 = v33.cd
        if _G.StamCheck("Spring Blitz") == false then
            return
        end
        if v33.statreq and _G.MeetReq(v33.statreq) == false then
            return
        end
        v31.blitz = true
        _G.canuse = false
        if game.ReplicatedStorage.Events.Skill:InvokeServer("Spring Blitz", v32.PrimaryPart.CFrame) then
            task.wait(2.25)
        end
        _G.canuse = true
        _G.keysetup:cooldown("Spring Blitz", v34)
        _G.fw(v34)
        v31.blitz = false
    end
end
function u5.CoilCrusher(p35, p36) --[[ Line: 128 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u13
        [5] = u16
    --]]
    local v37 = p35.Cooldowns
    local u38 = u1.Character
    local u39 = u2["Stats" .. u1.Name]
    if v37.crusher == false and (_G.check:inspect(u38) == true and _G.StamCheck("Coil Crusher") == true) then
        local v40 = u3.GetM("Coil Crusher")
        local v41 = v40.cd
        if _G.StamCheck("Coil Crusher") == false then
            return
        end
        if v40.statreq and _G.MeetReq(v40.statreq) == false then
            return
        end
        v37.crusher = true
        _G.canuse = false
        local u42 = u13(u38, script.coilCharge)
        _G.FaceMouse = true
        _G.canuse = false
        local u43 = nil
        local u44 = nil
        pcall(function() --[[ Line: 157 ]]
            --[[
            Upvalues:
                [1] = u43
                [2] = u44
            --]]
            local v45 = game.ReplicatedStorage.Events.Skill
            local v46, v47 = unpack(v45:InvokeServer("Coil Crusher"))
            u43 = v46
            u44 = v47
        end)
        local u48 = tick()
        local function v49() --[[ Line: 164 ]]
            --[[
            Upvalues:
                [1] = u38
                [2] = u48
                [3] = u43
                [4] = u39
            --]]
            if not u38:FindFirstChild(script.Name) or (tick() - u48 >= 10 or (u43 == nil or (u38.Parent == nil or (u38.Parent ~= workspace.PlayerCharacters or u39.Stamina.Value <= 0)))) then
                return true
            end
        end
        p35:ChargeSkill(p36, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = v49
        })
        u16(u42)
        if u43 then
            u43:FireServer()
        end
        u13(u38, script.coilLaunch)
        local v50 = (tick() - u48) * 50
        local u51 = Instance.new("LinearVelocity")
        u51.Attachment0 = u38.PrimaryPart.RootRigAttachment
        u51.MaxForce = 100000000000
        u51.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        u51.VectorVelocity = u38:GetPivot().LookVector * (175 + v50) + Vector3.new(0, 0.1, 0)
        u51.RelativeTo = Enum.ActuatorRelativeTo.World
        u51.Parent = u38
        local v52 = Instance.new("AlignOrientation")
        v52.Attachment0 = u38.PrimaryPart.RootRigAttachment
        v52.Mode = 0
        v52.CFrame = u38:GetPivot()
        v52.Responsiveness = 45
        v52.MaxTorque = 100000000000
        v52.Parent = u38
        _G.FaceMouse = false
        _G.mouseLevel = false
        _G.tween(u51, { 0.5, "Linear", Enum.EasingDirection.Out }, {
            ["VectorVelocity"] = Vector3.new(0, 0, 0)
        })
        _G.destroy(u51, 0.5)
        _G.destroy(v52, 0.8)
        local u53 = nil
        local function v55(p54) --[[ Line: 204 ]]
            --[[
            Upvalues:
                [1] = u51
                [2] = u44
                [3] = u16
                [4] = u42
                [5] = u38
                [6] = u53
            --]]
            u51:Destroy()
            if u44 then
                u16(u42)
                local _ = u38.PrimaryPart.CFrame * CFrame.new(0, 0, -5)
                u44:FireServer(p54.Parent, u38.PrimaryPart.CFrame)
                u53 = true
            end
        end
        _G.hitbox:start(u38, Vector3.new(15, 15, 15), 0.5, CFrame.new(0, 0, -1), v55)
        task.wait(0.5)
        _G.canuse = true
        _G.keysetup:cooldown("Coil Crusher", v41)
        _G.fw(v41)
        v37.crusher = false
    end
end
function u5.DeathKnock(p56, p57) --[[ Line: 226 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u13
        [5] = u16
    --]]
    local v58 = p56.Cooldowns
    local u59 = u1.Character
    local u60 = u2["Stats" .. u1.Name]
    if v58.knock == false and (_G.check:inspect(u59) == true and _G.StamCheck("Death Knock") == true) then
        local v61 = u3.GetM("Death Knock")
        local v62 = v61.cd
        if _G.StamCheck("Death Knock") == false then
            return
        end
        if v61.statreq and _G.MeetReq(v61.statreq) == false then
            return
        end
        v58.knock = true
        _G.canuse = false
        local v63 = u13(u59, script.deathCharge)
        _G.canuse = false
        local u64 = nil
        local u65 = nil
        pcall(function() --[[ Line: 247 ]]
            --[[
            Upvalues:
                [1] = u64
                [2] = u65
            --]]
            local v66 = game.ReplicatedStorage.Events.Skill
            local v67, v68 = unpack(v66:InvokeServer("Death Knock"))
            u64 = v67
            u65 = v68
        end)
        local u69 = tick()
        p56:ChargeSkill(p57, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 251 ]]
                --[[
                Upvalues:
                    [1] = u59
                --]]
                u59.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 255 ]]
                --[[
                Upvalues:
                    [1] = u59
                    [2] = u69
                    [3] = u60
                --]]
                if not u59:FindFirstChild(script.Name) or (tick() - u69 >= 10 or (u59.Parent == nil or (u59.Parent ~= workspace.PlayerCharacters or u60.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        u16(v63)
        if u64 then
            u64:FireServer()
        end
        u13(u59, script.deathPunch)
        local u70 = Instance.new("LinearVelocity")
        u70.Attachment0 = u59.PrimaryPart.RootRigAttachment
        u70.MaxForce = 100000000000
        u70.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        u70.VectorVelocity = u59:GetPivot().LookVector * 125 + Vector3.new(0, 0.1, 0)
        u70.RelativeTo = Enum.ActuatorRelativeTo.World
        u70.Parent = u59
        local v71 = Instance.new("AlignOrientation")
        v71.Attachment0 = u59.PrimaryPart.RootRigAttachment
        v71.Mode = 0
        v71.CFrame = u59:GetPivot()
        v71.Responsiveness = 45
        v71.MaxTorque = 100000000000
        v71.Parent = u59
        _G.tween(u70, { 0.5, "Linear", Enum.EasingDirection.Out }, {
            ["VectorVelocity"] = Vector3.new(0, 0, 0)
        })
        _G.destroy(u70, 0.5)
        _G.destroy(v71, 0.8)
        local u72 = nil
        local function v74(p73) --[[ Line: 293 ]]
            --[[
            Upvalues:
                [1] = u70
                [2] = u65
                [3] = u59
                [4] = u72
            --]]
            u70:Destroy()
            if u65 then
                u65:FireServer(p73.Parent, u59.PrimaryPart.CFrame)
                u72 = true
            end
        end
        _G.hitbox:start(u59, Vector3.new(15, 15, 15), 0.5, CFrame.new(0, 0, -1), v74)
        task.wait(0.75)
        u59.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Death Knock", v62)
        _G.fw(v62)
        v58.knock = false
    end
end
function u5.SpringFacebreaker(p75, p76) --[[ Line: 312 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u13
        [5] = u16
    --]]
    local v77 = p75.Cooldowns
    local u78 = u1.Character
    local u79 = u2["Stats" .. u1.Name]
    if v77.hooper == false and (_G.check:inspect(u78) == true and _G.StamCheck("Spring Facebreaker") == true) then
        local v80 = u3.GetM("Spring Facebreaker")
        local v81 = v80.cd
        if _G.StamCheck("Spring Facebreaker") == false then
            return
        end
        if v80.statreq and _G.MeetReq(v80.statreq) == false then
            return
        end
        v77.hooper = true
        _G.canuse = false
        local u82 = u13(u78, script.hopper)
        _G.mouseLevel = true
        _G.FaceMouse = true
        _G.canuse = false
        local u83 = nil
        local u84 = nil
        pcall(function() --[[ Line: 335 ]]
            --[[
            Upvalues:
                [1] = u83
                [2] = u84
            --]]
            local v85 = game.ReplicatedStorage.Events.Skill
            local v86, v87 = unpack(v85:InvokeServer("Spring Facebreaker"))
            u83 = v86
            u84 = v87
        end)
        local u88 = tick()
        local function v89() --[[ Line: 340 ]]
            --[[
            Upvalues:
                [1] = u78
                [2] = u88
                [3] = u83
                [4] = u79
            --]]
            if not u78:FindFirstChild(script.Name) or (tick() - u88 >= 10 or (u83 == nil or (u78.Parent == nil or (u78.Parent ~= workspace.PlayerCharacters or u79.Stamina.Value <= 0)))) then
                return true
            end
        end
        local u90 = u84
        local v91 = u83
        for u92 = 1, #u82 do
            if u92 ~= 1 then
                task.spawn(function() --[[ Line: 349 ]]
                    --[[
                    Upvalues:
                        [1] = u82
                        [2] = u92
                    --]]
                    _G.PauseAnim(u82[u92], 0.375, 1)
                end)
            end
        end
        _G.PauseAnim(u82[1], 0.375, 1)
        p75:ChargeSkill(p76, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = v89
        })
        for v93 = 1, #u82 do
            u82[v93]:AdjustSpeed(1)
        end
        if v91 then
            v91:FireServer()
        end
        local v94 = (tick() - u88) * 25
        local u95 = Instance.new("LinearVelocity")
        u95.Attachment0 = u78.PrimaryPart.RootRigAttachment
        u95.MaxForce = 100000000000
        u95.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        u95.VectorVelocity = u78:GetPivot().LookVector * (125 + v94) + Vector3.new(0, 0.1, 0)
        u95.RelativeTo = Enum.ActuatorRelativeTo.World
        u95.Parent = u78
        local v96 = Instance.new("AlignOrientation")
        v96.Attachment0 = u78.PrimaryPart.RootRigAttachment
        v96.Mode = 0
        v96.CFrame = u78:GetPivot()
        v96.Responsiveness = 45
        v96.MaxTorque = 100000000000
        v96.Parent = u78
        _G.FaceMouse = false
        _G.mouseLevel = false
        _G.tween(u95, { 0.5, "Linear", Enum.EasingDirection.Out }, {
            ["VectorVelocity"] = Vector3.new(0, 0, 0)
        })
        _G.destroy(u95, 0.5)
        _G.destroy(v96, 0.8)
        local u97 = nil
        local function v99(p98) --[[ Line: 391 ]]
            --[[
            Upvalues:
                [1] = u95
                [2] = u90
                [3] = u16
                [4] = u82
                [5] = u78
                [6] = u97
            --]]
            u95:Destroy()
            if u90 then
                u16(u82)
                local _ = u78.PrimaryPart.CFrame * CFrame.new(0, 0, -5)
                u90:FireServer(p98.Parent, u78.PrimaryPart.CFrame)
                u97 = true
            end
        end
        _G.hitbox:start(u78, Vector3.new(15, 15, 15), 0.5, CFrame.new(0, 0, -1), v99)
        task.wait(0.5)
        _G.canuse = true
        _G.keysetup:cooldown("Spring Facebreaker", v81)
        _G.fw(v81)
        v77.hooper = false
    end
end
function u5.SpringMode(p100, _) --[[ Line: 413 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v101 = p100.Cooldowns
    local v102 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v102:GetAttribute("springMode") == nil and (v101.mode == false and (_G.check:inspect(v102) == true and _G.StamCheck("Spring Mode") == true)) then
        local v103 = u3.GetM("Spring Mode")
        local v104 = v103.cd
        if _G.StamCheck("Spring Mode") == false then
            return
        end
        if v103.statreq and _G.MeetReq(v103.statreq) == false then
            return
        end
        v101.mode = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Spring Mode", p100.Tool)
        if v102:GetAttribute("springMode") then
            p100.Tool:SetAttribute("customRun", true)
        else
            p100.Tool:SetAttribute("customRun", nil)
        end
        _G.canuse = true
        _G.keysetup:cooldown("Spring Mode", v104)
        _G.fw(v104)
        v101.mode = false
    end
end
function u5.SpringLeap(u105, u106) --[[ Line: 445 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u13
        [5] = u16
    --]]
    local u107 = u105.Cooldowns
    local u108 = u1.Character
    local u109 = u2["Stats" .. u1.Name]
    if _G.grounded == false and (u107.leap == false and (_G.check:inspect(u108) == true and _G.StamCheck("Spring Leap") == true)) then
        local v110 = u3.GetM("Spring Leap")
        local u111 = v110.cd
        if _G.StamCheck("Spring Leap") == false then
            return
        end
        if v110.statreq and _G.MeetReq(v110.statreq) == false then
            return
        end
        u107.leap = true
        local u112 = 0
        local u113 = u108:GetAttribute("springMode") and 3 or 1
        local u114 = game.ReplicatedStorage.Events.Skill:InvokeServer("Spring Leap")
        local function u116() --[[ Line: 471 ]]
            --[[
            Upvalues:
                [1] = u105
                [2] = u108
            --]]
            if u105.Tool.Parent ~= u108 then
                return false
            end
            local v115
            if _G.grounded == false and _G.check:inspect(u108) == true then
                v115 = _G.canuse == true
            else
                v115 = false
            end
            return v115
        end
        local function u123() --[[ Line: 478 ]]
            --[[
            Upvalues:
                [1] = u112
                [2] = u13
                [3] = u108
                [4] = u109
                [5] = u114
                [6] = u105
                [7] = u106
                [8] = u16
                [9] = u113
                [10] = u111
                [11] = u107
                [12] = u116
                [13] = u123
            --]]
            u112 = u112 + 1
            _G.canuse = false
            _G.FaceMouse = true
            local u117 = tick()
            local v118 = u13(u108, script.leapCharge)
            local function v119() --[[ Line: 484 ]]
                --[[
                Upvalues:
                    [1] = u108
                    [2] = u117
                    [3] = u109
                --]]
                if not u108:FindFirstChild(script.Name) or (tick() - u117 >= 5 or u109.Stamina.Value <= 0) then
                    return true
                end
            end
            if u114 then
                u114:FireServer("charge")
            end
            u105:ChargeSkill(u106, {
                ["Key"] = Enum.KeyCode.T,
                ["EndFunction"] = v119,
                ["PCInputType"] = "Default",
                ["MobileInputType"] = "TapScreen"
            })
            u16(v118)
            u13(u108, script.leapJump)
            if u114 then
                u114:FireServer(nil, u108.PrimaryPart.CFrame * CFrame.new(0, -3, 2))
            end
            local v120 = u108.PrimaryPart.CFrame
            local v121 = Instance.new("BodyVelocity")
            v121.MaxForce = Vector3.new(1000000, 1000000, 1000000)
            v121.Velocity = v120.LookVector * (100 + (tick() - u117) * 15)
            v121.Parent = u108.PrimaryPart
            local v122 = Instance.new("AlignOrientation")
            v122.Attachment0 = u108.PrimaryPart.RootRigAttachment
            v122.Mode = 0
            v122.CFrame = u108:GetPivot()
            v122.Responsiveness = 45
            v122.MaxTorque = 100000000000
            v122.Parent = u108
            _G.destroy({ v121, v122 }, 0.25)
            _G.FaceMouse = false
            task.wait(0.35)
            _G.canuse = true
            if u113 <= u112 then
                _G.keysetup:cooldown("Spring Leap", u111)
                _G.fw(u111)
                u107.leap = false
            else
                u105:DoubleCastSkill(u106, {
                    ["ToolName"] = script.Name,
                    ["Key"] = Enum.KeyCode.T,
                    ["Button"] = u106,
                    ["PassFunction"] = u116,
                    ["CompleteFunction"] = u123,
                    ["SkipTap"] = true
                })
            end
        end
        u123()
    end
end
return u5