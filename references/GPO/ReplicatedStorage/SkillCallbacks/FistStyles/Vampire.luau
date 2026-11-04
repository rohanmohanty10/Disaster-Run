 

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
        ["ult"] = false,
        ["dash"] = false,
        ["bite"] = false,
        ["chain"] = false,
        ["burst"] = false
    }
    v7.currentGroundedUI = nil
    return v7
end
function u4.BloodDragon(u8, _) --[[ Line: 26 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v9 = u8.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v10 = u1.Character
    if v9.ult == false and (_G.check:inspect(v10) == true and _G.StamCheck("Blood Dragon") == true) then
        local v11 = u2.GetM("Blood Dragon")
        local v12 = v11.cd
        if _G.StamCheck("Blood Dragon") == false then
            return
        end
        if v11.statreq and _G.MeetReq(v11.statreq) == false then
            return
        end
        v9.ult = true
        _G.canuse = false
        local v13 = _G.getTargetNearMouse()
        if v13 == nil then
            v13 = u8:GetMouseCFrame()
        end
        if typeof(v13) == "Instance" then
            local _ = v13.CFrame
        end
        local function v14() --[[ Line: 55 ]]
            --[[
            Upvalues:
                [1] = u8
            --]]
            return u8:GetMouseCFrame()
        end
        _G.FaceMouse = true
        _G.mouseLevel = true
        local v15 = v10.Humanoid:LoadAnimation(script.ult)
        v15:Play(0)
        v15:AdjustWeight(2)
        task.wait(0.25)
        local v16 = game.ReplicatedStorage.Events.Skill:InvokeServer("Blood Dragon", v14())
        local v17 = tick()
        while true do
            if v16 then
                v16:FireServer(v14())
            end
            task.wait(0.05)
            if tick() - v17 >= 1.6 then
                v10.PrimaryPart.Anchored = false
                _G.FaceMouse = false
                _G.mouseLevel = false
                v10.Humanoid.WalkSpeed = 16
                _G.keysetup:cooldown("Blood Dragon", v12)
                _G.canuse = true
                _G.fw(v12)
                v9.ult = false
                goto l2
            end
        end
    else
        ::l2::
        return
    end
end
function u4.BloodDash(p18, _) --[[ Line: 86 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v19 = p18.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v20 = u1.Character
    if v19.dash == false and (_G.check:inspect(v20) == true and _G.StamCheck("Blood Dash") == true) then
        local v21 = u2.GetM("Blood Dash")
        local v22 = v21.cd
        if _G.StamCheck("Blood Dash") == false then
            return
        end
        if v21.statreq and _G.MeetReq(v21.statreq) == false then
            return
        end
        v19.dash = true
        _G.canuse = false
        local v23 = v20.Humanoid:LoadAnimation(script.dash)
        v23:Play(0)
        v23:AdjustWeight(2)
        v20.Humanoid.AutoRotate = false
        task.wait(0.25)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Blood Dash", v20.PrimaryPart.CFrame)
        v20.Humanoid.WalkSpeed = 16
        v20.Humanoid.AutoRotate = true
        _G.keysetup:cooldown("Blood Dash", v22)
        _G.canuse = true
        _G.fw(v22)
        v19.dash = false
    end
end
function u4.VampireBite(u24, p25) --[[ Line: 125 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v26 = u24.Cooldowns
    local u27 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u28 = u1.Character
    if v26.bite == false and (_G.check:inspect(u28) == true and _G.StamCheck("Vampire Bite") == true) then
        local v29 = u2.GetM("Vampire Bite")
        local v30 = v29.cd
        if _G.StamCheck("Vampire Bite") == false then
            return
        end
        if v29.statreq and _G.MeetReq(v29.statreq) == false then
            return
        end
        _G.canuse = false
        local u31 = game.ReplicatedStorage.Events.Skill:InvokeServer("Vampire Bite", {
            ["cf"] = u24:GetMouseCFrame()
        })
        v26.bite = true
        local v32 = u28.Humanoid:LoadAnimation(script.bite)
        v32:Play()
        v32:AdjustWeight(5)
        _G.canuse = false
        u28.Humanoid.WalkSpeed = 4
        _G.PauseAnim(v32, 0.12, 1)
        local u33 = tick()
        u24:ChargeSkill(p25, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 153 ]]
                --[[
                Upvalues:
                    [1] = u28
                --]]
                u28.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 158 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u24
                    [3] = u28
                    [4] = u27
                --]]
                if tick() - u33 >= 5 or (u24.Tool.Parent ~= u28 or (u28.Parent == nil or (u28.Parent ~= workspace.PlayerCharacters or u27.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v32:AdjustSpeed(1)
        local u34 = Instance.new("LinearVelocity")
        u34.Attachment0 = u28.PrimaryPart.RootRigAttachment
        u34.MaxForce = 100000000000
        u34.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        u34.VectorVelocity = u28:GetPivot().LookVector * 60
        u34.RelativeTo = Enum.ActuatorRelativeTo.World
        u34.Parent = u28
        local v35 = Instance.new("AlignOrientation")
        v35.Attachment0 = u28.PrimaryPart.RootRigAttachment
        v35.Mode = 0
        v35.CFrame = u28:GetPivot()
        v35.Responsiveness = 45
        v35.MaxTorque = 100000000000
        v35.Parent = u28
        _G.tween(u34, { 0.5, "Linear", Enum.EasingDirection.Out }, {
            ["VectorVelocity"] = Vector3.new(0, 0, 0)
        })
        _G.destroy(u34, 0.5)
        _G.destroy(v35, 0.5)
        if u31 then
            u31:FireServer("woosh")
        end
        local u36 = nil
        local function v38(p37) --[[ Line: 196 ]]
            --[[
            Upvalues:
                [1] = u34
                [2] = u31
                [3] = u28
                [4] = u36
            --]]
            u34:Destroy()
            if u31 then
                u31:FireServer(u28.PrimaryPart.CFrame, p37.Parent)
                u36 = true
            end
        end
        _G.hitbox:start(u28, Vector3.new(8, 8, 8), 0.25, CFrame.new(0, 0, -1), v38)
        task.wait(0.5)
        u28.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Vampire Bite", v30)
        _G.fw(v30)
        v26.bite = false
    end
end
function u4.BloodChain(u39, p40) --[[ Line: 215 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v41 = u39.Cooldowns
    local u42 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u43 = u1.Character
    if v41.chain == false and (_G.check:inspect(u43) == true and _G.StamCheck("Blood Chain") == true) then
        local v44 = u2.GetM("Blood Chain")
        local v45 = v44.cd
        if _G.StamCheck("Blood Chain") == false then
            return
        end
        if v44.statreq and _G.MeetReq(v44.statreq) == false then
            return
        end
        _G.canuse = false
        local u46 = game.ReplicatedStorage.Events.Skill:InvokeServer("Blood Chain", {
            ["cf"] = u39:GetMouseCFrame()
        })
        v41.chain = true
        local v47 = u43.Humanoid:LoadAnimation(script.punch)
        v47:Play()
        v47:AdjustWeight(5)
        _G.canuse = false
        u43.Humanoid.WalkSpeed = 4
        _G.PauseAnim(v47, 0.2, 1)
        local u48 = tick()
        u39:ChargeSkill(p40, {
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 243 ]]
                --[[
                Upvalues:
                    [1] = u43
                --]]
                u43.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 248 ]]
                --[[
                Upvalues:
                    [1] = u48
                    [2] = u39
                    [3] = u43
                    [4] = u42
                --]]
                if tick() - u48 >= 5 or (u39.Tool.Parent ~= u43 or (u43.Parent == nil or (u43.Parent ~= workspace.PlayerCharacters or u42.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v47:AdjustSpeed(1)
        local u49 = Instance.new("LinearVelocity")
        u49.Attachment0 = u43.PrimaryPart.RootRigAttachment
        u49.MaxForce = 100000000000
        u49.VelocityConstraintMode = Enum.VelocityConstraintMode.Vector
        u49.VectorVelocity = u43:GetPivot().LookVector * 125
        u49.RelativeTo = Enum.ActuatorRelativeTo.World
        u49.Parent = u43
        local v50 = Instance.new("AlignOrientation")
        v50.Attachment0 = u43.PrimaryPart.RootRigAttachment
        v50.Mode = 0
        v50.CFrame = u43:GetPivot()
        v50.Responsiveness = 45
        v50.MaxTorque = 100000000000
        v50.Parent = u43
        _G.tween(u49, { 0.5, "Linear", Enum.EasingDirection.Out }, {
            ["VectorVelocity"] = Vector3.new(0, 0, 0)
        })
        _G.destroy(u49, 0.5)
        _G.destroy(v50, 0.5)
        if u46 then
            u46:FireServer("woosh")
        end
        local u51 = nil
        local function v60(p52) --[[ Line: 287 ]]
            --[[
            Upvalues:
                [1] = u49
                [2] = u46
                [3] = u43
                [4] = u51
            --]]
            u49:Destroy()
            if u46 then
                local v53 = u43.PrimaryPart.CFrame * CFrame.new(0, 0, -5)
                local v54 = u46
                local v55 = CFrame.new
                local v56 = u43.PrimaryPart.Position
                local v57 = v53.X
                local v58 = u43.PrimaryPart.Position.Y
                local v59 = v53.Z
                v54:FireServer(v55(v56, (Vector3.new(v57, v58, v59))), p52.Parent)
                u51 = true
            end
        end
        _G.hitbox:start(u43, Vector3.new(8, 8, 8), 0.25, CFrame.new(0, 0, -1), v60)
        task.wait(0.5)
        u43.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Blood Chain", v45)
        _G.fw(v45)
        v41.chain = false
    end
end
function u4.BloodAura(u61, p62) --[[ Line: 307 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u1
    --]]
    local u63 = u61.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u64 = u1.Character
    if u63.burst == false and (_G.check:inspect(u64) == true and _G.StamCheck("Blood Aura") == true) then
        local v65 = u2.GetM("Blood Aura")
        local u66 = v65.cd
        if _G.StamCheck("Blood Aura") == false then
            return
        end
        if v65.statreq and _G.MeetReq(v65.statreq) == false then
            return
        end
        local v67 = u64:GetAttribute("vampireDamage")
        if v67 == nil or v67 and v67 < require(game.ReplicatedStorage.Modules.Skills.Modes.Vampire)(u1) / 4 then
            _G.displayMessage("<Color=Red>You dont have enough blood")
            return
        end
        u63.burst = true
        _G.canuse = false
        u64.Humanoid.WalkSpeed = 0
        local v68 = u64.Humanoid:LoadAnimation(script.aura)
        v68:Play(0)
        v68:AdjustWeight(2)
        v68.Priority = Enum.AnimationPriority.Action4
        u64.PrimaryPart.Anchored = true
        local u69 = game.ReplicatedStorage.Events.Skill:InvokeServer("Blood Aura", u64.PrimaryPart.CFrame)
        u61.currentGroundedUI = script.AuraUI:Clone()
        u61.currentGroundedUI.ImageLabel.ImageTransparency = 1
        u61.currentGroundedUI.Parent = u1.PlayerGui
        _G.tween(u61.currentGroundedUI.ImageLabel, { 0.25, "Cubic", Enum.EasingDirection.Out }, {
            ["ImageTransparency"] = script.AuraUI.ImageLabel.ImageTransparency
        })
        local u70 = script.ColorCorrection:Clone()
        u70.Name = "bloodAuraCamera"
        u70.TintColor = Color3.fromRGB(255, 255, 255)
        u70.Parent = workspace.CurrentCamera
        _G.tween(u70, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TintColor"] = script.ColorCorrection.TintColor
        })
        task.wait(1.5)
        u64.Humanoid.WalkSpeed = 16
        u64.PrimaryPart.Anchored = false
        if u69 then
            warn(u61.Tool)
            u61:DoubleCastSkill(p62, {
                ["Key"] = Enum.KeyCode.X,
                ["SkipTap"] = true,
                ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 359 ]]
                    --[[
                    Upvalues:
                        [1] = u69
                        [2] = u64
                    --]]
                    u69:FireServer(u64.PrimaryPart.CFrame)
                end,
                ["PassFunction"] = function() --[[ Name: PassFunction, Line 362 ]]
                    --[[
                    Upvalues:
                        [1] = u64
                        [2] = u61
                    --]]
                    local v71
                    if u64:GetAttribute("bloodAura") == nil then
                        v71 = false
                    else
                        v71 = u61.Tool.Parent == u64
                    end
                    return v71
                end
            })
            task.spawn(function() --[[ Line: 367 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u64
                    [3] = u70
                    [4] = u61
                    [5] = u66
                    [6] = u63
                --]]
                local u72 = {}
                local v73 = 0
                local function v76(p74, p75) --[[ Line: 371 ]]
                    --[[
                    Upvalues:
                        [1] = u72
                    --]]
                    if p74 then
                        _G.tween(p74, { 0.25, "Cubic", Enum.EasingDirection.Out }, {
                            ["FillTransparency"] = 1,
                            ["OutlineTransparency"] = 1
                        })
                        _G.destroy(p74, 0.25)
                        u72[p75] = nil
                    end
                end
                while true do
                    if tick() - v73 >= 0.1 then
                        local v77 = workspace.NPCs:GetChildren()
                        local v78 = game.Players:GetPlayers()
                        for v79 = 1, #v78 do
                            local v80 = v78[v79]
                            if v80 ~= u1 and v80:FindFirstChild("Party") then
                                if v80.Party.Value == nil or v80.Party.Value ~= u1.Party.Value then
                                    local v81 = v80.Character
                                    if v81 and v81.PrimaryPart then
                                        table.insert(v77, v81)
                                    end
                                end
                            end
                        end
                        for v82 = 1, #v77 do
                            if v77[v82].PrimaryPart ~= nil and u72[v77[v82]] == nil then
                                local v83 = (workspace.CurrentCamera.CFrame.Position - v77[v82].PrimaryPart.Position).Magnitude
                                local _, v84 = workspace.CurrentCamera:WorldToScreenPoint(v77[v82].PrimaryPart.Position)
                                if v84 == true and v83 <= 125 then
                                    local v85 = Instance.new("Highlight")
                                    v85.Name = "characterHighlight"
                                    v85.FillTransparency = 1
                                    v85.FillColor = Color3.fromRGB(255, 0, 0)
                                    v85.OutlineColor = Color3.fromRGB(255, 0, 0)
                                    v85.OutlineTransparency = 1
                                    v85.Parent = v77[v82]
                                    v85.Enabled = true
                                    _G.tween(v85, { 0.25, "Cubic", Enum.EasingDirection.Out }, {
                                        ["FillTransparency"] = 0.5,
                                        ["OutlineTransparency"] = 0
                                    })
                                    u72[v77[v82]] = v85
                                end
                            end
                        end
                        for v86, v87 in pairs(u72) do
                            if v86 == nil or v86 and v86.PrimaryPart == nil or v86.Parent == workspace.Effects then
                                v76(v87, v86)
                            elseif v86 and v86.PrimaryPart ~= nil then
                                local v88 = (workspace.CurrentCamera.CFrame.Position - v86.PrimaryPart.Position).Magnitude
                                local _, v89 = workspace.CurrentCamera:WorldToScreenPoint(v86.PrimaryPart.Position)
                                if v88 > 125 or v89 == false then
                                    v76(v87, v86)
                                end
                            end
                        end
                        v73 = tick()
                    end
                    task.wait()
                    if u64:GetAttribute("bloodAura") == nil then
                        _G.tween(u70, {
                            0.5,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["TintColor"] = Color3.fromRGB(255, 255, 255),
                            ["Contrast"] = 0
                        })
                        _G.destroy(u70, 0.5)
                        if u61.currentGroundedUI then
                            _G.tween(u61.currentGroundedUI.ImageLabel, { 0.25, "Cubic", Enum.EasingDirection.Out }, {
                                ["ImageTransparency"] = 1
                            })
                            _G.destroy(u61.currentGroundedUI, 0.25)
                            u61.currentGroundedUI = nil
                        end
                        for v90, v91 in pairs(u72) do
                            v76(v91, v90)
                        end
                        table.clone(u72)
                        _G.keysetup:cooldown("Blood Aura", u66)
                        _G.fw(u66)
                        u63.burst = false
                        return
                    end
                end
            end)
        end
        u64.Humanoid.WalkSpeed = 16
        _G.canuse = true
    end
end
return u4