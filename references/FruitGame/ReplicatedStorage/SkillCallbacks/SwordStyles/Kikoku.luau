 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
local v5 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
v5:GetControls()
local u6 = setmetatable({}, u4)
u6.__index = u6
function u6.new(_) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u6
    --]]
    local v7 = u4.new(script.Name)
    local v8 = u6
    local v9 = setmetatable(v7, v8)
    v9.Cooldowns = {
        ["amputate"] = false,
        ["kris"] = false,
        ["lin"] = false,
        ["cleave"] = false
    }
    return v9
end
function u6.SterbenLinie(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.lin == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Sterben Linie")
        local v15 = v14.cd
        if _G.StamCheck("Sterben Linie") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        _G.canuse = false
        local v16 = u13.Humanoid.Animator:LoadAnimation(script.LinieWindup)
        v16:Play()
        v16:AdjustWeight(2)
        u13.Humanoid.WalkSpeed = 4
        v12.lin = true
        local v17 = game.ReplicatedStorage.Events.Skill:InvokeServer("Sterben Linie")
        task.wait(0.5)
        v16:Stop()
        local v18 = u13.Humanoid.Animator:LoadAnimation(script.LinieLoop)
        v18:Play()
        v18:AdjustWeight(2)
        local u19 = tick()
        local _ = u13.PrimaryPart.CFrame
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 58 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                u13.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 62 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u19
                --]]
                if u13:FindFirstChild(script.Name) == nil then
                    return true
                end
                if tick() - u19 >= 1.5 then
                    return true
                end
                if _G.check:inspect(u13) == false then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v18:Stop()
        local v20 = u13.Humanoid.Animator:LoadAnimation(script.LinieEnd)
        v20:Play()
        v20:AdjustWeight(2)
        if v17 then
            v17:FireServer(u13.PrimaryPart.CFrame)
        end
        task.wait(0.5)
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Sterben Linie", v15)
        _G.fw(v15)
        v12.lin = false
    end
end
function u6.Amputate(p21, p22) --[[ Line: 98 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v23 = p21.Cooldowns
    local u24 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v23.amputate == false and _G.check:inspect(u24) == true then
        local v25 = u3.GetM("Amputate")
        local v26 = v25.cd
        if _G.StamCheck("Amputate") == false then
            return
        end
        if v25.statreq and _G.MeetReq(v25.statreq) == false then
            return
        end
        _G.canuse = false
        v23.amputate = true
        local v27 = u24.Humanoid.Animator:LoadAnimation(script.amputate2)
        v27:Play()
        v27:AdjustWeight(5)
        u24.Humanoid.WalkSpeed = 4
        local v28 = game.ReplicatedStorage.Events.Skill:InvokeServer("Amputate")
        _G.PauseAnim(v27, 0.3, 1)
        local _ = u24.PrimaryPart.CFrame
        p21:ChargeSkill(p22, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 123 ]]
                --[[
                Upvalues:
                    [1] = u24
                --]]
                u24.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 127 ]]
                --[[
                Upvalues:
                    [1] = u24
                --]]
                if u24:FindFirstChild(script.Name) == nil then
                    return true
                end
            end
        })
        u24.Humanoid.AutoRotate = false
        u24.PrimaryPart.Anchored = true
        if v28 then
            if v28:InvokeServer(u24.PrimaryPart.CFrame) == true then
                v27:AdjustSpeed(1)
                task.wait(2.3)
                u24.Humanoid.AutoRotate = true
            else
                v27:Stop()
                local v29 = u24.Humanoid.Animator:LoadAnimation(script.amputate)
                v29:Play()
                v29:AdjustWeight(2)
                v29.TimePosition = 0.35
                task.wait(0.6)
                u24.Humanoid.AutoRotate = true
            end
        else
            v27:Stop()
        end
        u24.PrimaryPart.Anchored = false
        u24.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Amputate", v26)
        _G.fw(v26)
        v23.amputate = false
    end
