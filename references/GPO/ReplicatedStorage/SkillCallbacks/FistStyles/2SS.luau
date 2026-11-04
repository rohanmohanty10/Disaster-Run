 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
local v5 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
v5:GetControls()
local u6 = require(game.ReplicatedStorage.Modules.SwordHandle.SwordInfo)
local u7 = setmetatable({}, u4)
u7.__index = u7
function u7.new(_) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u7
        [3] = u1
        [4] = u6
    --]]
    local v8 = u4.new(script.Name)
    local v9 = u7
    local v10 = setmetatable(v8, v9)
    game.ReplicatedStorage:FindFirstChild("Stats" .. u1.Name)
    function v10.getTools() --[[ Line: 26 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v11 = u1.Backpack:GetChildren()
        local v12 = nil
        for v13 = 1, #v11 do
            if v11[v13]:IsA("Tool") and (v11[v13]:FindFirstChild("SwordEquip") and v11[v13].Name ~= "2SS") then
                return v11[v13].Name
            end
        end
        return v12
    end
    local v14 = {}
    local v15 = u6[script.Name]
    local v16
    if v15 == nil then
        v16 = u6.Katana.keys
    else
        v16 = v15.keys
    end
    for v17 = 1, #v16 do
        v14[v16[v17][1]] = false
    end
    v10.Cooldowns = v14
    return v10
end
function u7.RashomonDraw(u18, p19) --[[ Line: 70 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v20 = u18.Cooldowns
    local u21 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v20["Rashomon Draw"] == false and _G.check:inspect(u21) == true then
        local v22 = u3.GetM("Rashomon Draw")
        local v23 = v22.cd
        if _G.StamCheck("Rashomon Draw") == false then
            return
        end
        if v22.statreq and _G.MeetReq(v22.statreq) == false then
            return
        end
        local u24 = u21.Humanoid.Animator:LoadAnimation(script.rash)
        u24:Play()
        u24:AdjustWeight(2)
        v20["Rashomon Draw"] = true
        _G.FaceMouse = true
        _G.canuse = false
        _G.PauseAnim(u24, 1.2, 1)
        local u25 = tick()
        u18:ChargeSkill(p19, {
            ["Key"] = Enum.KeyCode.C,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 96 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u24
                --]]
                if _G.check:inspect(u21) == false then
                    u24:Stop()
                    return true
                end
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 103 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u21
                    [3] = u25
                --]]
                if u18.Tool and u18.Tool.Parent ~= u21 or tick() - u25 >= 10 then
                    return true
                end
            end
        })
        _G.FaceMouse = false
        u21.HumanoidRootPart.Anchored = true
        u24:AdjustSpeed(1)
        local v26 = Ray.new(u21.HumanoidRootPart.CFrame.Position, (u18:GetMouseCFrame().Position - u21.HumanoidRootPart.CFrame.Position).unit * 125)
        local _, v27 = _G.raycastWhitelist(v26, { workspace.Islands, workspace.Ships, workspace.Env })
        local v28 = u21.HumanoidRootPart.CFrame
        local v29 = CFrame.new(v27, v28.Position) * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, u21.Humanoid.HipHeight * 1.25, 2)
        if _G.check:inspect(u21) == true then
            _G.tween(u21.HumanoidRootPart, {
                0.2,
                "Sharp",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = v29
            })
        end
        u21.Humanoid.AutoRotate = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Rashomon Draw", {
            ["cf"] = v29,
            ["old"] = v28
        })
        task.wait(0.9)
        u21.Humanoid.AutoRotate = true
        u21.HumanoidRootPart.Anchored = false
        u21.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Rashomon Draw", v23)
        require(script.Parent.SwordStyleSwapping):matchCooldowns(v20)
        _G.fw(v23)
        v20["Rashomon Draw"] = false
    end
