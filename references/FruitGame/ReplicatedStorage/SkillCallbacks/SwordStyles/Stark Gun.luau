 

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
        ["upper"] = false,
        ["dash"] = false,
        ["wolf"] = false
    }
    return v9
end
function u6.CeroMetralleta(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local v13 = u1.Character
    local u14 = u2["Stats" .. u1.Name]
    if v12.upper == false and _G.check:inspect(v13) == true then
        local v15 = u3.GetM("Cero Metralleta")
        local v16 = v15.cd
        if _G.StamCheck("Cero Metralleta") == false then
            return
        end
        if v15.statreq and _G.MeetReq(v15.statreq) == false then
            return
        end
        local v17
        if v13:GetAttribute("starkgunDamage") then
            local v18 = v13:GetAttribute("starkgunDamage")
            v17 = math.ceil(v18)
        else
            v17 = 0
        end
        if v17 < require(game.ReplicatedStorage.Modules.Skills.Modes["Stark Gun"])(u1) then
            _G.displayMessage("<Color=Red>I dont have enough damage.")
            return
        end
        v12.upper = true
        _G.canuse = false
        local v19 = v13.Humanoid.Animator:LoadAnimation(script.gun)
        v19:Play()
        v19:AdjustWeight(2)
        v19.Priority = Enum.AnimationPriority.Action4
        _G.FaceMouse = true
        local v20 = game.ReplicatedStorage.Events.Skill:InvokeServer("Cero Metralleta")
        _G.PauseAnim(v19, 0.4, 1)
        local u21 = tick()
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 67 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 71 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u14
                --]]
                if tick() - u21 >= 3 or u14.Stamina.Value <= 0 then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v19:Stop()
        local v22 = v13.Humanoid.Animator:LoadAnimation(script.ceroMet)
        v22:Play()
        v22.Priority = Enum.AnimationPriority.Action4
        _G.FaceMouse = false
        v13.PrimaryPart.Anchored = true
        v13.Humanoid.AutoRotate = false
        if v20 then
            v20:InvokeServer(v13.PrimaryPart.CFrame)
        end
        v13.PrimaryPart.Anchored = false
        v13.Humanoid.AutoRotate = true
        v22:Stop()
        v13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Cero Metralleta", v16)
        _G.fw(v16)
        v12.upper = false
    end
end
function u6.RightGun(p23, p24) --[[ Line: 109 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v25 = p23.Cooldowns
    local u26 = u1.Character
    local u27 = u2["Stats" .. u1.Name]
    if v25.dash == false and _G.check:inspect(u26) == true then
        local v28 = u3.GetM("Right Gun")
        local v29 = v28.cd
        if _G.StamCheck("Right Gun") == false then
            return
        end
        if v28.statreq and _G.MeetReq(v28.statreq) == false then
            return
        end
        local v30 = u26.Humanoid.Animator:LoadAnimation(script.gun)
        v30:Play()
        v30:AdjustWeight(2)
        v30.Priority = Enum.AnimationPriority.Action4
        v25.dash = true
        _G.canuse = false
        _G.FaceMouse = true
        local v31 = game.ReplicatedStorage.Events.Skill:InvokeServer("Right Gun", u26.PrimaryPart.CFrame)
        local u32 = tick()
        _G.PauseAnim(v30, 0.4, 1)
        p23:ChargeSkill(p24, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 137 ]]
                --[[
                Upvalues:
                    [1] = u26
                --]]
                if _G.check:inspect(u26) == false then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 143 ]]
                --[[
                Upvalues:
                    [1] = u32
                    [2] = u27
                --]]
                if tick() - u32 >= 2 or u27.Stamina.Value <= 0 then
                    return true
                end
            end
        })
        u26.PrimaryPart.Anchored = true
        v30:AdjustSpeed(2)
        _G.FaceMouse = false
        if v31 then
            local v33 = u26.PrimaryPart.CFrame
            u26:SetPrimaryPartCFrame(CFrame.new(u26.PrimaryPart.Position, p23:GetMouseCFrame().Position))
            if u26:FindFirstChild(script.Name .. "Sword") then
                v33 = CFrame.new(u26:FindFirstChild(script.Name .. "Sword").Blade.FireHole.WorldCFrame.Position, p23:GetMouseCFrame().Position)
            end
            v31:FireServer(u26.PrimaryPart.CFrame, v33)
        end
        task.wait(0.45)
        u26.PrimaryPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Right Gun", v29)
        _G.fw(v29)
        v25.dash = false
    end
end
function u6.SoulWolves(p34, _) --[[ Line: 183 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v35 = p34.Cooldowns
    local v36 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v35.wolf == false and _G.check:inspect(v36) == true then
        local v37 = u3.GetM("Soul Wolves")
        local v38 = v37.cd
        if _G.StamCheck("Soul Wolves") == false then
            return
        end
        if v37.statreq and _G.MeetReq(v37.statreq) == false then
            return
        end
        local v39 = v36.Humanoid.Animator:LoadAnimation(script.wolf)
        v39:Play()
        v39:AdjustSpeed(0.5)
        v39:AdjustWeight(2)
        v35.wolf = true
        _G.canuse = false
        v36.PrimaryPart.Anchored = true
        task.wait(0.4)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Soul Wolves", v36.PrimaryPart.CFrame)
        v36.PrimaryPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Soul Wolves", v38)
        _G.fw(v38)
        v35.wolf = false
    end
end
return u6