 

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
    --]]
    local v6 = u4.new(script.Name)
    local v7 = u5
    local v8 = setmetatable(v6, v7)
    v8.Cooldowns = {
        ["roar"] = false,
        ["chill"] = false,
        ["ghost"] = false,
        ["ass"] = false,
        ["death"] = false,
        ["run"] = false
    }
    return v8
end
function u5.SoulKingRoar(p9, _) --[[ Line: 30 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v10 = p9.Cooldowns
    local v11 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v10.roar == false and (_G.check:inspect(v11) == true and _G.StamCheck("Soul King Roar") == true) then
        local v12 = u3.GetM("Soul King Roar")
        local v13 = v12.cd
        if _G.StamCheck("Soul King Roar") == false then
            return
        end
        if v12.statreq and _G.MeetReq(v12.statreq) == false then
            return
        end
        v10.roar = true
        local v14 = v11.Humanoid:LoadAnimation(script.ult)
        v14:Play()
        v14:AdjustSpeed(1)
        v11.HumanoidRootPart.Anchored = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Soul King Roar")
        task.wait(3)
        _G.canuse = true
        v11.HumanoidRootPart.Anchored = false
        _G.keysetup:cooldown("Soul King Roar", v13)
        _G.fw(v13)
        v10.roar = false
    end
end
function u5.ChillingSoul(u15, p16) --[[ Line: 64 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v17 = u15.Cooldowns
    local u18 = u1.Character
    local u19 = u2["Stats" .. u1.Name]
    if v17.chill == false and (_G.check:inspect(u18) == true and _G.StamCheck("Chilling Soul") == true) then
        local v20 = u3.GetM("Chilling Soul")
        local v21 = v20.cd
        if _G.StamCheck("Chilling Soul") == false then
            return
        end
        if v20.statreq and _G.MeetReq(v20.statreq) == false then
            return
        end
        v17.chill = true
        local v22 = u18.Humanoid:LoadAnimation(script.freeze)
        v22:Play()
        v22:AdjustSpeed(1)
        u18.Humanoid.WalkSpeed = 4
        _G.canuse = false
        local u23 = tick()
        _G.PauseAnim(v22, 0.28, 0.5)
        u15:ChargeSkill(p16, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 98 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u15
                    [3] = u18
                    [4] = u19
                --]]
                if tick() - u23 >= 10 or (u15.Tool.Parent ~= u18 or (u18.Parent == nil or (u18.Parent ~= workspace.PlayerCharacters or u19.Stamina.Value <= 0))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 91 ]]
                --[[
                Upvalues:
                    [1] = u18
                --]]
                u18.Humanoid.WalkSpeed = 4
                if _G.check:inspect(u18) == false then
                    return false
                end
            end
        })
        v22:AdjustSpeed(1)
        task.wait(0.13999999999999996)
        if u18.Humanoid.FloorMaterial ~= Enum.Material.Air then
            game.ReplicatedStorage.Events.Skill:InvokeServer("Chilling Soul")
        end
        task.wait(0.25)
        _G.canuse = true
        u18.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Chilling Soul", v21)
        _G.fw(v21)
        v17.chill = false
    end
end
function u5.SoulForm(p24, p25) --[[ Line: 126 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v26 = p24.Cooldowns
    local u27 = u1.Character
    local u28 = u2["Stats" .. u1.Name]
    if v26.ghost == false and (_G.check:inspect(u27) == true and _G.StamCheck("Soul Form") == true) then
        local v29 = u3.GetM("Soul Form")
        local v30 = v29.cd
        if _G.StamCheck("Soul Form") == false then
            return
        end
        if v29.statreq and _G.MeetReq(v29.statreq) == false then
            return
        end
        v26.ghost = true
        local u31 = u27.Humanoid.Health
        local v32 = game.ReplicatedStorage.Events.Skill:InvokeServer("Soul Form")
        local u33 = tick()
        p24:ToggleSkill(p25, {
            ["Key"] = Enum.KeyCode.R,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 150 ]]
                --[[
                Upvalues:
                    [1] = u31
                    [2] = u27
                    [3] = u28
                    [4] = u33
                --]]
                return (u31 > u27.Humanoid.Health or u28.Stamina.Value <= 0) and true or tick() - u33 >= 15
            end
        })
        if v32 then
            v32:FireServer("keygo")
        end
        task.wait(0.25)
        _G.canuse = true
        u27.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Soul Form", v30)
        _G.fw(v30)
        v26.ghost = false
    end
