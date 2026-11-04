 

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
        ["floor"] = false,
        ["nado"] = false
    }
    return v9
end
function u6.ExplosiveField(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.floor == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Explosive Field")
        local v15 = v14.cd
        if _G.StamCheck("Explosive Field") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        local v16, _, _ = _G.getRayFloor(u13.PrimaryPart.CFrame, 5)
        if v16 == nil then
            return nil
        end
        local u17 = u13.Humanoid.Animator:LoadAnimation(script.floor)
        u17:Play()
        u17:AdjustWeight(2)
        v12.floor = true
        _G.canuse = false
        _G.mouseLevel = true
        _G.FaceMouse = true
        local v18 = game.ReplicatedStorage.Events.Skill:InvokeServer("Explosive Field")
        _G.PauseAnim(u17, 0.2, 1.3125)
        local u19 = tick()
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 60 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u17
                --]]
                if _G.check:inspect(u13) == false then
                    u17:Stop()
                    return true
                end
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 67 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u19
                --]]
                if u13:FindFirstChild(script.Name) == nil or tick() - u19 >= 10 then
                    return true
                end
            end
        })
        _G.mouseLevel = false
        _G.FaceMouse = false
        u13.HumanoidRootPart.Anchored = true
        u13.Humanoid.AutoRotate = false
        task.wait(0.09142857142857143)
        u13.Humanoid.AutoRotate = false
        u17:AdjustSpeed(1.75)
        if v18 then
            if _G.check:inspect(u13) == true then
                v18:FireServer(u13.PrimaryPart.CFrame)
            else
                v18:FireServer(nil)
            end
        end
        task.wait(0.75)
        u13.Humanoid.AutoRotate = true
        u13.HumanoidRootPart.Anchored = false
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Explosive Field", v15)
        _G.fw(v15)
        v12.floor = false
    end
end
function u6.SUPERMEGADEATHROCKET(p20, p21) --[[ Line: 108 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v22 = p20.Cooldowns
    local u23 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v22.nado == false and _G.check:inspect(u23) == true then
        local v24 = u3.GetM("SUPER MEGA DEATH ROCKET")
        local v25 = v24.cd
        if _G.StamCheck("SUPER MEGA DEATH ROCKET") == false then
            return
        end
        if v24.statreq and _G.MeetReq(v24.statreq) == false then
            return
        end
        if (u23:GetAttribute("rocketBladeDamage") or 0) < require(game.ReplicatedStorage.Modules.Skills.Modes["Inferno Rocket Blade"])(u1) * 0.2 then
            _G.displayMessage("<Color=Red>You dont have enough damage pool yet! (20%)")
            return
        end
        local v26 = u23.Humanoid.Animator:LoadAnimation(script.aim)
        if script:GetAttribute("Prestige") then
            v26 = u23.Humanoid.Animator:LoadAnimation(script.aimPrestige)
        end
        v26:Play()
        v26:AdjustWeight(2)
        v22.nado = true
        _G.canuse = false
        _G.FaceMouse = true
        local v27 = game.ReplicatedStorage.Events.Skill:InvokeServer("SUPER MEGA DEATH ROCKET")
        u23.Humanoid.WalkSpeed = 4
        task.wait(0.8)
        v26:Stop()
        local u28 = u23.Humanoid.Animator:LoadAnimation(script.charge)
        u28:Play()
        u28.Priority = Enum.AnimationPriority.Action3
        u28:AdjustWeight(2)
        local u29 = tick()
        p20:ChargeSkill(p21, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 150 ]]
                --[[
                Upvalues:
                    [1] = u23
                --]]
                u23.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 154 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u29
                --]]
                if u23:FindFirstChild(script.Name) == nil or (tick() - u29 >= 25 or u23.Parent == workspace.Ragdolls) then
                    return true
                end
                local v30 = u23:GetAttribute("rocketBladeDamage")
                if v30 and v30 <= 0 or v30 == nil then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        task.delay(0.1, function() --[[ Line: 171 ]]
            --[[
            Upvalues:
                [1] = u28
                [2] = u23
            --]]
            u28:Stop()
            u28 = u23.Humanoid.Animator:LoadAnimation(script.fire)
            u28:Play()
            u28:AdjustWeight(2)
        end)
        _G.FaceMouse = false
        u23.PrimaryPart.Anchored = true
        if v27 then
            v27:FireServer({
                ["Target"] = _G.getTargetNearMouse(300),
                ["cf"] = p20:GetMouseCFrame(),
                ["hrpCF"] = u23.HumanoidRootPart.CFrame
            })
        end
        task.wait(1)
        u23.PrimaryPart.Anchored = false
        u23.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("SUPER MEGA DEATH ROCKET", v25)
        _G.fw(v25)
        v22.nado = false
    end
end
return u6