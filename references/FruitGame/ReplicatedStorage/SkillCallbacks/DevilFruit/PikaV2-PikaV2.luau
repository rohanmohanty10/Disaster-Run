 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u5 = setmetatable({}, u4)
u5.__index = u5
function u5.new(_) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    local v6 = u4.new(script.Name)
    local v7 = u5
    local v8 = setmetatable(v6, v7)
    v8.Cooldowns = {
        ["Kick"] = false,
        ["rapid"] = false,
        ["ray"] = false,
        ["sword"] = false,
        ["ult"] = false,
        ["fly"] = false
    }
    return v8
end
function u5.RadiantKick(u9, p10) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = u9.Cooldowns
    local u12 = u1.Character
    local u13 = u2["Stats" .. u1.Name]
    if _G.canuse == true and (v11.Kick == false and _G.check:inspect(u12) == true) then
        local v14 = u3.GetM("Radiant Kick")
        local v15 = v14.cd
        if _G.StamCheck("Radiant Kick") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        v11.Kick = true
        _G.canuse = false
        _G.FaceMouse = true
        local v16 = u12.Humanoid:LoadAnimation(script.kickStart)
        v16:Play()
        v16:AdjustSpeed(1.142857142857143)
        v16:AdjustWeight(2)
        task.wait(0.35)
        v16:Stop()
        local v17 = u12.Humanoid:LoadAnimation(script.kickHold)
        v17:Play(0)
        v17:AdjustWeight(2)
        local u18 = tick()
        local u19 = game.ReplicatedStorage.Events.Skill:InvokeServer("Radiant Kick")
        local u20 = false
        local function v21() --[[ Line: 65 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u18
                [3] = u20
                [4] = u9
                [5] = u12
                [6] = u13
            --]]
            if u19 == nil then
                return true
            end
            if tick() - u18 >= 1.0499999999999998 and u20 == false then
                u20 = true
                if u19 then
                    u19:FireServer("charged")
                end
            end
            if tick() - u18 >= 10 or (u9.Tool.Parent ~= u12 or (u12.Parent == nil or (u12.Parent ~= workspace.PlayerCharacters or u13.Stamina.Value <= 0))) then
                return true
            end
        end
        u9:ChargeSkill(p10, {
            ["Key"] = Enum.KeyCode.R,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = v21
        })
        u12.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        v17:Stop()
        local v22 = u12.Humanoid:LoadAnimation(script.kickShoot)
        v22:Play(0)
        v22:AdjustWeight(2)
        task.delay(0.2, function() --[[ Line: 95 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u12
                [3] = u9
                [4] = u20
            --]]
            if u19 then
                u19:FireServer(u12.RightFoot.CFrame, u9:GetMouseCFrame(), u20)
            end
        end)
        task.wait(0.75)
        u12.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Radiant Kick", v15)
        _G.fw(v15)
        v11.Kick = false
    end