end
function u5.SoulAssault(p34, _) --[[ Line: 168 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v35 = p34.Cooldowns
    local v36 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v35.ass == false and (_G.check:inspect(v36) == true and _G.StamCheck("Soul Assault") == true) then
        local v37 = u3.GetM("Soul Assault")
        local v38 = v37.cd
        if _G.StamCheck("Soul Assault") == false then
            return
        end
        if v37.statreq and _G.MeetReq(v37.statreq) == false then
            return
        end
        v35.ass = true
        local _ = v36.Humanoid.Health
        v36.Humanoid.WalkSpeed = 4
        _G.canuse = false
        local v39 = tick()
        game.ReplicatedStorage.Events.Skill:InvokeServer("Soul Assault")
        local v40 = Instance.new("BodyVelocity")
        v40.Velocity = v36.PrimaryPart.CFrame.LookVector * 8
        v40.MaxForce = Vector3.new(10000000, 10000000, 10000000)
        v40.Parent = v36.HumanoidRootPart
        _G.destroy(v40, 2)
        repeat
            task.wait()
            v40.Velocity = v36.PrimaryPart.CFrame.LookVector * 8
            v36.Humanoid.WalkSpeed = 4
        until tick() - v39 >= 2.5
        _G.canuse = true
        v36.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Soul Assault", v38)
        _G.fw(v38)
        v35.ass = false
    end
end
function u5.DeathDefied(p41, _) --[[ Line: 209 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v42 = p41.Cooldowns
    local v43 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v42.death == false and (_G.check:inspect(v43) == true and _G.StamCheck("Death Defied") == true) then
        local v44 = u3.GetM("Death Defied")
        local v45 = v44.cd
        if _G.StamCheck("Death Defied") == false then
            return
        end
        if v44.statreq and _G.MeetReq(v44.statreq) == false then
            return
        end
        if v43:GetAttribute("yomiRevived") ~= nil and v43:GetAttribute("yomiRevived") ~= nil then
            _G.displayMessage("<Color=Red>Death Defied has already been casted!")
            return
        end
        v42.death = true
        local _ = v43.Humanoid.Health
        tick()
        if v43:GetAttribute("yomiRevived") == nil then
            v43.Humanoid:LoadAnimation(script.revive):Play()
            v43.PrimaryPart.Anchored = true
            _G.canuse = false
            v43.Humanoid.WalkSpeed = 0
        end
        game.ReplicatedStorage.Events.Skill:InvokeServer("Death Defied")
        task.wait(0.5)
        v43.PrimaryPart.Anchored = false
        _G.canuse = true
        v43.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Death Defied", v45)
        _G.fw(v45)
        v42.death = false
    end
end
function u5.Skedaddle(p46, p47) --[[ Line: 253 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v48 = p46.Cooldowns
    local u49 = u1.Character
    local u50 = u2["Stats" .. u1.Name]
    if v48.run == false and (_G.check:inspect(u49) == true and _G.StamCheck("Skedaddle") == true) then
        local v51 = u3.GetM("Skedaddle")
        local v52 = v51.cd
        if _G.StamCheck("Skedaddle") == false then
            return
        end
        if v51.statreq and _G.MeetReq(v51.statreq) == false then
            return
        end
        v48.run = true
        local u53 = tick()
        _G.canuse = false
        local u54 = game.ReplicatedStorage.Events.Skill:InvokeServer("Skedaddle")
        local u55 = u49.Humanoid:LoadAnimation(script.run)
        u55:Play()
        u55.Priority = Enum.AnimationPriority.Action
        local u56 = Instance.new("BodyVelocity")
        u56.MaxForce = Vector3.new(100000, 100000, 100000)
        u56.Parent = u49.HumanoidRootPart
        p46:ToggleSkill(p47, {
            ["Key"] = Enum.KeyCode.T,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 287 ]]
                --[[
                Upvalues:
                    [1] = u49
                    [2] = u56
                    [3] = u55
                    [4] = u50
                    [5] = u53
                    [6] = u54
                --]]
                if _G.check:inspect(u49) == false then
                    return true
                end
                local v57 = u49.Humanoid.Health / u49.Humanoid.MaxHealth
                u56.Velocity = u49.PrimaryPart.CFrame.LookVector * (55 * v57)
                u49.Humanoid.WalkSpeed = 35
                u55:AdjustSpeed(1 * v57)
                _G.canuse = false
                if u50.Stamina.Value <= 0 then
                    return true
                end
                local v58 = tick() - u53 < 30 and (u54 ~= nil and u54)
                if v58 then
                    v58 = u54:IsDescendantOf(game) == false
                end
                return v58
            end
        })
        u56:Destroy()
        u55:Stop()
        if u54 then
            u54:FireServer()
        end
        _G.canuse = true
        u49.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Skedaddle", v52)
        _G.fw(v52)
        v48.run = false
    end
end
return u5