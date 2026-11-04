 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u5 = 25
local u6 = setmetatable({}, u4)
u6.__index = u6
function u6.new(_) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u6
    --]]
    local v7 = u4.new(script.Name)
    local v8 = u6
    local v9 = setmetatable(v7, v8)
    v9.Cooldowns = {
        ["rise"] = false,
        ["fall"] = false,
        ["crash"] = false
    }
    v9.preFloat = tick()
    local v10 = Instance.new("BodyVelocity")
    v10.Velocity = Vector3.new()
    v10.MaxForce = Vector3.new(0, 100000000000, 0)
    v10.Name = "geppo"
    v9.bv = v10
    v9.floatingRemote = nil
    v9.startFly = 0
    v9.floatCheck = 0.5
    v9:_main()
    return v9
end
function u6._main(u11) --[[ Line: 45 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u5
    --]]
    local u12 = u1.Character or u1.CharacterAdded:Wait()
    u11.floatingAnim = u12.Humanoid:LoadAnimation(script.floating)
    u11.floatingAnim.Priority = Enum.AnimationPriority.Action
    local u13 = u2:WaitForChild("Stats" .. u1.Name)
    local u14 = u11.bv
    u11.Heartbeat = game["Run Service"].Heartbeat:Connect(function(_) --[[ Line: 53 ]]
        --[[
        Upvalues:
            [1] = u12
            [2] = u14
            [3] = u11
            [4] = u5
            [5] = u13
        --]]
        if u12.Parent ~= workspace.PlayerCharacters then
            u14.Velocity = Vector3.new()
        end
        if u14.Parent == nil then
            if u11.floatingRemote and tick() - u11.preFloat >= u11.floatCheck then
                u11:endFloat()
            end
        elseif u12.Humanoid.FloorMaterial ~= Enum.Material.Air and (tick() - u11.preFloat >= u11.floatCheck and tick() - u11.startFly >= 0.2) or u12:FindFirstChild("Floating") == nil then
            if u11.floatingRemote then
                u11:endFloat()
            end
            u14.Parent = nil
        end
        if u12.Humanoid.FloorMaterial == Enum.Material.Air and _G.canuse ~= false then
            if u12.Humanoid.FloorMaterial == Enum.Material.Air and (u14.Parent ~= nil and u11.floatingAnim.IsPlaying == false) then
                u11.floatingAnim:Play()
            end
        elseif u11.floatingAnim.IsPlaying == true then
            u11.floatingAnim:Stop()
        end
        local v15 = 10 + u13.Stats.DevilFruitMastery.Value / 3
        u5 = math.clamp(v15, 0, 50) * (u12.Humanoid.Health / u12.Humanoid.MaxHealth)
    end)
    function u11.Destroy(p16) --[[ Line: 91 ]]
        p16:endFloat()
    end