end
u7["72CaliberPhoenix"] = function(u30, p31) --[[ Line: 143 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v32 = u30.Cooldowns
    local u33 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v32["72 Caliber Phoenix"] == false and _G.check:inspect(u33) == true then
        local v34 = u3.GetM("72 Caliber Phoenix")
        local v35 = v34.cd
        if _G.StamCheck("72 Caliber Phoenix") == false then
            return
        end
        if v34.statreq and _G.MeetReq(v34.statreq) == false then
            return
        end
        local u36 = u33.Humanoid.Animator:LoadAnimation(script.pound)
        u36:Play()
        u36:AdjustWeight(2)
        v32["72 Caliber Phoenix"] = true
        _G.FaceMouse = true
        _G.canuse = false
        _G.PauseAnim(u36, 0.35, 1)
        local u37 = tick()
        u30:ChargeSkill(p31, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 170 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u36
                --]]
                if _G.check:inspect(u33) == false then
                    u36:Stop()
                    return true
                end
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 177 ]]
                --[[
                Upvalues:
                    [1] = u30
                    [2] = u33
                    [3] = u37
                --]]
                if u30.Tool and u30.Tool.Parent ~= u33 or tick() - u37 >= 10 then
                    return true
                end
            end
        })
        _G.FaceMouse = false
        u33.HumanoidRootPart.Anchored = true
        u36:AdjustSpeed(1.5)
        task.wait(0.1)
        game.ReplicatedStorage.Events.Skill:InvokeServer("72 Caliber Phoenix", {
            ["cf"] = u33.HumanoidRootPart.CFrame
        })
        task.wait(0.8)
        u33.Humanoid.AutoRotate = true
        u33.HumanoidRootPart.Anchored = false
        u33.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("72 Caliber Phoenix", v35)
        require(script.Parent.SwordStyleSwapping):matchCooldowns(v32)
        _G.fw(v35)
        v32["72 Caliber Phoenix"] = false
    end
end
function u7.RagingWhirl(u38, p39) --[[ Line: 208 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v40 = u38.Cooldowns
    local u41 = u1.Character
    local u42 = u2["Stats" .. u1.Name]
    if v40["Raging Whirl"] == false and _G.check:inspect(u41) == true then
        local v43 = u3.GetM("Raging Whirl")
        local v44 = v43.cd
        if _G.StamCheck("Raging Whirl") == false then
            return
        end
        if v43.statreq and _G.MeetReq(v43.statreq) == false then
            return
        end
        local u45 = u41.Humanoid.Animator:LoadAnimation(script.spin)
        u45:Play()
        u45:AdjustWeight(2)
        u45:AdjustSpeed(4)
        v40["Raging Whirl"] = true
        _G.canuse = false
        local v46 = game.ReplicatedStorage.Events.Skill:InvokeServer("Raging Whirl")
        local u47 = Instance.new("BodyVelocity", u41.HumanoidRootPart)
        u47.MaxForce = Vector3.new(1000000, 10000, 1000000)
        u47.Name = "geppo"
        local u48 = tick()
        u38:ChargeSkill(p39, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 242 ]]
                --[[
                Upvalues:
                    [1] = u41
                    [2] = u47
                    [3] = u48
                    [4] = u45
                --]]
                if u41.HumanoidRootPart:FindFirstChild("comboBV") and u47 then
                    u47:Destroy()
                end
                if u47 then
                    local v49 = u47
                    local v50 = u41.HumanoidRootPart.CFrame.LookVector
                    local v51 = (tick() - u48) / 0.5
                    v49.Velocity = v50 * (125 + -95 * math.clamp(v51, 0, 1))
                end
                local v52 = u45
                local v53 = (tick() - u48) / 0.5
                v52:AdjustSpeed(4 + -3 * math.clamp(v53, 0, 1))
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 253 ]]
                --[[
                Upvalues:
                    [1] = u38
                    [2] = u41
                    [3] = u48
                    [4] = u42
                    [5] = u45
                --]]
                if u38.Tool and u38.Tool.Parent ~= u41 or (tick() - u48 >= 2 or u42.Stamina.Value <= 0) then
                    return true
                end
                if _G.check:inspect(u41) == false then
                    u45:Stop()
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        u45:Stop()
        if u47 then
            u47:Destroy()
        end
        if v46 then
            v46:FireServer()
        end
        u41.HumanoidRootPart.Anchored = false
        u41.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Raging Whirl", v44)
        require(script.Parent.SwordStyleSwapping):matchCooldowns(v40)
        _G.fw(v44)
        v40["Raging Whirl"] = false
    end