end
function u5.RadiantJewels(u23, p24) --[[ Line: 111 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v25 = u23.Cooldowns
    local u26 = u1.Character
    local u27 = u2["Stats" .. u1.Name]
    if _G.canuse == true and (v25.rapid == false and (_G.check:inspect(u26) == true and _G.StamCheck("Radiant Jewels") == true)) then
        local v28 = u3.GetM("Radiant Jewels")
        local v29 = v28.cd
        if _G.StamCheck("Radiant Jewels") == false then
            return
        end
        if v28.statreq and _G.MeetReq(v28.statreq) == false then
            return
        end
        v25.rapid = true
        _G.canuse = false
        _G.FaceMouse = true
        local v30 = u26.Humanoid:LoadAnimation(script.rapid)
        v30:Play()
        v30:AdjustSpeed(0.5)
        task.wait(0.532)
        local u31 = game.ReplicatedStorage.Events.Skill:InvokeServer("Radiant Jewels")
        local u32 = tick()
        u23:ChargeSkill(p24, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 140 ]]
                --[[
                Upvalues:
                    [1] = u31
                    [2] = u23
                    [3] = u26
                    [4] = u27
                    [5] = u32
                --]]
                if u31 == nil then
                    return true
                end
                if u23.Tool.Parent ~= u26 or (u26.Parent == nil or (u26.Parent ~= workspace.PlayerCharacters or (u27.Stamina.Value <= 0 or (tick() - u32 >= 3 or _G.check:inspect(u26) == false)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        _G.FaceMouse = false
        if u31 then
            u31:FireServer()
        end
        v30:Stop(0.3)
        _G.canuse = true
        _G.keysetup:cooldown("Radiant Jewels", v29)
        _G.fw(v29)
        v25.rapid = false
    end
end
function u5.RadiantRay(u33, p34) --[[ Line: 169 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v35 = u33.Cooldowns
    local u36 = u1.Character
    local u37 = u2["Stats" .. u1.Name]
    if _G.canuse == true and (v35.ray == false and _G.check:inspect(u36) == true) then
        local v38 = u3.GetM("Radiant Ray")
        local v39 = v38.cd
        if _G.StamCheck("Radiant Ray") == false then
            return
        end
        if v38.statreq and _G.MeetReq(v38.statreq) == false then
            return
        end
        v35.ray = true
        _G.canuse = false
        local v40 = u36.Humanoid:LoadAnimation(script.rayStart)
        v40:Play()
        task.wait(0.433)
        v40:Stop()
        local v41 = u36.Humanoid:LoadAnimation(script.rayHold)
        v41:Play()
        local u42 = game.ReplicatedStorage.Events.Skill:InvokeServer("Radiant Ray", u33:GetMouseCFrame())
        local u43 = tick()
        u33:ChargeSkill(p34, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 199 ]]
                --[[
                Upvalues:
                    [1] = u36
                    [2] = u42
                    [3] = u33
                    [4] = u37
                    [5] = u43
                --]]
                u36.Humanoid.WalkSpeed = 4
                if u42 == nil then
                    return true
                end
                u42:FireServer({ "update", u33:GetMouseCFrame() })
                if u33.Tool.Parent ~= u36 or (u36.Parent == nil or (u36.Parent ~= workspace.PlayerCharacters or (u37.Stamina.Value <= 0 or (tick() - u43 >= 5 or _G.check:inspect(u36) == false)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v41:Stop()
        u36.Humanoid:LoadAnimation(script.rayEnd):Play()
        if u42 then
            u42:FireServer()
        end
        u36.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Radiant Ray", v39)
        _G.fw(v39)
        v35.ray = false
    end
end
local u44 = RaycastParams.new()
u44.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
u44.FilterType = Enum.RaycastFilterType.Include
u5["StarlightRapier:Blitzstrike"] = function(u45, p46) --[[ Line: 238 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u44
    --]]
    local v47 = u45.Cooldowns
    local u48 = u1.Character
    local u49 = u2["Stats" .. u1.Name]
    if _G.canuse == true and (v47.sword == false and (_G.check:inspect(u48) == true and _G.StamCheck("Starlight Rapier: Blitzstrike") == true)) then
        local v50 = u3.GetM("Starlight Rapier: Blitzstrike")
        local v51 = v50.cd
        if _G.StamCheck("Starlight Rapier: Blitzstrike") == false then
            return
        end
        if v50.statreq and _G.MeetReq(v50.statreq) == false then
            return
        end
        v47.sword = true
        _G.canuse = false
        _G.FaceMouse = true
        local u52 = game.ReplicatedStorage.Events.Skill:InvokeServer("Starlight Rapier: Blitzstrike")
        local v53 = u48.Humanoid:LoadAnimation(script.swordStart)
        v53:Play()
        _G.PauseAnim(v53, 0.4, 1.2)
        local u54 = tick()
        u45:ChargeSkill(p46, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 265 ]]
                --[[
                Upvalues:
                    [1] = u52
                    [2] = u45
                    [3] = u48
                    [4] = u49
                    [5] = u54
                --]]
                if u52 == nil then
                    return true
                end
                if u45.Tool.Parent ~= u48 or (u48.Parent == nil or (u48.Parent ~= workspace.PlayerCharacters or (u49.Stamina.Value <= 0 or (tick() - u54 >= 5 or _G.check:inspect(u48) == false)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        u48.PrimaryPart.Anchored = true
        _G.FaceMouse = false
        v53:AdjustSpeed(1)
        local v55 = u48.PrimaryPart.CFrame
        if u52 then
            local v56 = u48.PrimaryPart.CFrame * CFrame.new(0, 0, -100)
            local v57 = CFrame.new(v55.Position, v56.Position)
            local v58 = (v56.Position - v57.Position).Unit * 40
            local v59 = workspace:Raycast(v57.Position, v58, u44)
            local v60 = v57.Position
            local v61
            if v59 then
                local v62 = (v60 - v59.Position).Magnitude
                v61 = CFrame.new(v60, v59.Position) * CFrame.new(0, 0, -(v62 - 5))
            else
                v61 = CFrame.new(v60, v56.Position) * CFrame.new(0, 0, -40)
            end
            u48:SetPrimaryPartCFrame(v61)
            _G.PlayEffect("Light BlitzV2", nil, "Dash", nil, v57)
            u52:InvokeServer(v61)
        else
            u48.PrimaryPart.Anchored = false
        end
        task.wait(0.1)
        _G.canuse = true
        _G.keysetup:cooldown("Starlight Rapier: Blitzstrike", v51)
        _G.fw(v51)
        v47.sword = false
    end
end
u5["StarlightRapier:Excalibur"] = function(u63, p64) --[[ Line: 317 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v65 = u63.Cooldowns
    local u66 = u1.Character
    local u67 = u2["Stats" .. u1.Name]
    if _G.canuse == true and (v65.ult == false and (_G.check:inspect(u66) == true and _G.StamCheck("Starlight Rapier: Excalibur") == true)) then
        local v68 = u3.GetM("Starlight Rapier: Excalibur")
        local v69 = v68.cd
        if u66.Humanoid.FloorMaterial == Enum.Material.Air then
            _G.displayMessage("<Color=Red>I have to touch the ground")
            return nil
        end
        if _G.StamCheck("Starlight Rapier: Excalibur") == false then
            return
        end
        if v68.statreq and _G.MeetReq(v68.statreq) == false then
            return
        end
        v65.ult = true
        _G.canuse = false
        _G.mouseLevel = true
        _G.FaceMouse = true
        local u70 = game.ReplicatedStorage.Events.Skill:InvokeServer("Starlight Rapier: Excalibur", u66.PrimaryPart.CFrame)
        local v71 = u66.Humanoid:LoadAnimation(script.ultWindup)
        v71:Play()
        task.wait(1.2)
        v71:Stop()
        local v72 = u66.Humanoid:LoadAnimation(script.ultHold)
        v72:Play(0)
        local u73 = tick()
        u63:ChargeSkill(p64, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 354 ]]
                --[[
                Upvalues:
                    [1] = u70
                    [2] = u63
                    [3] = u66
                    [4] = u67
                    [5] = u73
                --]]
                if u70 == nil then
                    return true
                end
                if u63.Tool.Parent ~= u66 or (u66.Parent == nil or (u66.Parent ~= workspace.PlayerCharacters or (u67.Stamina.Value <= 0 or tick() - u73 >= 5))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v72:Stop()
        u66.Humanoid:LoadAnimation(script.ultRelease):Play()
        if u70 then
            task.delay(1.8, function() --[[ Line: 376 ]]
                --[[
                Upvalues:
                    [1] = u70
                    [2] = u66
                --]]
                if u70 then
                    u70:InvokeServer("updateCFrame", u66.PrimaryPart.CFrame)
                end
            end)
            task.spawn(function() --[[ Line: 381 ]]
                --[[
                Upvalues:
                    [1] = u66
                --]]
                repeat
                    task.wait()
                until u66:GetAttribute("PikaV2UltSwordHold") == nil
                _G.mouseLevel = nil
                _G.FaceMouse = false
                u66.PrimaryPart.Anchored = true
            end)
            u70:InvokeServer("release", u66.PrimaryPart.CFrame)
        end
        u66.PrimaryPart.Anchored = false
        _G.mouseLevel = nil
        _G.FaceMouse = false
        _G.canuse = true
        _G.keysetup:cooldown("Starlight Rapier: Excalibur", v69)
        _G.fw(v69)
        v65.ult = false
    end
end
function u5.RadiantFlight(u74, p75) --[[ Line: 403 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v76 = u74.Cooldowns
    local u77 = u1.Character
    local _ = u77.HumanoidRootPart
    local u78 = u2["Stats" .. u1.Name]
    if _G.grounded == false and (_G.canuse == true and (v76.fly == false and (_G.check:inspect(u77) == true and _G.StamCheck("Radiant Flight") == true))) then
        local v79 = u3.GetM("Radiant Flight")
        local v80 = v79.cd
        if _G.StamCheck("Radiant Flight") == false then
            return
        end
        if v79.statreq and _G.MeetReq(v79.statreq) == false then
            return
        end
        v76.fly = true
        _G.canuse = false
        local v81 = Instance.new("BodyVelocity", u77.HumanoidRootPart)
        v81.Name = "geppo"
        v81.MaxForce = Vector3.new(inf, inf, inf)
        v81.Velocity = Vector3.new()
        v81.P = 4324234234
        tick()
        local u82 = u77:GetDescendants()
        _G.transparentCharacter(u77, nil, nil, true)
        local v83 = CFrame.new(u77.HumanoidRootPart.Position, u74:GetMouseCFrame().Position)
        u77.HumanoidRootPart.CFrame = v83
        u77.Humanoid.PlatformStand = true
        local u84 = u77.HumanoidRootPart.CFrame
        local u85 = {}
        for u86 = 1, #u82 do
            if u82[u86]:IsA("BasePart") then
                pcall(function() --[[ Line: 443 ]]
                    --[[
                    Upvalues:
                        [1] = u82
                        [2] = u86
                        [3] = u85
                    --]]
                    u82[u86].CollisionGroup = "noclip"
                    local v87 = u85
                    local v88 = u82[u86]
                    table.insert(v87, v88)
                end)
            end
        end
        local u89 = game.ReplicatedStorage.Events.Skill:InvokeServer("Radiant Flight")
        u77.HumanoidRootPart.CFrame = v83
        local u90 = u77.HumanoidRootPart.CFrame
        local u91 = u84.Position
        local u92 = u84.LookVector
        local u93 = 0
        local u94 = tick()
        u74:ToggleSkill(p75, {
            ["Key"] = Enum.KeyCode.T,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function(_) --[[ Name: EndFunction, Line 463 ]]
                --[[
                Upvalues:
                    [1] = u77
                    [2] = u84
                    [3] = u90
                    [4] = u91
                    [5] = u92
                    [6] = u89
                    [7] = u93
                    [8] = u94
                    [9] = u74
                    [10] = u78
                --]]
                local v95 = 8 * (60 / _G.FPS) * (u77.Humanoid.Health / u77.Humanoid.MaxHealth)
                local v96 = u84 * CFrame.new(0, 0, -v95)
                local v97 = Ray.new(u90.Position, (u90.Position - v96.Position).unit * -v95)
                local v98, v99, v100 = _G.raycastWhitelist(v97, { workspace.Islands, workspace.Ships, workspace.Env })
                u84 = CFrame.new(u91:Lerp(v99, 0.5), v99)
                if u84 ~= u84 then
                    return true
                end
                u77.HumanoidRootPart.CFrame = u84
                u91 = v99
                if v98 or v99.Y <= workspace.Env.WaterStuff.Falls.Position.Y and (v99.Y > workspace.Env.WaterStuff.Sand.Position.Y and u77:FindFirstChild("coatBubble") == nil) then
                    if v99.Y <= workspace.Env.WaterStuff.Falls.Position.Y and (v99.Y > workspace.Env.WaterStuff.Sand.Position.Y and u77:FindFirstChild("coatBubble") == nil) then
                        local v101 = v99.X
                        local v102 = workspace.Env.WaterStuff.Falls.Position.Y + 0.1
                        local v103 = v99.Z
                        v99 = Vector3.new(v101, v102, v103)
                        v100 = Vector3.new(0, 1, 0)
                    end
                    if u77.HumanoidRootPart.Position.Y > workspace.Env.WaterStuff.Falls.Position.Y - 1 or (v99.Y < workspace.Env.WaterStuff.Sand.Position.Y or u77:FindFirstChild("coatBubble")) then
                        u92 = u92 - 2 * u92:Dot(v100) * v100
                        if u89 then
                            u89:FireServer("reflect", CFrame.new(v99, v99 + v100))
                        end
                    end
                    u84 = CFrame.new(v99, v99 + u92)
                    if u84 ~= u84 then
                        return true
                    end
                    u77.HumanoidRootPart.CFrame = u84
                end
                if u77.Humanoid.SeatPart ~= nil then
                    u77.Humanoid.SeatPart:Sit(nil)
                end
                u77.HumanoidRootPart.Velocity = Vector3.new()
                u77.HumanoidRootPart.RotVelocity = Vector3.new()
                if u89 and (tick() - u93 >= 0.05 and tick() - u94 >= 0.1) then
                    u89:FireServer("dmg", u84)
                    u93 = tick()
                end
                if u77:FindFirstChild("inCombat") and tick() - u94 >= 7 then
                    return true
                end
                u90 = u84
                return (u89 == nil or (u74.Tool.Parent ~= u77 or (u77.Parent == nil or (u77.Parent ~= workspace.PlayerCharacters or u78.Stamina.Value <= 0)))) and true or _G.check:inspect(u77) == false
            end
        })
        u77.Humanoid.PlatformStand = false
        u77.Humanoid.AutoRotate = true
        _G.transparentCharacter(u77, true, nil, true)
        u77.HumanoidRootPart.Velocity = Vector3.new()
        u77.Humanoid.PlatformStand = false
        for u104 = 1, #u85 do
            pcall(function() --[[ Line: 530 ]]
                --[[
                Upvalues:
                    [1] = u85
                    [2] = u104
                --]]
                u85[u104].CollisionGroup = "Players"
            end)
        end
        if u89 then
            u89:FireServer()
        end
        v81:Destroy()
        _G.canuse = true
        if u77:FindFirstChild("inCombat") then
            repeat
                task.wait()
            until u77.Humanoid.FloorMaterial ~= Enum.Material.Air
        end
        _G.keysetup:cooldown("Radiant Flight", v80)
        _G.fw(v80)
        v76.fly = false
    end
end
return u5