end
function u6.startFloat(p17, _) --[[ Line: 96 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v18 = u1.Character
    p17.preFloat = tick()
    if p17.floatingRemote == nil or v18:FindFirstChild("Floating") == nil then
        p17.floatingRemote = game.ReplicatedStorage.Events.Skill:InvokeServer("Kilo Float")
    end
    v18:WaitForChild("Floating", 3)
end
function u6.endFloat(p19, _) --[[ Line: 106 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local _ = u1.Character
    if p19.floatingRemote then
        p19.floatingRemote:FireServer()
        p19.bv.Parent = nil
        p19.floatingRemote = nil
    end
end
function u6.KiloRise(p20, p21) --[[ Line: 116 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u5
    --]]
    local v22 = p20.Cooldowns
    local u23 = u1.Character
    local u24 = u2["Stats" .. u1.Name]
    local u25 = p20.bv
    if _G.grounded == false and (v22.rise == false and (_G.check:inspect(u23) == true and _G.StamCheck("Kilo Rise") == true)) then
        local v26 = u3.GetM("Kilo Rise")
        local v27 = v26.cd
        if _G.StamCheck("Kilo Rise") == false then
            return
        end
        if v26.statreq and _G.MeetReq(v26.statreq) == false then
            return
        end
        v22.rise = true
        _G.canuse = false
        local v28 = game.ReplicatedStorage.Events.Skill:InvokeServer("Kilo Rise")
        local v29 = u23.Humanoid:LoadAnimation(script.rise)
        v29:Play()
        v29:AdjustWeight(2)
        u23.Humanoid.Jump = true
        p20.startFly = tick()
        local v30 = u5
        p20.bv.Velocity = Vector3.new(0, v30, 0)
        p20:startFloat()
        p20:ChargeSkill(p21, {
            ["Button"] = p21,
            ["Key"] = Enum.KeyCode.E,
            ["PCInputType"] = "Default",
            ["MobileInputType"] = "Toggle",
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 170 ]]
                --[[
                Upvalues:
                    [1] = u25
                    [2] = u23
                    [3] = u24
                --]]
                if u25 then
                    pcall(function() --[[ Line: 172 ]]
                        --[[
                        Upvalues:
                            [1] = u25
                            [2] = u23
                        --]]
                        u25.Parent = u23.HumanoidRootPart
                    end)
                end
                if u23:FindFirstChild("Floating") == nil or (_G.check:inspect(u23) == false or (not u23:FindFirstChild("Kilo-Kilo") or (u23.Parent == nil or (u23.Parent ~= workspace.PlayerCharacters or u24.Stamina.Value <= 0)))) then
                    return true
                end
            end
        })
        v29:Stop()
        if v28 then
            v28:FireServer()
        end
        u23.Humanoid.PlatformStand = false
        u25.Velocity = Vector3.new()
        _G.canuse = true
        _G.keysetup:cooldown("Kilo Rise", v27)
        _G.fw(v27)
        v22.rise = false
    end
end
function u6.KiloDescend(u31, p32) --[[ Line: 201 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u5
    --]]
    local v33 = u31.Cooldowns
    local u34 = u1.Character
    local u35 = u2["Stats" .. u1.Name]
    local u36 = u31.bv
    if v33.fall == false and (_G.check:inspect(u34) == true and _G.StamCheck("Kilo Descend") == true) then
        local v37 = u3.GetM("Kilo Descend")
        local v38 = v37.cd
        if _G.StamCheck("Kilo Descend") == false then
            return
        end
        local v39, _, _ = _G.getRayFloor(u34.PrimaryPart.CFrame, 5)
        if v39 then
            return
        end
        if v37.statreq and _G.MeetReq(v37.statreq) == false then
            return
        end
        v33.fall = true
        _G.canuse = false
        local v40 = game.ReplicatedStorage.Events.Skill:InvokeServer("Kilo Descend")
        local v41 = u34.Humanoid:LoadAnimation(script.down)
        v41:Play()
        v41:AdjustWeight(2)
        local v42 = -u5 * 1.25
        u36.Velocity = Vector3.new(0, v42, 0)
        u31:startFloat()
        u31:ChargeSkill(p32, {
            ["Button"] = p32,
            ["Key"] = Enum.KeyCode.R,
            ["PCInputType"] = "Default",
            ["MobileInputType"] = "Toggle",
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 272 ]]
                --[[
                Upvalues:
                    [1] = u36
                    [2] = u5
                    [3] = u34
                    [4] = u31
                    [5] = u35
                --]]
                local v43 = u36
                local v44 = -u5 * 1.25
                v43.Velocity = Vector3.new(0, v44, 0)
                u36.Parent = u34.HumanoidRootPart
                local _ = u34.Humanoid
                if u34.Humanoid.FloorMaterial ~= Enum.Material.Air then
                    u31:endFloat()
                    u34.Humanoid:LoadAnimation(script.land):Play()
                    return true
                end
                if u34:FindFirstChild("Floating") == nil or (not u34:FindFirstChild("Kilo-Kilo") or (u34.Parent == nil or (u34.Parent ~= workspace.PlayerCharacters or u35.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v41:Stop()
        u34.Humanoid.PlatformStand = false
        u36.Velocity = Vector3.new()
        if v40 then
            v40:FireServer()
        end
        _G.canuse = true
        _G.keysetup:cooldown("Kilo Descend", v38)
        _G.fw(v38)
        v33.fall = false
    end
end
function u6.KiloCrash(p45, _) --[[ Line: 310 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v46 = p45.Cooldowns
    local v47 = u1.Character
    local v48 = u2["Stats" .. u1.Name]
    local v49 = p45.bv
    if v46.crash == false and (_G.check:inspect(v47) == true and _G.StamCheck("Kilo Crash") == true) then
        local v50 = u3.GetM("Kilo Crash")
        local v51 = v50.cd
        if _G.StamCheck("Kilo Crash") == false then
            return
        end
        if v50.statreq and _G.MeetReq(v50.statreq) == false then
            return
        end
        v46.crash = true
        _G.canuse = false
        local u52 = v47.Humanoid:LoadAnimation(script.loop)
        u52:Play()
        v49.Velocity = Vector3.new(0, -5, 0)
        p45:endFloat()
        local v53 = v47.HumanoidRootPart.Position
        tick()
        local v54 = tick()
        local v55 = game.ReplicatedStorage.Events.Skill:InvokeServer("Kilo Crash", {
            ["cf"] = v47.HumanoidRootPart.CFrame,
            ["diff"] = 15 + (v53 - v47.HumanoidRootPart.Position).Magnitude / 2
        })
        local v56 = false
        while true do
            v49.MaxForce = Vector3.new(0, 0, 0)
            v49.Velocity = v49.Velocity - Vector3.new(0, 0, 0)
            v49.Parent = v47.HumanoidRootPart
            local v57 = v47.HumanoidRootPart.CFrame
            local v58 = 50 / (v57.Position - v53).Magnitude
            if tick() - v54 >= v58 / 200 then
                v54 = tick()
                local v59 = game.ReplicatedStorage.MiscModels.sphere:Clone()
                v59.CFrame = v47.HumanoidRootPart.CFrame * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(math.random(-5, 5), math.random(-5, 5), math.random(-15, 5))
                local v60 = (v57.Position - v53).Magnitude / 2 + 80
                local v61 = math.random(v60 / 2, v60) / 10
                local v62 = math.random(1, 5) / 10
                v59.Mesh.Scale = Vector3.new(v62, v62, v61)
                v56 = not v56
                if v56 == true then
                    v59.Transparency = 0.5
                    v59.Color = Color3.fromRGB(0, 0, 0)
                end
                v59.Parent = workspace.Effects
                local v63 = math.random(100, 200) / 1000
                local v64 = (v57.Position - v53).Magnitude / 10
                _G.tween(v59, {
                    v63,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    true,
                    0
                }, {
                    ["Transparency"] = 1,
                    ["CFrame"] = v59.CFrame * CFrame.new(0, 0, math.random(v64 / 2, v64))
                })
                _G.tween(v59.Mesh, {
                    v63,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.In,
                    0,
                    true,
                    0
                }, {
                    ["Scale"] = Vector3.new(0, 0, 0)
                })
                _G.destroy(v59, v63)
            end
            local v65, _, _ = _G.getRayFloor(v47.PrimaryPart.CFrame, 15)
            if v65 ~= nil then
                break
            end
            game["Run Service"].Stepped:Wait()
            if v47.Parent == nil or (v47.Parent ~= workspace.PlayerCharacters or v48.Stamina.Value <= 0) then
                break
            end
        end
        v47.Humanoid.PlatformStand = false
        v49.Velocity = Vector3.new()
        task.spawn(function() --[[ Line: 388 ]]
            --[[
            Upvalues:
                [1] = u52
            --]]
            repeat
                game["Run Service"].Heartbeat:Wait()
            until u52 ~= nil
            u52:Stop()
        end)
        if v65 then
            v49.Parent = nil
            v47.HumanoidRootPart.Anchored = true
            local v66 = v47.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
            local v67 = CFrame.new(v47.HumanoidRootPart.CFrame.Position) * CFrame.new(0, 2, 0)
            local v68 = Ray.new(v67.Position, v67.upVector * -15)
            local _, v69, v70 = _G.raycastWhitelist(v68, { workspace.Islands, workspace.Env, workspace.Ships })
            local v71 = v70 == Vector3.new(0, 0, 0) and Vector3.new(0, 1, 0) or v70
            v47.HumanoidRootPart.CFrame = CFrame.new(v69, v69 + v71) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, v47.HumanoidRootPart.Size.Z * 2.5, 0)
            local v72 = CFrame.new
            local v73 = v47.HumanoidRootPart.CFrame.Position
            local v74 = v66.X
            local v75 = v47.HumanoidRootPart.CFrame.Position.Y + 1
            local v76 = v66.Z
            local v77 = v72(v73, (Vector3.new(v74, v75, v76)))
            if (v77.Position - v47.HumanoidRootPart.Position).Magnitude < 10 then
                v47.HumanoidRootPart.CFrame = v77
            end
            local v78 = v47.Humanoid:LoadAnimation(script.crash)
            v78:Play()
            v78:AdjustWeight(10)
            if v55 then
                v55:FireServer({
                    ["cf"] = v47.HumanoidRootPart.CFrame,
                    ["diff"] = 15 + (v53 - v47.HumanoidRootPart.Position).Magnitude / 2
                })
            end
            task.wait(0.8)
            v47.HumanoidRootPart.Anchored = false
        end
        v49.MaxForce = Vector3.new(0, 100000000000, 0)
        _G.canuse = true
        _G.keysetup:cooldown("Kilo Crash", v51)
        _G.fw(v51)
        v46.crash = false
    end
end
return u6