end
function u7.TowerClimb(p54, _) --[[ Line: 289 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v55 = p54.Cooldowns
    local v56 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v55["Tower Climb"] == false and _G.check:inspect(v56) == true then
        local v57 = u3.GetM("Tower Climb")
        local v58 = v57.cd
        if _G.StamCheck("Tower Climb") == false then
            return
        end
        if v57.statreq and _G.MeetReq(v57.statreq) == false then
            return
        end
        local v59 = v56.Humanoid.Animator:LoadAnimation(script.counter)
        v59:Play()
        v59:AdjustWeight(2)
        v55["Tower Climb"] = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Tower Climb")
        task.wait(0.5)
        _G.canuse = true
        _G.keysetup:cooldown("Tower Climb", v58)
        require(script.Parent.SwordStyleSwapping):matchCooldowns(v55)
        _G.fw(v58)
        v55["Tower Climb"] = false
    end
end
function u7.NitoryuStrike(u60, p61) --[[ Line: 325 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v62 = u60.Cooldowns
    local u63 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v62["Nitoryu Strike"] == false and _G.check:inspect(u63) == true then
        local v64 = u3.GetM("Nitoryu Strike")
        local v65 = v64.cd
        if _G.StamCheck("Nitoryu Strike") == false then
            return
        end
        if v64.statreq and _G.MeetReq(v64.statreq) == false then
            return
        end
        local v66 = u63.Humanoid.Animator:LoadAnimation(script.anim)
        v66:Play()
        v66:AdjustWeight(2)
        v62["Nitoryu Strike"] = true
        _G.FaceMouse = true
        _G.canuse = false
        _G.PauseAnim(v66, 0.6, 1.3)
        local u67 = script.aim:Clone()
        u67.Parent = workspace.Effects
        u67.Attachment2.Position = Vector3.new()
        _G.tween(u67.Attachment2, {
            0.25,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Position"] = script.aim.Attachment2.Position
        })
        local v68 = game.ReplicatedStorage.Events.Skill:InvokeServer("Nitoryu Strike")
        local u69 = tick()
        u60:ChargeSkill(p61, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 361 ]]
                --[[
                Upvalues:
                    [1] = u63
                    [2] = u67
                    [3] = u69
                --]]
                if _G.check:inspect(u63) == false then
                    return true
                end
                u67.CFrame = u63.HumanoidRootPart.CFrame * CFrame.new(0, -u63.Humanoid.HipHeight * 1.45, -25) * CFrame.Angles(3.141592653589793, 0, 0)
                if tick() - u69 > 0.25 then
                    local v70 = u67.Attachment2
                    local v71 = u67.Attachment2.Position
                    local v72 = 0.1 * (60 / _G.FPS)
                    v70.Position = v71 + Vector3.new(0, 0, v72)
                end
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 371 ]]
                --[[
                Upvalues:
                    [1] = u60
                    [2] = u63
                    [3] = u69
                --]]
                if (u60.Tool and u60.Tool.Parent ~= u63 or tick() - u69 >= 10) and tick() - u69 >= 0.25 then
                    return true
                end
            end
        })
        _G.FaceMouse = false
        if v68 then
            u63.HumanoidRootPart.Anchored = true
            u63.Humanoid.AutoRotate = false
        end
        _G.tween(u67.Beam, {
            0.25,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = NumberSequence.new(1)
        })
        _G.destroy(u67, 0.25)
        local v73 = u63.HumanoidRootPart.CFrame
        local v74 = u67.Attachment2.Position.Z * 2
        local v75 = Ray.new(u63.HumanoidRootPart.CFrame.Position, u63.HumanoidRootPart.CFrame.LookVector * v74)
        local _, v76 = _G.raycastWhitelist(v75, { workspace.Islands, workspace.Ships, workspace.Env })
        local _ = (v73.Position - v76).Magnitude
        local v77 = CFrame.new(v76, v73.Position) * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, 0, 2)
        if v68 then
            v68:FireServer(v77, v73)
        end
        task.wait(0.2)
        v66:Stop()
        task.wait(1.5)
        u63.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Nitoryu Strike", v65)
        require(script.Parent.SwordStyleSwapping):matchCooldowns(v62)
        _G.fw(v65)
        v62["Nitoryu Strike"] = false
    end
end
function u7.SwordStyleSwap(p78, _) --[[ Line: 419 ]]
    require(script.Parent.SwordStyleSwapping):swap(p78)
end
return u7