end
function u6.SterbenKreis(p30, p31) --[[ Line: 173 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v32 = p30.Cooldowns
    local u33 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v32.kris == false and _G.check:inspect(u33) == true then
        local v34 = u3.GetM("Sterben Kreis")
        local v35 = v34.cd
        if _G.StamCheck("Sterben Kreis") == false then
            return
        end
        if v34.statreq and _G.MeetReq(v34.statreq) == false then
            return
        end
        _G.canuse = false
        v32.kris = true
        local v36 = u33.Humanoid.Animator:LoadAnimation(script.lineCharge)
        v36:Play()
        v36:AdjustWeight(2)
        u33.Humanoid.WalkSpeed = 4
        local u37 = tick()
        local v38 = game.ReplicatedStorage.Events.Skill:InvokeServer("Sterben Kreis")
        _G.PauseAnim(v36, 0.35, 1)
        local _ = u33.PrimaryPart.CFrame
        p30:ChargeSkill(p31, {
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 200 ]]
                --[[
                Upvalues:
                    [1] = u33
                --]]
                u33.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 204 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u37
                --]]
                if u33:FindFirstChild(script.Name) == nil then
                    return true
                end
                if tick() - u37 >= 2 then
                    return true
                end
            end
        })
        v36:Stop()
        u33.Humanoid.AutoRotate = false
        u33.PrimaryPart.Anchored = true
        if v38 then
            v38:FireServer(u33.PrimaryPart.CFrame)
            local v39 = u33.Humanoid.Animator:LoadAnimation(script.lineFire)
            v39:Play()
            v39:AdjustWeight(2)
            v39:AdjustSpeed(1.25)
        end
        task.wait(1)
        u33.Humanoid.AutoRotate = true
        u33.PrimaryPart.Anchored = false
        u33.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Sterben Kreis", v35)
        _G.fw(v35)
        v32.kris = false
    end
end
function u6.AmputatingCleave(p40, p41) --[[ Line: 244 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v42 = p40.Cooldowns
    local u43 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v42.cleave == false and _G.check:inspect(u43) == true then
        local v44 = u3.GetM("Amputating Cleave")
        local v45 = v44.cd
        if _G.StamCheck("Amputating Cleave") == false then
            return
        end
        if v44.statreq and _G.MeetReq(v44.statreq) == false then
            return
        end
        _G.canuse = false
        v42.cleave = true
        u43.Humanoid.WalkSpeed = 4
        local u46 = tick()
        _G.FaceMouse = true
        _G.mouseLevel = true
        local v47 = game.ReplicatedStorage.Events.Skill:InvokeServer("Amputating Cleave", u43.PrimaryPart.CFrame)
        local v48 = u43.Humanoid.Animator:LoadAnimation(script.cleaveCharge)
        v48:Play()
        v48:AdjustWeight(2)
        local u49 = script.Part:Clone()
        u49.Parent = workspace.Effects
        u49.Transparency = 1
        u49.Size = Vector3.new(26, 1, 1)
        u49.CFrame = u43.PrimaryPart.CFrame
        _G.tween(u49, {
            1.5,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = Vector3.new(60, 1, 1)
        })
        local _ = u43.PrimaryPart.CFrame
        p40:ChargeSkill(p41, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 280 ]]
                --[[
                Upvalues:
                    [1] = u43
                    [2] = u49
                --]]
                u43.Humanoid.WalkSpeed = 4
                u49.CFrame = u43.PrimaryPart.CFrame
            end,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 285 ]]
                --[[
                Upvalues:
                    [1] = u43
                    [2] = u46
                --]]
                if u43:FindFirstChild(script.Name) == nil then
                    return true
                end
                if tick() - u46 >= 1.5 then
                    return true
                end
            end
        })
        v48:Stop()
        _G.destroy(u49, 0.25)
        local v50 = u43.Humanoid.Animator:LoadAnimation(script.cleave)
        v50:Play()
        v50:AdjustWeight(2)
        _G.FaceMouse = false
        _G.mouseLevel = false
        u43.Humanoid.AutoRotate = false
        u43.PrimaryPart.Anchored = true
        if v47 then
            if v47:InvokeServer(u43.PrimaryPart.CFrame, u49.Size.X) == true then
                task.wait(1.2)
            else
                v50:Stop()
                local v51 = u43.Humanoid.Animator:LoadAnimation(script.miss)
                v51:Play()
                v51:AdjustWeight(2)
                v51:AdjustSpeed(2)
            end
        end
        task.wait(0.8)
        u43.Humanoid.AutoRotate = true
        u43.PrimaryPart.Anchored = false
        u43.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Amputating Cleave", v45)
        _G.fw(v45)
        v42.cleave = false
    end
end
return u6